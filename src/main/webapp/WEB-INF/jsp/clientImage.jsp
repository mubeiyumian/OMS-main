<%--
  Created by IntelliJ IDEA.
  User: 云轩
  Date: 2024/11/29
  Time: 13:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        img {
            width: 166px;
            height: 208px;
            background-color: pink;
        }

        .st1 {
            object-fit: cover;
        }

        .st2 {
            object-fit: fill;
        }

        .st3 {
            object-fit: contain;
        }

        .st4 {
            object-fit: none;
        }
    </style>
</head>
<body>
<form action="${pageContext.request.contextPath}/clientUpload" method="post" enctype="multipart/form-data">
    <input type="file" name="multipartFile" placeholder="file">
    <input type="submit" value="提交">
</form>
<img src="${pageContext.request.contextPath}/image/黄焖鸡.jpg" alt="111" class="st1">
<br/>
<img src="${pageContext.request.contextPath}/image/黄焖鸡.jpg" alt="111" class="st2">
<br/>
<img src="${pageContext.request.contextPath}/image/黄焖鸡.jpg" alt="111" class="st3">
<br/>
<img src="${pageContext.request.contextPath}/image/黄焖鸡.jpg" alt="111" class="st4">
</body>
</html>
