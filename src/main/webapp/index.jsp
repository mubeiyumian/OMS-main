<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
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
</head>
<body>
<div class="box">
    <h1>
        &nbsp;
        <small>登录</small>
        &nbsp;
        <a href="${pageContext.request.contextPath}/goSignup">
            <button type="button" class="btn btn-info">
                注册
            </button>
        </a>
    </h1>
    <div class="col-xs-10 column">
        <form action="${pageContext.request.contextPath}/login" method="post">

            <div class="form-group">
                <label>用户名</label>
                <input type="text" class="form-control" name="name" placeholder="Phone Number/Email/UserName" required>
            </div>

            <div class="form-group">
                <label>密码</label>
                <input type="password" class="form-control" name="pwd" placeholder="Password" required>
                <span id="pwdInfo"><p style="color: red">${info}</p></span>
            </div>

            <div>
                <button type="submit" class="btn btn-info btn-block">登录</button>
            </div>

        </form>
    </div>
</div>
</body>
</html>
