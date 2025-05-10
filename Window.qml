
/* Ketangpai is a free online education service platform.
 * The file defines the appwindow of Ketangpai and setts up all UI's logic, except the content's.
 * Author: 何泳珊
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    width: 500
    height: 600
    visible: true
    title: qsTr("KeTangPai")

    // 主内容区域
    Content {
        id: content
        anchors.fill: parent // 改为填充整个窗口

        // 通过StackView的currentItem获取当前页面引用
        property var currentPage: content.stackView.currentItem

        Connections{
            target: content.currentPage
            ignoreUnknownSignals: true
            onExitCreateCoursePage: content.stackView.pop()
        }
    }
}
