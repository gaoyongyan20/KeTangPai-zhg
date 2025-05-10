import QtQuick
import QtQuick.Controls



Page {
    id:courseDetail_teacher

    signal pushHomework_teacher
    signal exitThisPage

    header:Rectangle{
        id:t_rec
        width: courseDetail_teacher.width
        height: 35
        Text{
            text:" < 软工四班"
            anchors.verticalCenter: parent.verticalCenter
        }
        MouseArea{
            anchors.fill: parent
            onClicked:{
                exitThisPage()
            }
        }
    }
    Rectangle{
        color:"grey"
        width:courseDetail_teacher.width
        height: courseDetail_teacher.height-35

        //这里实现课程的标题简介板块
        Column{
            spacing:8
            Text{
                text: "Metors\n加课码："
            }
            Row{
                spacing: 70
                 anchors.horizontalCenter: parent.horizontalCenter  // 关键代码
                Text{
                    text:"成员"
                    font.pixelSize: 15
                }
                Text{
                    text:"分组"
                    font.pixelSize: 15
                }
                Text{
                    text:"学生视角"
                    font.pixelSize: 15
                }
                Text{
                    text:"课堂评价"
                    font.pixelSize: 15
                }
                Text{
                    text:"编辑"
                    font.pixelSize: 15
                }
            }
        }

            //这里设置课程相关的详情内容（很多按钮那里）
            Rectangle{
                width: courseDetail_teacher.width
                height: courseDetail_teacher.height*0.8
                color: "yellow"
                anchors.bottom: parent.bottom
                radius: 20//圆角半径

                //考勤、表现、成绩管理、学情分析、报名审核的五个按钮的包含Rectangle
                Rectangle{
                    width: parent.width
                    height: parent.height*0.18
                    color: "pink"
                    anchors.top:parent.top
                    radius:20

                    Row{
                        anchors.centerIn: parent
                        spacing: 50
                        //考勤按钮
                        Column{
                            spacing: 5
                            RoundButton{
                                id:t_attendance
                                icon.name:"view-calendar-day.svg"
                                icon.color: "white"
                                anchors.horizontalCenter: parent.horizontalCenter
                                background: Rectangle {
                                        implicitWidth: 40
                                        implicitHeight: 40
                                        color: "#3498db"  //蓝色
                                        radius: parent.radius
                                        border.color: "#2980b9"  // 边框颜色
                                    }
                            }
                            Text{
                                text:"考勤"
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 14
                            }
                        }

                        //表现按钮
                        Column {
                            spacing: 5
                            RoundButton {
                                id: t_performance
                                icon.name: "favorites-symbolic.svg"
                                icon.color: "white"
                                anchors.horizontalCenter: parent.horizontalCenter
                                background: Rectangle {
                                        implicitWidth: 40
                                        implicitHeight: 40
                                        color: "#3498db"  //蓝色
                                        radius: parent.radius
                                        border.color: "#2980b9"  // 边框颜色
                                    }
                            }

                            Text {
                                text: "表现"
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 14
                            }
                        }

                        //成绩管理按钮
                        Column {
                            spacing: 5
                            RoundButton {
                                id: t_grades
                                icon.name: "games-highscores-symbolic.svg"
                                icon.color: "white"
                                anchors.horizontalCenter: parent.horizontalCenter
                                background: Rectangle {
                                        implicitWidth: 40
                                        implicitHeight: 40
                                        color: "#3498db"  //蓝色
                                        radius: parent.radius
                                        border.color: "#2980b9"  // 边框颜色
                                    }
                            }

                            Text {
                                text: "成绩管理"
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 14
                            }
                        }

                        //学情分析按钮
                        Column {
                            spacing: 5
                            RoundButton {
                                id: t_learningAnalytics
                                icon.name: "office-chart-pie-symbolic.svg"
                                icon.color: "white"
                                anchors.horizontalCenter: parent.horizontalCenter
                                background: Rectangle {
                                        implicitWidth: 40
                                        implicitHeight: 40
                                        color: "#3498db"  //蓝色
                                        radius: parent.radius
                                        border.color: "#2980b9"  // 边框颜色
                                    }
                            }

                            Text {
                                text: "学情分析"
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 14
                            }
                        }

                        //报名审核按钮
                        Column {
                            spacing: 5
                            RoundButton {
                                id: t_registrationReview
                                icon.name: "preview-symbolic.svg"
                                icon.color: "white"
                                anchors.horizontalCenter: parent.horizontalCenter
                                background: Rectangle {
                                        implicitWidth: 40
                                        implicitHeight: 40
                                        color: "#3498db"  //蓝色
                                        radius: parent.radius
                                        border.color: "#2980b9"  // 边框颜色
                                    }
                            }

                            Text {
                                text: "报名审核"
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 14
                            }
                        }

                    }
                }
                //这里是目录、互动课件、作业、测试、资料、公告、话题、互动答题模块包含的Rectangle
                Rectangle{
                    width:parent.width
                    height: parent.height*0.85
                    anchors.bottom: parent.bottom

                    StackView{
                        id:course_content
                        initialItem: directory
                        anchors {
                            top: topBar.bottom
                            bottom: parent.bottom
                            left: parent.left
                            right: parent.right
                        }

                    }

                    Row{
                        id:topBar
                        width: parent.width
                        spacing: 0
                        Button {
                                   id: left
                                   text: "<"
                                   height: scrollView_title.height
                                   width: 20
                                   onClicked: {
                                       // 向左移动200px，用Math.max保护左边界
                                        scrollView_title.contentItem.contentX = Math.max(0,  // 最小不能小于0（最左侧）
                                                scrollView_title.contentItem.contentX - 200  // 减号=向左
                                            )
                                   }
                                   opacity: scrollView_title.contentItem.contentX > 10 ? 1 : 0
                               }
                        ScrollView{
                            id:scrollView_title
                            width:parent.width-left.width-right.width
                            height: 30
                            clip:true
                            ScrollBar.horizontal: ScrollBar{
                                policy:ScrollBar.AsNeeded
                                visible:false
                            }
                            //目录、互动课件、作业、测试、资料、公告、话题、互动答题模块的导航栏
                            TabBar {
                                width: implicitWidth
                                height: parent.height
                                spacing:20

                                TabButton{
                                    text:"目录"
                                    font.pixelSize: 20
                                    width:implicitWidth
                                    onClicked: {
                                        course_content.pop(course_content.currentItem)
                                        course_content.push(directory)
                                    }
                                    background: Rectangle {
                                            color: "transparent"  // 透明背景
                                            border.width: 0       // 无边框
                                        }
                                }

                                TabButton{
                                    text:"互动课件"
                                    font.pixelSize: 20
                                    width:implicitWidth
                                    onClicked: {
                                        course_content.pop(course_content.currentItem)
                                        course_content.push(interactiveCourseware)
                                    }
                                    background: Rectangle {
                                            color: "transparent"  // 透明背景
                                            border.width: 0       // 无边框
                                        }
                                }

                                TabButton{
                                    text:"作业"
                                    font.pixelSize: 20
                                    width:implicitWidth
                                    onClicked: {
                                        course_content.pop(course_content.currentItem)
                                        course_content.push(homework)
                                    }
                                    background: Rectangle {
                                            color: "transparent"  // 透明背景
                                            border.width: 0       // 无边框
                                        }
                                }

                                TabButton{
                                    text:"测试"
                                    font.pixelSize: 20
                                    width:implicitWidth
                                    onClicked: {
                                        course_content.pop(course_content.currentItem)
                                        course_content.push(testing)
                                    }
                                    background: Rectangle {
                                            color: "transparent"  // 透明背景
                                            border.width: 0       // 无边框
                                        }
                                }

                                TabButton{
                                    text:"资料"
                                    font.pixelSize: 20
                                    width:implicitWidth
                                    onClicked: {
                                        course_content.pop(course_content.currentItem)
                                        course_content.push(documents)
                                    }
                                    background: Rectangle {
                                            color: "transparent"  // 透明背景
                                            border.width: 0       // 无边框
                                        }
                                }

                                TabButton{
                                    text:"公告"
                                    font.pixelSize: 20
                                    width:implicitWidth
                                    onClicked: {
                                        course_content.pop(course_content.currentItem)
                                        course_content.push(announcements)
                                    }
                                    background: Rectangle {
                                            color: "transparent"  // 透明背景
                                            border.width: 0       // 无边框
                                        }
                                }

                                TabButton{
                                    text:"话题"
                                    font.pixelSize: 20
                                    width:implicitWidth
                                    onClicked: {
                                        course_content.pop(course_content.currentItem)
                                        course_content.push(topics)
                                    }
                                    background: Rectangle {
                                            color: "transparent"  // 透明背景
                                            border.width: 0       // 无边框
                                        }
                                }
                                TabButton{
                                    text:"互动答题"
                                    font.pixelSize: 20
                                    width:implicitWidth
                                    onClicked: {
                                        course_content.pop(course_content.currentItem)
                                        course_content.push(interactiveAssessment)
                                    }
                                    background: Rectangle {
                                            color: "transparent"  // 透明背景
                                            border.width: 0       // 无边框
                                        }
                                }

                            }
                        }
                        Button{
                            id: right
                            text: ">"
                            height:scrollView_title.height
                            width:20
                            onClicked: {
                                scrollView_title.contentItem.contentX = Math.min(
                                            scrollView_title.contentItem.contentWidth - scrollView_title.width,
                                            scrollView_title.contentItem.contentX + 200
                                        )
                            }
                            opacity: (scrollView_title.contentItem.contentWidth - scrollView_title.contentItem.contentX - scrollView_title.width > 10) ? 1 : 0
                        }
                    }





                    //目录的组件
                    Component{
                        id:directory
                        Page{
                            Column{
                                spacing: 5
                                Rectangle{
                                    height: 30
                                    width: courseDetail_teacher.width
                                    Text{
                                        text:"课程内容："
                                    }
                                }
                                ScrollView{
                                    width: courseDetail_teacher.width
                                    height: parent.parent.height

                                    ListView{
                                        width: parent.width
                                        height: parent.height
                                        spacing: 10
                                        model:interactiveCourseware_Model

                                        delegate:Label{
                                            text:model.text
                                        }
                                    }

                                    ListModel{
                                        id:interactiveCourseware_Model
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                    }
                                }
                            }
                        }
                    }

                    //互动课件组件
                    Component{
                        id:interactiveCourseware
                        Page{
                            Column{
                                spacing: 5
                                Rectangle{
                                    height: 30
                                    width: courseDetail_teacher.width
                                    Text{
                                        text:"课程内容："
                                    }
                                }
                                ScrollView{
                                    width: courseDetail_teacher.width
                                    height: parent.parent.height

                                    ListView{
                                        width: parent.width
                                        height: parent.height
                                        spacing: 10
                                        model:interactiveCourseware_Model

                                        delegate:Label{
                                            text:model.text
                                        }
                                    }

                                    ListModel{
                                        id:interactiveCourseware_Model
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                    }
                                }
                            }
                        }
                    }

                    //作业组件
                    Component{
                        id:homework
                        Page{
                            Column{
                                spacing: 5
                                Rectangle{
                                    height: 30
                                    width: courseDetail_teacher.width
                                    Text{
                                        text:"课程内容："
                                    }
                                }
                                ScrollView{
                                    width: courseDetail_teacher.width
                                    height: parent.parent.height

                                    ListView{
                                        width: parent.width
                                        height: parent.height
                                        spacing: 10
                                        model:interactiveCourseware_Model

                                        delegate:Label{
                                            text:model.text
                                            MouseArea {
                                                        anchors.fill: parent
                                                        onClicked: {
                                                            console.log("点击了ID:", interactiveCourseware_Model.itemId)
                                                            console.log("索引:", index)  // 可以直接使用index
                                                            pushHomework_teacher()
                                                        }
                                                    }
                                        }

                                    }

                                    ListModel{
                                        id:interactiveCourseware_Model
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                    }
                                }
                            }
                        }
                    }

                    //测试组件
                    Component{
                        id:testing
                        Page{
                            Column{
                                spacing: 5
                                Rectangle{
                                    height: 30
                                    width: courseDetail_teacher.width
                                    Text{
                                        text:"课程内容："
                                    }
                                }
                                ScrollView{
                                    width: courseDetail_teacher.width
                                    height: parent.parent.height

                                    ListView{
                                        width: parent.width
                                        height: parent.height
                                        spacing: 10
                                        model:interactiveCourseware_Model

                                        delegate:Label{
                                            text:model.text
                                        }
                                    }

                                    ListModel{
                                        id:interactiveCourseware_Model
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                    }
                                }
                            }
                        }
                    }

                    //资料组件
                    Component{
                        id:documents
                        Page{
                            Column{
                                Row{
                                    spacing: 40

                                    Button{
                                        text:"学习资料"
                                        flat: true
                                        font.pixelSize: 15
                                    }
                                    Button{
                                        text:"慕课资料"
                                        flat: true
                                        font.pixelSize: 15
                                    }
                                    Button{
                                        text:"录屏录像"
                                        flat: true
                                        font.pixelSize: 15
                                    }
                                    Button{
                                        text:"直播录像"
                                        flat: true
                                        font.pixelSize: 15
                                    }
                                }

                                spacing: 5
                                Rectangle{
                                    height: 30
                                    width: courseDetail_teacher.width
                                    Text{
                                        text:"课程内容："
                                    }
                                }
                                ScrollView{
                                    width: courseDetail_teacher.width
                                    height: parent.parent.height

                                    ListView{
                                        width: parent.width
                                        height: parent.height
                                        spacing: 10
                                        model:interactiveCourseware_Model

                                        delegate:Label{
                                            text:model.text
                                        }
                                    }

                                    ListModel{
                                        id:interactiveCourseware_Model
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                    }
                                }
                            }
                        }
                    }

                    //公告组件
                    Component{
                        id:announcements
                        Page{
                            Column{
                                spacing: 5
                                Rectangle{
                                    height: 30
                                    width: courseDetail_teacher.width
                                    Text{
                                        text:"课程内容："
                                    }
                                }
                                ScrollView{
                                    width: courseDetail_teacher.width
                                    height: parent.parent.height

                                    ListView{
                                        width: parent.width
                                        height: parent.height
                                        spacing: 10
                                        model:interactiveCourseware_Model

                                        delegate:Label{
                                            text:model.text
                                        }
                                    }

                                    ListModel{
                                        id:interactiveCourseware_Model
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                    }
                                }
                            }
                        }
                    }

                    //话题组件
                    Component{
                        id:topics
                        Page{
                            Column{
                                spacing: 5
                                Rectangle{
                                    height: 30
                                    width: courseDetail_teacher.width
                                    Text{
                                        text:"课程内容："
                                    }
                                }
                                ScrollView{
                                    width: courseDetail_teacher.width
                                    height: parent.parent.height

                                    ListView{
                                        width: parent.width
                                        height: parent.height
                                        spacing: 10
                                        model:interactiveCourseware_Model

                                        delegate:Label{
                                            text:model.text
                                        }
                                    }

                                    ListModel{
                                        id:interactiveCourseware_Model
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                    }
                                }
                            }
                        }
                    }

                    //互动答题组件
                    Component{
                        id:interactiveAssessment
                        Page{
                            Column{
                                spacing: 5
                                Rectangle{
                                    height: 30
                                    width: courseDetail_teacher.width
                                    Text{
                                        text:"课程内容："
                                    }
                                }
                                ScrollView{
                                    width: courseDetail_teacher.width
                                    height: parent.parent.height

                                    ListView{
                                        width: parent.width
                                        height: parent.height
                                        spacing: 10
                                        model:interactiveCourseware_Model

                                        delegate:Label{
                                            text:model.text
                                        }
                                    }

                                    ListModel{
                                        id:interactiveCourseware_Model
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                        ListElement{
                                            text:"ABC"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

        }
    }
}
