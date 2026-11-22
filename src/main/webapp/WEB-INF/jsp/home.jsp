<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="common/head.jsp" %>
<html>
<head>
    <title>所有菜单</title>
    <script src="https://how2j.cn/study/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container-fluid">

    <div class="row clear-fix">
        <div class="col-md-2 column">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="${pageContext.request.contextPath}/allUser">用户管理</a></li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/allDishes">菜单管理</a></li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/allOrdering">订单管理</a></li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/allBill">帐单管理</a></li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/allCoupons">优惠券管理</a></li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/allCharts">数据分析</a></li>
            </ul>
        </div>
        <div class="col-md-10 column text-center">
            <h1>欢迎使用订单管理系统</h1>
        </div>
    </div>
</div>

</body>
</html>
<%@ include file="common/foot.jsp" %>