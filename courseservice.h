// 处理课程相关的业务逻辑
// 2025-5-26
#pragma once
#include <QHttpServerRequest>
#include <QHttpServerResponse>
#include <QObject>

class CourseService : public QObject
{
    Q_OBJECT
public:
    explicit CourseService(QObject *parent = nullptr);
    // 处理创建课程的业务逻辑
    QHttpServerResponse handleCreateCourse(const QHttpServerRequest &request);

private:
    // 生成加课码
    QString generateJoinCode();
    QHttpServerResponse errorResponse(const QString &message);
};
