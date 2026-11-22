<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="common/head.jsp" %>
<html>
<head>
    <title>所有优惠券</title>
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
                <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/allCoupons">优惠券管理</a>
                </li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/allCharts">数据分析</a></li>
            </ul>
        </div>
        <div class="col-md-10 column">
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-body">
                    <div class="row clear-fix">

                        <div class="col-xs-2 col-md-2 column">
                            <a href="${pageContext.request.contextPath}/toAddCoupons">
                                <button type="button" class="btn btn-success">
                                    <span class="glyphicon glyphicon-tag" aria-hidden="true"></span>
                                    &nbsp; &nbsp;
                                    添加优惠券
                                </button>
                            </a>
                        </div>

                        <div class="col-xs-2 col-md-2 column">
                            &nbsp;
                        </div>

                        <div class="col-xs-2 col-md-2column">
                            <a href="${pageContext.request.contextPath}/allCoupons">
                                <button type="button" class="btn btn-info">
                                    <span class="glyphicon glyphicon-list" aria-hidden="true"></span>
                                    &nbsp; &nbsp;
                                    显示完整优惠券
                                </button>
                            </a>
                        </div>

                        <div class="col-xs-1 col-md-1 column">
                            &nbsp;
                        </div>

                        <div class="col-xs-5 col-md-5 column">
                            <form class="form-inline" action="${pageContext.request.contextPath}/getCouponsBySuffixName"
                                  method="post">
                                <div class="form-group">
                                    <label>券名：</label>
                                    <input type="text" class="form-control" name="couponsName"
                                           placeholder="Search for..." required>
                                </div>
                                <button type="submit" class="btn btn-default">查询</button>
                            </form>
                        </div>

                    </div>


                </div>

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
                                    <th class="text-center">当前状态</th>
                                    <th class="text-center"><span class="glyphicon glyphicon-align-center"
                                                                  aria-hidden="true"></span></th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="coupons" items="${couponsList}">
                                    <tr>
                                        <td>${coupons.couponsId}</td>
                                        <td>${coupons.couponsName}</td>
                                        <td>${coupons.couponsPrice}</td>
                                        <td>${coupons.couponsThreshold}</td>
                                        <td><fmt:formatDate value="${coupons.effectiveDate}" type="date"/></td>
                                        <td><fmt:formatDate value="${coupons.invalidDate}" type="date"/></td>
                                            <%--                                        <td>${coupons.state}</td>--%>
                                        <td>
                                            <c:choose>
                                                <c:when test="${coupons.state == 1}">
                                                    生效
                                                </c:when>
                                                <c:otherwise>
                                                    失效
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                                <%--                                            修改--%>
                                            <a href="${pageContext.request.contextPath}/toUpdateCoupons?couponsId=${coupons.couponsId}"
                                               style='text-decoration:none;'>
                                                <button class="btn btn-info">
                                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                                </button>
                                            </a>
                                                <%--                                            删除--%>
                                            <button class="btn btn-danger" data-toggle="modal"
                                                    data-target="#${coupons.couponsId}">
                                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                            </button>

                                            <div class="modal fade" id="${coupons.couponsId}" tabindex="-1"
                                                 role="dialog" aria-labelledby="myModalLabel">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal"
                                                                    aria-label="Close"><span
                                                                    aria-hidden="true">&times;</span></button>
                                                            <h4 class="modal-title" id="myModalLabel">警告</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            确认删除该优惠券？
                                                        </div>
                                                        <div class="modal-footer">
                                                            <a href="${pageContext.request.contextPath}/deleteCoupons?couponsId=${coupons.couponsId}"
                                                               style='text-decoration:none;'>
                                                                <button class="btn btn-danger">确认</button>
                                                            </a>
                                                            <button type="button" class="btn btn-default"
                                                                    data-dismiss="modal">取消
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

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