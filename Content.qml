// 主页面层，封装了StackView
import QtQuick
import QtQuick.Controls
import "CourseController.js" as CourseController

Item {
    //stackView  id
    property alias stackView: _stackView
    //对话框（整体）
    property alias dialogs: _dialogs
    ////获取当前页面
    property var currentPage: stackView.currentItem

    //特征
    id: root
    width: parent.width
    height: parent.height

    //--------------------------------学生-----------------------------------------
    //学生在首页点击加入课程时，发出信号-以显示加入课程三个选项对话框的槽函数实现
    function joinCourses_student() {
        dialogs.joinCourseDialog_student.open()
    }

    //学生点击课程区域，可进入课程详情页槽函数实现
    function clickCourse_student() {
        _stackView.push(Qt.resolvedUrl("CourseDetail_student.qml"))

    }

    //学生点击作业区域，进入作业详情页实现
    function pushHomework_student(){
        _stackView.push(Qt.resolvedUrl("HomeworkDetail_student.qml"))
    }

    //学生点击提交作业区域（在学生作业详情界面的），进入作业提交界面
    function submitHomework(){
        _stackView.push(Qt.resolvedUrl("Submithomework.qml"))
    }

    //---------------------------------老师----------------------------------------

    //老师在首页点击加入课程时，发出信号-以显示加入课程四个选项对话框的槽函数实现
    function joinCourses_teacher() {
        dialogs.joinCourseDialog_teacher.open()
    }

    //老师点击课程区域，可进入课程详情页槽函数实现
    function clickCourse_teacher() {
        _stackView.push(Qt.resolvedUrl("CourseDetail_teacher.qml"))
    }

     //老师点击作业区域，进入作业详情页
    function pushHomework_teacher(){
        _stackView.push(Qt.resolvedUrl("HomeworkDetail_teacher.qml"))
    }



    //----------------------------老师和学生共同--------------------------------------

    //退出当前页面
    function exitThisPage() {
        _stackView.pop()
    }

    //老师/学生在首页点击加入课程时，显示加入课程三个选项中 取消 按钮的槽函数实现
    function cancelJoinCourse() {
        dialogs.joinCourseDialog_student.close()
        dialogs.joinCourseDialog_teacher.close()
    }


    //---------------------------------视图------------------------------------------
    Dialogs {
        id: _dialogs

    }

    StackView {
        id: _stackView
        anchors.fill: parent

        initialItem: login


        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }

    }
        Login {
            id: login
        }
    }

