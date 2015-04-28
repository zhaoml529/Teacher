<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>发表论文</title>
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
	    	editor.readonly();
   	    });
	  })
	  
	  function back(){
		  window.location.href="${ctx}/paperAction/toList_page";
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
            <li class="active">论文详情</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;论文详情&nbsp;<span class="caret"></span>
		  </blockquote>
          <div class="row-fluid">
          <div class="table-responsive">
          	<table class="table table-striped table-hover table-bordered">
		  	<tr class="active">
		  		<td colspan="2" align="center">论文信息</td>
		  	</tr>
		  	<tr>
		  		<td>论文名称</td>
		  		<td>
		  			${paper.title }
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>发表时间</td>
		  		<td>
		  			<fmt:formatDate value="${paper.publishDate }" type="date" />
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>论文字数</td>
		  		<td>
		  			${paper.wordCount } 万字
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>作者顺序</td>
		  		<td>
		  			${paper.author }
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>期刊级别</td>
		  		<td>
		  			${paper.periodicalLevel }
		  		</td>
		  	</tr>
		  	<tr>
		  		<td>期刊名称</td>
		  		<td>
		  			${paper.periodicalName }
		  		</td>
		  	</tr>
		  	<tr>
		  		<td colspan="2">
		  			<textarea id="editor_id" class="form-control" name="remark" rows="3" cols="20">
						${paper.remark }
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