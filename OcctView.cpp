#include <windows.h>
#include <WNT_Window.hxx>

#include "OcctView.h"

#include <BRepPrimAPI_MakeCone.hxx>
#include <BRepPrimAPI_MakeSphere.hxx>
#include <BRepPrimAPI_MakeBox.hxx>
#include <AIS_Shape.hxx>
#include <BRepPrimAPI_MakeCylinder.hxx>
#include <BRepAlgoAPI_Fuse.hxx>
#include <BRepPrim_Wedge.hxx>
#include <BRepPrimAPI_MakePrism.hxx>
#include <BRepPrimAPI_MakeWedge.hxx>
#include <BRepBuilderAPI_Transform.hxx>
#include <BRepAlgoAPI_Cut.hxx>
#include <GProp_GProps.hxx>
#include <BRepBuilderAPI_MakePolygon.hxx>
#include <BRepBuilderAPI_MakeFace.hxx>
#include <BRepBuilderAPI_MakeVertex.hxx>
#include <BRepAlgoAPI_Section.hxx>
#include <GCPnts_AbscissaPoint.hxx>

#include <BRepAdaptor_Curve.hxx>
#include <TopoDS.hxx>
#include <TopoDS_Shape.hxx>
#include <TopExp_Explorer.hxx>
#include <Geom_Curve.hxx>

#include <gp.hxx>

#include <Geom_Curve.hxx>
#include <Geom_Surface.hxx>

#include <BRepBuilderAPI_MakeEdge.hxx>
#include <BRep_Tool.hxx>
#include <TopExp.hxx>
#include <TopoDS_Edge.hxx>
#include <TopoDS_Wire.hxx>
#include <TopoDS_Face.hxx>
#include <Geom_Plane.hxx>
#include <GProp_GProps.hxx>
#include <BRepGProp.hxx>

#include <IGESControl_Writer.hxx>
#include <STEPControl_Writer.hxx>
#include <IGESControl_Reader.hxx>
#include <STEPControl_Reader.hxx>

#include <BRepAdaptor_Curve.hxx>

#include <AIS_TextLabel.hxx>

#include <QOpenGLContext>
#include <QString>
#include <QFileDialog>

const Handle_AIS_InteractiveContext OcctView::getContext() const
{
    return m_context;
}

const Handle_V3d_View OcctView::getView() const
{
    return m_view;
}

const Handle_V3d_Viewer OcctView::getViewer() const
{
    return m_viewer;
}


OcctView::OcctView(QQuickItem* parent) :
	QQuickItem(parent)
{
	QObject::connect(this, &QQuickItem::windowChanged, this, &OcctView::onWindowChanged, Qt::DirectConnection);

}

void OcctView::onWindowChanged(QQuickWindow* window)
{
	if (!window)
		return;

	QObject::connect(window, &QQuickWindow::beforeSynchronizing, this, &OcctView::onSynchronizing, Qt::DirectConnection);
	QObject::connect(window, &QQuickWindow::sceneGraphInvalidated, this, &OcctView::onInvalidating, Qt::DirectConnection);

    window->setClearBeforeRendering(false);
}

void OcctView::onSynchronizing()
{
	// If the viewer is not yet initialized, initialize it.
	if (m_viewer.IsNull())
	{
		this->initializeViewer(Aspect_Drawable(this->window()->winId()));
		QObject::connect(this->window(), &QQuickWindow::beforeRendering, this, &OcctView::onRendering, Qt::DirectConnection);
	}

	// Get the control position and size.
	QPoint viewportPos = this->mapToGlobal(QPointF(0, 0)).toPoint();
	QSize viewportSize = this->size().toSize();

	// Check if the viewport needs to be resized.
	if (viewportPos.x() != m_viewportPos.x() || viewportPos.y() != m_viewportPos.y())
        m_view->MustBeResized();
	if (viewportSize.width() != m_viewportSize.width() || viewportSize.height() != m_viewportSize.height())
	{
        m_view->MustBeResized();
		m_view->Invalidate();
	}

	// Store the current pos and size.
	m_viewportPos = viewportPos;
	m_viewportSize = viewportSize;
}

void OcctView::onInvalidating()
{
	m_view.Nullify();
	m_context.Nullify();
	m_viewer.Nullify();
}

