<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="common/head.jsp" %>
<html>
<head>
    <title>消费记录</title>
    <script src="https://how2j.cn/study/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script>
        $(document).ready(function () {
            $('#Person').click(function (e) {
                e.preventDefault(); // 阻止默认行为
                $(this).nextAll('.person').toggle(); // 切换第八和第九个列表项的显示状态
                $('li').removeClass('active'); // 移除所有列表项的active类
                $(this).addClass('active'); // 将当前点击的列表项设置为active并添加btn-success类
            });
        });

        function getInfo(Id) {
            $.ajax({
                url: "${pageContext.request.contextPath}/getConsumeInfo",
                data: {
                    Id: Id
                },
                dataType: "JSON",
                success: function (data) {
                    // console.log(data)
                    let tableBody = $("#dataTable tbody")
                    tableBody.empty()
                    $.each(data, function (index, item) {
                        let row = $("<tr></tr>")
                        row.append($("<td></td>").text(item.dishesName))
                        row.append($("<td></td>").text(item.unitPrice))
                        row.append($("<td></td>").text(item.dishesNum))
                        row.append($("<td></td>").text(item.Price))
                        tableBody.append(row)
                    })
                }
            })
        }
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
                <li role="presentation" class="active"><a
                        href="${pageContext.request.contextPath}/clientConsume">消费记录</a></li>
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
                                    <th class="text-center">应收帐</th>
                                    <th class="text-center">用户名</th>
                                    <th class="text-center">时间</th>
                                    <th class="text-center"><span class="glyphicon glyphicon-align-center"
                                                                  aria-hidden="true"></span></th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="bill" items="${list}">
                                    <tr>
                                        <td>${bill.billId}</td>
                                        <td>${bill.totalPrice}</td>
                                        <td>${bill.user.userName}</td>
                                            <%--                                        <td>${bill.billTime.toString()}</td>--%>
                                        <td><fmt:formatDate value="${bill.billTime}"
                                                            pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td>

                                            <button class="btn btn-info" data-toggle="modal"
                                                    data-target="#${bill.billId}" onclick="getInfo(${bill.billId})">
                                                <span class="glyphicon glyphicon-list" aria-hidden="true"></span>
                                            </button>

                                            <div class="modal fade" id="${bill.billId}" tabindex="-1" role="dialog"
                                                 aria-labelledby="myModalLabel">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal"
                                                                    aria-label="Close"><span
                                                                    aria-hidden="true">&times;</span></button>
                                                            <h4 class="modal-title" id="myModalLabel">订单详情</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <table class="table table-striped table-bordered table-hover table-condensed"
                                                                   id="dataTable">
                                                                <thead class="thead-dark">
                                                                <tr>
                                                                    <th>菜名</th>
                                                                    <th>单价</th>
                                                                    <th>数量</th>
                                                                    <th>总价</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                        <div class="modal-footer">
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