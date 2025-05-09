import QtQuick
import QtQuick.Controls

Item {
    id: root
    width: parent.width
    height: parent.height

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
