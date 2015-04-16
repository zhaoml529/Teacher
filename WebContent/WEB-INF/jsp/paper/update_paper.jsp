<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>发表论文</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <script type="text/javascript" src="${ctx}/kindeditor/kindeditor-min.js"></script>
  <script type="text/javascript" src="${ctx}/js/kindeditor.js"></script>
  <script type="text/javascript">
	  $(function(){
	    $("#publishDate").datetimepicker({
	    	language: 'zh-CN',
	        format: "yyyy-mm-dd",
	        minView: "month", //选择日期后，不会再跳转去选择时分秒 
	        autoclose: true,
	        todayBtn: true,
	        todayHighlight: true,
	        pickerPosition: "bottom-left"
	    })
	  })
  </script>
</head>
<body>
  <c:import url="../top.jsp" />
  <!-- kindeditor,js所需 -->
  <input type="hidden" id="ctx" value="${ctx }"/>
  <div class="container"> 
    <div class="template-page-wrapper">
 	<c:import url="../menu.jsp" />
     <div class="templatemo-content-wrapper">
        <div class="templatemo-content">
          <ol class="breadcrumb">
            <li><span class="glyphicon glyphicon-home"></span>&nbsp;<a href="${ctx }/loginAction/main">首页</a></li>
            <li>发表论文</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;发表论文&nbsp;<span class="caret"></span>
		  </blockquote>
          <div class="row-fluid">
          
          <form:form action="${ctx }/paperAction/doUpdate" modelAttribute="paper" method="POST">
          <input type="hidden" name="id" value="${paper.id }"/>
          <input type="hidden" name="teacher.teacherId" value="${user.teacherId }"/>
          <input type="hidden" name="type" value="${paper.type }"/>
          <input type="hidden" name="createDate" value="<fmt:formatDate value='${paper.createDate }' type='both'/>"/>
          <div class="table-responsive">
          	<table class="table table-bordered table-condensed">
		  	<tr class="active">
		  		<td colspan="2" align="center">修改论文信息</td>
		  	</tr>
		  	<tr>
		  		<td>论文名称</td>
		  		<td>
		  			<form:errors path="title" cssClass="valid_text"></form:errors>
			    	<input type="text" name="title" value="${paper.title }" class="form-control" placeholder="Enter Title">
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>发表时间</td>
		  		<td>
		  			<form:errors path="publishDate" cssClass="valid_text"></form:errors>
					<div class="input-group date form_datetime" id="publishDate">
						<div class="input-group">
	                    <input name="publishDate" class="form-control" type="text" value="<fmt:formatDate value="${paper.publishDate }" type="date" />" readonly required />
	                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						</div>
	                </div>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>论文字数</td>
		  		<td>
		  			<form:errors path="wordCount" cssClass="valid_text"></form:errors>
			    	<div class="input-group">
						<div class="input-group">
	                    <input type="text" name="wordCount" value="${paper.wordCount }" class="form-control" placeholder="Enter wordCount">
					      <div class="input-group-addon">万字</div>
						</div>
	                </div>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>作者顺序</td>
		  		<td>
		  			<form:errors path="author" cssClass="valid_text"></form:errors>
			    	<input type="text" name="author" value="${paper.author }" class="form-control" placeholder="Enter author">
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>期刊级别</td>
		  		<td>
		  			<form:errors path="periodicalLevel" cssClass="valid_text"></form:errors>
			    	<input type="text" name="periodicalLevel" value="${paper.periodicalLevel }" class="form-control" placeholder="Enter periodicalLevel">
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>期刊名称</td>
		  		<td>
		  			<form:errors path="periodicalName" cssClass="valid_text"></form:errors>
			    	<input type="text" name="periodicalName" value="${paper.periodicalName }" class="form-control" placeholder="Enter periodicalName">
		  		</td>
		  	</tr>
		  	<tr>
		  		<td colspan="2">
		  			<textarea id="editor_id1" class="form-control" name="remark" rows="3" cols="20">
						${paper.remark }
					</textarea>
		  		</td>
		  	</tr>
		  	</table>
          </div>
		  	<button type="submit" class="btn btn-success btn-sm">修改</button>
	      </form:form>
          	
          </div><!-- row-fluid -->
          
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>