// 这是连接业务逻辑层和前端界面层的桥接类
// zykl
#pragma once
#include <QObject>
#include "courseservice.h"

class CourseBridge : public QObject
{
    Q_OBJECT

public:
    explicit CourseBridge(QObject* parent = nullptr);

    // 设置CourseService对象
    void initializeService();

public slots:
    Q_INVOKABLE void load_StudnetCoursesFor(int student_id);
    Q_INVOKABLE void load_TeacherCoursesFor(int teacher_id);

signals:
    void studentCoursesLoaded(QString jsonResoult); //无参数的信号
    void teacherCoursesLoaded(QString jsonResoult); //无参数的信号

private:
    QString m_jsonResoult;
    CourseService* m_service;
};
