<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="common/head.jsp" %>
<html>
<head>
    <title>充值</title>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://how2j.cn/study/jquery.min.js"></script>
    <style>
        /* 设置所有元素的盒模型为border-box */
        *{
            box-sizing:border-box;
        }
        /* 定义slider类的样式 */
        .slider{
            width:1000px; /* 设置宽度为560像素 */
            height:580px; /* 设置高度为400像素 */
            overflow:hidden; /* 隐藏溢出的内容 */
            margin: 0 auto;
        }
        /* 定义slider-wrapper类的样式 */
        .slider-wrapper{
            width:100%; /* 宽度设置为100% */
            height:520px; /* 高度设置为320像素 */
        }
        /* 定义slider-wrapper类下的img标签的样式 */
        .slider-wrapper img{
            width:100%; /* 宽度设置为100% */
            height:100%; /* 高度设置为100% */
            display:block; /* 将图片设置为块级元素 */
        }
        /* 定义slider-footer类的样式 */
        .slider-footer{
            height:60px; /* 高度设置为80像素 */
            background-color:rgb(208,255,217); /* 背景颜色设置为RGB值(135,206,235) */
            padding:12px 12px 0 12px; /* 内边距设置为上下12像素，左右12像素 */
            position:relative; /* 相对定位 */
        }
        /* 定义slider-footer类下的toggle类的样式 */
        .slider-footer .toggle{
            position:absolute; /* 绝对定位 */
            right:0; /* 距离右侧边缘0像素 */
            top:12px; /* 距离顶部边缘12像素 */
            display:flex; /* 使用弹性布局 */
        }
        /* 定义slider-footer类下的toggle类下的button标签的样式 */
        .slider-footer .toggle button{
            margin-right:12px; /* 右边距设置为12像素 */
            width:28px; /* 宽度设置为28像素 */
            height:28px; /* 高度设置为28像素 */
            appearance:none; /* 取消默认外观 */
            border:none; /* 无边框 */
            background:rgba(255,255,255,0.1); /* 背景颜色设置为半透明的白色 */
            color:#fff; /* 文字颜色设置为白色 */
            border-radius:4px; /* 边框圆角设置为4像素 */
            cursor:pointer; /* 鼠标指针变为手形图标 */
        }
        /* 定义slider-footer类下的toggle类下的button标签的悬停样式 */
        .slider-footer .toggle button:hover{
            background-color:rgba(255,255,255,0.2); /* 背景颜色设置为更浅的半透明白色 */
        }
        /* 定义slider-footer类下的p标签的样式 */
        .slider-footer p{
            margin:0; /* 外边距设置为0 */
            color:#fff; /* 文字颜色设置为白色 */
            font-size:18px; /* 字体大小设置为18像素 */
            margin-bottom:10px; /* 下边距设置为10像素 */
        }
        /* 定义slider-indicator类的样式 */
        .slider-indicator{
            margin:0; /* 外边距设置为0 */
            padding:0; /* 内边距设置为0 */
            list-style:none; /* 去除列表样式 */
            display:flex; /* 使用弹性布局 */
            align-items:center; /* 垂直居中对齐 */
        }
        /* 定义slider-indicator类下的li标签的样式 */
        .slider-indicator li{
            width:8px; /* 宽度设置为8像素 */
            height:8px; /* 高度设置为8像素 */
            margin:4px; /* 外边距设置为4像素 */
            border-radius:50%; /* 边框圆角设置为50% */
            background:#fff; /* 背景颜色设置为白色 */
            opacity:0.4; /* 透明度设置为0.4 */
            cursor:pointer; /* 鼠标指针变为手形图标 */
        }
        /* 定义slider-indicator类下的li标签的激活状态样式 */
        .slider-indicator li.active{
            width:12px; /* 宽度设置为12像素 */
            height:12px; /* 高度设置为12像素 */
            opacity:1; /* 透明度设置为1 */
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
            // 定义一个包含图片URL和颜色的对象数组
            const data = [
                {url:'${pageContext.request.contextPath}/image/main.jpg', color:'rgba(135,206,235,0.2)'},
                {url:'${pageContext.request.contextPath}/image/3.jpg', color:'rgba(228 227 222,0.2)'},
                {url:'${pageContext.request.contextPath}/image/4.jpg', color:'rgba(179 157 133,0.2)'}
            ]

            // 获取页面中的img元素
            const img = document.querySelector('img')

            // 获取页面中的slider-footer元素
            const color = document.querySelector('.slider-footer')

            // 初始化索引变量i
            let i = 0

            // 获取页面中的next元素
            const next = document.querySelector(".next")

            // 获取页面中的prev元素
            const prev = document.querySelector(".prev")

            // 为下一个按钮添加点击事件监听器
            next.addEventListener('click', function(){
                i++;
                if (i >= data.length){
                    i = 0
                }
                fn()
            })

            // 为上一个按钮添加点击事件监听器
            prev.addEventListener('click', function(){
                i--;
                i = i < 0 ? data.length - 1 : i // 如果i小于0，则将其设置为data.length - 1，否则保持不变
                fn()
            })

            // 设置定时器，每隔1秒自动切换到下一张图片
            let timerID = setInterval(function(){
                next.click()
            }, 10000)

            // 获取slider元素并为其添加鼠标进入和离开事件监听器
            const slider = document.querySelector(".slider")
            slider.addEventListener("mouseenter", function(){
                clearInterval(timerID) // 当鼠标进入时，清除定时器
            })
            slider.addEventListener("mouseleave", function(){
                clearInterval(timerID) // 当鼠标离开时，清除定时器
                timerID = setInterval(function(){ // 重新设置定时器，每隔1秒自动切换到下一张图片
                    next.click()
                }, 10000)
            })

            // 定义一个函数fn，用于更新图片和颜色
            function fn(){
                img.src = data[i].url // 更新图片的src属性为当前索引对应的图片URL
                color.style.backgroundColor = data[i].color // 更新slider-footer的背景颜色为当前索引对应的颜色
                // 移除当前选中项的active类
                document.querySelector('.active').classList.remove('active')
                // 给当前索引对应的li元素添加active类
                document.querySelector(`li:nth-child(${i + 1})`).classList.add('active')
            }
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
                <li role="presentation" class="person" style="display: none"><a href="${pageContext.request.contextPath}/clientCoupons">优惠券</a></li>
                <li role="presentation" class="person" style="display: none"><a href="${pageContext.request.contextPath}/goclientTopUp">充值</a></li>
                <li role="presentation" class="person" style="display: none"><a href="${pageContext.request.contextPath}/goclientChangePwd">修改密码</a></li>
            </ul>
        </div>

        <div class="col-md-10 column">
            <div class="slider">
                <div class="slider-wrapper">
                    <img src="${pageContext.request.contextPath}/image/main.jpg" alt="" />
                </div>
                <div class="slider-footer">
                    <ul class="slider-indicator">
                        <li class="active"></li>
                        <li></li>
                        <li></li>
                    </ul>
                    <div class="toggle">
                        <button class="prev">&lt;</button>
                        <button class="next">&gt;</button>
                    </div>
                </div>
            </div>
        </div>


    </div>
</div>

</body>
</html>
<%@ include file="common/foot.jsp" %>