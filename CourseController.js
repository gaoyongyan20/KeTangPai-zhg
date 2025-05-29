// 处理课程相关的控制器层

// 服务器的ip地址和端口
var _server_url = "http://10.253.66.224:8088/"
//处理课程添加请求数据
function joinRequest(user_id,course_code){

    //创建一个快递员
    var request = new XMLHttpRequest()

    //填写快递单
    request.open("POST", _server_url + "joincourse")   //高的ip地址
    // request.open("POST", "http://localhost:8088/joincourse")

    // 设置请求头
    request.setRequestHeader("Content-Type", "application/json")

    // 准备”包裹“内容
    let data = {
        "user_id": user_id,
        "course_code": course_code
    }


    // 发送包裹
    request.send(JSON.stringify(data))

    //监听 XMLHttpRequest 对象的状态变化 也就是邮递员的状态
    request.onreadystatechange = function () {
        //readyState：表示请求的当前状态
        if (request.readyState === XMLHttpRequest.DONE) {
            let response = JSON.parse(request.responseText)    //JSON.parse()：将 JSON 字符串解析为 JavaScript 对象
            console.log(response.status)
            if (response.status === "success") {
                exitThisPage()  //加入课程成功直接退出当前界面
                loadStudentCoursesRequest(User.userId)


            } else {
                console.log("加入课程失败！")
               _displayCourseCode_Page.show("加入课程失败！\n 请重新输入")
            }
        }
    }
}

//处理教师所有创建的课程显示请求数据
function loadTeacherCoursesRequest(teacher_id) {

    //创建一个快递员
    var request = new XMLHttpRequest()

    //填写快递单
    request.open("POST",
                 _server_url + "loadTeacherCourses") //高的ip地址
    // request.open("POST", "http://localhost:8088/loadTeacherCourses")

    // 设置请求头
    request.setRequestHeader("Content-Type", "application/json")

    // 准备”包裹“内容
    let data = {
        "teacher_id": teacher_id
    }

    // 发送包裹
    request.send(JSON.stringify(data))

    //监听 XMLHttpRequest 对象的状态变化 也就是邮递员的状态
    request.onreadystatechange = function () {
        //readyState：表示请求的当前状态
        if (request.readyState === XMLHttpRequest.DONE) {
            let response = JSON.parse(request.responseText)
            load_teacherCourse(response)
        }
    }
}

//处理老师课程加载数据
function load_teacherCourse(jsonResoult) {
    console.log("开始加载")
    var courseArray = jsonResoult
    console.log(courseArray)
    var count = courseArray.length
    stackView.currentItem.teachercourse_list_model.clear()

    for (var i = 0; i < count; i++) {
        var data = {
            "course_name": courseArray[i].course_name,
            "course_code": courseArray[i].course_code,
            "class_name": courseArray[i].class_name
        }
        stackView.currentItem.teachercourse_list_model.append(data)
        console.log(stackView.currentItem.teachercourse_list_model.count)
        stackView.currentItem.teachercouse_list.model
                = stackView.currentItem.teachercourse_list_model
        stackView.currentItem.teachercouse_list.currentIndex = 0
    }
}

//处理学生所有加入的课程显示请求数据
function loadStudentCoursesRequest(student_id){

    //创建一个快递员
    var request = new XMLHttpRequest()

    //填写快递单
    request.open("POST", _server_url + "loadStudentCourses")   //高的ip地址
    // request.open("POST", "http://localhost:8088/loadStudentCourses")

    // 设置请求头
    request.setRequestHeader("Content-Type", "application/json")

    // 准备”包裹“内容
    let data = {
        "student_id": student_id,
    }

    // 发送包裹
    request.send(JSON.stringify(data))

    //监听 XMLHttpRequest 对象的状态变化 也就是邮递员的状态
    request.onreadystatechange = function () {
        //readyState：表示请求的当前状态
        if (request.readyState === XMLHttpRequest.DONE) {
            let response = JSON.parse(request.responseText)
            load_studentCourse(response)
        }
    }
}


//处理学生课程加载数据
function load_studentCourse(jsonResoult){
    console.log("开始加载")
    var courseArray = jsonResoult;
    var count = courseArray.length;
    console.log(count)

    stackView.currentItem.studentcourse_list_model.clear()

    for (var i=0;i<count;i++){
        var data={
            "course_name":courseArray[i].course_name,
            "course_code":courseArray[i].course_code,
            "class_name":courseArray[i].class_name
        }

        stackView.currentItem.studentcourse_list_model.append(data)
        stackView.currentItem.studentcouse_list.model=stackView.currentItem.studentcourse_list_model
        stackView.currentItem.studentcouse_list.currentIndex=0
    }
}




// 发出创建课程请求
function createCourseRequest(courseData, callback) {
    // 创建请求对象
    var request = new XMLHttpRequest()
    // 初始化请求
    request.open("POST", _server_url + "createCourse") // 路由名字为创建课程
    // 设置请求头
    request.setRequestHeader("Content-Type", "application/json")
    let data = courseData

    // 发送数据
    request.send(JSON.stringify(data))

    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            let response = JSON.parse(request.responseText)
            callback(response)
        }
    }
}