void OcctView::onRendering()
{
	if (m_view.IsNull())
		return;

	m_mutex.lock();
	// TODO: Handle user input.
	m_mutex.unlock();

	// Redraw the view.
	// NOTE: MustBeResized is called here, due to a bug that causes the background to
	//       go white, when hovering a MenuBar (and possibly other top-level QML items).
	m_view->Redraw();
    m_view->MustBeResized();
}

void OcctView::initializeViewer(const Aspect_Drawable& drawable)
{
	Q_ASSERT(m_viewer.IsNull());

    if (drawable == nullptr)
        return;

    // Request device and render context.
    auto deviceContext = wglGetCurrentDC();
    auto renderContext = wglGetCurrentContext();

    if (drawable == nullptr || deviceContext == nullptr || renderContext == nullptr)
        return;

    // Setup display driver.
    Handle(Aspect_DisplayConnection) display = new Aspect_DisplayConnection();
    Handle(OpenGl_GraphicDriver) driver = new OpenGl_GraphicDriver(display, Standard_False);
    driver->ChangeOptions().buffersNoSwap = Standard_True;
    //aDriver->ChangeOptions().glslWarnings  = Standard_True;

    // Create and setup the viewer.
    m_viewer = new V3d_Viewer(driver);
    m_viewer->SetDefaultBackgroundColor(Quantity_NOC_GRAY50);
    m_viewer->SetDefaultLights();
    m_viewer->SetLightOn();

    // Create and setup interactivity context.
    m_context = new AIS_InteractiveContext(m_viewer);
    m_context->SetDisplayMode(AIS_Shaded, false);

    // Create and setup view.
    Handle(WNT_Window) window = new WNT_Window(drawable);
    m_view = m_viewer->CreateView();

    m_view->SetImmediateUpdate(Standard_False);
    m_view->SetWindow(window, reinterpret_cast<Aspect_RenderingContext>(renderContext));
    m_view->TriedronDisplay(Aspect_TOTP_RIGHT_LOWER, Quantity_NOC_WHITESMOKE, 0.1, V3d_ZBUFFER);



}

//Функция не используется
void OcctView::createDemoScene()
{
	gp_Ax2 axis;
	axis.SetLocation(gp_Pnt(0.0, 10.0, 0.0));

	TopoDS_Shape bisqueCone = BRepPrimAPI_MakeCone(axis, 3.0, 1.5, 5.0).Shape();
	Handle(AIS_Shape) bisqueConeShape = new AIS_Shape(bisqueCone);
	bisqueConeShape->SetColor(Quantity_NOC_BISQUE);

	axis.SetLocation(gp_Pnt(8.0, 10.0, 0.0));
	TopoDS_Shape chocoCone = BRepPrimAPI_MakeCone(axis, 3.0, 0.0, 5.0).Shape();
	Handle(AIS_Shape) chocoConeShape = new AIS_Shape(chocoCone);
	chocoConeShape->SetColor(Quantity_NOC_CHOCOLATE);

    Handle_AIS_Shape aSphere = new AIS_Shape(BRepPrimAPI_MakeSphere(gp_Pnt(10,20,10),4));

	m_context->Display(bisqueConeShape, Standard_True);
	m_context->Display(chocoConeShape, Standard_True);
    m_context->Display(aSphere, Standard_True);

	// Fit all into the view.
	m_view->FitAll();
}

void OcctView::createSphere(double dX, double dY, double dZ, double dRad)
{

    if (dRad != 0)
    {
        TopoDS_Shape sphere = BRepPrimAPI_MakeSphere(gp_Pnt(dX,dY,dZ),dRad);
        Handle_AIS_Shape aSphere = new AIS_Shape(sphere);
        m_context->Display(aSphere, Standard_True);
        m_view->FitAll();
        shapes.push_back(sphere);
    }
}

void OcctView::createBlock(double dX, double dY, double dZ,
                           double A, double B, double C)
{
    TopoDS_Shape block = BRepPrimAPI_MakeBox(gp_Pnt(dX,dY,dZ),A,B,C);
     auto aBlock = new AIS_Shape(block);
    //aBlock->SetColor(Quantity_NOC_RED);
     m_context->Display(aBlock, Standard_True);
     m_view->FitAll();
     shapes.push_back(block);
}



void OcctView::rotationTheScene()
{
    myCurrentMode = CurAction3d_DynamicRotation;
}

void OcctView::movementTheScene()
{
    myCurrentMode = CurAction3d_DynamicPanning;
}

void OcctView::leftButtonDown(const int& x, const int& y)
{
    myXmin = x;
    myYmin = y;
    myXmax = x;
    myYmax = y;

}

