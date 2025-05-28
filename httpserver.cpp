// // 该程序实现处理网络请求的服务器类
// // author：何泳珊 date:2025-4-6

// #include "httpserver.h"
// #include <QDebug>

// HttpServer::HttpServer(QObject *parent)
//     : QObject(parent)
// {
//     m_server = new QTcpServer(this); // this ?
// }

// // 析构函数 （理由？）
// HttpServer::~HttpServer()
// {
//     // 停止服务器
//     // stopServer()
//     delete m_server;
// }

// // 启动服务器
// bool HttpServer::startServer(quint16 port)
// {
//     // 检查服务器是否已在监听
//     if (m_server->isListening()) {
//         qWarning() << "the server is already running";
//         return true;
//     }

//     // 尝试监听指定端口
//     // 告诉服务器监听地址地址和端口上的传入连接,Any表示监听任意接口上的连接
//     if (!(m_server->listen(QHostAddress::Any, port))) {
//         qWarning() << "Failed to start Server" << m_server->errorString();
//         return false;
//     }

//     qDebug() << "Server started on port:" << port;
//     // 发射服务器启动信号？为什么要发送
//     // emit serverStarted(); // 发射服务器启动信号
//     return true;
// }

#include "httpserver.h"
#include <QDebug>
#include "courseservice.h"
#include "databasemanagement.h"
#include "loginservice.h"

HttpServer::HttpServer(QObject *parent)
    : QObject(parent)
{}

void HttpServer::start()
{
    registerRoutes(); // 注册路由

    if (httpServer.listen(QHostAddress::Any, 8080)) {
        qDebug() << "HTTP Server started at http://10.253.217.81:8080";
    } else {
        qWarning() << "Failed to start HTTP Server";
    }

    // 连接数据库
    DatabaseManagement::instance().connect();
}

void HttpServer::registerRoutes()
{
    LoginService *loginService = new LoginService(this); // 注册登录路由  创建登录服务实例
    CourseService *courseService = new CourseService(this); //创建课程处理的实例

    // [] - 捕获的外部变量，不加&表示的是值捕获
    // （）- 参数列表，const表示不会修改这个请求对象，&表示引用传递，避免拷贝整个请求对象
    //三个参数：
    // 1. 路径：/login
    // 2. HTTP方法：POST
    // 3. 处理函数：Lambda表达式
    httpServer.route("/login",
                     QHttpServerRequest::Method::Post,
                     [loginService](const QHttpServerRequest
                                        &req) { //常量引用传递HTTP请求对象，避免深拷贝提高性能
                         return loginService->handleLogin(req);
                     });

    httpServer.route("/joincourse",
                     QHttpServerRequest::Method::Post,
                     [courseService](const QHttpServerRequest
                                         &req) { //常量引用传递HTTP请求对象，避免深拷贝提高性能
                         return courseService->handleJoin(req);
                     });
}
