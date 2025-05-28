#pragma once
#include <QHttpServerRequest>
#include <QHttpServerResponse>
#include <QObject>

class CourseService : public QObject
{
    Q_OBJECT
public:
    explicit CourseService(QObject *parent = nullptr);
    QHttpServerResponse handleJoin(const QHttpServerRequest &request);
    QJsonArray getCoursesesJsonForStudent(int student_id);
    void cou();

private:
    QPair<bool, QString> checkCredentials(const int &user_id, const QString &course_code);
    QHttpServerResponse successResponse(const int &user_id, const QString &course_code);
    QHttpServerResponse errorResponse(const QString &message);
};
