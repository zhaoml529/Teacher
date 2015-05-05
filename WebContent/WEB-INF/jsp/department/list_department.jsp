<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>系部列表</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <link rel="stylesheet" href="${ctx}/css/messenger.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/css/messenger-theme-flat.css" type="text/css" />
  <script type="text/javascript" src="${ctx}/js/messenger.min.js"></script>
  <script type="text/javascript" src="${ctx}/js/messenger-theme-flat.js"></script>
  <script type="text/javascript" src="${ctx}/js/util.js"></script>
  <script type="text/javascript">
  	$(function(){
  		if('${message}' != ""){
  			Messenger.options = {
			    extraClasses: 'messenger-fixed messenger-on-bottom messenger-on-right',
			    theme: 'flat'
			}
		 	Messenger().post({
			  message: "<h5>${message}</h5>",
		 	  hideAfter: 3,
		 	  showCloseButton: true,
		 	});
  		} 
  	 });
  	
  	function toUpdate( id ){
		window.location.href="${ctx}/departmentAction/toUpdate/"+id;  		
  	}
  	
  	function doDel( id ){
  		window.location.href = "${ctx}/departmentAction/doDelete/"+id;
  	}
  	
  </script>
</head>
<body onload="displayPart('${fn:length(newsList)}');">
  <c:import url="../top.jsp" />
  <div class="container"> 
    <div class="template-page-wrapper">
 	<c:import url="../menu.jsp" />
     <div class="templatemo-content-wrapper">
        <div class="templatemo-content">
          <ol class="breadcrumb">
            <li><span class="glyphicon glyphicon-home"></span>&nbsp;<a href="${ctx }/loginAction/main">主页</a></li>
            <li>系统管理</li>
            <li class="active">系部列表</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;系部列表&nbsp;<span class="caret"></span>
		  </blockquote>
		  <form:form action="${ctx }/departmentAction/toList_page" id="pageForm" method="POST">
          <div class="table-responsive" style="margin: -25px 0 0 0;">
          <!-- Split button -->
			<div class="btn-group pull-right" style="margin-bottom: 5px">
			  <button type="button" class="btn btn-success btn-sm" onclick="javascript:window.location.href='${ctx }/departmentAction/toAdd'">添加</button>
			  <button type="button" class="btn btn-success dropdown-toggle" style="height: 30px" data-toggle="dropdown" aria-expanded="false">
			    <span class="caret"></span>
			    <span class="sr-only">Toggle Dropdown</span>
			  </button>
			  <ul class="dropdown-menu" role="menu">
			    <li><a href="${ctx }/departmentAction/toList_page">刷新列表</a></li>
			  </ul>
			</div>
		  <table class="table table-striped table-hover table-bordered">
		  	<tr>
		  		<td>#</td>
		  		<td>系部名称</td>
		  		<td>创建时间</td>
		  		<td>
		  			操作
		  		</td>
		  	</tr>	 
		  	<c:choose>
		  		<c:when test="${list== null || fn:length(list) == 0}">
		  			<tr class="danger">
		  				<td colspan="3" align="center">暂无数据</td>
		  			</tr>
		  		</c:when>
		  		<c:otherwise>
				    <c:forEach items="${list }" var="dept" varStatus="i">
					  	<tr>
					  		<td>${dept.id }</td>
					  		<td>${dept.name }</td>
					  		<td>${dept.createDate }</td>
					  		<td>
					  			<button type="button" class="btn btn-warning btn-xs" onclick="toUpdate('${dept.id}');" >修改</button>
					  			<button type="button" class="btn btn-danger btn-xs" onclick="doDel('${dept.id}');">删除</button>
					  		</td>
					  	</tr>
					</c:forEach>
		  		</c:otherwise>
		  	</c:choose>
		  </table>
		  <div class="well well-sm">
			  <c:out value="${page }" escapeXml="false"/> 
		  </div>
		  </div>
		  </form:form>
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>