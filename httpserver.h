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
    void start(); // 启动监听、注册路由

private:
    QHttpServer httpServer;
    void registerRoutes(); // 注册所有路由
};
