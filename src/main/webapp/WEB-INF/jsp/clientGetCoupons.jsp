<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="common/head.jsp" %>
<html>
<head>
    <title>领取优惠券</title>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://how2j.cn/study/jquery.min.js"></script>

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
                <li role="presentation"><a href="${pageContext.request.contextPath}/clientOrderPopular">推荐菜单</a></li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/clientCart">购物车</a></li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/clientCheckOrder">待上菜</a></li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/clientConsume">消费记录</a></li>
                <li role="presentation" id="Person"><a href="#">个人中心</a></li>
                <li role="presentation" class="person active"><a
                        href="${pageContext.request.contextPath}/clientCoupons">优惠券</a></li>
                <li role="presentation" class="person"><a href="${pageContext.request.contextPath}/goclientTopUp">充值</a>
                </li>
                <li role="presentation" class="person"><a href="${pageContext.request.contextPath}/goclientChangePwd">修改密码</a>
                </li>
            </ul>
        </div>

        <div class="col-md-10 column">
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <!-- Table -->
                <table class="table">
                    <div class="row clearfix">
                        <div class="col-md-2 column">
                        </div>
                        <div class="col-xs-12 col-md-8 column">
                            <table class="table table-hover table-striped text-center">

                                <thead>
                                <tr>
                                    <th class="text-center">#</th>
                                    <th class="text-center">券名</th>
                                    <th class="text-center">优惠金额</th>
                                    <th class="text-center">优惠门槛</th>
                                    <th class="text-center">生效日期</th>
                                    <th class="text-center">失效日期</th>
                                    <th class="text-center"><span class="glyphicon glyphicon-align-center"
                                                                  aria-hidden="true"></span></th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="coupons" items="${couponsListAll}">
                                    <tr>
                                        <td>${coupons.couponsId}</td>
                                        <td>${coupons.couponsName}</td>
                                        <td>${coupons.couponsPrice}</td>
                                        <td>${coupons.couponsThreshold}</td>
                                        <td><fmt:formatDate value="${coupons.effectiveDate}" type="date"/></td>
                                        <td><fmt:formatDate value="${coupons.invalidDate}" type="date"/></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/clientAddUserCoupons?couponsId=${coupons.couponsId}"
                                               style='text-decoration:none;'>
                                                <button class="btn btn-info">
                                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                                </button>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>

                            </table>
                        </div>
                    </div>
                </table>
            </div>
        </div>


    </div>
</div>

</body>
</html>
<%@ include file="common/foot.jsp" %>