void OcctView::middleButtonDown(const int& x, const int& y)
{
    myXmin = x;
    myYmin = y;
    myXmax = x;
    myYmax = y;
    if (myCurrentMode == CurAction3d_DynamicRotation)
    {
        m_view->StartRotation(x, y);
    }

}

void OcctView::wheelMove(const int& x, const int& y, const int& delta)
{
    Standard_Integer aFactor = 5;

    Standard_Integer aX = x;
    Standard_Integer aY = y;


    if (delta > 0)
    {
        aX += aFactor;
        aY += aFactor;
    }
    else
    {
        aX -= aFactor;
        aY -= aFactor;
    }

    m_view->Zoom(x, y, aX, aY);

    emit occViewChanged();
}

void OcctView::mMove(const int& x, const int& y)
{
    switch (myCurrentMode)
    {
    case CurAction3d_DynamicRotation:
        m_view->Rotation(x, y);
        emit occViewChanged();
        break;

    case CurAction3d_DynamicZooming:
        m_view->Zoom(myXmin, myYmin, x, y);
        emit occViewChanged();
        break;

    case CurAction3d_DynamicPanning:
        m_view->Pan(x - myXmax, myYmax - y);
        myXmax = x;
        myYmax = y;
        emit occViewChanged();
        break;

    default:
        break;
    }
}

void OcctView::mousePress(int x, int y, int buttonsFlag)
{
    if (buttonsFlag == Qt::LeftButton)
    {
        leftButtonDown(x, y);
    }
    else if (buttonsFlag == Qt::MiddleButton)
    {
        middleButtonDown(x, y);
    }
    else if (buttonsFlag == Qt::RightButton)
    {
        rightButtonDown();
    }
}

void OcctView::mouseRelease(int x, int y, int buttonsFlag)
{
    //Q_UNUSED(x)
    //Q_UNUSED(y)
    if (buttonsFlag == Qt::LeftButton)
    {
        leftButtonUp();
    }
    else if (buttonsFlag == Qt::MiddleButton)
    {
        middleButtonDown(x,y);
    }
    else if (buttonsFlag == Qt::RightButton)
    {
        rightButtonUp();
    }
}

void OcctView::mouseWheel(const int x, const int y, const int delta, const int buttonsFlag)
{
    if (buttonsFlag == Qt::NoButton)
    {
        wheelMove(x, y, delta);
    }
}

void OcctView::mouseMove(const int x, const int y, const int buttonsFlag)
{
    if (buttonsFlag == Qt::MiddleButton)
    {
        mMove(x, y);
    }
}

void OcctView::createModel(double dX,double dY,double dZ, double scale)
{
    gp_Ax2 axes1(gp_Pnt(dX, dY, dZ), gp_Dir (1, 0, 0));
    gp_Ax2 axes2(gp_Pnt(dX-21 * scale, dY+10 * scale, dZ+10 * scale), gp_Dir (1, 0, 0));

    TopoDS_Shape mainBox = BRepPrimAPI_MakeBox(gp_Pnt(dX, dY, dZ),26 * scale, 12 * scale, 15 * scale);

    TopoDS_Shape firstWedge = BRepPrimAPI_MakeWedge (axes1, 15 * scale, 24 * scale, 26 * scale, 6 * scale);

    TopoDS_Shape Model_main = BRepAlgoAPI_Fuse(mainBox, firstWedge);

    TopoDS_Shape boxcuttingfrom_mainBox = BRepPrimAPI_MakeBox(gp_Pnt(dX+9 * scale, dY-24 * scale, dZ),8 * scale, 18 * scale, 15 * scale);
    TopoDS_Shape Model_cut_box = BRepAlgoAPI_Cut(Model_main,boxcuttingfrom_mainBox);

    TopoDS_Shape maincyl = BRepPrimAPI_MakeCylinder(gp_Ax2(gp_Pnt(dX+5 * scale, dY+20 * scale, dZ+14 * scale),gp_Dir(1,0,0)),8 * scale,16 * scale);
    TopoDS_Shape Model_2 = BRepAlgoAPI_Fuse(Model_cut_box, maincyl);

    TopoDS_Shape cylcuttingfrom_maincyl = BRepPrimAPI_MakeCylinder(gp_Ax2(gp_Pnt(dX+5 * scale, dY+20 * scale, dZ+14 * scale),gp_Dir(1,0,0)),4.1 * scale,16 * scale);
    TopoDS_Shape Model_cut_cul = BRepAlgoAPI_Cut(Model_2, cylcuttingfrom_maincyl);

    TopoDS_Shape secondWedge = BRepPrimAPI_MakeWedge (axes2, 16.95 * scale, 10 * scale, 16 * scale, 10 * scale);

    gp_Trsf rotation;
    rotation.SetRotation(gp_Ax1(gp_Pnt(dX, dY, dZ), gp_Dir(1, 0, 0)), M_PI / 2.0);
    BRepBuilderAPI_Transform transform(rotation);
    transform.Perform(secondWedge);
    TopoDS_Shape rotatedShape = transform.ModifiedShape(secondWedge);

    gp_Trsf rotation2;
    rotation2.SetRotation(gp_Ax1(gp_Pnt(dX, dY, dZ), gp_Dir(0, 0, 1)), M_PI);
    BRepBuilderAPI_Transform transform2(rotation2);
    transform2.Perform(rotatedShape);
    TopoDS_Shape rotatedShape2 = transform2.ModifiedShape(rotatedShape);

    TopoDS_Shape Model_almostredy = BRepAlgoAPI_Fuse(Model_cut_cul, rotatedShape2);

    TopoDS_Shape fusedox = BRepPrimAPI_MakeBox(gp_Pnt(dX+5 * scale, dY+12 * scale, dZ),16 * scale, 2 * scale, 15 * scale);

    TopoDS_Shape Model_final = BRepAlgoAPI_Fuse(Model_almostredy, fusedox);

    auto Model = new AIS_Shape(Model_final);
    Model->SetColor(Quantity_NOC_GOLD);

    m_context->Display(Model, Standard_True);
    m_view->FitAll();
    shapes.push_back(Model_final);
}


