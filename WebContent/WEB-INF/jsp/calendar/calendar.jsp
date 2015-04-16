<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>课题列表</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <link rel="stylesheet" href="${ctx}/css/messenger.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/css/messenger-theme-flat.css" type="text/css" />
  <script type="text/javascript" src="${ctx}/js/messenger.min.js"></script>
  <script type="text/javascript" src="${ctx}/js/messenger-theme-flat.js"></script>
  <script type="text/javascript" src="${ctx}/js/fullcalendar/zh-cn.js"></script>
  <script type="text/javascript" src="${ctx}/js/util.js"></script>
  <script type="text/javascript">
  	$(function(){
  		var currentLangCode = 'zh-cn';

  		// rerender the calendar when the selected option changes
		$('#lang-selector').on('change', function() {
			if (this.value) {
				currentLangCode = this.value;
				$('#calendar').fullCalendar('destroy');
				renderCalendar();
			}
		});

  		var date = new Date();
  		var d = date.getDate();
  		var m = date.getMonth();
  		var y = date.getFullYear();
  		
  		/* initialize the calendar
  		-----------------------------------------------------------------*/
  		function renderCalendar() {
  			$('#calendar').fullCalendar({
  				header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month,agendaWeek,agendaDay'
				},
				lang: currentLangCode,
				firstDay: 1,
				eventLimit: true, // allow "more" link when too many events
				weekNumbers: true,
				//now: date,
				events: function(start, end, timezone, callback) {
					//moment().format("YYYY-MM-DD HH:mm:ss")  --Visit the MomentJS website
					var startDate = $.fullCalendar.moment(start).format("YYYY-MM-DD HH:mm:ss");
					var endDate = $.fullCalendar.moment(end).format("YYYY-MM-DD HH:mm:ss");
			        var para = {start:startDate, end:endDate};
			        $.ajax({
		                   url: "${ctx}/calendarAction/listCalendar", 
			        	   dataType: "POST", 
		                   data: para,
		                   success: function (data) {
		                	   var events = [];
		                       $(data).find('event').each(function() {
		                           events.push({
		                               title: $(this).attr('title'),
		                               start: $(this).attr('start') // will be parsed
		                           });
		                       });
		                       callback(events);
		                	   
		                     for(var i=0;i<data.length;i++) {  
		                            var obj = new Object();  
		                            obj.id = data[i].id;  
		                            obj.title = data[i].title==null?'无':data[i].title;  
		                            obj.allDay = data[i].allDay;  
		                            //如果后台穿过来的是字符串格式的日期类型那么就要用到$.fullCalendar.parseDate(data[i].kssj,"yyyy-MM-dd HH:mm:ss")
									//这个方法来解析日期，将一个字符串日期，格式成一个javascript的Date对象
		                            obj.start = data[i].beginDate;
		                            obj.end =   data[i].endDate;
		                            obj.description = data[i].remark;
		                            $("#calendar").fullCalendar('renderEvent',obj,true);//把从后台取出的数据进行封装以后在页面上以fullCalendar的方式进行显示  
		                        }  
		                  }
	                });
			    },
	  			viewDisplay: function(view) {
	  				/* var viewStart = $.fullCalendar.formatDate(view.start,"yyyy-MM-dd HH:mm");  
                    var viewEnd = $.fullCalendar.formatDate(view.end,"yyyy-MM-dd HH:mm");  
                    var viewName = view.name;  
					alert(viewStart+"---"+viewEnd); */
					alert(view.start);
	  			$("#calendar").fullCalendar('renderEvent',events,true);
	  			}
  			})
  		}
  		
  		renderCalendar();
  	 });
  	
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
            <li class="active">日程管理</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;日程管理&nbsp;<span class="caret"></span>
		  </blockquote>
		  <div class="row">
			<div class="col-xs-12">
				<div class="space"></div>
				<div id="calendar"></div>
			</div>
		  </div>
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>