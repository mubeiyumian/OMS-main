<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="common/head.jsp" %>
<html>
<head>
    <title>数据分析</title>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://how2j.cn/study/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/echarts/5.3.3/echarts.min.js"></script>
<%--    <script src="https://cdn.staticfile.net/Chart.js/3.9.1/chart.js"></script>--%>

    <script>
        $(document).ready(function () {
            $('#Person').click(function (e) {
                e.preventDefault(); // 阻止默认行为
                $(this).nextAll('.person').toggle(); // 切换第八和第九个列表项的显示状态
                $('li').removeClass('active'); // 移除所有列表项的active类
                $(this).addClass('active'); // 将当前点击的列表项设置为active并添加btn-success类
            });

            $.ajax({
                url: "${pageContext.request.contextPath}/getChartsDish",
                dataType: "JSON",
                success: function (orders) {
                    console.log(orders)
                    var topDishNames = $.map(orders, function(order) { return order.dishesName; });
                    var topDishQuantities = $.map(orders, function(order) { return order.cnt; });
                    // ECharts for Top Dishes Chart
                    var topDishesChart = echarts.init(document.querySelector('#topDishesChart'));
                    var optionTopDishes = {
                        title: {
                            text: '排名前10的菜品数目'
                        },
                        tooltip: {},
                        xAxis: {
                            data: topDishNames
                        },
                        yAxis: {},
                        series: [{
                            type: 'bar',
                            data: topDishQuantities
                        }]
                    };
                    topDishesChart.setOption(optionTopDishes);
                }
            })

            <%--$.ajax({--%>
            <%--    url: "${pageContext.request.contextPath}/getChartsTime",--%>
            <%--    dataType: "JSON",--%>
            <%--    success: function (data) {--%>
            <%--        var topDishQuantities = $.map(orders, function(order) { return order.cnt; });--%>
            <%--        var peakHoursData = [10, 15, 20, 25, 30, 28, 22, 18, 15, 10, 5, 3];--%>

            <%--        // ECharts for Peak Hours Chart--%>
            <%--        var peakHoursChart = echarts.init(document.getElementById('peakHoursChart'));--%>
            <%--        var optionPeakHours = {--%>
            <%--            title: {--%>
            <%--                text: '用餐时间高峰期'--%>
            <%--            },--%>
            <%--            tooltip: {},--%>
            <%--            xAxis: {--%>
            <%--                data: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00']--%>
            <%--            },--%>
            <%--            yAxis: {},--%>
            <%--            series: [{--%>
            <%--                type: 'line',--%>
            <%--                data: peakHoursData--%>
            <%--            }]--%>
            <%--        };--%>
            <%--        peakHoursChart.setOption(optionPeakHours);--%>
            <%--    }--%>
            <%--})--%>
        });
    </script>
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
                <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/allCharts">数据分析</a>
                </li>
            </ul>
        </div>

        <div class="col-md-10 column">
            <div class="card mb-4">
                <div class="card-body">
                    <div id="topDishesChart" style="height: 400px;"></div>
                </div>
            </div>
        </div>


    </div>
</div>

</body>
</html>
<%@ include file="common/foot.jsp" %>