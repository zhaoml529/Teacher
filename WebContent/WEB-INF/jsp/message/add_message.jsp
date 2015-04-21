<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>发站内信</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <link rel="stylesheet" href="${ctx}/css/jquery-ui.min.css" type="text/css" />
  <script charset="utf-8" src="${ctx}/kindeditor/kindeditor-min.js"></script>
  <script charset="utf-8" src="${ctx}/js/kindeditor.js"></script>
  <script charset="utf-8" src="${ctx}/js/jquery-ui.min.js"></script>
  <%-- <script charset="utf-8" src="${ctx}/js/bootstrap-typeahead.js"></script> --%>
  <style>
	  .ui-autocomplete-loading {
	    background: white url("${ctx}/images/ui-anim_basic_16x16.gif") right center no-repeat;
	  }
  </style>
  <script type="text/javascript">
  		$(function(){
  			//autoTypeahead();
  			
  			$("#teaName").autocomplete({
				source: function( request, response ) {
			        $.ajax({
			          url: "${ctx}/teacherAction/searchTeacher",
			          dataType: "json",
			          data: {
			        	  teacherName: request.term //request.term为输入的字符串
			          },
			          success: function( data ) {
			        	  response( $.map( data, function( item ) {
	                          return {
	                        	 teacherName:item.teacherName,
	                        	 teacherId:item.teacherId,
	                          	 value:item.teacherName	//下拉列表显示的值
	                          }
	                      }));
			          }
			        });
		      	},
			    minLength: 2,
			    width: 200, 		//提示的宽度，溢出隐藏 
			    scrollHeight: 200,  //提示的高度，溢出显示滚动条 
			    scroll: true,
			    autoFocus: false,	//自动选中第一个
			    multiple: true,
			    multipleSeparator: ",", 
			    select: function( event, ui ) {
	               $("#teaName").val(ui.item.teacherName);
	               $("#toUser").val(ui.item.teacherId);
	               $("#teaName").removeClass("ui-autocomplete-loading");
		        },
		        focus: function (event, ui) {
		           $("#teaName").val(ui.item.teacherName);
		           $("#teaName").removeClass("ui-autocomplete-loading");
		           return false;
		        }
			});
  		});
  		
  		
  		function autoTypeahead(){
  			$('#toUser').typeahead({
                source: function (query, process) {
                	$.ajax({
  			          url: "${ctx}/teacherAction/searchTeacher",
  			          dataType: "json",
  			          data: {
  			        	  teacherName: query //query为输入的字符串
  			          },
  			          success: function( data ) {
  			        	  var results = [];
  			        	  process(
  			        		$.map( data, function( item ) {
 			        			var group;
 			        		     group = {
 			        		    		teacherName:item.teacherName,
 			        		    		teacherId:item.teacherId
 			        		     };
 			        		    results.push(group);
	                        })
	                      );
  			        	  //results.push(data);
  			        	  process(results);
  			          }
  			        });
                },
                matcher: function (item) {
                    return true;
                },
                highlighter: function (item) {
                    //return product.name + " ($" + product.price + ")";
                    return item;
                },
                updater: function (item) {
                	alert(item.teacherId)
                    return item;
                }
            });
  		}
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
            <li><span class="glyphicon glyphicon-home"></span>&nbsp;<a href="${ctx }/loginAction/main">主页</a></li>
            <li><a href="${ctx }/messageAction/toList_page">站内信</a></li>
            <li class="active">写信</li>
          </ol>
          <blockquote>
          	<span class="glyphicon glyphicon-edit"></span>&nbsp;发站内信&nbsp;<span class="caret"></span>
          </blockquote>
          <div class="row-fluid">
      	  <form:form action="${ctx }/messageAction/doAdd" modelAttribute="message" method="POST">
		  <div class="panel panel-default">
			  <input type="hidden" name="messageId" value="${msg.id }"/>
			  <div class="panel-body">
			    <label class="control-label">收件人:</label>
			    <div class="form-group">
				    <form:errors path="toUser" cssClass="valid_text"></form:errors>
				    <input type="hidden" id="toUser" name="toUser" value=""/>
				    <input id="teaName" class="form-control" placeholder="Input @"/>
				    <!-- <input id="toUser" name="toUser" class="form-control" data-provide="typeahead" placeholder="Input @"/> -->
			    </div>
			    <label class="control-label">标题:</label>
			    <div class="form-group">
				    <form:errors path="title" cssClass="valid_text"></form:errors>
				    <input type="text" name="title" value="${message.title }" class="form-control" placeholder="Enter title">
			    </div>
			    <label class="control-label">内容:</label>
			    <div class="form-group">
			    <textarea id="editor_id1" class="form-control" name="content" rows="3" cols="20">
					&lt;strong&gt;站内信&lt;/strong&gt;
				</textarea>
				</div>
			  </div>
			  <div class="panel-footer"><button type="submit" class="btn btn-success btn-sm">发送</button></div>
		  	</div>
		  </form:form>
		  
          </div><!-- row-fluid -->
          
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>