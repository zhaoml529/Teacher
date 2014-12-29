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
            <li><span class="glyphicon glyphicon-home"></span>&nbsp;<a href="index.html">主页</a></li>
            <li><a href="${ctx }/messageAction/toList_page">站内信</a></li>
            <li class="active">写信</li>
          </ol>
          <blockquote>
          	<span class="glyphicon glyphicon-edit"></span>&nbsp;发站内信&nbsp;<span class="caret"></span>
          </blockquote>
          <div class="row-fluid">
      	  <form:form action="${ctx }/messageAction/doAdd" modelAttribute="message" method="POST">
		  <div class="panel panel-default">
			  <input type="hidden" name="messageId" value="${msg.id }"/>
			  <div class="panel-body">
			    <label class="control-label">收件人:</label>
			    <div class="form-group">
				    <form:errors path="toUser" cssClass="valid_text"></form:errors>
				    <input type="text" name="toUser" class="form-control" placeholder="Enter receiver">
			    </div>
			    <label class="control-label">标题:</label>
			    <div class="form-group">
				    <form:errors path="title" cssClass="valid_text"></form:errors>
				    <input type="text" name="title" class="form-control" placeholder="Enter title">
			    </div>
			    <label class="control-label">内容:</label>
			    <div class="form-group">
			    <textarea id="editor_id1" class="form-control" name="content" rows="3" cols="20">
					&lt;strong&gt;站内信&lt;/strong&gt;
				</textarea>
				</div>
			  </div>
			  <div class="panel-footer"><button type="submit" class="btn btn-primary btn-sm">发送</button></div>
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