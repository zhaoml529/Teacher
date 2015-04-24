<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
   <script src="${ctx}/js/html5shiv.js"></script>
   <script src="${ctx}/js/respond.min.js"></script>
  <![endif]-->  
  <title>教师档案管理系统</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">  
  <meta http-equiv="X-UA-Compatible" content="IE=9" />
  <link rel="stylesheet" href="${ctx}/css/messenger.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/css/messenger-theme-flat.css" type="text/css" />
  <script type="text/javascript" src="${ctx}/js/messenger.min.js"></script>
  <script type="text/javascript" src="${ctx}/js/messenger-theme-flat.js"></script>
  <script type="text/javascript" src="${ctx}/js/fullcalendar/zh-cn.js"></script>
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
	  	  hideAfter: 6,
	  	  status: 500,
	  	  showCloseButton: true,
	  	});
	  	
	  	initNews(); //新闻列表
	  	
	  	initCalendar(); //初始化日程信息
    });
    
    function initCalendar() {
    	$('#calendar').fullCalendar({
    		header: {
				right: 'prev,next today',
				left: 'title',
			},
			lang: 'zh-cn',
			firstDay: 1,
			eventLimit: true, // allow "more" link when too many events
			weekNumbers: true,
			events: function(start, end, timezone, callback) {
				//页面初始化显示日程信息
				//moment().format("YYYY-MM-DD HH:mm:ss")  --Visit the MomentJS website
				$("#calendar").fullCalendar('removeEvents'); 
				var startDate = $.fullCalendar.moment(start).format("YYYY-MM-DD");
				var endDate = $.fullCalendar.moment(end).format("YYYY-MM-DD");
		        var para = {start:startDate, end:endDate};
		        $.ajax({
	                   url: "${ctx}/calendarAction/listCalendar", 
	                   dataType : "json",
                       type : "POST",
	                   data: para,
	                   success: function (data) {
	                     for(var i=0;i<data.length;i++) {  
	                            var events = new Object();  
	                            events.id = data[i].id;  
	                            events.title = data[i].title==null?'无':data[i].title;  
	                            events.allDay = false;  
	                            events.start = $.fullCalendar.moment(data[i].beginDate).format("YYYY-MM-DD HH:mm");
	                            events.end =   $.fullCalendar.moment(data[i].endDate).format("YYYY-MM-DD HH:mm");
	                            events.description = data[i].remark;
	                            $("#calendar").fullCalendar('renderEvent',events,true);//把从后台取出的数据进行封装以后在页面上以fullCalendar的方式进行显示  
	                        }  
	                  }
                });
		    },
		    eventMouseover: function (calEvent, jsEvent, view) {
		    	//鼠标滑过时有提示
                var startDate = $.fullCalendar.moment(calEvent.start).format("YYYY-MM-DD HH:mm");
                var endDate = $.fullCalendar.moment(calEvent.end).format("YYYY-MM-DD HH:mm");
                $(this).attr('title', "标题: " + calEvent.title+" 时间: "+startDate + " ~ " + endDate);
                $(this).css({
                	"font-weight": "bold"
                });
                $(this).tooltip({
                	placement: 'bottom'
                });
                $(this).tooltip('show');
            }
    	});
	};

	function initNews(){
		$.ajax({
            url: "${ctx}/newsAction/initNews_page", 
            dataType : "json",
            type : "POST",
            data: {},
            success: function (data) {
            	$.each(data, function(i,item){  
            	      $("#newsList").append("<li class='list-group-item'><span class='glyphicon glyphicon-link'></span>&nbsp;&nbsp;<b><a href='${ctx }/newsAction/details/"+item.id+"'>"+item.title+"</a></b><span class='more'><span class='glyphicon glyphicon-edit'></span>&nbsp;"+moment(item.updateDate).format("YYYY-MM-DD HH:mm:ss")+"</span></li>");
           	    });   
            }
       });
	}
	
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
	            <p>File Manager System 由邯郸学院信息工程学院 11级计算机科学与技术专接本班刘亚迪同学独立开发完成。</p>
	            <p><h3><b>技术选型</b></h3></p>
	            <p><h4><b>管理</b></h4></p>
            	<p><ul><li>Github版本控制</li></ul></p>
	            <p><h4><b>后端</b></h4></p>
            	<p>
            		<ul>
            			<li>Ioc容器 Spring</li>
            			<li>Web框架 SpringMVC</li>
            			<li>Orm框架 Hibernate</li>
            			<li>验证框架 Hibernate Validator</li>
            			<li>数据源 Proxool</li>
            			<li>日志 Log4j</li>
            			<li>Jsp 模版视图</li>
            		</ul>
            	</p>
	            <p><h4><b>前端</b></h4></p>
	            <p>
            		<ul>
            			<li>Bootstrap 框架</li>
            			<li>Bootstrap-datatimepicker 日历选择</li>
            			<li>KindEditor 富文本框</li>
            			<li>Bootbox 弹框</li>
            			<li>Message 消息提示</li>
            			<li>Jquery-fileupload 文件上传</li>
            			<li>Fullcalendar 日历插件</li>
            			<li>icheck 美化单选复选框</li>
            		</ul>
            	</p>
     			<p><h4><b>数据库</b></h4></p>
     			<p>
            		<ul>
            			<li>目前只支持MySQL,建议MySQL5.5及以上</li>
            		</ul>
            	</p>
            	<p><h4><b>支持的浏览器</b></h4></p>
            	<p>
            		<ul>
            			<li>Chrome</li>
            			<li>Firefox</li>
            			<li>IE8及以上(不建议使用IE)</li>
            			<li>360极速浏览器</li>
            			<li>其他浏览器暂时未测试</li>
            		</ul>
            	</p>
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
			  <div class="panel-heading"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;最新新闻<a href="${ctx }/newsAction/toList_page" class="more">more>>&nbsp;</a></div>
			  <div class="panel-body">
			    <p>高校教师档案管理系统V1.0上线...</p>
			  </div>
			  <!-- List group -->
			  <ul id="newsList" class="list-group">
			  	  <!-- 此处是新闻列表 -->
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
   
      
    </div>
    </div>
	<c:import url="footer.jsp" />
</body>
<script type="text/javascript">
$(document).ajaxSuccess(function(evt, request, settings){  
    var url = settings.url;
    var req = url.substring(url.lastIndexOf('/')+1);
    if(req == "getMessageCount" || req == "getArchiveMessage"){
    	var messageCount = $("#messageCount").html();
    	var approvalCount = $("#approvalArchive").html();
    	if(messageCount !=null && messageCount != ''){
    		Messenger().post({
    		  message: "您当前有 "+messageCount+" 条未读信息！",
    	  	  hideAfter: 7,
    	  	  status: 500,
    	  	  showCloseButton: true,
    	  	});
    	}
    	
    	if(approvalCount !=null && approvalCount != ''){
    		Messenger().post({
      		  message: "当前有 "+approvalCount+" 个档案需要您进行审批！",
    	  	  hideAfter: 8,
    	  	  status: 500,
    	  	  showCloseButton: true,
    	  	});
    	}
    }
}); 
</script>
</html>