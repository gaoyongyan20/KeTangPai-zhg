// 该程序实现处理网络请求的服务器类
// author：何泳珊 date:2025-4-6

#include "httpserver.h"
#include <QDebug>
#include <QTcpSocket>
#include "databasemanagement.h"
#include "loginservice.h"

HttpServer::HttpServer(QObject *parent)
    : QObject(parent)
{
    m_httpServer = new QHttpServer(this);
}

HttpServer::~HttpServer()
{
    delete m_httpServer;
}

bool HttpServer::startServer()
{
    registerRoutes(); // 注册路由
    if (m_httpServer->listen(QHostAddress::Any, 8088)) {
        qDebug() << "服务器连接成功";
        // 连接数据库
        DatabaseManagement::instance().connectToDatabase();
        return true;
    } else {
        qWarning() << "服务器连接失败";
        return false;
    }
}

void HttpServer::registerRoutes()
{
    //登录服务
    LoginService *loginService = new LoginService(this); // 注册登录路由
    m_httpServer->route("/login",
                        QHttpServerRequest::Method::Post,
                        [loginService](const QHttpServerRequest &req) {
                            return loginService->handleLogin(req);
                        });
}
