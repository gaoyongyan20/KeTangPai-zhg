#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "httpserver.h"
#include "user.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    User user;
    //服务端
    HttpServer *httpServer = new HttpServer();
    if (!httpServer->startServer()) {
        qDebug() << "服务器启动失败";
        return -1;
    }

    // 客户端
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("User", &user);
    const QUrl url(QStringLiteral("qrc:/Ketangpai/Window.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
