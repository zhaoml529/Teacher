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
            <li class="active">发表论著</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;发表论著&nbsp;<span class="caret"></span>
		  </blockquote>
          <div class="row-fluid">
          
          <form:form action="${ctx }/bookAction/doUpdate" modelAttribute="book" method="POST">
          <input type="hidden" name="id" value="${book.id }"/>
          <input type="hidden" name="teacher.teacherId" value="${user.teacherId }"/>
          <input type="hidden" name="deptId" value="${book.deptId }"/>
          <input type="hidden" name="type" value="${book.type }"/>
          <input type="hidden" name="createDate" value="<fmt:formatDate value='${book.createDate }' type='both'/>"/>
          <div class="table-responsive">
          	<table class="table table-bordered table-condensed">
		  	<tr class="active">
		  		<td colspan="2" align="center">修改论著信息</td>
		  	</tr>
		  	<tr>
		  		<td>论著名称</td>
		  		<td>
		  			<form:errors path="title" cssClass="valid_text"></form:errors>
			    	<input type="text" name="title" value="${book.title }" class="form-control" placeholder="Enter Title">
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>论著类别</td>
		  		<td>
		  			<form:errors path="style" cssClass="valid_text"></form:errors>
			    	<input type="text" name="style" value="${book.style }" class="form-control" placeholder="Enter Style">
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>出版时间</td>
		  		<td>
		  			<form:errors path="publishDate" cssClass="valid_text"></form:errors>
					<div class="input-group date form_datetime" id="publishDate">
						<div class="input-group">
	                    <input name="publishDate" class="form-control" type="text" value="<fmt:formatDate value="${book.publishDate }" type="date" />" readonly required />
	                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						</div>
	                </div>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>论著字数</td>
		  		<td>
		  			<form:errors path="wordCount" cssClass="valid_text"></form:errors>
			    	<div class="input-group">
						<div class="input-group">
	                    <input type="text" name="wordCount" value="${book.wordCount }" class="form-control" placeholder="Enter wordCount">
					      <div class="input-group-addon">万字</div>
						</div>
	                </div>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>是否为主编</td>
		  		<td>
		  			<form:errors path="isEditor" cssClass="valid_text"></form:errors>
			    	<label class="radio-inline">
					  <input type="radio" name="isEditor" ${book.isEditor == 0?'checked':'' } id="isEditor" value="0"> 否
					</label>
					<label class="radio-inline">
					  <input type="radio" name="isEditor" ${book.isEditor == 1?'checked':'' } id="isEditor" value="1"> 是
					</label>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td colspan="2">
		  			<textarea id="editor_id1" class="form-control" name="remark" rows="3" cols="20">
						${book.remark }
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