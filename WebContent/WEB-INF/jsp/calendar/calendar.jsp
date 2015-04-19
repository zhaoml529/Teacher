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
		                            //events.description = data[i].remark;
		                            $("#calendar").fullCalendar('renderEvent',events,true);//把从后台取出的数据进行封装以后在页面上以fullCalendar的方式进行显示  
		                        }  
		                  }
	                });
			    },
			    eventClick: function(calEvent, jsEvent, view) {
					//点击日程修改操作
			        $(this).css('border-color', 'red');
					//读取日程信息
    				$.ajax({
                        url: "${ctx}/calendarAction/getCalendar",
                        dataType : "json",
                        type : "POST",
                        data: {id: calEvent.id},
                        success: function (data) {
                        	if(data.id != 0 ){
	                        	var model = $('#calendarModal').modal('show');
	                        	model.find("#modalLabel").html("修改预定信息");
	                        	model.find("input[name=title]").val(data.title);
	    		            	model.find("textarea[name=content]").val(data.content);
	        	            	model.find("input[name=beginDate]").val($.fullCalendar.moment(data.beginDate).format("YYYY-MM-DD HH:mm"));
	        	            	model.find("input[name=endDate]").val($.fullCalendar.moment(data.endDate).format("YYYY-MM-DD HH:mm"));
	        	            	model.find("textarea[name=remark]").val(data.remark);
	        	            	model.find('form').on('submit', function(ev){
	        	            		//修改日程信息
	        	            		ev.preventDefault();
	        	            		var c_id = data.id;
	        	            		var c_title = model.find("input[name=title]").val();
	        		            	var c_content = model.find("textarea[name=content]").val();
	        		            	var c_beginDate = model.find("input[name=beginDate]").val();
	        		            	var c_endDate = model.find("input[name=endDate]").val();
	        		            	var c_remark = model.find("textarea[name=remark]").val();
	        		            	var c_createDate = data.createDate;
	        		            	
	        		            	var event = new Object();
	        		            	event.id = c_id;
	        		            	event.title = c_title;
	        		            	event.start = c_beginDate;
	        		            	event.end = c_endDate;
	        		            	var para = {
	      		            			id: c_id, 
	      		            			title: c_title, 
	      		            			content: c_content, 
	      		            			beginDate: c_beginDate, 
	      		            			endDate: c_endDate, 
	      		            			remark: c_remark, 
	      		            			createDate: c_createDate
	        		            	};
	        		            	$.ajax({
	        	                       url: "${ctx}/calendarAction/updateCalendar",
	        	                       dataType : "json",
	        	                       type : "POST",
	        	                       data: para,
	        	                       success: function (data) {
	        	                    	   if(data.id != 0 ){
	        	                    		   $('#calendar').fullCalendar('updateEvent', event);
	           	                       	       bootbox.alert("<h4><span class='label label-success'>Success!</span>&nbsp;&nbsp;修改成功！</h4>");
	           	                       	 	   $('#calendarModal').modal('hide');
	        	                    	   }else{
	        	                    		   bootbox.alert("<h4><span class='label label-error'>Error!</span>&nbsp;&nbsp;修改失败！</h4>");
	        	                    	   }
	        	                       },
	        	                       error:function(){
	        	                      		alert("修改日程失败！");
	        	                       }
	        	                   });
	        	            		
	        	            	});
                        	}else{
                        		bootbox.alert("<h4><span class='label label-error'>Error!</span>&nbsp;&nbsp;未找到此日程信息！</h4>");
                        	}
                        },
                        error:function(){
                          	alert("未找到此日程信息！");
                        }
                    });
			        
			    },
			    eventMouseover: function (calEvent, jsEvent, view) {
			    	//鼠标滑过时有提示
	                var startDate = $.fullCalendar.moment(calEvent.start).format("YYYY-MM-DD HH:mm");
	                var endDate = $.fullCalendar.moment(calEvent.end).format("YYYY-MM-DD HH:mm");
	                $(this).attr('title', startDate + " ~ " + endDate + " " + "标题" + " : " + calEvent.title);
	                $(this).css({
	                	"font-weight": "bold"
	                });
	                $(this).tooltip({
	                	placement: 'bottom'
	                });
	                $(this).tooltip('show');
	            },
	            eventDrop: function( event, delta, revertFunc ) { 
	            	//拖动日程时触发
	            	bootbox.confirm("<h5><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;预定时间已改变,您确定改变为当前的预定时间吗?</h5>", function(result) {
	        			if(result){
	        				var para = {id: event.id, allDay: event.allDay, start: $.fullCalendar.moment(event.start, "YYYY-MM-DD HH:mm"), end: $.fullCalendar.moment(event.end, "YYYY-MM-DD HH:mm")};
	        				$.ajax({
	                            url: "${ctx}/calendarAction/updateCalendar",
	                            dataType : "json",
	 	                        type : "POST",
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
		    				var para = {id: event.id, start: $.fullCalendar.moment(event.start, "YYYY-MM-DD HH:mm"), end: $.fullCalendar.moment(event.end, "YYYY-MM-DD HH:mm")};
		    				$.ajax({
		                       url: "${ctx}/calendarAction/updateCalendar",
		                       dataType : "json",
		                       type : "POST",
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
	            	var model = $('#calendarModal').modal('show');
	            	model.find("input[name=beginDate]").val($.fullCalendar.moment(start).format("YYYY-MM-DD"));
	            	model.find("input[name=endDate]").val($.fullCalendar.moment(end).format("YYYY-MM-DD"));
	            	model.find("#modalLabel").html("添加预定信息");
	            	model.find('form').on('submit', function(ev){
	            		ev.preventDefault();
	            		
	            		var c_title = model.find("input[name=title]").val();
		            	var c_content = model.find("textarea[name=content]").val();
		            	var c_beginDate = model.find("input[name=beginDate]").val();
		            	var c_endDate = model.find("input[name=endDate]").val();
		            	var c_remark = model.find("textarea[name=remark]").val();
		            	
		            	var event = new Object();
		            	event.title = c_title;
		            	event.start = c_beginDate;
		            	event.end = c_endDate;
		            	var para = {title: c_title, content: c_content, beginDate: c_beginDate, endDate: c_endDate, remark: c_remark};
		            	$.ajax({
	                       url: "${ctx}/calendarAction/addCalendar",
	                       dataType : "json",
	                       type : "POST",
	                       data: para,
	                       success: function (data) {
	                    	   if(data.id != 0 ){
	                    		   event.id = data.id;
	                    		   $("#calendar").fullCalendar('renderEvent', event, true);
	                       	       bootbox.alert("<h4><span class='label label-success'>Success!</span>&nbsp;&nbsp;添加成功！</h4>");
	                       	       $('#calendarModal').modal('hide');
	                    	   }else{
	                    		   bootbox.alert("<h4><span class='label label-error'>Error!</span>&nbsp;&nbsp;添加失败！</h4>");
	                    	   }
	                       },
	                       error:function(){
	                      		alert("添加日程失败！");
	                       }
	                   });
	            	});
	            }
			    
  			})
  		}
  		$("#beginDate,#endDate").datetimepicker({
	    	language: 'zh-CN',
	        format: "yyyy-mm-dd hh:ii",
	        // minView: "month", //选择日期后，不会再跳转去选择时分秒 
	        autoclose: true,
	        todayBtn: true,
	        todayHighlight: true,
	        pickerPosition: "bottom-left"
	   });
  		renderCalendar();
  	 });
  	
  	function valid( val ){
  		if(val == '' || val == null){
  			return false;
  		}else{
  			return true;
  		}
  	}
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
		  <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <form class="no-margin" method="post">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="modalLabel"></h4>
			      </div>
			      <div class="modal-body">
					<table class="table table-striped table-hover table-bordered">
					<tr>
			    		<td>标题</td>
			    		<td>
			    			<form:errors path="title" cssClass="valid_text"></form:errors>
			    			<input type="text" name="title" value="${book.title }" class="form-control" placeholder="请输入标题" required>
			    		</td>
			    		
			    	</tr>
			    	<tr>
			    		<td>内容</td>
			    		<td>
			    			<form:errors path="content" cssClass="valid_text"></form:errors>
			    			<textarea name="content" class="form-control" rows="3" cols="53" placeholder="请输入内容" required></textarea>
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
			    		<td>备注</td>
			    		<td><textarea name="remark" class="form-control" rows="3" cols="53" placeholder="备注信息"></textarea></td>
			    	</tr>
			    	</table>
			      </div>
			      <div class="modal-footer">
			        <button type="submit" class="btn btn-success btn-sm">Save</button>
			    	<button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
			      </div>
			    </div>
			    </form>
			  </div>
		  </div>
		</div>  
	  	</div>
	 </div>
	</div>
  <c:import url="../footer.jsp" />
</body>
</html>