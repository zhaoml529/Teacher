<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>教师档案管理系统</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">  
  <link rel="stylesheet" href="${ctx}/css/messenger.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/css/messenger-theme-flat.css" type="text/css" />
  <script type="text/javascript" src="${ctx}/js/messenger.min.js"></script>
  <script type="text/javascript" src="${ctx}/js/messenger-theme-flat.js"></script>
  <script type="text/javascript">
    $(function(){
    	var msg = '';
    	now = new Date(),hour = now.getHours() 
        if(hour < 6){msg = "凌晨好！"} 
        else if (hour < 9){msg = "早上好！"} 
        else if (hour < 12){msg = "上午好！"} 
        else if (hour < 14){msg = "中午好！"} 
        else if (hour < 17){msg = "下午好！"} 
        else if (hour < 19){msg = "傍晚好！"} 
        else if (hour < 22){msg = "晚上好！"} 
        else {msg = "夜里好！"} 
    	
	  	Messenger.options = {
		    extraClasses: 'messenger-fixed messenger-on-bottom messenger-on-right',
		    theme: 'flat'
		}
	  	Messenger().post({
  		  message: msg+"${user.teacherName}<br/>您上次登录时间为 :${user.lgoinDate}",
	  	  hideAfter: 8,
	  	  status: 500,
	  	  hideOnNavigate: true,
	  	  showCloseButton: true,
	  	action: function(opts) {
	  	      return opts.error({
	  	        status: 500,
	  	        readyState: 0,
	  	        responseText: 0
	  	      });
	  	}
	  	});

    });
    
  </script>
 <%--  <script type="text/javascript" src="${ctx}/js/calendar.js"></script> --%>  
 <script>

	$(document).ready(function() {

		$('#calendar').fullCalendar({
			defaultDate: '2014-11-12',
			editable: true,
			eventLimit: true, // allow "more" link when too many events
			events: [
				{
					title: 'All Day Event',
					start: '2014-11-01'
				},
				{
					title: 'Long Event',
					start: '2014-11-07',
					end: '2014-11-10'
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: '2014-11-09T16:00:00'
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: '2014-11-16T16:00:00'
				},
				{
					title: 'Conference',
					start: '2014-11-11',
					end: '2014-11-13'
				},
				{
					title: 'Meeting',
					start: '2014-11-12T10:30:00',
					end: '2014-11-12T12:30:00'
				},
				{
					title: 'Lunch',
					start: '2014-11-12T12:00:00'
				},
				{
					title: 'Meeting',
					start: '2014-11-12T14:30:00'
				},
				{
					title: 'Happy Hour',
					start: '2014-11-12T17:30:00'
				},
				{
					title: 'Dinner',
					start: '2014-11-12T20:00:00'
				},
				{
					title: 'Birthday Party',
					start: '2014-11-13T07:00:00'
				},
				{
					title: 'Click for Google',
					url: 'http://google.com/',
					start: '2014-11-28'
				}
			]
		});
		
	});

</script>
</head>
<body>
  <c:import url="top.jsp" />
  <div class="container"> 
    <div class="template-page-wrapper">
 	<c:import url="menu.jsp" />
    <div class="templatemo-content-wrapper">
      <div class="templatemo-content">
      		
      	  <!-- Head -->
          <div class="row-fluid">
    	  <div class="jumbotron">
	    	  <div class="page-header">
	            <h2>欢迎使用 高校教师档案管理系统</h2>
	          </div>
	            <p>File Manager System 由邯郸学院信息工程学院(CIE/HDC)11级计算机科学与技术专接本班提供技术支持。</p>
	            <p>你可以进行以下操作：</p>
	            <ul>
				    <li>查看当前新闻：<a href="/guetoj/news.html">点击进入</a> </li>
				    <li>查看个人档案：<a href="/guetoj/problems.html">点击进入</a> </li>
				    <li>管理个人日程：<a href="/guetoj/contests.html">点击进入</a></li>
	            </ul>
	            <p>如果你有什么建议或问题, 请<a href="/guetoj/message/composetoadmin">联系我们</a>。
	             </p>
	      </div>
		  </div> <!-- row-fluid -->
		  
		  <!-- News -->
		  <div class="row-fluid">
		  <div class="panel panel-default">
			  <!-- Default panel contents -->
			  <div class="panel-heading"><span class="glyphicon glyphicon-th-list"></span>&nbsp;最新新闻<a href="${ctx }/newsAction/toList_page" class="more">more>>&nbsp;</a></div>
			  <div class="panel-body">
			    <p>高校教师档案管理系统V1.0上线...</p>
			  </div>
			
			  <!-- List group -->
			  <ul class="list-group">
			    <li class="list-group-item"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;&nbsp;<b><a href="#">Cras justo odio</a></b><span class="more"><span class="glyphicon glyphicon-edit"></span>&nbsp;2014-05-26 10:51:12</span></li>
			    <li class="list-group-item"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;&nbsp;<b><a href="#">Dapibus ac facilisis in</a></b><span class="more"><span class="glyphicon glyphicon-edit"></span>&nbsp;2014-04-21 11:33:22</span></li>
			    <li class="list-group-item"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;&nbsp;<b><a href="#">Morbi leo risus</a></b><span class="more"><span class="glyphicon glyphicon-edit"></span>&nbsp;2014-04-06 21:23:11</span></li>
			    <li class="list-group-item"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;&nbsp;<b><a href="#">Porta ac consectetur ac</a></b><span class="more"><span class="glyphicon glyphicon-edit"></span>&nbsp;2014-03-05 11:51:32</span></li>
			    <li class="list-group-item"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;&nbsp;<b><a href="#">Vestibulum at eros</a></b><span class="more"><span class="glyphicon glyphicon-edit"></span>&nbsp;2014-02-26 10:51:12</span></li>
			  </ul>
		  </div>
		  </div> <!-- row-fluid -->
		  
		  <!-- Calendar -->
		  <div class="row-fluid">
		  	<div class="panel panel-default">
			  <div class="panel-heading"><span class="glyphicon glyphicon-calendar"></span>&nbsp;日程</div>
			  <div class="panel-body">
			    <div id="calendar"></div>
			  </div>
			</div>
		  </div> <!-- row-fluid -->
		  
      </div>
    </div>
   
    <!-- Modal -->
    <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title" id="myModalLabel">Are you sure you want to sign out?</h4>
          </div>
          <div class="modal-footer">
            <a href="sign-in.html" class="btn btn-primary">Yes</a>
            <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
          </div>
        </div>
      </div>
    </div>
      
    </div>
    </div>
	<c:import url="footer.jsp" />
</body>
</html>
