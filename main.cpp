#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext> //注册C++类user的时候用的
#include "CourseBridge.h"
#include "httpserver.h"
#include "user.h"

int main(int argc, char *argv[])
{
    // 先运行后端服务器
    // 创建服务器实体
    // HttpServer httpServer;
    // // 该程序启动在指定端口：8080
    // if (!httpServer.startServer(8088)) {
    //     return 1;
    // }

    // qDebug() << "http server running...";

    // QGuiApplication app(argc, argv);
    // // 再运行客户端
    // QQmlApplicationEngine engine;
    // const QUrl url(QStringLiteral("qrc:/Ketangpai/Window.qml"));
    // QObject::connect(
    //     &engine,
    //     &QQmlApplicationEngine::objectCreationFailed,
    //     &app,
    //     []() { QCoreApplication::exit(-1); },
    //     Qt::QueuedConnection);
    // engine.load(url);

    // return app.exec();

    //---------------------------------------------------------------------------------
    QGuiApplication app(argc, argv);

    HttpServer server;
    server.start(); // 启动网络服务

    User user;
    CourseBridge coursebridge;

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/Ketangpai/Window.qml"));

    //注册C++文件
    engine.rootContext()->setContextProperty("User", &user);
    engine.rootContext()->setContextProperty("courseBridge", &coursebridge);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