void OcctView::intersectionLine(double dX1_1,double dY1_1,double dZ1_1,
                                double dX2_1,double dY2_1,double dZ2_1,
                                double dX3_1,double dY3_1,double dZ3_1,
                                double dX1_2,double dY1_2,double dZ1_2,
                                double dX2_2,double dY2_2,double dZ2_2,
                                double dX3_2,double dY3_2,double dZ3_2){
    gp_Pnt point1_1(dX1_1, dY1_1, dZ1_1);
    gp_Pnt point2_1(dX2_1, dY2_1, dZ2_1);
    gp_Pnt point3_1(dX3_1, dY3_1, dZ3_1);

    gp_Pnt point1_2(dX1_2, dY1_2, dZ1_2);
    gp_Pnt point2_2(dX2_2, dY2_2, dZ2_2);
    gp_Pnt point3_2(dX3_2, dY3_2, dZ3_2);

//    Координаты точек по умолчанию
//    gp_Pnt point1_1(101,111,121);
//    gp_Pnt point2_1(223, 121, 151);
//    gp_Pnt point3_1(142, 151, 171);

//    gp_Pnt point1_2(266, 155, 161);
//    gp_Pnt point2_2(131, 121, 131);
//    gp_Pnt point3_2(121, 112, 161);

    TopoDS_Vertex v1_1 = BRepBuilderAPI_MakeVertex(point1_1);
    TopoDS_Vertex v2_1 = BRepBuilderAPI_MakeVertex(point2_1);
    TopoDS_Vertex v3_1 = BRepBuilderAPI_MakeVertex(point3_1);
    TopoDS_Wire mesh1 = BRepBuilderAPI_MakePolygon(v1_1, v2_1, v3_1, Standard_True);
    TopoDS_Face face1 = BRepBuilderAPI_MakeFace(mesh1);
    Handle(AIS_Shape) triangle1 = new AIS_Shape(face1);
    triangle1->SetColor(Quantity_NOC_GOLD);
    m_context->Display(triangle1, Standard_True);


    TopoDS_Vertex v1_2 = BRepBuilderAPI_MakeVertex(point1_2);
    TopoDS_Vertex v2_2 = BRepBuilderAPI_MakeVertex(point2_2);
    TopoDS_Vertex v3_2 = BRepBuilderAPI_MakeVertex(point3_2);
    TopoDS_Wire mesh2 = BRepBuilderAPI_MakePolygon(v1_2, v2_2, v3_2, Standard_True);
    TopoDS_Face face2 = BRepBuilderAPI_MakeFace(mesh2);
    Handle(AIS_Shape) triangle2 = new AIS_Shape(face2);
    triangle2->SetColor(Quantity_NOC_PERU);
    m_context->Display(triangle2, Standard_True);

    BRepAlgoAPI_Section section(face1, face2);
    Handle(AIS_Shape) intersectionLine = new AIS_Shape(section.Shape());
    intersectionLine->SetColor(Quantity_NOC_GREEN4);
    intersectionLine->SetDisplayMode(AIS_Shaded);
    intersectionLine->SetWidth(2.0);
    m_context->Display(intersectionLine, Standard_True);

//    TopoDS_Edge edge = TopoDS::Edge(section);
//    GProp_GProps edgeProps;
//    BRepGProp::LinearProperties(edge, edgeProps);
//    double edgeLength = edgeProps.Mass();

    GProp_GProps props;
    BRepGProp::LinearProperties(section.Shape(), props);
    double length = props.Mass();

//    Вывод длинны пересецения во вьювер
//    Handle(AIS_TextLabel) textLabel = new AIS_TextLabel();
//    std::to_string(length);
//    textLabel->SetText(length);
//    textLabel->SetPosition(gp_Pnt(0, 0, 0));
//    m_context->Display(textLabel, Standard_True);

//    m_view->FitAll();

    m_resultValue = length;
    //Выполнените данной функции вызывает
    //ошибку QML при которой пропадают шрифты
    emit resultValueChanged();

    //Данные функции сохраняют только треугольники
    //линия пересечения не сохраняется
    shapes.push_back(face1);
    shapes.push_back(face2);

}

