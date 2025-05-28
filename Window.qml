
/* Ketangpai is a free online education service platform.
 * The file defines the appwindow of Ketangpai and setts up all UI's logic, except the content's.
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    width: 500
    height: 600
    maximumHeight: 600
    maximumWidth: 500
    minimumHeight: 600
    minimumWidth: 500
    visible: true
    title: qsTr("KeTangPai")

    // 主内容区域
    Content {
        id: content

        Connections {
            target: content.currentPage
            ignoreUnknownSignals: true
            function onExitCreateCoursePage() {
                content.stackView.pop()
            }
        }
        anchors.fill: parent
        //获取当前页面
        property var currentPage: stackView.currentItem

        //-----------------------------------------学生------------------------------------------------
        //学生当在首页点击加入课程时，发出信号-以显示加入课程的三个选项的对话框
        Connections {
            target: content.currentPage
            ignoreUnknownSignals: true
            function onJoinCourses_student() {
                content.joinCourses_student()
            }
        }

        //学生当在首页点击加入课程时，显示加入课程的三个选项中“取消”的处理器，即关闭界面
        dialogs.cancelJoinCourse_student.onClicked: {
            content.cancelJoinCourse()
        }

        //学生点击课程区域，可进入课程详情页
        Connections {
            target: content.currentPage
            ignoreUnknownSignals: true
            function onClickCourse_student() {
                content.clickCourse_student()
            }
        }
        //学生点击作业区域，进入作业详情页
        Connections {
            target: content.currentPage
            ignoreUnknownSignals: true
            function onPushHomework_student() {
                content.pushHomework_student()
            }
        }

        //学生点击提交作业区域，进入提交作业界面
        Connections{
            target: content.currentPage
            ignoreUnknownSignals: true
            function onSubmitHomework(){
                content.submitHomework()
            }
        }


        //----------------------------------------老师-------------------------------------------------------
        //老师创建课程
        dialogs.onCreateCourse: {
            content.cancelJoinCourse()
            stackView.push(Qt.resolvedUrl("Createcourse_teacher.qml"))
        }

        //老师当在首页点击加入课程时，发出信号-以显示加入课程的四个选项的对话框
        Connections {
            target: content.currentPage
            ignoreUnknownSignals: true
            function onJoinCourses_teacher() {
                content.joinCourses_teacher()
            }
        }

        //老师当在首页点击加入课程时，显示加入课程的四个选项中“取消”的处理器，即关闭界面
        dialogs.cancelJoinCourse_teacher.onClicked: {
            content.cancelJoinCourse()
        }

        //老师点击课程区域，可进入课程详情页
        Connections {
            target: content.currentPage
            ignoreUnknownSignals: true
            function onClickCourse_teacher() {
                content.clickCourse_teacher()
            }
        }

        //老师点击作业区域，进入作业详情页
        Connections {
            target: content.currentPage
            ignoreUnknownSignals: true
            function onPushHomework_teacher() {
                content.pushHomework_teacher()
            }
        }

        //----------------------------------------老师和学生共同有的---------------------------------------------------
        // 登录成功(分老师登录成功和学生登录成功的情况)
        Connections {
            target: content.currentPage
            ignoreUnknownSignals: true
            function onTeacherLoginSuccessfully(userData) {
                //这里的userData是所有的user数据，包括密码，创建时间
                User.userId = userData.user_id
                User.role = userData.role
                content.stackView.push(Qt.resolvedUrl("HomePage_teacher.qml"))
            }
            function onStudentLoginSuccessfully(userData) {
                User.userId = userData.user_id
                User.role = userData.role
                content.stackView.push(Qt.resolvedUrl("HomePage_student.qml"))

            }
        }

        //学生/老师打开输入课程码页面
        dialogs.onDisplayCourseCode: {
                content.cancelJoinCourse()
                stackView.push(Qt.resolvedUrl("DisplayCourseCodePage.qml"))
        }

        //退出当前页面
        Connections {
            target: content.currentPage
            ignoreUnknownSignals: true
            function onExitThisPage() {
                console.log("exit this page ")
                content.exitThisPage()
            }
        }
    }
}
