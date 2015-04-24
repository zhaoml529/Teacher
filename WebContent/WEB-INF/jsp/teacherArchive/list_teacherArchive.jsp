<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>审批列表</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <script type="text/javascript" src="${ctx}/js/util.js"></script>
  <script type="text/javascript">
  	function details( id ){
  		window.location.href="${ctx}/teacherArchiveAction/doApproval/"+id;
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
            <li class="active">档案管理</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;档案管理&nbsp;<span class="caret"></span>
		  </blockquote>
		  <form action="${ctx }/teacherArchiveAction/getArchiveList_page" id="pageForm" method="post">
		  <input type="hidden" name="status" value="${status }">
		  <div class="table-responsive">
		  <div class="btn-group pull-right" style="margin-bottom: 5px">
			  <button type="button" class="btn btn-default  btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
			    查看 <span class="caret"></span>
			  </button>
			  <ul class="dropdown-menu" role="menu">
			    <li><a href="${ctx }/teacherArchiveAction/getArchiveList_page?status=APPROVAL_SUCCESS">已通过</a></li>
			    <li><a href="${ctx }/teacherArchiveAction/getArchiveList_page?status=APPROVAL_FAILED">未通过</a></li>
			    <li><a href="${ctx }/teacherArchiveAction/getArchiveList_page?status=WAITING_FOR_APPROVAL">待审核</a></li>
			    <li><a href="${ctx }/teacherArchiveAction/getArchiveList_page?status=PENDING">审核中</a></li>
			    <li class="divider"></li>
			    <li><a href="${ctx }/teacherArchiveAction/getArchiveList_page?status=${status }">刷新列表</a></li>
			  </ul>
			</div>
		  <table class="table table-striped table-hover table-bordered">
            <thead>
              <tr>
                <th width="20%">教师ID</th>
                <th width="20%">教师姓名</th>
                <th width="20%">审批状态</th>
                <th width="20%">创建时间</th>
                <th style="text-align: left; width: 20%">
                	操作
                </th>
              </tr>
            </thead>
            <tbody>
            <c:forEach items="${list }" var="teacher" varStatus="i">
            	<tr>
            		<td>${teacher.teacher.teacherId }</td>
            		<td>${teacher.teacherName }</td>
            		<td>
            			<c:choose>
            				<c:when test="${teacher.isPass == 'WAITING_FOR_APPROVAL' }">
            					<span class="label label-warning">待审批...</span>
            				</c:when>
            				<c:when test="${teacher.isPass == 'APPROVAL_SUCCESS' }">
            					<span class="label label-success">通过</span>
            				</c:when>
            				<c:when test="${teacher.isPass == 'PENDING' }">
            					<span class="label label-info">审批中...</span>
            				</c:when>
            				<c:otherwise>
            					<span class="label label-danger">不通过</span>
            				</c:otherwise>
            			</c:choose>
            		</td>
            		<td>${teacher.createDate }</td>
            		<td align="center">
            			<button type="button" onclick="details('${teacher.id}');" class="btn btn-success btn-sm">查看</button>
            		</td>
            	</tr>
            </c:forEach>
          	</tbody>
          </table>
		  <div class="well well-sm">
			  <c:out value="${page }" escapeXml="false"/> 
		  </div>
		  </div>
		  </form>
		  </div>
	  	</div>
	 </div>
	</div>
  <c:import url="../footer.jsp" />
</body>
</html>