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
  	$(function(){
  		var count = "${fn:length(newsList)}";
  		for(var i=1;i<=count;i++){
	  		$("#author_"+i).tooltip();
	  		$("#updateDate_"+i).tooltip();
	  		$("#view_"+i).tooltip();
	  		$("#readmore_"+i).tooltip();
  		}
  	})
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
            <li class="active">新闻</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;新闻&nbsp;<span class="caret"></span>
		  </blockquote>
		  <form action="${ctx }/newsAction/toList_page" id="pageForm" method="post">
		  <c:forEach items="${newsList }" var="news" varStatus="i">
			  <div class="page-header">
				 <h3>
				 	<span class="glyphicon glyphicon-paperclip"></span>
				 	<a href="${ctx }/newsAction/details/${news.id }">${news.title }</a>
				 </h3>
				 <blockquote class="meta">
				 	<p>
				 		<span id="author_${i.count }" data-placement="bottom" title="发布人" class="glyphicon glyphicon-user"></span>
				 		${news.teacher.teacherName }&nbsp;
				 		<span id="updateDate_${i.count}" data-placement="bottom" title="发布时间" class="glyphicon glyphicon-edit"></span>
				 		<fmt:formatDate value="${news.updateDate }" type="both"/>&nbsp;
				 		<span id="view_${i.count}" data-placement="bottom" title="查看数" class="glyphicon glyphicon-eye-open"></span>
				 		${news.view }
				 	</p>
				 </blockquote><br>
				 <div id="displayPart${i.index }" displayLength="200">
				 	${news.content }
				 </div>
				 <a href="${ctx }/newsAction/details/${news.id }" id="readmore_${i.count}" data-placement="right" title="查看详情">Read more..</a>
			  </div>	
		  </c:forEach>
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