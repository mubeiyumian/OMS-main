<%@ page import="com.xu.pojo.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="common/head.jsp" %>
<html>
<head>
    <title>购物车</title>
    <script src="https://how2j.cn/study/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <script>
        $(document).ready(function () {
            $('#useCoupons').click(function () {
                $('#couponModal').modal('show');
            });
            $('#confirmCoupon').click(function () {
                applyChanges();
                $('#couponModal').modal('hide');
            });

            // 初始化时设置state的checked状态
            updateStateChecked();

            // 监听coupons的radio按钮变化
            $('input[name="couponsType"]').change(function () {
                updateStateChecked();
            });

            // 取消按钮点击事件
            $('#close').click(function () {
                resetToDefault();
            });

            $('#Person').click(function (e) {
                e.preventDefault(); // 阻止默认行为
                $(this).nextAll('.person').toggle(); // 切换第八和第九个列表项的显示状态
                $('li').removeClass('active'); // 移除所有列表项的active类
                $(this).addClass('active'); // 将当前点击的列表项设置为active并添加btn-success类
            });
        });

        // ---------------
        function updateStateChecked() {
            const selectedCoupon = $('input[name="couponsType"]:checked').val();
            if (selectedCoupon === '0') {
                $('input[name="coupons"]').prop('checked', false);
            } else {
                $('input[name="coupons"]').prop('checked', true);
            }
        }

        function applyChanges() {
            // 保存当前选中的状态
            localStorage.setItem('selectedCoupon', $('input[name="couponsType"]:checked').val());
            localStorage.setItem('stateChecked', $('input[name="coupons"]').is(':checked'));
        }

        function resetToDefault() {
            // 重置为默认值
            $('input[name="couponsType"][value="0"]').prop('checked', true);
            $('input[name="coupons"]').prop('checked', false);
            updateStateChecked();
        }

        // ---------------

        function a(obj) {
            var judge =
            ${totalPrice} >
            ${userLoginInfo.getBalance()};
            obj2 = document.getElementById("useWeixin");
            if (judge) {
                obj.checked = false;
                obj2.checked = true;
                $("#info").css("color", "red");
                $("#info").html("账户余额不足");
            }
        }

        function isN() {
            if ($("#tableId").val() == "" || isNaN($("#tableId").val())) {
                $("#info").css("color", "red");
                $("#info").html("请输入数字");
                $("#btn").attr("disabled", true);
            } else {
                $("#info").html("");
                $("#btn").attr("disabled", false);
            }
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
                <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/clientCart">购物车</a>
                </li>
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

                        <div class="col-xs-10 col-md-10 column">
                            <form class="form-inline" action="${pageContext.request.contextPath}/clientSubmit"
                                  method="post">
                                <div class="form-group">
                                    <label>桌号：</label>
                                    <input type="text" class="form-control" name="tableId" id="tableId" onkeyup="isN()"
                                           placeholder="请填写" required>
                                </div>
                                &nbsp;
                                &nbsp;
                                <input type="radio" name="pay" id="useWeixin" value="1" checked> 微信支付
                                <input type="radio" name="pay" id="useBalance" value="0" onclick="a(this)"> 余额支付
                                &nbsp;
                                &nbsp;
                                <input type="radio" name="coupons" id="useCoupons" value="1"> 优惠券
                                <!-- Modal -->
                                <div class="modal fade" id="couponModal" tabindex="-1"
                                     aria-labelledby="couponModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="couponModalLabel">选择优惠券</h5>
                                                <button type="button" class="close" data-dismiss="modal"
                                                        aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <table class="table table-striped table-bordered table-hover table-condensed"
                                                       id="dataTable">
                                                    <thead class="thead-dark">
                                                    <tr>
                                                        <th>#</th>
                                                        <th>券名</th>
                                                        <th>优惠金额</th>
                                                        <th>优惠门槛</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <tr>
                                                        <td><input type="radio" name="couponsType" value="0" checked>
                                                        </td>
                                                        <td>不使用优惠券</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                    </tr>
                                                    <c:forEach var="couponse" items="${couponsEffective}">
                                                        <tr>
                                                            <td><input type="radio" name="couponsType"
                                                                       value="${couponse.couponsUserId}"></td>
                                                            <td>${couponse.couponsName}</td>
                                                            <td>${couponse.couponsPrice}</td>
                                                            <td>${couponse.couponsThreshold}</td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal"
                                                        id="close">关闭
                                                </button>
                                                <button type="button" class="btn btn-primary" id="confirmCoupon">确认
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                &nbsp;
                                &nbsp;
                                <button type="submit" id="btn" class="btn btn-success" disabled>
                                    <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>
                                    &nbsp;
                                    &nbsp;
                                    提交订单并支付
                                </button>
                                <span id="info"></span>
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
                                    <th class="text-center">菜名</th>
                                    <th class="text-center">单价</th>
                                    <th class="text-center">类别</th>
                                    <th class="text-center">数量</th>
                                    <th class="text-center"><span class="glyphicon glyphicon-align-center"
                                                                  aria-hidden="true"></span></th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="dish" items="${cartList}">
                                    <tr>
                                        <td>${dish.menu.dishesName}</td>
                                        <td>${dish.menu.unitPrice}</td>
                                            <%--                                        <td>${dish.menu.category}</td>--%>
                                        <td>
                                            <c:choose>
                                                <c:when test="${dish.menu.categoryId == 1}">
                                                    主食
                                                </c:when>
                                                <c:when test="${dish.menu.categoryId == 2}">
                                                    素菜
                                                </c:when>
                                                <c:when test="${dish.menu.categoryId == 3}">
                                                    荤菜
                                                </c:when>
                                                <c:otherwise>
                                                    饮料
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${dish.dishesNum}</td>
                                        <td>
                                            <button class="btn btn-danger" data-toggle="modal"
                                                    data-target="#${dish.menu.dishesId}">
                                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                            </button>

                                            <div class="modal fade" id="${dish.menu.dishesId}" tabindex="-1"
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
                                                            确认将此菜品数量减一？
                                                        </div>
                                                        <div class="modal-footer">
                                                            <a href="${pageContext.request.contextPath}/clientCartDelete?dishesId=${dish.menu.dishesId}"
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

                                <tr>
                                    <td>合计:</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        ${totalPrice}
                                    </td>
                                </tr>
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