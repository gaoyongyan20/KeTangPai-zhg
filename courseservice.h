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

    // 处理加入课程的业务逻辑
    QHttpServerResponse handleJoin(const QHttpServerRequest &request);
    // 处理创建课程的业务逻辑
    QHttpServerResponse handleCreateCourse(const QHttpServerRequest &request);
    // 处理加载学生创建的所有课程的业务逻辑
    QHttpServerResponse handleLoadStudentCourses(const QHttpServerRequest &request);
    // 处理加载老师创建的所有课程的业务逻辑
    QHttpServerResponse handleLoadTeacherCourses(const QHttpServerRequest &request);

private:
    // 查询数据库
    QPair<bool, QString> checkCredentials(const int &user_id, const QString &course_code);
    // ---- 加入课程成功/失败的响应
    QHttpServerResponse successResponse();
    QHttpServerResponse errorResponse(const QString &message);

    // 生成加课码
    QString generateJoinCode();
    //获取该老师创建课程的详细信息
    QPair<bool, QJsonArray> getCoursesesJsonForTeacher(int teacher_id);
    // 获取该学生所有课程的详细信息
    QPair<bool, QJsonArray> getCoursesesJsonForStudent(int student_id);
};
