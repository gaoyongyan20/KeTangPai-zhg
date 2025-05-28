// 该方法用于发送登录请求
function loginRequest(username, password, callback) {
    // 创建“快递员”准备发送请求
    var request = new XMLHttpRequest()

    // 初始化请求
    // 填写"快递单"：POST方式，发送到/login地址
    // 第一个参数：HTTP请求方法
    // 第二个：请求的url地址
    // 请求发送到本机的8080端口的/login路径，这里的路径由后端路由决定
    request.open("POST", "http://10.253.217.81:8080/login")

    // 设置请求头
    // 著名”包裹类型“（JSON格式）
    // Content-Type：表示服务器发送的数据类型
    // application/json"：表示我们要发送的JSON格式的数据
    request.setRequestHeader("Content-Type", "application/json")

    // 准备发送的数据
    // 准备”包裹“内容
    let data = {
        "username": username,
        "password": password
    }

    // 发送请求
    // 发送包裹
    // stringify将js对象转换为json字符串
    request.send(JSON.stringify(data))

    //监听 XMLHttpRequest 对象的状态变化 也就是邮递员的状态
    request.onreadystatechange = function () {
        //readyState：表示请求的当前状态
        if (request.readyState === XMLHttpRequest.DONE) {
            let response = JSON.parse(request.responseText)    //JSON.parse()：将 JSON 字符串解析为 JavaScript 对象
            if (response.status === "success") {
                messageLabel.text = "✅ 登录成功，欢迎 " + response.role + ": " + response.user
            } else {
                messageLabel.text = "❌ " + response.message
            }
            callback(response)   //这里调用外部传入的回调函数，并将响应对象 response 传递给它
        }
    }
}
