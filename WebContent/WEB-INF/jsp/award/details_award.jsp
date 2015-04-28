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
	    });
	    
	    KindEditor.ready(function(K) {
	    	editor = K.create('#editor_id', {
	    		readonlyMode : true
	    	});
	    	editor.readonly();
   	    });
	  })
	  
	  function back(){
		  window.location.href="${ctx}/awardAction/toList_page?type="+${award.type};
	  }
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
            <li class="active">获奖情况</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;获奖情况&nbsp;<span class="caret"></span>
		  </blockquote>
          <div class="row-fluid">
          <div class="table-responsive">
          	<table class="table table-striped table-hover table-bordered">
		  	<tr class="active">
		  		<td colspan="2" align="center">获奖情况信息</td>
		  	</tr>
		  	<tr>
		  		<td>获奖名称</td>
		  		<td>
		  			${award.name }
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>获奖级别</td>
		  		<td>
		  			${award.awardLevel }
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>获奖时间</td>
		  		<td>
		  			<fmt:formatDate value="${award.achieveDate }" type="date" />
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>奖项</td>
		  		<td>
		  			${award.awards }
		  		</td>
		  	</tr>
		  	<tr>
		  		<td colspan="2">
		  			<textarea id="editor_id" class="form-control" name="remark" rows="3" cols="20">
						${award.remark }
					</textarea>
		  		</td>
		  	</tr>
		  	</table>
          </div>
          <button type="submit" onclick="back();" class="btn btn-success btn-sm">返回</button>
          </div><!-- row-fluid -->
          
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>