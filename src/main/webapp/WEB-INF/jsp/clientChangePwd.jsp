<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="common/head.jsp" %>
<html>
<head>
    <title>修改密码</title>
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

        function getold_pwd() {
            $.ajax({
                url: "${pageContext.request.contextPath}/getold_pwd",
                data: {"Pwd": $("#Old_pwd").val()},
                success: function (data) {
                    $("#old_pwdinfo").css("color", "red");
                    $("#old_pwdinfo").html(data);
                    $("#old_pwdinfo").val(data);
                    if ($("#old_pwdinfo").val() === "" && $("#New_pwd").val() === "")
                        $("#btn").attr("disabled", false);
                    else
                        $("#btn").attr("disabled", true);
                }
            })
        }

        function judge_pwd() {
            if ($("#pwd1").val().length < 6 || !/[a-zA-Z]/.test($("#pwd1").val()) || !/\d/.test($("#pwd1").val())) {
                $("#pwdInfo").css("color", "red");
                $("#pwdInfo").html("密码长度小于6，需包含字母与数字");
                $("#pwdInfo").val("密码长度小于6，需包含字母与数字");
            } else {
                if ($("#pwd1").val() !== $("#pwd").val()) {
                    $("#pwdInfo").css("color", "red");
                    $("#pwdInfo").html("两次输入的密码不一致");
                    $("#pwdInfo").val("两次输入的密码不一致");
                } else {
                    $("#pwdInfo").html("");
                    $("#pwdInfo").val("");
                }
            }
            if ($("#old_pwdinfo").val() === "" && $("#pwdInfo").val() === "")
                $("#btn").attr("disabled", false);
            else
                $("#btn").attr("disabled", true);
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
                <li role="presentation"><a href="${pageContext.request.contextPath}/clientConsume">消费记录</a></li>
                <li role="presentation" id="Person"><a href="#">个人中心</a></li>
                <li role="presentation" class="person"><a
                        href="${pageContext.request.contextPath}/clientCoupons">优惠券</a></li>
                <li role="presentation" class="person"><a href="${pageContext.request.contextPath}/goclientTopUp">充值</a>
                </li>
                <li role="presentation" class="person active"><a
                        href="${pageContext.request.contextPath}/goclientChangePwd">修改密码</a></li>
            </ul>
        </div>

        <div class="col-md-4 column">
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-body">

                    <div class="row clear-fix">
                        <form class="form-inline" action="${pageContext.request.contextPath}/clientChangePwd"
                              method="post">
                            &nbsp;
                            <br>
                            <div class="form-group col-md-12">
                                <label>旧密码: </label>
                                <input type="text" class="form-control" name="old_pwd" id="Old_pwd" placeholder=请输入旧密码
                                       onkeyup="getold_pwd()" required>
                                <span id="old_pwdinfo"></span>
                            </div>
                            &nbsp;
                            <br>
                            <div class="form-group col-md-12">
                                <label>新密码: </label>
                                <input type="text" class="form-control" name="new_pwd" id="pwd1" placeholder=请输入新密码
                                       required>
                            </div>
                            &nbsp;
                            <br>
                            <div class="form-group col-md-12">
                                <label>请确认: </label>
                                <input type="text" class="form-control" name="pwd" id="pwd" onkeyup="judge_pwd()"
                                       placeholder=请确认新密码 required>
                                <br/>
                                <span id="pwdInfo"></span>
                            </div>
                            &nbsp;
                            <br>
                            &nbsp;&nbsp;&nbsp;<button type="submit" class="btn btn-success" id="btn">修改密码</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>


    </div>
</div>

</body>
</html>
<%@ include file="common/foot.jsp" %>