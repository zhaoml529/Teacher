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
  <script type="text/javascript" src="${ctx}/js/jquery.ui.widget.js"></script>
  <script type="text/javascript" src="${ctx}/js/jquery.iframe-transport.js"></script>
  <script type="text/javascript" src="${ctx}/js/jquery.fileupload.js"></script>
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
			  <li class="active">用户中心</li>
			</ol>
			<blockquote>
				<h4><span class="glyphicon glyphicon-user"></span>&nbsp;${user.teacherName } 的信息&nbsp;<span class="caret"></span></h4>
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
          		<tr>
          			<th>照片</th>
          			<td>
          				<img id="photo" src="${ctx}/images/no_picture.gif" alt="个人照片" width="75%" class="img-thumbnail img-responsive">
	          				<input id="fileupload" type="file" name="teacherPic" />
	          				<button type="submit" class="btn btn-primary btn-xs">上传</button>
	          				<div class="progress">
							  <div id="progress" class="progress-bar" role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100" style="min-width: 2em; width: 0%;">
							    0%
							  </div>
						    </div>
          			</td>
          		</tr>
          	</table>
          	
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
  <script type="text/javascript">
  	$(function(){  
		  alert(window.location.hostname);
		  $('#fileupload').fileupload({
		     url: '${ctx }/teacherArchiveAction/uploadPic',
		     //dataType: 'json',
		     autoUpload: true,
		     acceptFileTypes:  /(\.|\/)(gif|jpe?g|png)$/i,
		     maxFileSize: 5000000,
		     progressall: function (e, data) {  
		    	var progress = parseInt(data.loaded / data.total * 100, 10);  
		        $("#progress").width(progress + '%');  
		        $("#progress").html(progress + '%');  
		     },
		     done: function (e, data) {
	    	 	$("#photo").attr("src",'${ctx}'+data.result);  
		     }
		 });
	  })
 </script>
</body>
</html>