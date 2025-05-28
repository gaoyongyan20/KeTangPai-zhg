#include "httpserver.h"
#include "courseservice.h"
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

// 启动服务器
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
// 注册路由
void HttpServer::registerRoutes()
{

    // [] - 捕获的外部变量，不加&表示的是值捕获
    // （）- 参数列表，const表示不会修改这个请求对象，&表示引用传递，避免拷贝整个请求对象
    //三个参数：
    // 1. 路径：/login
    // 2. HTTP方法：POST
    // 3. 处理函数：Lambda表达式

    //登录服务
    LoginService *loginService = new LoginService(this); // 注册登录路由
    // 课程相关服务
    CourseService *courseService = new CourseService(this);
    // 处理登录请求
    m_httpServer->route("/login",
                        QHttpServerRequest::Method::Post,
                        [loginService](const QHttpServerRequest &req) {
                            return loginService->handleLogin(req);
                        });
    // 处理创建课程请求
    m_httpServer->route("/createCourse",
                        QHttpServerRequest::Method::Post,
                        [courseService](const QHttpServerRequest &req) {
                            return courseService->handleCreateCourse(req);
                        });
    // 处理加入课程请求
    m_httpServer->route("/joincourse",
                        QHttpServerRequest::Method::Post,
                        [courseService](const QHttpServerRequest
                                            &req) { //常量引用传递HTTP请求对象，避免深拷贝提高性能
                            return courseService->handleJoin(req);
                        });
}
