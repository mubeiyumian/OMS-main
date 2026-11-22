<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="common/head.jsp" %>
<html>
<head>
    <title>优惠券</title>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://how2j.cn/study/jquery.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        .box {
            float: left;
            margin-right: 120px;
            margin-bottom: 20px;
            margin-left: 10px;
            width: 300px;
            height: 150px;
            background-color: pink;
            border-radius: 15px;
            box-shadow: 10px 10px 10px -4px rgba(0, 0, 0, 0.3);
        }

        .left {
            /*#FFF1EB*/
            /*#ACE0F9*/
            float: left;
            width: 230px;
            height: 150px;
            padding: 20px 10px 10px 20px;
            /*background-image: linear-gradient(to right,#FFF1EB,#ACE0F9);*/
            background-color: #ffcc00;
            border-top-left-radius: 15px;
            border-bottom-left-radius: 15px;
        }

        .left p {
            font: normal 700 20px/20px 宋体, "Times New Roman";
        }

        .right {
            float: left;
            width: 70px;
            height: 150px;
            background-color: #ff8500;
            border-top-right-radius: 15px;
            border-bottom-right-radius: 15px;
        }

        /*.right a {*/
        /*    display: inline-block;*/
        /*    width: 70px;*/
        /*    height: 150px;*/
        /*    text-decoration: none;*/
        /*}*/
        .right button {
            width: 70px;
            height: 150px;
            background-color: #add8e6;
            /*background-image: linear-gradient(to right,#be71f9, #b45afa, #9348fa);*/
            border-top-right-radius: 15px;
            border-bottom-right-radius: 15px;
            border: 0;
            writing-mode: vertical-rl;
            font: normal 700 35px/10px 宋体, "Times New Roman";
            margin: 0 auto;
        }
    </style>
    <script>
        $(document).ready(function () {
            $.ajax({
                method: "GET",
                url: "${pageContext.request.contextPath}/clientGetCouponsInfo",
                dataType: "JSON",
                success: function (data) {
                    renderCoupons(data);

                    function renderCoupons(coupons) {
                        const container = $('#container');
                        coupons.forEach(coupon => {
                            const couponBox = createCouponBox(coupon);
                            container.append(couponBox);
                        });
                    }

                    function getdate(date) {
                        const year = date.getFullYear()
                        let month = date.getMonth()
                        let day = date.getDate()
                        month += 1
                        day = day < 10 ? "0" + day : day
                        return year + "-" + month + "-" + day
                    }

                    function createCouponBox(coupon) {
                        const box = $('<div class="box"></div>');
                        const leftDiv = $('<div class="left"></div>');
                        const rightDiv = $('<div class="right"></div>');
                        let state = '可使用'
                        const effecttmp = new Date(coupon.effectiveDate)
                        const effect = getdate(effecttmp)
                        const invalidtmp = new Date(coupon.invalidDate)
                        const invalid = getdate(invalidtmp)
                        if (coupon.mainState === 1) {
                            if (coupon.secondState === 1) {
                                state = "已使用"
                            } else {
                                const currenttmp = new Date()
                                const current = getdate(currenttmp)
                                if (current >= effect) {
                                    if (current <= invalid) {
                                        state = "可使用"
                                    } else {
                                        state = "已过期"
                                    }
                                } else {
                                    state = "未生效"
                                }
                            }
                        } else {
                            state = "已过期"
                        }
                        const form = $('<form action="${pageContext.request.contextPath}/clientOrder?pageNum=1" method="post"></form>')
                        const button = $('<button></button>').text(state);
                        if (state === "可使用") {
                            button.prop("disabled", false)
                        } else {
                            button.prop("disabled", true)
                        }
                        form.append(button)
                        rightDiv.append(form);

                        <%--const properties = ['userName', 'couponsPrice'];--%>
                        <%--properties.forEach(prop => {--%>
                        <%--    const p = $('<p></p>').text(`${coupon[prop]}`);--%>
                        <%--    leftDiv.append(p);--%>
                        <%--});--%>
                        const p1 = $('<p></p>').text('优惠金额' + coupon.couponsPrice);
                        leftDiv.append(p1)
                        const p2 = $('<p></p>').text('优惠门槛' + coupon.couponsThreshold);
                        leftDiv.append(p2)
                        // const effdate = new Date(coupon.effectiveDate).toJSON()
                        const p3 = $('<p></p>').text('开始日期' + effect);
                        leftDiv.append(p3)
                        // const ivddate = new Date(coupon.invalidDate).toJSON()
                        const p4 = $('<p></p>').text('结束日期' + invalid);
                        leftDiv.append(p4)

                        box.append(leftDiv);
                        box.append(rightDiv);
                        return box;
                    }
                }
            })

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
        <%--        <div class="col-xs-1 col-md-1 column">--%>
        <%--            &nbsp;--%>
        <%--        </div>--%>
        <div class="col-md-10 column">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row clear-fix">
                        <div class="col-xs-2 col-md-2 column">
                            <a href="${pageContext.request.contextPath}/clientGetCouponsAll">
                                <button type="button" class="btn btn-success">
                                    <span class="glyphicon glyphicon-list" aria-hidden="true"></span>
                                    &nbsp; &nbsp;
                                    领取优惠券
                                </button>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row clear-fix">
                        <div class="row clear-fix">
                            <div class="col-xs-11 col-md-11 column" id="container">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>
<%@ include file="common/foot.jsp" %>