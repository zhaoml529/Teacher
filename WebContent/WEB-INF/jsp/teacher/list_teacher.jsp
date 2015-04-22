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
  <script type="text/javascript" src="${ctx}/js/util.js"></script>
  <script type="text/javascript">
  	function edit( id,dept_id ){
  		if(dept_id == null){
  			window.location.href="${ctx}/teacherAction/toUpdate/"+id+"/0";
  		}else{
  			window.location.href="${ctx}/teacherAction/toUpdate/"+id+"/"+dept_id;
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
            <li class="active">教师列表</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;教师列表&nbsp;<span class="caret"></span>
		  </blockquote>
		  <form action="${ctx }/teacherAction/toList_page" id="pageForm" method="post">
		  <input type="hidden" name="dept_id" value="${dept_id }" />
		  <div class="table-responsive" style="margin: -25px 0 0 0;">
            <!-- Split button -->
			<div class="btn-group pull-right" style="margin-bottom: 5px">
			  <button type="button" class="btn btn-info btn-sm" onclick="javascript:window.location.href='${ctx }/teacherAction/toAdd?dept_id=${dept_id }'">添加</button>
			  <button type="button" class="btn btn-info dropdown-toggle" style="height: 30px" data-toggle="dropdown" aria-expanded="false">
			    <span class="caret"></span>
			    <span class="sr-only">Toggle Dropdown</span>
			  </button>
			  <ul class="dropdown-menu" role="menu">
			    <li><a href="${ctx }/teacherAction/toList_page?dept_id=${dept_id }&orderBy=ASC">姓名升序</a></li>
			    <li><a href="${ctx }/teacherAction/toList_page?dept_id=${dept_id }&orderBy=DESC">姓名降序</a></li>
			    <li class="divider"></li>
			    <li><a href="${ctx }/teacherAction/toList_page?dept_id=${dept_id }">刷新列表</a></li>
			  </ul>
			</div>
		  <table class="table table-striped table-hover table-bordered">
            <thead>
              <tr>
                <th>教师ID</th>
                <th>教师姓名</th>
                <th>注册时间</th>
                <th>上次登录IP</th>
                <th>所属机构</th>
                <th>角色</th>
                <th style="text-align: left; width: 15%">
                	操作
                </th>
              </tr>
            </thead>
            <tbody>
            <c:forEach items="${list }" var="teacher" varStatus="i">
            	<tr>
            		<td>${teacher.teacherId }</td>
            		<td>${teacher.teacherName }</td>
            		<td>${teacher.regDate }</td>
            		<td>${teacher.IPAddress }</td>
            		<td>${teacher.department.name }</td>
            		<td>
            			<c:choose>
            				<c:when test="${teacher.role == 'teacher' }">
            					教师
            				</c:when>
            				<c:when test="${teacher.role == 'manager' }">
            					系部管理员
            				</c:when>
            				<c:when test="${teacher.role == 'admin' }">
            					系统管理员
            				</c:when>
            			</c:choose>
            		</td>
            		<td align="center">
            			<button type="button" onclick="edit('${teacher.teacherId}', '${dept_id }');" class="btn btn-success btn-sm">编辑</button>
            			<c:choose>
	            			<c:when test="${teacher.isDelete == 0 }">
	            				<button type="button" onclick="accountStop('${teacher.teacherId}');" class="btn btn-danger btn-sm">停用</button>
	            			</c:when>
	            			<c:otherwise>
	            				<button type="button" onclick="activation('${teacher.teacherId}');" class="btn btn-primary btn-sm">激活</button>
	            			</c:otherwise>
            			</c:choose>
            		</td>
            	</tr>
            </c:forEach>
          	</tbody>
          </table>
		  <div class="well well-sm"><c:out value="${page }" escapeXml="false"/></div>
		  </div>
		  </form>
		  </div>
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>