<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="common/head.jsp" %>
<html>
<head>
    <title>推荐菜单</title>
    <script src="https://how2j.cn/study/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            border: 0;
        }

        .box {
            float: left;
            width: 300px;
            height: 208px;
            /*background-color: pink;*/
            margin: 30px 0px 10px 20px;
        }

        .left {
            float: left;
            width: 166px;
            height: 208px;
            /*background-color: skyblue;*/
        }

        .left img {
            width: 166px;
            height: 208px;
            object-fit: cover;
        }

        .right {
            float: left;
            width: 134px;
            height: 208px;
            /*background-color: #ff8500;*/
        }

        .right h4 {
            position: relative;
            top: 20px;
            left: 20px;
        }

        .right p {
            position: relative;
            top: 40px;
            left: 20px;
            line-height: 30px;
        }

        .right a {
            display: inline-block;
            text-decoration: none;
            position: relative;
            top: 60px;
            left: 20px;
        }
    </style>
    <script>
        $(document).ready(function () {
            $('#Person').click(function (e) {
                e.preventDefault(); // 阻止默认行为
                $(this).nextAll('.person').toggle(); // 切换第八和第九个列表项的显示状态
                $('li').removeClass('active'); // 移除所有列表项的active类
                $(this).addClass('active'); // 将当前点击的列表项设置为active并添加btn-success类
            });
        });
    </script>
</head>

<body>

<div class="container-fluid">

    <div class="row clear-fix">
        <div class="col-md-2 column">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="${pageContext.request.contextPath}/clientOrder?pageNum=1">菜单</a></li>
                <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/clientOrderPopular">推荐菜单</a>
                </li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/clientCart">购物车</a></li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/clientCheckOrder">待上菜</a></li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/clientConsume">消费记录</a></li>
                <li role="presentation" id="Person"><a href="#">个人中心</a></li>
                <li role="presentation" class="person" style="display: none"><a
                        href="${pageContext.request.contextPath}/clientCoupons">优惠券</a></li>
                <li role="presentation" class="person" style="display: none"><a
                        href="${pageContext.request.contextPath}/goclientTopUp">充值</a></li>
                <li role="presentation" class="person" style="display: none"><a
                        href="${pageContext.request.contextPath}/goclientChangePwd">修改密码</a></li>
            </ul>
        </div>
        <div class="col-md-10 column">
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-body">
                    <div class="row clear-fix">

                        <div class="col-xs-2 col-md-2column">
                            <a href="${pageContext.request.contextPath}/clientOrder?pageNum=1">
                                <button type="button" class="btn btn-info">
                                    <span class="glyphicon glyphicon-list" aria-hidden="true"></span>
                                    &nbsp; &nbsp;
                                    显示完整菜单
                                </button>
                            </a>
                        </div>

                        <div class="col-xs-1 col-md-1 column">
                            &nbsp;
                        </div>

                    </div>


                </div>
                <div class="clearfix">
                    <div class="col-md-13 column">
                        <table class="table">
                            <tbody>
                            <c:forEach var="dish" items="${list}">
                                <div class="box">
                                    <div class="left">
                                        <img src="${pageContext.request.contextPath}/${dish.image}" alt="111">
                                    </div>
                                    <div class="right">
                                        <h4>${dish.dishesName}</h4>
                                        <p>价格：${dish.unitPrice}</p>
                                        <p>类别：${dish.cateName}</p>
                                            <%--                                        <a href="#">111</a>--%>
                                        <a class="btn btn-success"
                                           href="${pageContext.request.contextPath}/clientAddDish?dishesId=${dish.dishesId}"
                                           role="button"><span class="glyphicon glyphicon-shopping-cart"
                                                               aria-hidden="true"></span></a>
                                    </div>
                                </div>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
<%@ include file="common/foot.jsp" %>