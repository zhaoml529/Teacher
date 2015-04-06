<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>教师列表</title>
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
            <li><span class="glyphicon glyphicon-home"></span>&nbsp;<a href="${ctx }/loginAction/main">首页</a></li>
            <li><a href="#">新闻</a></li>
            <li class="active">修改新闻</li>
          </ol>
          <div class="row-fluid">
          <form:form action="${ctx }/newsAction/doUpdate" modelAttribute="news" method="POST">
          <input name="id" type="hidden" value="${news.id }"/>
          <div class="panel panel-default">
	          <div class="panel-body">
	          <label class="control-label">新闻标题:</label>
	          <div class="form-group">
				    <form:errors path="title" cssClass="valid_text"></form:errors>
				    <input type="text" name="title" value="${news.title }" class="form-control" placeholder="Enter title">
			  </div>
	          <label class="control-label">新闻内容:</label>
		      <div class="form-group">
		      <textarea id="editor_id1" class="form-control" name="content" rows="3" cols="20">
				${news.content }
			  </textarea>
			  </div>
	          </div>
	          <div class="panel-footer"><button type="submit" class="btn btn-success btn-sm">修改</button></div>
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