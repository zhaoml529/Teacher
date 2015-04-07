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
  <script type="text/javascript">
  	function approval( id ){
  		window.location.href="${ctx}/teacherArchiveAction/doApproval/"+id;
  	}
  	function doSearch(currentPage)
  	{
  		var pageNum = document.getElementById("pageNum").value;
  		if(isNaN(pageNum))
  		{
  			alert("请输入正确的行数!");
  		}
  		else
  		{
  			document.getElementById('currentPage').value = currentPage;
  			alert("pageNum: "+pageNum+"   currentPage: "+currentPage);
  			document.forms[0].submit();
  		}
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
		  <table class="table table-striped table-hover table-bordered">
            <thead>
              <tr>
                <th width="30%">教师ID</th>
                <th width="25%">教师姓名</th>
                <th width="25%">申请时间</th>
                <th style="text-align: left; width: 20%">
                	<div class="btn-group">
					  <button type="button" class="btn btn-default  btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
					    操作 <span class="caret"></span>
					  </button>
					  <ul class="dropdown-menu" role="menu">
					    <li><a href="${ctx }/teacherArchiveAction/toApprovalList_page?status=APPROVAL_SUCCESS">已通过</a></li>
					    <li><a href="${ctx }/teacherArchiveAction/toApprovalList_page?status=APPROVAL_FAILED">未通过</a></li>
					    <li><a href="${ctx }/teacherArchiveAction/toApprovalList_page?status=WAITING_FOR_APPROVAL">待审核</a></li>
					    <li><a href="${ctx }/teacherArchiveAction/toApprovalList_page?status=PENDING">审核中</a></li>
					    <li class="divider"></li>
					    <li><a href="${ctx }/teacherArchiveAction/toApprovalList_page">刷新列表</a></li>
					  </ul>
					</div>
                </th>
              </tr>
            </thead>
            <tbody>
            <c:forEach items="${list }" var="teacher" varStatus="i">
            	<tr>
            		<td>${teacher.teacher.teacherId }</td>
            		<td>${teacher.teacherName }</td>
            		<td>${teacher.updateDate }</td>
            		<td align="center">
					  	<c:if test="${teacher.isPass == 'PENDING' }">
	            			<button type="button" onclick="approval('${teacher.id}');" class="btn btn-success btn-sm">审核</button>
					  	</c:if>
            		</td>
            	</tr>
            </c:forEach>
          	</tbody>
          </table>
		  <form action="${ctx }/teacherArchiveAction/toList_page" method="post">
		  <div class="well well-sm">
			  ${page }
		  </div>
		  </form>
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>