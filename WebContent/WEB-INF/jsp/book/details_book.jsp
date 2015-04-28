<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>发表论著</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <script type="text/javascript" src="${ctx}/kindeditor/kindeditor-min.js"></script>
  <script type="text/javascript">
	  $(function(){
	    KindEditor.ready(function(K) {
	    	editor = K.create('#editor_id', {
	    		readonlyMode : true
	    	});
   	    });
	  })
	  
	  function back(){
		  window.location.href="${ctx}/bookAction/toList_page?type=${book.type}";
	  }
  </script>
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
            <li class="active">论著详情</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;论著详情&nbsp;<span class="caret"></span>
		  </blockquote>
          <div class="row-fluid">
          <div class="table-responsive">
          	<table class="table table-striped table-hover table-bordered">
		  	<tr class="active">
		  		<td colspan="2" align="center">论著信息</td>
		  	</tr>
		  	<tr>
		  		<td>论著名称</td>
		  		<td>
		  			${book.title }
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>论著类别</td>
		  		<td>
		  			${book.style }
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>出版时间</td>
		  		<td>
		  			<fmt:formatDate value="${book.publishDate }" type="date" />
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>论著字数</td>
		  		<td>
		  			${book.wordCount } 万字
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>是否为主编</td>
		  		<td>
		  			${book.isEditor == 0?'否':'是' }
		  		</td>
		  	</tr>
		  	<tr>
		  		<td colspan="2">
		  			<textarea id="editor_id" class="form-control" name="remark" rows="3" cols="20">
						${book.remark }
					</textarea>
		  		</td>
		  	</tr>
		  	</table>
          </div>
          <button type="submit" onclick="back();" class="btn btn-success btn-sm">返回</button>
          </div><!-- row-fluid -->
          
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>