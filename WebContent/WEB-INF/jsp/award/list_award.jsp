<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>获奖情况列表</title>
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
  		$(function () { $("[data-toggle='tooltip']").tooltip(); });
  	 });
  	
  	function toUpdate( id ){
		window.location.href="${ctx}/awardAction/toUpdate/"+id;  		
  	}
  	
  	function doDel( id ){
  		window.location.href = "${ctx}/awardAction/doDelete/"+id;
  	}
  	
  	function details( id ){
  		window.location.href = "${ctx}/awardAction/details/"+id;
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
            <li class="active">获奖情况列表</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;获奖列表&nbsp;<span class="caret"></span>
		  </blockquote>
		  <form:form action="${ctx }/awardAction/toList_page" id="pageForm" method="POST">
		  <input type="hidden" name="subId" value="123"/>
          <div class="table-responsive" style="margin: -25px 0 0 0;">
          <!-- Split button -->
			<div class="btn-group pull-right" style="margin-bottom: 5px">
			<c:choose>
				<c:when test="${type != null }">
					<button type="button" class="btn btn-success btn-sm" onclick="javascript:window.location.href='${ctx }/awardAction/toAdd?type=${type }'">添加</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-success btn-sm" onclick="javascript:window.location.href='${ctx }/awardAction/toAdd'">添加</button>
				</c:otherwise>
			</c:choose>
			  
			</c:if>
			  <button type="button" class="btn btn-success dropdown-toggle" style="height: 30px" data-toggle="dropdown" aria-expanded="false">
			    <span class="caret"></span>
			    <span class="sr-only">Toggle Dropdown</span>
			  </button>
			  <ul class="dropdown-menu" role="menu">
			    <li><a href="${ctx }/awardAction/toList_page?orderBy=ASC">创建时间升序</a></li>
			    <li><a href="${ctx }/awardAction/toList_page?orderBy=DESC">创建时间降序</a></li>
			    <li class="divider"></li>
			    <li>
			    	<c:choose>
						<c:when test="${type != null }">
						<a href="${ctx }/awardAction/toList_page?type=${type }">刷新列表</a>
						</c:when>
						<c:otherwise>
							<a href="${ctx }/awardAction/toList_page">刷新列表</a>
						</c:otherwise>
					</c:choose>
			    </li>
			  </ul>
			</div>
		  <table class="table table-striped table-hover table-bordered">
		  	<tr>
		  		<td>#</td>
		  		<td>获奖名称</td>
		  		<td>获奖级别</td>
		  		<td>获得时间</td>
		  		<td>奖项</td>
		  		<td>创建时间</td>
		  		<td>
		  			操作
		  		</td>
		  	</tr>	 
		  	<c:choose>
		  		<c:when test="${awardList== null || fn:length(awardList) == 0}">
		  			<tr class="danger">
		  				<td colspan="7" align="center">暂无数据</td>
		  			</tr>
		  		</c:when>
		  		<c:otherwise>
				    <c:forEach items="${awardList }" var="award">
					  	<tr>
					  		<td><a href="javascript:void(0);" data-toggle="tooltip" data-placement="top" title="详情" onclick="details('${award.id}')">${award.id }</a></td>
					  		<td>${award.name }</td>
					  		<td>${award.awardLevel }</td>
					  		<td>${award.achieveDate }</td>
					  		<td>${award.awards }</td>
					  		<td>${award.createDate }</td>
					  		<td>
					  			<button type="button" class="btn btn-warning btn-xs" onclick="toUpdate('${award.id}');" >修改</button>
					  			<button type="button" class="btn btn-danger btn-xs" onclick="doDel('${award.id}');">删除</button>
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