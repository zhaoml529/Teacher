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
				editable: true,
				eventLimit: true, // allow "more" link when too many events
				weekNumbers: true,
				droppable: true, // this allows things to be dropped onto the calendar
				selectable: true,
				selectHelper: true,
				//now: date,
				events: function(start, end, timezone, callback) {
					//页面初始化显示日程信息
					//moment().format("YYYY-MM-DD HH:mm:ss")  --Visit the MomentJS website
					var startDate = $.fullCalendar.moment(start).format("YYYY-MM-DD");
					var endDate = $.fullCalendar.moment(end).format("YYYY-MM-DD");
					alert(startDate+"--"+endDate);
			        var para = {start:startDate, end:endDate};
			        $.ajax({
		                   url: "${ctx}/calendarAction/listCalendar", 
			        	   dataType: "POST", 
		                   data: para,
		                   success: function (data) {
		                	  /*  var events = [];
		                       $(data).find('event').each(function() {
		                           events.push({
		                               title: $(this).attr('title'),
		                               start: $(this).attr('start') // will be parsed
		                           });
		                       });
		                       callback(events); */
		                	   
		                     for(var i=0;i<data.length;i++) {  
		                            var events = new Object();  
		                            events.id = data[i].id;  
		                            events.title = data[i].title==null?'无':data[i].title;  
		                            events.allDay = data[i].allDay;  
		                            //如果后台穿过来的是字符串格式的日期类型那么就要用到$.fullCalendar.parseDate(data[i].kssj,"yyyy-MM-dd HH:mm:ss")
									//这个方法来解析日期，将一个字符串日期，格式成一个javascript的Date对象
		                            events.start = data[i].beginDate;
		                            events.end =   data[i].endDate;
		                            events.description = data[i].remark;
		                            $("#calendar").fullCalendar('renderEvent',events,true);//把从后台取出的数据进行封装以后在页面上以fullCalendar的方式进行显示  
		                        }  
		                  }
	                });
			    },
			    eventMouseover: function (calEvent, jsEvent, view) {
			    	//鼠标滑过时有提示
	                var startDate = $.fullCalendar.formatDate(calEvent.start, "YYYY-MM-DD HH:mm");
	                var endDate = $.fullCalendar.formatDate(calEvent.end, "YYYY-MM-DD HH:mm");
	                $(this).attr('title', startDate + " - " + endDate + " " + "标题" + " : " + calEvent.title);
	                $(this).css('font-weight', 'normal');
	                $(this).tooltip({
	                    effect: 'toggle',
	                    cancelDefault: true
	                });
	            },
	            eventDrop: function( event, delta, revertFunc ) { 
	            	//拖动日程时触发
	            	bootbox.confirm("<h5><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;预定时间已改变,您确定改变为当前的预定时间吗?</h5>", function(result) {
	        			if(result){
	        				var para = {id: event.id, allDay: event.allDay, start: $.fullCalendar.formatDate(event.start, "YYYY-MM-DD HH:mm"), end: $.fullCalendar.formatDate(event.end, "YYYY-MM-DD HH:mm")};
	        				$.ajax({
	                            url: "calendarAction/updateCalendar", //要访问的后台地址
	        					dataType: "POST",
	                            data: para,
	                            success: function (data) {
	                            	bootbox.alert("<h4><span class='label label-success'>Success!</span>&nbsp;&nbsp;修改成功！</h4>");
		                        },
		                        error:function(){
		                          	alert("改变日程出错,日程已还原为改变之前！");
		                          	revertFunc(); //还原到拖动之前
		                        }
	                        });
	                    }else{
	        	        	revertFunc();  //还原拖动之前
	        	        }
        			}); 
	            },
	            eventResize: function(event, delta, revertFunc) {
	            	//拖动日程大小改变时间触发
	    	    	bootbox.confirm("<h5><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;预定时间已改变,您确定改变为当前的预定时间吗? </h5>", function(result) {
		    			if(result){
		    				var para = {id: event.id, start: $.fullCalendar.formatDate(event.start, "YYYY-MM-DD HH:mm"), end: $.fullCalendar.formatDate(event.end, "YYYY-MM-DD HH:mm")};
		    				$.ajax({
		                       url: "calendarAction/updateCalendar",
		                       type: "POST",
		                       data: para,
		                       success: function (data) {
		                       		bootbox.alert("<h4><span class='label label-success'>Success!</span>&nbsp;&nbsp;修改成功！</h4>");
		                       },
		                       error:function(){
		                      		alert("改变日程出错,日程已还原为改变之前！");
		                      		revertFunc();//还原到拖动之前
		                       }
		                   });
		                }else{
		    	        	revertFunc();//还原拖动之前
		    	        }
	    		    }); 
	            },
	            select: function(start, end) {
	            	var model = $('#addCalendar').modal('show');
	            	model.find("input[name=beginDate]").val($.fullCalendar.moment(start).format("YYYY-MM-DD"));
	            	model.find("input[name=endDate]").val($.fullCalendar.moment(end).format("YYYY-MM-DD"));
	            	
	            	modal.find('form').on('submit', function(ev){
	            		ev.preventDefault();
		            	var event = new Object();
		            	event.title = model.find("input[name=title]").val();
		            	event.start = model.find("input[name=beginDate]").val();
		            	event.end = model.find("input[name=endDate]").val();
		            	
		            	$.ajax({
	                       url: "calendarAction/addCalendar",
	                       type: "POST",
	                       data: para,
	                       success: function (data) {
	                       		bootbox.alert("<h4><span class='label label-success'>Success!</span>&nbsp;&nbsp;修改成功！</h4>");
	                       },
	                       error:function(){
	                      		alert("改变日程出错,日程已还原为改变之前！");
	                      		revertFunc();//还原到拖动之前
	                       }
	                   });
	            	});
	            	
	               $("#beginDate,#endDate").datetimepicker({
	        	    	language: 'zh-CN',
	        	        format: "yyyy-mm-dd hh:ii",
	        	        // minView: "month", //选择日期后，不会再跳转去选择时分秒 
	        	        autoclose: true,
	        	        todayBtn: true,
	        	        todayHighlight: true,
	        	        pickerPosition: "bottom-left"
	        	   });
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
		  
		  <!-- modal -->
		  <div class="modal fade" id="addCalendar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <form class="no-margin" action="calendarAction/doAdd" method="post">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="exampleModalLabel">添加预定信息</h4>
			      </div>
			      <div class="modal-body">
					<table class="table table-striped table-hover table-bordered">
					<tr>
			    		<td>标题</td>
			    		<td>
			    			<form:errors path="title" cssClass="valid_text"></form:errors>
			    			<input type="text" name="title" value="${book.title }" class="form-control" placeholder="请输入标题">
			    		</td>
			    		
			    	</tr>
			    	<tr>
			    		<td>内容</td>
			    		<td>
			    			<form:errors path="content" cssClass="valid_text"></form:errors>
			    			<textarea name="content" class="form-control" rows="3" cols="53" placeholder="请输入内容"></textarea>
			    		</td>
			    	</tr>
			    	<tr>
			    		<td>日程开始时间</td>
			    		<td>
			    			<form:errors path="beginDate" cssClass="valid_text"></form:errors>
				    		<div id="beginDate" style="width: 300px;" class="input-group date form_datetime">
								<div class="input-group">
				                    <input name="beginDate" class="form-control" type="text" value="" readonly required />
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
								</div>
			                </div>
			    		</td>
			    	</tr>
			    	<tr>
			    		<td>日程结束时间</td>
			    		<td>
			    			<form:errors path="endDate" cssClass="valid_text"></form:errors>
				    		<div id="endDate" style="width: 300px;" class="input-group date form_datetime">
								<div class="input-group">
				                    <input name="endDate" class="form-control" type="text" value="" readonly required />
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
								</div>
			                </div>
			    		</td>
			    	</tr>
			    	<tr>
			    		<td>联系人</td>
			    		<td><input name="lxfs" type="text" value="" class="form-control" placeholder="联系电话" required/></td>
			    	</tr>
			    	<tr>
			    		<td>备注</td>
			    		<td><textarea name="remark" class="form-control" rows="3" cols="53" placeholder="备注信息"></textarea></td>
			    	</tr>
			    	</table>
			      </div>
			      <div class="modal-footer">
			        <button type="submit" class="btn btn-success btn-sm">Save</button>
			    	<button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
			      </div>
			    </form>
			    </div>
			  </div>
		  </div>
		  
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>