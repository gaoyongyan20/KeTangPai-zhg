// 该类是程序的处理网络请求的服务器类
// author：何泳珊 date:2025-4-6
#pragma once

#include <QHttpServer>
#include <QObject>

class HttpServer : public QObject
{
    Q_OBJECT
public:
    explicit HttpServer(QObject *parent = nullptr);
    ~HttpServer();

    // 启动服务器
    bool startServer();

private:
    QHttpServer *m_httpServer;
    //构造路由表
    void registerRoutes();
};
