//处理课程添加请求数据
function joinRequest(user_id,course_code){

    //创建一个快递员
    var request = new XMLHttpRequest()

    //填写快递单
    // request.open("POST", "http://10.253.217.81:8080/joincourse")   //高的ip地址
    request.open("POST", "http://localhost:8080/joincourse")

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
               courseBridge.loadCoursesFor(3)
                exitThisPage()  //加入课程成功直接退出当前界面
            } else {
                console.log("加入失败，请重新输入课程码")
            }
        }
    }
};

//处理课程加载数据
function loadCourse(jsonResoult){
    console.log("开始加载")
    var courseArray = JSON.parse(jsonResoult);
    var count = courseArray.length;
    _homePage_student.course_list_model.clear()

    for (var i=0;i<count;i++){
        var data={
            "course_name":courseArray[i].course_name,
            "course_code":courseArray[i].course_code,
            "class_name":courseArray[i].class_name
        }
        _homePage_student.course_list_model.append(data)
        console.log(_homePage_student.course_list_model.count)
        _homePage_student.couse_list.model=_homePage_student.course_list_model
        _homePage_student.couse_list.currentIndex=0
    }
}


