<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="common/head.jsp" %>
<html>
<head>
    <title>更改优惠券</title>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery UI CSS -->
    <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
    <script src="https://how2j.cn/study/jquery.min.js"></script>
    <!-- jQuery UI -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.6.0/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function () {
            $("select option[value=${coupons.state}]").prop("selected", true)
        })

        $(function () {
            $("#effective").datepicker({
                dateFormat: "yy-mm-dd" // Set the format of the date
            });
            $("#invalid").datepicker({
                dateFormat: "yy-mm-dd" // Set the format of the date
            });
        });

        function isN() {
            if ($("#couponsPrice").val() == "" || isNaN($("#couponsPrice").val())) {
                $("#couponsPriceInfo").css("color", "red");
                $("#couponsPriceInfo").html("请输入数字");
                $("#couponsPriceInfo").val("请输入数字");
            } else {
                $("#couponsPriceInfo").html("");
                $("#couponsPriceInfo").val("");
            }
            if ($("#couponsPriceInfo").val() === "" && $("#couponsThresholdInfo").val() === "")
                $("#btn").attr("disabled", false);
            else
                $("#btn").attr("disabled", true);
        };

        function isNN() {
            if ($("#couponsThreshold").val() == "" || isNaN($("#couponsThreshold").val())) {
                $("#couponsThresholdInfo").css("color", "red");
                $("#couponsThresholdInfo").html("请输入数字");
                $("#couponsThresholdInfo").val("请输入数字");
            } else {
                $("#couponsThresholdInfo").html("");
                $("#couponsThresholdInfo").val("");
            }
            if ($("#couponsPriceInfo").val() === "" && $("#couponsThresholdInfo").val() === "")
                $("#btn").attr("disabled", false);
            else
                $("#btn").attr("disabled", true);
        };
    </script>
</head>
<body>
<div class="container">
    <div class="row clear-fix">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1>
                    <small>更改优惠券</small>
                </h1>
            </div>
        </div>
    </div>
    <div class="col-xs-8 col-md-4 column">
        <form action="${pageContext.request.contextPath}/updateCoupons?couponsId=${coupons.couponsId}" method="post">
            <div class="form-group">
                <label>#</label>
                <input type="text" class="form-control" name="couponsId" value="${coupons.couponsId}" disabled>
            </div>
            <div class="form-group">
                <label>券名</label>
                <input type="text" class="form-control" name="couponsName" value="${coupons.couponsName}" required>
            </div>

            <div class="form-group">
                <label>优惠金额</label>
                <input type="text" class="form-control" name="couponsPrice" id="couponsPrice"
                       value="${coupons.couponsPrice}" onkeyup="isN()" required>
                <span id="couponsPriceInfo"></span>
            </div>

            <div class="form-group">
                <label>优惠门槛</label>
                <input type="text" class="form-control" name="couponsThreshold" id="couponsThreshold"
                       value="${coupons.couponsThreshold}" onkeyup="isNN()" required>
                <span id="couponsThresholdInfo"></span>
            </div>

            <div class="form-group">
                <label for="effective">生效日期</label>
                <input type="text" class="form-control" id="effective" name="effectiveDate"
                       value="<fmt:formatDate value="${coupons.effectiveDate}" type="date"/>" required>
                <%--                <label>生效日期</label>--%>
                <%--                <input type="text" class="form-control" name="effectiveDate" placeholder="effectiveDate" required>--%>
            </div>

            <div class="form-group">
                <label for="invalid">失效日期</label>
                <input type="text" class="form-control" id="invalid" name="invalidDate"
                       value="<fmt:formatDate value="${coupons.invalidDate}" type="date"/>" required>
                <%--                <label>失效日期</label>--%>
                <%--                <input type="text" class="form-control" name="invalidDate" placeholder="invalidDate" required>--%>
            </div>

            <div class="form-group">
                <label>当前状态</label>
                <%--                <input type="text" class="form-control" name="state" value="${coupons.state}" required>--%>
                <select name="state" class="form-control" required>
                    <option value="1">生效</option>
                    <option value="0">失效</option>
                </select>
            </div>

            <div>
                <button type="submit" id="btn" class="btn btn-success btn-block">保存</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
<%@ include file="common/foot.jsp" %>
