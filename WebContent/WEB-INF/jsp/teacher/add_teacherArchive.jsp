<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>教师个人档案</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <script charset="utf-8" src="${ctx}/kindeditor/kindeditor-min.js"></script>
  <script charset="utf-8" src="${ctx}/js/kindeditor.js"></script>
</head>
<body>
  <c:import url="../top.jsp" />
  <div class="container"> 
    <div class="template-page-wrapper">
 	<c:import url="../menu.jsp" />
     <div class="templatemo-content-wrapper">
        <div class="templatemo-content">
          <ol class="breadcrumb">
            <li><span class="glyphicon glyphicon-home"></span>&nbsp;<a href="${ctx }/loginAction/main">主页</a></li>
            <li class="active">个人档案</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;${teacher.teacherName } 的个人档案&nbsp;<span class="caret"></span>
		  </blockquote>
          <div class="row-fluid">
          <form:form action="${ctx }/teacherArchiveAction/doAdd" modelAttribute="teacherArchive" method="POST">
          <div class="panel panel-default">
	          <div class="panel-body">
	          <label class="control-label">新闻标题:</label>
	          <div class="form-group">
				    <form:errors path="title" cssClass="valid_text"></form:errors>
				    <input type="text" name="title" class="form-control" placeholder="Enter title">
			  </div>
	          <label class="control-label">新闻内容:</label>
		      <div class="form-group">
		      <textarea id="editor_id1" class="form-control" name="content" rows="3" cols="20">
				&lt;strong&gt;新闻内容&lt;/strong&gt;
			  </textarea>
			  </div>
	          </div>
	          
	          <table class="table table-bordered">
			  	<tr>
			  		<td colspan="4" align="center">添加个人档案信息</td>
			  	</tr>
			  	<tr>
			  		<td>教师姓名</td>
			  		<td>
			  			<form:errors path="title" cssClass="valid_text"></form:errors>
				    	<input type="text" name="teacherName" value="${teacher.teacherName }" class="form-control" placeholder="Enter teachers name">
			  		</td>
			  		<td colspan="2" rowspan="6">
			  			<img src="${ctx}/images/no_picture.gif}" alt="个人照片" class="img-thumbnail">
			  		</td>
			  	</tr>
			  </table>
	          
	          
	          
	          
	          <div class="panel-footer"><button type="submit" class="btn btn-primary btn-sm">发布</button></div>
          </div>
          </form:form>
          </div><!-- row-fluid -->
          
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>