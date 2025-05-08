// 该类是程序的处理网络请求的服务器类
// author：何泳珊 date:2025-4-6
#pragma once

#include <QObject>
#include <QTcpServer> // TCP服务器类
#include <QTcpSocket> // TCP套接字类

class HttpServer : public QObject
{
    Q_OBJECT
public:
    explicit HttpServer(QObject *parent = nullptr);
    ~HttpServer();

    // 启动服务器
    bool startServer(quint16 port);

signals:
    void serverStarted(); // 服务器启动信号

private:
    QTcpServer *m_server;
};
