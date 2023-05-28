#ifndef OCCTVIEW_H
#define OCCTVIEW_H

#include <QtQuick/QQuickItem>
#include <QtQuick/qquickwindow.h>
#include <qmutex.h>

#include <OpenGl_GraphicDriver.hxx>
#include <V3d_View.hxx>
#include <V3d_Viewer.hxx>
#include <AIS_InteractiveContext.hxx>
#include <Graphic3d_Vec2.hxx>

#include <Aspect_Drawable.hxx>
#include <Aspect_DisplayConnection.hxx>
#include <TopoDS_Shape.hxx>

#include <QObject>
#include <QString>
#include <vector>

//Renderer class
class OcctView : public QQuickItem
{
	Q_OBJECT
    Q_PROPERTY(QString message READ message NOTIFY messageChanged)
    Q_PROPERTY(double resultValue READ resultValue NOTIFY resultValueChanged)


	// Member fields.
private:
	Handle(V3d_Viewer)				m_viewer { nullptr };
	Handle(V3d_View)				m_view { nullptr };
	Handle(AIS_InteractiveContext)	m_context { nullptr };

	QSize							m_viewportSize;
	QPoint							m_viewportPos;
	QMutex							m_mutex;
	// Properties.
public:
    QString m_message;

    QString message() const {
        return m_message;
    }

    double m_resultValue;

    double resultValue() const {
        return m_resultValue;
    }
	// Constructor/Destructor.
public:
	explicit OcctView(QQuickItem* parent = nullptr);

	// Signals.
signals:

	// Slots.
private slots:
	void onWindowChanged(QQuickWindow* window);

public slots:
	void onSynchronizing();
	void onInvalidating();
	void onRendering();

	// Public interface.
public:
    const Handle_AIS_InteractiveContext getContext() const;
    const Handle_V3d_View getView() const;
    const Handle_V3d_Viewer getViewer() const;

	// Protected interface.
protected:
	void initializeViewer(const Aspect_Drawable& drawable);

	// Private interface.
public:
    Q_INVOKABLE void createDemoScene();
    Q_INVOKABLE void createSphere(double dX,double dY,double dZ,double dRad);
    Q_INVOKABLE void createBlock(double dX,double dY,double dZ,
                                 double A,double B, double C);
    Q_INVOKABLE void createModel(double dX,double dY,double dZ, double scale);
    Q_INVOKABLE void intersectionLine(double dX1_1,double dY1_1,double dZ1_1,
                                 double dX2_1,double dY2_1,double dZ2_1,
                                 double dX3_1,double dY3_1,double dZ3_1,
                                 double dX1_2,double dY1_2,double dZ1_2,
                                 double dX2_2,double dY2_2,double dZ2_2,
                                 double dX3_2,double dY3_2,double dZ3_2);
    Q_INVOKABLE void erase();
    Q_INVOKABLE void save();
    Q_INVOKABLE void open();
private:
    //save the mouse position.
    Standard_Integer myXmin;
    Standard_Integer myYmin;
    Standard_Integer myXmax;
    Standard_Integer myYmax;

    //mouse actions.
    enum CurrentAction3d
    {
        CurAction3d_Nothing,
        CurAction3d_DynamicZooming,
        CurAction3d_WindowZooming,
        CurAction3d_DynamicPanning,
        CurAction3d_GlobalPanning,
        CurAction3d_DynamicRotation
    };

    //the mouse current mode.
    CurrentAction3d myCurrentMode {CurAction3d_DynamicRotation};



private:
    //Mouse
    void leftButtonDown(const int& x, const int& y);
    void middleButtonDown(const int& x, const int& y);
    void rightButtonDown() {};
    void leftButtonUp() {};
    void middleButtonUp() {};
    void rightButtonUp() {};
    void wheelMove(const int& x, const int& y, const int& delta);
    void mMove(const int& x, const int& y);

signals:
    void occViewChanged();
    void clicked();
    void messageChanged();
    void resultValueChanged();
public slots:
    //slots for mouse events.
    void mousePress (const int x, const int y, const int buttonsFlag);
    void mouseRelease (const int x, const int y, const int buttonsFlag);
    void mouseWheel (const int x, const int y, const int delta, const int buttonsFlag);
    void mouseMove (const int x, const int y, const int buttonsFlag);

    void rotationTheScene();
    void movementTheScene();
private:
    std::vector<TopoDS_Shape> shapes;
};

#endif // OCCTVIEW_H