void OcctView::erase(){
    m_context->RemoveAll(Standard_True);
    m_context->UpdateCurrentViewer();
    emit occViewChanged();
}

//Функция save() работает не коректнно т.к.
//записывает данные о всех созданных шейпах
//в течении работы, как инициализированных,
//так и уже удаленных
void OcctView::save(){
    TopoDS_Compound compound;
    BRep_Builder builder;
    builder.MakeCompound(compound);

    for (const auto& shape : shapes) {
        builder.Add(compound, shape);
    }

    QString strFilter="*.step";
    QString file = QFileDialog::getSaveFileName(qobject_cast<QWidget*>(window()),tr("Сохранить файл"),
                                                QDir::currentPath(),
                                                tr("STEP format(*.step);; IGES format(*.iges)"),
                                                &strFilter);
    if (!file.isEmpty()){
        std::string str = qPrintable(file);
        const char* filename = str.c_str();

        if (strFilter.contains(".step"))
        {

            STEPControl_Writer stepWriter;
            stepWriter.Transfer(compound,STEPControl_ManifoldSolidBrep);
            stepWriter.Write(filename);
        }
        if (strFilter.contains(".iges"))
        {
            IGESControl_Writer igesWriter;
            igesWriter.AddShape(compound);
            igesWriter.ComputeModel();
            igesWriter.Write(filename);
        }
    }
}

void OcctView::open(){
    QString strFilter = tr("STEP format(*.step);;IGES format(*.iges)");
    QString file = QFileDialog::getOpenFileName(qobject_cast<QWidget*>(window()), tr("Открыть файл"),
                                                QDir::currentPath(), strFilter);
    if (!file.isEmpty()) {
        std::string str = qPrintable(file);
        const char* filename = str.c_str();

        if (file.endsWith(".step", Qt::CaseInsensitive)) {
            STEPControl_Reader reader;
            reader.ReadFile(filename);
            // Loads file MyFile.stp
            Standard_Integer NbRoots = reader.NbRootsForTransfer();
            Standard_Integer NbTrans = reader.TransferRoots();
            TopoDS_Shape result = reader.OneShape();
            Handle(AIS_Shape) aAISShape = new AIS_Shape(result);
            getContext()->Display(aAISShape, true);
        }
        else if (file.endsWith(".iges", Qt::CaseInsensitive)) {
            IGESControl_Reader myIgesReader;
            Standard_Integer nIgesFaces, nTransFaces;
            myIgesReader.ReadFile(filename);
            Handle(TColStd_HSequenceOfTransient) myList = myIgesReader.GiveList();
            nIgesFaces = myList->Length();
            nTransFaces = myIgesReader.TransferList(myList);
            TopoDS_Shape sh = myIgesReader.OneShape();
            Handle(AIS_Shape) aAISShape = new AIS_Shape(sh);
            getContext()->Display(aAISShape, true);
        }
    }
    emit occViewChanged();
}
