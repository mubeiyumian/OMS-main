<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="common/head.jsp" %>
<html>
<head>
    <title>所有菜单</title>
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
            margin: 30px 30px 10px 20px;
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
                <li role="presentation" class="active"><a
                        href="${pageContext.request.contextPath}/clientOrder?pageNum=1">菜单</a></li>
                <li role="presentation"><a href="${pageContext.request.contextPath}/clientOrderPopular">推荐菜单</a></li>
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
                <li role="presentation"><a href="${pageContext.request.contextPath}/clientTest">修改密码</a></li>
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

                        <div class="col-xs-5 col-md-5 column">
                            <form class="form-inline"
                                  action="${pageContext.request.contextPath}/clientGetDishBySuffixName" method="post">
                                <div class="form-group">
                                    <label>菜名：</label>
                                    <input type="text" class="form-control" name="dishesName"
                                           placeholder="Search for..." required>
                                </div>
                                <button type="submit" class="btn btn-default">查询</button>
                            </form>
                        </div>

                        <div class="col-xs-3 col-md-3 column">
                            <form class="form-inline"
                                  action="${pageContext.request.contextPath}/clientGetDishByCategoryId" method="post">
                                <div class="form-group">
                                    <label>分类：</label>
                                    <%--                                    <input type="text" class="form-control" name="dishesName" placeholder="Search for..." required>--%>
                                    <%--                                    <select name="categoryId" class="form-control">--%>
                                    <%--                                        <option value="0" selected>请选择</option>--%>
                                    <%--                                        <c:forEach var="cateinfo" items="${category}">--%>
                                    <%--                                            <option value="${cateinfo.categoryId}">${cateinfo.cateName}</option>--%>
                                    <%--                                        </c:forEach>--%>
                                    <%--                                    </select>--%>
                                </div>
                                <button type="submit" class="btn btn-default">查询</button>
                            </form>
                        </div>

                    </div>


                </div>

                <div class="clearfix">
                    <div class="col-md-10 column">
                        <div class="box">
                            <div class="left">
                                <img src="${pageContext.request.contextPath}/image/test.jpg" alt="111">
                            </div>
                            <div class="right">
                                <h4>高达</h4>
                                <p>价格：100</p>
                                <p>类别：拼装模型</p>
                                <a href="#">111</a>
                            </div>
                        </div>
                        <div class="box">
                            <div class="left">
                                <img src="${pageContext.request.contextPath}/image/test.jpg" alt="111">
                            </div>
                            <div class="right">
                                <h4>高达</h4>
                                <p>价格：100</p>
                                <p>类别：拼装模型</p>
                                <a href="#">111</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Table -->
                <%--                <table class="table">--%>
                <%--                    <div class="row clearfix">--%>
                <%--                        <div class="col-md-2 column">--%>
                <%--                        </div>--%>
                <%--                        <div class="col-xs-12 col-md-8 column">--%>
                <%--                            <table class="table table-hover table-striped text-center">--%>

                <%--                                <thead>--%>
                <%--                                <tr>--%>
                <%--                                    <th class="text-center">image</th>--%>
                <%--                                    <th class="text-center">#</th>--%>
                <%--                                    <th class="text-center">菜名</th>--%>
                <%--                                    <th class="text-center">单价</th>--%>
                <%--                                    <th class="text-center">类别</th>--%>
                <%--                                    <th class="text-center"><span class="glyphicon glyphicon-align-center" aria-hidden="true"></span></th>--%>
                <%--                                </tr>--%>
                <%--                                </thead>--%>

                <%--                                <tbody>--%>
                <%--                                <c:forEach var="dish" items="${pageInfo.list}">--%>
                <%--                                    <tr>--%>
                <%--                                        <td><img src="${pageContext.request.contextPath}/image/test.jpg" alt="111" style="width: 100px;height: 100px;"></td>--%>
                <%--                                        <td>${dish.dishesId}</td>--%>
                <%--                                        <td>${dish.dishesName}</td>--%>
                <%--                                        <td>${dish.unitPrice}</td>--%>
                <%--&lt;%&ndash;                                        <td>${dish.category}</td>&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                        <td>&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                            <c:choose>&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                                <c:when test="${dish.categoryId == 1}">&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                                    主食&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                                </c:when>&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                                <c:when test="${dish.categoryId == 2}">&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                                    素菜&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                                </c:when>&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                                <c:when test="${dish.categoryId == 3}">&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                                    荤菜&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                                </c:when>&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                                <c:otherwise>&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                                    饮料&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                                </c:otherwise>&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                            </c:choose>&ndash;%&gt;--%>
                <%--&lt;%&ndash;                                        </td>&ndash;%&gt;--%>
                <%--                                        <td>${dish.cateName}</td>--%>
                <%--                                        <td>--%>
                <%--                                            <a class="btn btn-success" href="${pageContext.request.contextPath}/clientAddDish?dishesId=${dish.dishesId}" role="button"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span></a>--%>
                <%--                                        </td>--%>
                <%--                                    </tr>--%>
                <%--                                </c:forEach>--%>
                <%--                                </tbody>--%>
                <%--                                <tfoot>--%>
                <%--                                <tr>--%>
                <%--                                    <td colspan="5">--%>
                <%--                                        <nav aria-label="Page navigation">--%>
                <%--                                            <ul class="pagination justify-content-center">--%>
                <%--                                                <c:forEach var="pageNum" begin="1" end="${pageInfo.pages}">--%>
                <%--                                                    <li class="page-item ${pageNum == pageInfo.pageNum ? 'active' : ''}">--%>
                <%--                                                        <a class="page-link" href="${pageContext.request.contextPath}/clientOrder?pageNum=${pageNum}">${pageNum}</a>--%>
                <%--                                                    </li>--%>
                <%--                                                </c:forEach>--%>
                <%--                                            </ul>--%>
                <%--                                        </nav>--%>
                <%--                                    </td>--%>
                <%--                                </tr>--%>
                <%--                                </tfoot>--%>
                <%--                            </table>--%>
                <%--                        </div>--%>
                <%--                    </div>--%>
                <%--                </table>--%>
            </div>
        </div>
    </div>
</div>

</body>
</html>
<%@ include file="common/foot.jsp" %>