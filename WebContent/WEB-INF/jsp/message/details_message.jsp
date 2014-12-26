<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>查看站内信</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <script charset="utf-8" src="${ctx}/kindeditor/kindeditor-min.js"></script>
  <script charset="utf-8" src="${ctx}/kindeditor/plugins/code/prettify.js"></script>
  
  <script type="text/javascript">
    	KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="content"]', {
				uploadJson : 'uploadJson/file_upload',
				fileManagerJson : 'uploadJson/file_manager',
				minWidth : '500px',
				allowFileManager : true,
				items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
					});
				}
			});
			prettyPrint();
		});
    	
    </script>
  
</head>
<body>
  <c:import url="../top.jsp" />
  <div class="container"> 
    <div class="template-page-wrapper">
 	<c:import url="../menu.jsp" />
     <div class="templatemo-content-wrapper">
        <div class="templatemo-content">
          <ol class="breadcrumb">
            <li><a href="index.html">首页</a></li>
            <li><a href="#">站内信</a></li>
            <li class="active">详情</li>
          </ol>
          
          <div class="row-fluid">
          <div class="page-header">
		    <h1><b>${msg.title }</b> <small>来自 <a href="">${msg.fromUser }</a> 在  <fmt:formatDate value="${msg.createDate }" type="both"/></small></h1>
		  </div>
		  <em>内容：</em><br/>
       	  <blockquote>
      	    <p><c:out value="${msg.content }" escapeXml="false"></c:out></p>		      				   
          </blockquote>
          </div><!-- row-fluid -->
          
          <div class="row-fluid">
          <div class="panel panel-default">
          	<form action="" method="post">
			  <div class="panel-body">
			    <p>收件人:</p>
			    <div class="form-group">
				    <label class="sr-only" for="exampleInputEmail2">To User</label>
				    <input type="text" class="form-control" value="${msg.fromUser }" placeholder="Enter receiver" readonly>
			    </div>
			    <p>标题:</p>
			    <div class="form-group">
				    <label class="sr-only" for="exampleInputEmail2">Title</label>
				    <input type="text" class="form-control" placeholder="Enter title">
			    </div>
			    <p>内容:</p>
			    <textarea id="editor_id1" class="form-control" name="content" rows="3" cols="20">
					&lt;strong&gt;站内信&lt;/strong&gt;
				</textarea>
			  </div>
			  <div class="panel-footer"><button type="button" class="btn btn-primary btn-sm">回复</button></div>
			</form>
		  </div>
          </div><!-- row-fluid -->
          
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>