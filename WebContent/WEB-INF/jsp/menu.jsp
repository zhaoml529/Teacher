<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar-collapse collapse templatemo-sidebar">
<div class="well" style="padding: 8px 3px;">
<ul class="templatemo-sidebar-menu">
  <li class="active"><a href="#"><i class="fa fa-home"></i>Dashboard</a></li>
  <li class="sub">
    <a href="javascript:;">
      <i class="fa fa-database"></i> Nested Menu <div class="pull-right"><span class="caret"></span></div>
    </a>
    <ul class="templatemo-submenu">
      <li><a href="#">Aenean</a></li>
      <li><a href="#">Pellentesque</a></li>
      <li><a href="#">Congue</a></li>             
      <li><a href="#">Interdum</a></li>
      <li><a href="#">Facilisi</a></li>
    </ul>
  </li>
  <li><a href="data-visualization.html"><i class="fa fa-cubes"></i><span class="badge pull-right">9</span>Data Visualization</a></li>
  <li><a href="maps.html"><i class="fa fa-map-marker"></i><span class="badge pull-right">42</span>Maps</a></li>
  <li><a href="tables.html"><i class="fa fa-users"></i><span class="badge pull-right">NEW</span>Manage Users</a></li>
  <li><a href="preferences.html"><i class="fa fa-cog"></i>Preferences</a></li>
  <li><a href="${ctx }/teacherAction/1/toList_page" target="content"><i class="fa fa-cog"></i>教师列表</a></li>
  <li><a href="javascript:;" data-toggle="modal" data-target="#confirmModal"><i class="fa fa-sign-out"></i>Sign Out</a></li>
</ul>
</div>
</div><!--/.navbar-collapse -->