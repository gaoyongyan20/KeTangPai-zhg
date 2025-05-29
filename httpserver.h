// 该类是程序的处理网络请求的服务器类 - 通信层
#pragma once
#include <QHttpServer>
#include <QObject>

class HttpServer : public QObject
{
    Q_OBJECT
public:
    explicit HttpServer(QObject *parent = nullptr);
    // void start(); // 启动监听、注册路由
    // 启动服务器
    bool startServer();
    ~HttpServer();

private:
    QHttpServer *m_httpServer;
    // QHttpServer httpServer;
    //构造路由表
    void registerRoutes();
};
