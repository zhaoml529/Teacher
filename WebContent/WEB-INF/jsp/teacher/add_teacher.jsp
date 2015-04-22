<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>添加教师</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
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
            <li><a href="#">添加教师</a></li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;添加教师&nbsp;<span class="caret"></span>
		  </blockquote>
          <div class="row-fluid">
          
          <form:form action="${ctx }/teacherAction/doAdd" modelAttribute="teacher" method="POST">
          <input type="hidden" name="dept_id" value="${dept_id }"/>
          <div class="table-responsive">
          	<div class="alert alert-warning alert-dismissible" role="alert">
			  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			  <strong>Warning!</strong> 您只能添加系部管理员所在系部的教师信息.
			</div>
          	<table class="table table-bordered table-condensed">
		  	<tr class="active">
		  		<td colspan="2" align="center">添加教师</td>
		  	</tr>
		  	<tr>
		  		<td>教师姓名</td>
		  		<td>
		  			<form:errors path="teacherName" cssClass="valid_text"></form:errors>
			    	<input type="text" name="teacherName" value="${teacher.teacherName }" class="form-control" placeholder="Enter subName" required/>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>登录密码</td>
		  		<td>
		  			<form:errors path="password" cssClass="valid_text"></form:errors>
			    	<input type="text" name="password" value="${teacher.password }" class="form-control" placeholder="Enter password" required/>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>所属机构</td>
		  		<td>
		  			<form:errors path="department.id" cssClass="valid_text"></form:errors>
		  			<c:choose>
		  				<c:when test="${empty dept_id }">
				  			<select name="department.id" required>  
				  				<c:forEach items="${deptList }" var="department">
					  				<option ${teacher.department.id == department.id?"selected":"" } value="${department.id }">${department.name }</option>
				  				</c:forEach>
				  			</select>
		  				</c:when>
		  				<c:otherwise>
		  					<input type="text" name="role" value="${user.department.name }" class="form-control" disabled="disabled" required/>
		  				</c:otherwise>
		  			</c:choose>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>所属角色</td>
		  		<td>
		  			<form:errors path="role" cssClass="valid_text"></form:errors>
		  			<select name="role" required>  
	  					<option ${teacher.role == "teacher"?"selected":"" } value="teacher">教师</option>
	  					<option ${teacher.role == "manager"?"selected":"" } value="manager">系部管理员</option>
	  					<option ${teacher.role == "admin"?"selected":"" } value="admin">系统管理员</option>
	  				</select>
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