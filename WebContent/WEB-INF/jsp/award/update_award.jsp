<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>获奖情况</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <script type="text/javascript" src="${ctx}/kindeditor/kindeditor-min.js"></script>
  <script type="text/javascript" src="${ctx}/js/kindeditor.js"></script>
  <script type="text/javascript">
	  $(function(){
	    $("#achieveDate").datetimepicker({
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
            <li>获奖情况</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;获奖情况&nbsp;<span class="caret"></span>
		  </blockquote>
          <div class="row-fluid">
          
          <form:form action="${ctx }/awardAction/doUpdate" modelAttribute="award" method="POST">
          <input type="hidden" name="id" value="${award.id }"/>
          <input type="hidden" name="teacher.teacherId" value="${user.teacherId }"/>
          <input type="hidden" name="type" value="${type }"/>
          <input type="hidden" name="createDate" value="<fmt:formatDate value='${award.createDate }' type='both'/>"/>
          <div class="table-responsive">
          	<table class="table table-bordered table-condensed">
		  	<tr class="active">
		  		<td colspan="2" align="center">修改获奖信息</td>
		  	</tr>
		  	<tr>
		  		<td>获奖名称</td>
		  		<td>
		  			<form:errors path="title" cssClass="valid_text"></form:errors>
			    	<input type="text" name="title" value="${award.title }" class="form-control" placeholder="Enter Title">
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>获奖级别</td>
		  		<td>
		  			<form:errors path="awardLevel" cssClass="valid_text"></form:errors>
			    	<input type="text" name="awardLevel" value="${award.awardLevel }" class="form-control" placeholder="Enter name">
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>获奖时间</td>
		  		<td>
		  			<form:errors path="achieveDate" cssClass="valid_text"></form:errors>
					<div id="achieveDate" class="input-group date form_datetime">
						<div class="input-group">
	                    <input name="achieveDate" class="form-control" type="text" value="<fmt:formatDate value="${award.achieveDate }" type="date" />" readonly required />
	                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						</div>
	                </div>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>奖项</td>
		  		<td>
		  			<form:errors path="awards" cssClass="valid_text"></form:errors>
			    	<input type="text" name="awards" value="${award.awards }" class="form-control" placeholder="Enter name">
		  		</td>
		  	</tr>
		  	<tr>
		  	<tr>
		  		<td colspan="2">
		  			<textarea id="editor_id1" class="form-control" name="remark" rows="3" cols="20">
						${award.remark }
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