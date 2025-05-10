import QtQuick
import QtQuick.Controls

Item {
    //stackView  id
    property alias stackView: _stackView
    //对话框（整体）
    property alias dialogs: _dialogs

    //特征
    id: root
    width: parent.width
    height: parent.height
    visible: true

    ////获取当前页面
    property var currentPage: stackView.currentItem

    //学生在首页点击加入课程时，发出信号-以显示加入课程三个选项对话框的槽函数实现
    function joinCourses_student() {
        dialogs.joinCourseDialog_student.open()
    }

    //老师/学生在首页点击加入课程时，显示加入课程三个选项中 取消 按钮的槽函数实现
    function cancelJoinCourse() {
        dialogs.joinCourseDialog_student.close()
        dialogs.joinCourseDialog_teacher.close()
    }

    //老师在首页点击加入课程时，发出信号-以显示加入课程四个选项对话框的槽函数实现
    function joinCourses_teacher() {
        dialogs.joinCourseDialog_teacher.open()
    }

    //退出当前页面
    function exitThisPage() {
        _stackView.pop()
    }

    //点击课程区域，可进入课程详情页槽函数实现-------------------zhou姐姐------------------------
    function clickCourse() {
        _stackView.push(Qt.resolvedUrl("DisplayCourseCodePage.qml"))
    }

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

        Login {
            id: login
        }
    }
}
