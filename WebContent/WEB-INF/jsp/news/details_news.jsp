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
            <li><span class="glyphicon glyphicon-home"></span>&nbsp;<a href="${ctx }/loginAction/main">首页</a></li>
            <li><a href="${ctx }/newsAction/toList_page">新闻</a></li>
            <li class="active">详情</li>
          </ol>
          <div class="row-fluid">
          	<div class="page-header">
				 <h3>
				 	<a href="${ctx }/newsAction/details/${news.id }">${news.title }</a>
				 </h3>
 				 <blockquote class="meta">
				 	<p>
				 		<span class="glyphicon glyphicon-user"></span>
				 		${news.teacher.teacherName }&nbsp;
				 		<span class="glyphicon glyphicon-edit"></span>
				 		<fmt:formatDate value="${news.updateDate }" type="both"/>&nbsp;
				 		<span class="glyphicon glyphicon-eye-open"></span>
				 		${news.view }
				 		<c:if test="${user.role == 'manager' or user.role == 'admin' }">
					 		<a class="more" data-toggle="tooltip" data-placement="bottom" title="删除" href="${ctx }/newsAction/doDelete/${news.id }"><span class="glyphicon glyphicon-trash more"></span></a>
					 		<a class="more" data-toggle="tooltip" data-placement="bottom" title="修改" href="${ctx }/newsAction/toUpdate/${news.id }"><span class="glyphicon glyphicon-pencil more"></span></a>
				 		</c:if>
				 		
				 	</p>
				 </blockquote>
				 <div class="panel-body">
				 <p><c:out value="${news.content }" escapeXml="false" /></p>
				 </div>
				 <p><small class="more">——By File Manager System Team</small></p>
			</div>
          </div><!-- row-fluid -->
          <script>
			 $(function () { $("[data-toggle='tooltip']").tooltip(); });
		  </script>
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>