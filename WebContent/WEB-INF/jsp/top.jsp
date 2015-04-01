<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="navbar-inner">
	<div class="container-fluid">
    <div class="navbar-header">
   	  <div class="logo"><h1 style="color: white;">教师档案管理系统</h1></div>
   	  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
    </div>
    <div class="nav-collapse">
      <ul class="pull-right nav navbar-nav">
		<li class="item-test"><a href="${ctx }/loginAction/main">首页</a></li>
		<li class="item-test"><a href="${ctx }/newsAction/toList_page">新闻</a></li>
		<li class="item-test"><a href="${ctx }/messageAction/toList_page"><span class="badge pull-right">9</span>站内信</a></li>
		<li class="item-test"><a href="${ctx }/teacherAction/details">用户中心</a></li>
		<li class="item-test"><a href="${ctx }/loginAction/logout">退出</a></li>
	  </ul>          
	</div><!-- nav-collapse -->
   </div><!-- navbar-inner -->
   </div>
</div><!-- navbar navbar-inverse navbar-fixed-top -->
<div class="subnav navbar navbar-fixed-top">
<nav class="navbar navbar-default" role="navigation">
	<div class="container">
    <div class="navbar-inner">
        	<div class="style-switcher pull-left">
                <a href="javascript:chooseStyle('none', 60, 'none');"><span class="style" style="background-color:#000000;"></span></a>
                <a href="javascript:chooseStyle('style1', 60, 'blue');"><span class="style" style="background-color:#0088CC;"></span></a>
                <a href="javascript:chooseStyle('style2', 60, 'purple');"><span class="style" style="background-color:#7c5706;"></span></a>
                <a href="javascript:chooseStyle('style3', 60, 'green');"><span class="style" style="background-color:#468847;"></span></a>
                <a href="javascript:chooseStyle('style4', 60, 'grey');"><span class="style" style="background-color:#4e4e4e;"></span></a>
                <a href="javascript:chooseStyle('style5', 60, 'orange');"><span class="style" style="background-color:#d85515;"></span></a>
                <a href="javascript:chooseStyle('style6', 60, 'pink');"><span class="style" style="background-color:#a00a69;"></span></a>
                <a href="javascript:chooseStyle('style7', 60, 'red');"><span class="style" style="background-color:#a30c22;"></span></a>          	
            </div>
           <form class="navbar-form navbar-right pull-right" role="search">
			    <input type="text" class="form-control" placeholder="Search">
		   </form><!-- container -->
    </div><!-- navbar-inner -->
    </div>
</nav>
</div><!-- subnav -->
