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
<body onload="displayPart('${fn:length(newsList)}');">
  <c:import url="../top.jsp" />
  <div class="container"> 
    <div class="template-page-wrapper">
 	<c:import url="../menu.jsp" />
     <div class="templatemo-content-wrapper">
        <div class="templatemo-content">
          <ol class="breadcrumb">
            <li><a href="${ctx }/loginAction/main">主页</a></li>
            <li class="active">新闻列表</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;新闻&nbsp;<span class="caret"></span>
		  </blockquote>
		  <c:forEach items="${newsList }" var="news" varStatus="i">
			  <div class="page-header">
				 <h3>
				 	<span class="glyphicon glyphicon-paperclip"></span>
				 	${news.title }
				 </h3>
				 <blockquote class="meta">
				 	<p>
				 		<span class="glyphicon glyphicon-user"></span>
				 		${news.teacher.teacherName }&nbsp;
				 		<span class="glyphicon glyphicon-edit"></span>
				 		<fmt:formatDate value="${news.updateDate }" type="both"/>&nbsp;
				 		<span class="glyphicon glyphicon-eye-open"></span>
				 		${news.view }
				 	</p>
				 </blockquote><br>
				 <div id="displayPart${i.index }" displayLength="200">
				 	${news.content }
				 </div>
				 <a href="">Read more</a>
			  </div>	
		  </c:forEach>
		  <form action="${ctx }/newsAction/toList_page" method="post">
		  <input type="hidden" name="newName" value="100">
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