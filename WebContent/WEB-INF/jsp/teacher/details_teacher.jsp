<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>用户中心</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
</head>
<body>
  <c:import url="../top.jsp" />
  <div class="container"> 
    <div class="template-page-wrapper">
 	<c:import url="../menu.jsp" />
     <div class="templatemo-content-wrapper">
        <div class="templatemo-content">
			<ol class="breadcrumb">
			  <li><a href="index.html">主页</a></li>
			  <li><a href="#">用户中心</a></li>
			</ol>
			<blockquote>
				<h4><span class="glyphicon glyphicon-user"></span>&nbsp;${teacher.teacherName } 的信息&nbsp;<span class="caret"></span></h4>
			</blockquote>
          	<table class="table table-bordered table-hover">
          		<tr>
          			<th>用户名</th>
          			<td>${teacher.teacherName }</td>
          		</tr>
          		<tr>
          			<th>教师编号</th>
          			<td>${teacher.teacherId }</td>
          		</tr>
          		<tr>
          			<th>注册时间</th>
          			<td>${teacher.regDate }</td>
          		</tr>
          		<tr>
          			<th>最后登录时间</th>
          			<td>${teacher.lgoinDate }</td>
          		</tr>
          		<tr>
          			<th>最后登录IP</th>
          			<td>${teacher.IPAddress }</td>
          		</tr>
          		<tr>
          			<th>所属机构</th>
          			<td>${teacher.department.name }</td>
          		</tr>
          	</table>
          	
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>