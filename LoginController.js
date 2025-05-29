// 处理登录的控制器层

// 服务器的ip地址和端口
var _server_url = "http://10.253.66.224:8088/"
function loginRequest(role, account, password, callback) {
    var request = new XMLHttpRequest()
    request.open("POST", _server_url + "login")
    request.setRequestHeader("Content-Type", "application/json")

    // 准备发送的数据
    let data = {
        "role": role,
        "account": account,
        "password": password
    }

        // 发送请求
    // stringify将js对象转换为json字符串
    request.send(JSON.stringify(data))

    // 回调请求处理
    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            try {
                // 解析响应数据
                let response = JSON.parse(request.responseText)

                // 处理成功逻辑
                if (response.status === "success") {
                    errorLabel.text = "✅ 登录成功，欢迎 " + response.role + ": " + response.account
                } // 处理失败逻辑
                else {
                    errorLabel.text = "❌ " + response.message
                }
                // 调用回调函数（确保在解析成功后调用）
                if (typeof callback === 'function') {
                    callback(response)
                }
            } catch (error) {
                // 捕获JSON解析错误
                console.error("JSON 解析失败:", error, "原始响应:",
                              request.responseText)

                // 构造错误响应并调用回调
                if (typeof callback === 'function') {
                    callback({
                                 "status": "error",
                                 "message": "服务器响应格式错误（可能不是合法JSON）"
                             })
                }
                // 显示通用错误信息
                errorLabel.text = "❌ 登录失败，请检查网络或重试"
            }
        }
    }
}
