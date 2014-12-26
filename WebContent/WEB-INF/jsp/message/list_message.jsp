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
</head>
<body>
  <c:import url="../top.jsp" />
  <div class="container"> 
    <div class="template-page-wrapper">
 	<c:import url="../menu.jsp" />
     <div class="templatemo-content-wrapper">
        <div class="templatemo-content">
          <ol class="breadcrumb">
            <li><a href="${ctx }/loginAction/login_view">主页</a></li>
            <li><a href="#">站内信</a></li>
          </ol>
          <blockquote>
				<h4><span class="glyphicon glyphicon-envelope"></span>&nbsp;我的信箱&nbsp;<span class="caret"></span></h4>
		  </blockquote>
          
          <div class="table-responsive">
         	 <div class="btn-group" id="action_btn">
			  <button type="button" id="btn_checkbox" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
			    <input type="checkbox" /> <span class="caret"></span>
			  </button>
			  <ul class="dropdown-menu" role="menu">
			    <li><a href="#">全选</a></li>
			    <li><a href="#">不选</a></li>
			    <li class="divider"></li>
			    <li><a href="#">已读</a></li>
			    <li><a href="#">未读</a></li>
			  </ul>
			 </div>
			 
			 <div class="btn-group" id="action_btn">
		      <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
		      	标记为 <span class="caret"></span></button>
		      <ul class="dropdown-menu" role="menu">
		        <li><a href="#">已读</a></li>
		        <li><a href="#">未读</a></li>
		        <li><a href="#">全部设为已读</a></li>
		      </ul>
		     </div>
          
  			 <div class="btn-group" id="action_btn">
		      <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
		      	排序 <span class="caret"></span></button>
		      <ul class="dropdown-menu" role="menu">
		        <li><a href="#">日期升序</a></li>
		        <li><a href="#">日期降序</a></li>
		      </ul>
		     </div>
		     
		     <div class="btn-group" id="action_btn">
			 	<button type="button" class="btn btn-default btn-sm">写信</button>
			 </div>
		     
  			 <div class="btn-group" id="action_btn">
			 	<button type="button" class="btn btn-danger btn-sm">删除</button>
			 </div>
		     
             <table class="table table-striped table-hover table-bordered">
               <thead>
                 <tr>
                   <th>#</th>
                   <th>标题</th>
                   <th>发送者</th>
                   <th>发送时间</th>
                   <th>操作</th>
                 </tr>
               </thead>
               <tbody>
               <c:forEach items="${messageList }" var="msg">
                 <tr>
                 	<td><input type="checkbox" id="1"/></td>
                 	<td>
                 	<c:choose>
              			<c:when test="${msg.review == 0 }">
              				<span class="glyphicon glyphicon-folder-close"></span>
              			</c:when>
              			<c:otherwise>
              				<span class="glyphicon glyphicon-folder-open"></span>
              			</c:otherwise>
              		</c:choose>&nbsp;
                 	${msg.title }
                 	</td>
                 	<td>${msg.fromUser }</td>
                 	<td><fmt:formatDate value="${msg.createDate }" type="both"/> </td>
                 	<td><a href="${ctx }/messageAction/details/${msg.id }">查看</a></td>
                 </tr>
               </c:forEach>
               <tr>
              		<td class="fun_area" colspan="5" align="center">${page }</td>
               </tr>
               </tbody>
             </table>
           </div><!-- table-responsive -->
          
          
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>