<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>在研课题</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <script type="text/javascript" src="${ctx}/kindeditor/kindeditor-min.js"></script>
  <script type="text/javascript" src="${ctx}/js/kindeditor.js"></script>
  <script type="text/javascript">
	  $(function(){
	    $("#subDate").datetimepicker({
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
  <input type="hidden" id="ctx" value="${ctx }"/>
  <div class="container"> 
    <div class="template-page-wrapper">
 	<c:import url="../menu.jsp" />
     <div class="templatemo-content-wrapper">
        <div class="templatemo-content">
          <ol class="breadcrumb">
            <li><span class="glyphicon glyphicon-home"></span>&nbsp;<a href="${ctx }/loginAction/main">首页</a></li>
            <li class="active">课题添加</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;课题添加&nbsp;<span class="caret"></span>
		  </blockquote>
          <div class="row-fluid">
          
          <form:form action="${ctx }/subjectAction/doAdd" modelAttribute="subject" method="POST">
          <input type="hidden" name="teacher.teacherId" value="${user.teacherId }"/>
          <input type="hidden" name="type" value="${type }"/>
          <div class="table-responsive">
          	<table class="table table-bordered table-condensed">
		  	<tr class="active">
		  		<td colspan="2" align="center">添加课题信息</td>
		  	</tr>
		  	<tr>
		  		<td>课题名称</td>
		  		<td>
		  			<form:errors path="subName" cssClass="valid_text"></form:errors>
			    	<input type="text" name="subName" value="${subject.subName }" class="form-control" placeholder="Enter subName">
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>立项时间</td>
		  		<td>
		  			<form:errors path="subDate" cssClass="valid_text"></form:errors>
					<div class="input-group date form_datetime" id="subDate">
						<div class="input-group">
	                    <input name="subDate" class="form-control" type="text" value="<fmt:formatDate value="${subject.subDate }" type="date" />" readonly required />
	                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						</div>
	                </div>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>课题级别</td>
		  		<td>
		  			<form:errors path="subLevel" cssClass="valid_text"></form:errors>
			    	<input type="text" name="subLevel" value="${subject.subLevel }" class="form-control" placeholder="Enter subLevel">
		  		</td>
		  	</tr>
		  	<tr>
		  		<td colspan="2">
		  			<textarea id="editor_id1" class="form-control" name="remark" rows="3" cols="20">
						&lt;strong&gt;备注&lt;/strong&gt;
					</textarea>
		  		</td>
		  	</tr>
		  	</table>
          </div>
		  	<button type="submit" class="btn btn-success btn-sm">添加</button>
	      </form:form>
          	
          </div><!-- row-fluid -->
          
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>