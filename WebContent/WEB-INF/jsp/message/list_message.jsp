<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
  <script type="text/javascript">
  	function delSelect() {
  		var chk = document.getElementsByName("checkAll");
	    var count = 0;
	    for (var i = 0; i < chk.length; i++) {
	        if (chk[i].checked) {
	                count++;
	        }
	    }
		if(count == 0){
			bootbox.alert("<h4><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;至少选择一条记录！</h4>");
			return;
		}
  		bootbox.confirm("<h4><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;您确定删除所选信息吗?</h4>", function(result) {
  			if(result){
  				document.message.action="${ctx}/messageAction/delSelect"; 
  	  	  		message.submit();
  			}
  		});

  	}
  	
  	function setReview( obj ) {
  		var chk = document.getElementsByName("checkAll");
	    var count = 0;
	    for (var i = 0; i < chk.length; i++) {
	        if (chk[i].checked) {
	                count++;
	        }
	    }
		if(count == 0 && obj != 3){
			bootbox.alert("<h4><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;至少选择一条记录！</h4>");
			return;
		}
		if(obj == 1){
			document.message.action="${ctx}/messageAction/setReviewYES";
		}else if(obj == 2){
			document.message.action="${ctx}/messageAction/setReviewNO";
		}else if(obj == 3){
			document.message.action="${ctx}/messageAction/setReviewALL";
		}
  		message.submit();
  	}
  	
  	function orderBy( option ) {
		document.getElementById("orderBy").value = option;
		message.submit();
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
            <li><span class="glyphicon glyphicon-home"></span>&nbsp;<a href="${ctx }/loginAction/login_view">主页</a></li>
            <li class="active">站内信</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-envelope"></span>&nbsp;我的信箱&nbsp;<span class="caret"></span>
		  </blockquote>
          
          <div class="table-responsive">
         	 <div class="btn-group" id="action_btn">
			  <button type="button" id="btn_checkbox" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
			    <input id="checkAll" type="checkbox" /> <span class="caret"></span>
			  </button>
			  <ul class="dropdown-menu" role="menu">
			    <li><a href="#" onclick="selectAll(true);">全选</a></li>
			    <li><a href="#" onclick="unSelect(false);">不选</a></li>
			    <li class="divider"></li>
			    <li><a href="#" onclick="viewSelect(true);">已读</a></li>
			    <li><a href="#" onclick="viewSelect(false);">未读</a></li>
			  </ul>
			 </div>
			 
			 <div class="btn-group" id="action_btn">
		      <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
		      	标记为 <span class="caret"></span></button>
		      <ul class="dropdown-menu" role="menu">
		        <li><a href="#" onclick="setReview(1);">已读</a></li>
		        <li><a href="#" onclick="setReview(2);">未读</a></li>
		        <li><a href="#" onclick="setReview(3);">全部设为已读</a></li>
		      </ul>
		     </div>
          
  			 <div class="btn-group" id="action_btn">
		      <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
		      	排序 <span class="caret"></span></button>
		      <ul class="dropdown-menu" role="menu">
		        <li><a href="#" onclick="orderBy('ASC');">日期升序</a></li>
		        <li><a href="#" onclick="orderBy('DESC');">日期降序</a></li>
		      </ul>
		     </div>
		     
		     <div class="btn-group" id="action_btn">
			 	<a href="${ctx }/messageAction/toAdd" class="btn btn-default btn-sm" role="button">写信</a>
			 </div>
		     
  			 <div class="btn-group" id="action_btn">
			 	<button type="button" class="btn btn-danger btn-sm" onclick="delSelect();">删除</button>
			 </div>
		     <form name="message" action="${ctx }/messageAction/toList_page" method="post">
             <input name="orderBy" id="orderBy" type="hidden" />
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
               <c:forEach items="${messageList }" var="msg" varStatus="i">
                 <tr id="checked_${i.count }">
                 	<td><input name="checkAll" id="view${msg.review }" value="${msg.id }" type="checkbox"/></td>
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
              		<td colspan="5" align="center">${page }</td>
               </tr>
               </tbody>
             </table>
             </form>
           </div><!-- table-responsive -->
          
          
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>