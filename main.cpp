#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "httpserver.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // 先运行后端服务器
    // 创建服务器实体
    HttpServer httpServer;
    // 该程序启动在指定端口：8080
    if (!httpServer.startServer(8088)) {
        return 1;
    }

    qDebug() << "http server running...";
    // 再运行客户端
    QQmlApplicationEngine engine;
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
