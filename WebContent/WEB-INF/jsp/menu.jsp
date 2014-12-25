<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar-collapse collapse templatemo-sidebar">
<div class="well" style="padding: 8px 3px;">
<ul class="templatemo-sidebar-menu">
  <li class="active"><a href="#"><i class="fa fa-home"></i>我的档案</a></li>
  <li class="sub">
    <a href="javascript:;">
      <i class="fa fa-cubes"></i>教学研究 <div class="pull-right"><span class="caret"></span></div>
    </a>
    <ul class="templatemo-submenu">
      <!--宽度 templatemo_main.css 120  -->
      <!--li 北京颜色 templatemo_main.css 131  -->
      <li><a href="#">在研课题</a></li>
      <li><a href="#">发表论文</a></li>
      <li><a href="#">发表论著</a></li>             
      <li><a href="#">获奖情况</a></li>
    </ul>
  </li>
  <li class="sub">
    <a href="javascript:;">
      <i class="fa fa-database"></i>科学研究 <div class="pull-right"><span class="caret"></span></div>
    </a>
    <ul class="templatemo-submenu">
      <li><a href="#">在研课题</a></li>
      <li><a href="#">发表论文</a></li>
      <li><a href="#">论著情况</a></li>             
      <li><a href="#">获奖情况</a></li>
    </ul>
  </li>
  <li><a href="${ctx }/teacherAction/1/toList_page" target="content"><i class="fa fa-users"></i>教师列表</a></li>
  <li><a href="${ctx }/teacherAction/1/toList_page" target="content"><i class="glyphicon glyphicon-calendar"></i>日程管理</a></li>
  <li><a href="preferences.html"><i class="fa fa-cog"></i>系统设置</a></li>
  <li><a href="javascript:;" data-toggle="modal" data-target="#confirmModal"><i class="fa fa-sign-out"></i>退出</a></li>
</ul>
</div>
</div><!--/.navbar-collapse -->