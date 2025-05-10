import QtQuick
import QtQuick.Controls

Item {
    id: root
    width: parent.width
    height: parent.height
    property alias stackView: _stackView
    // 移除预先加载的页面属性
    // 改为动态加载页面

    // 导航方法
    function navigateToPage2() {
        stackView.push(Qt.resolvedUrl("HomeworkDetail_student.qml"))
    }
    function navigateToPage3() {
        stackView.pop(Qt.resolvedUrl("HomeworkDetail_student.qml"))
    }
    function navigateToPage4() {
        stackView.push(Qt.resolvedUrl("Page4.qml"))
    }

    StackView {
        id: _stackView
        anchors.fill: parent
        initialItem: courseDetail_teacher

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

    CourseDetail_teacher {
        id: courseDetail_teacher
        onPushHomework:{
            var component = Qt.createComponent("HomeworkDetail_student.qml")
                        if (component.status === Component.Ready) {
                            var homeworkPage = component.createObject(root)
                            homeworkPage.popHomework.connect(navigateToPage3)  // 连接信号
                            stackView.push(homeworkPage)
                        }
        }
    }

}
