// 该程序实现处理网络请求的服务器类
// author：何泳珊 date:2025-4-6

#include "httpserver.h"
#include <QDebug>

HttpServer::HttpServer(QObject *parent)
    : QObject(parent)
{
    m_server = new QTcpServer(this); // this ?
}

// 析构函数 （理由？）
HttpServer::~HttpServer()
{
    // 停止服务器
    // stopServer()
    delete m_server;
}

// 启动服务器
bool HttpServer::startServer(quint16 port)
{
    // 检查服务器是否已在监听
    if (m_server->isListening()) {
        qWarning() << "the server is already running";
        return true;
    }

    // 尝试监听指定端口
    // 告诉服务器监听地址地址和端口上的传入连接,Any表示监听任意接口上的连接
    if (!(m_server->listen(QHostAddress::Any, port))) {
        qWarning() << "Failed to start Server" << m_server->errorString();
        return false;
    }

    qDebug() << "Server started on port:" << port;
    // 发射服务器启动信号？为什么要发送
    // emit serverStarted(); // 发射服务器启动信号
    return true;
}
