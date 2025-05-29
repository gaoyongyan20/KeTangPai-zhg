#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext> //注册C++类user的时候用的
#include "httpserver.h"
#include "user.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // //服务端
    // HttpServer *httpServer = new HttpServer();
    // if (!httpServer->startServer()) {
    //     qDebug() << "服务器启动失败";
    //     return -1;
    // }

    QQmlApplicationEngine engine;
    // 客户端
    // 注册C++类型
    User user;
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
