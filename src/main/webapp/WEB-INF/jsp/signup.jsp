<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://how2j.cn/study/jquery.min.js"></script>
    <style>
        body {
            background-image: url('${pageContext.request.contextPath}/image/6.jpg'); /* 替换为你的图片路径 */
            background-size: cover; /* 使背景图片覆盖整个页面 */
            background-repeat: no-repeat; /* 防止背景图片重复 */
            background-position: center; /* 将背景图片居中 */
            background-attachment: fixed;
        }

        .box {
            position: absolute;
            top: 150px;
            padding: 10px 50px;
            right: 100px;
            width: 500px;
            height: 400px;
            background-color: rgba(255, 255, 255, 0.7);
            box-shadow: 10px 10px 10px -4px rgba(0, 0, 0, 0.3);
            border-radius: 35px;
        }
    </style>
    <script>
        function a() {
            $.ajax({
                url: '${pageContext.request.contextPath}/validationName',
                data: {"Name": $("#Name").val()},
                success: function (data) {
                    $("#nameInfo").css("color", "red");
                    $("#nameInfo").html(data);
                    $("#nameInfo").val(data);
                    if ($("#nameInfo").val() === "" && $("#pwdInfo").val() === "")
                        $("#btn").attr("disabled", false);
                    else
                        $("#btn").attr("disabled", true);
                }

            })
        }

        function a2() {
            if ($("#pwd1").val() != $("#pwd2").val()) {
                $("#pwdInfo").css("color", "red");
                $("#pwdInfo").html("两次输入的密码不一致");
                $("#pwdInfo").val("两次输入的密码不一致");
            } else {
                $("#pwdInfo").html("");
                $("#pwdInfo").val("");
            }
            if ($("#nameInfo").val() === "" && $("#pwdInfo").val() === "")
                $("#btn").attr("disabled", false);
            else
                $("#btn").attr("disabled", true);
        }
    </script>
</head>
<body>
<div class="box">
    <h1>
        &nbsp;
        <small>注册</small>
        &nbsp;
        <a href="${pageContext.request.contextPath}/goLogin">
            <button type="button" class="btn btn-info">
                登录
            </button>
        </a>
    </h1>
    <div class="col-xs-10 column">
        <form action="${pageContext.request.contextPath}/signup" method="post">

            <div class="form-group">
                <label>用户名</label>
                <input type="text" class="form-control" name="name" id="Name" onkeyup="a()"
                       placeholder="Phone Number/Email/UserName" required>
                <span id="nameInfo"></span>
            </div>
            <div class="form-group">
                <label>密码</label>
                <input type="password" class="form-control" name="pwd" id="pwd1" placeholder="Password" required>
            </div>

            <div class="form-group">
                <label>请再次输入密码</label>
                <input type="password" class="form-control" id="pwd2" onkeyup="a2()" placeholder="Password" required>
                <span id="pwdInfo"></span>
            </div>

            <div>
                <button type="submit" id="btn" class="btn btn-info btn-block" disabled>注册</button>
            </div>

        </form>
    </div>
</div>

</body>
</html>