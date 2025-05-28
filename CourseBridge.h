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
    Q_INVOKABLE void loadCoursesFor(int student_id);

signals:
    void coursesLoaded(QString jsonResoult); //无参数的信号

private:
    QString m_jsonResoult;
    CourseService* m_service;
};
