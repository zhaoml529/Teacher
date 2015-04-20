<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>日程信息</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <link rel="stylesheet" href="${ctx}/css/messenger.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/css/messenger-theme-flat.css" type="text/css" />
  <script type="text/javascript" src="${ctx}/js/messenger.min.js"></script>
  <script type="text/javascript" src="${ctx}/js/messenger-theme-flat.js"></script>
  <script type="text/javascript" src="${ctx}/js/fullcalendar/zh-cn.js"></script>
  <script type="text/javascript" src="${ctx}/js/fullcalendar/en-au.js"></script>
  <script type="text/javascript" src="${ctx}/js/fullcalendar/de.js"></script>
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
			    eventClick: function(calEvent, jsEvent, view) {
					//点击日程修改操作
					//读取日程信息
    				$.ajax({
                        url: "${ctx}/calendarAction/getCalendar",
                        dataType : "json",
                        type : "POST",
                        data: {id: calEvent.id},
                        success: function (data) {
                        	if(data.id != 0 ){
	                        	var modal = $('#calendarModal').modal('show');
	                        	modal.find("#modalLabel").html("修改预定信息");
	                        	modal.find("#delBtn").removeClass("sr-only");
	                        	modal.find("input[name=title]").val(data.title);
	    		            	modal.find("textarea[name=content]").val(data.content);
	        	            	modal.find("input[name=beginDate]").val($.fullCalendar.moment(data.beginDate).format("YYYY-MM-DD HH:mm"));
	        	            	modal.find("input[name=endDate]").val($.fullCalendar.moment(data.endDate).format("YYYY-MM-DD HH:mm"));
	        	            	modal.find("textarea[name=remark]").val(data.remark);
	        	            	//modal.find('form').one('submit', function(ev){
	        	            		//ev.preventDefault();
	        	            	$("#savBtn").click(function(){
	        	            		//修改日程信息
	        	            		var c_id = data.id;
	        	            		var c_title = modal.find("input[name=title]").val();
	        		            	var c_content = modal.find("textarea[name=content]").val();
	        		            	var c_beginDate = modal.find("input[name=beginDate]").val();
	        		            	var c_endDate = modal.find("input[name=endDate]").val();
	        		            	var c_remark = modal.find("textarea[name=remark]").val();
	        		            	var c_createDate = data.createDate;
	        		            	
	        		            	calEvent.id = c_id;
	        		            	calEvent.title = c_title;
	        		            	calEvent.start = c_beginDate;
	        		            	calEvent.end = c_endDate;
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
	        	                    		   calEvent.allDay = data.allDay;		        	                    		   
	           	                       	       bootbox.alert("<h4><span class='label label-success'>Success!</span>&nbsp;&nbsp;修改成功！</h4>");
	           	                       	 	   $('#calendarModal').modal('hide');
	        	                    		   $('#calendar').fullCalendar('updateEvent', calEvent);
	        	                    	   }else{
	        	                    		   bootbox.alert("<h4><span class='label label-error'>Error!</span>&nbsp;&nbsp;修改失败！</h4>");
	        	                    	   }
	        	                       },
	        	                       error:function(){
	        	                      		alert("修改日程失败！");
	        	                       }
	        	                    });
	        	            	});
	        	            	//modal.find('#delBtn').one('click', function(ev){
	        	            		//ev.preventDefault();
        	            		$("#delBtn").click(function(){
        	            			bootbox.confirm("<h5><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;确定删除此项日程信息吗?</h5>", function(result) {
       	                			if(result){
		        	            		$.ajax({
			        	                       url: "${ctx}/calendarAction/deleteCalendar",
			        	                       dataType : "text",
			        	                       type : "POST",
			        	                       data: {id: data.id},
			        	                       success: function (data) {
			        	                    	   if(data == "success"){
				        	                    	   /* $('#calendar').fullCalendar('removeEvents' , function(ev){
				        	                    		   alert("delete:"+ev.id+"--"+calEvent.id);
				        	   						       return (ev.id == calEvent.id);
				        	   						   }); */
				        	                    	   bootbox.alert("<h4><span class='label label-success'>Success!</span>&nbsp;&nbsp;删除成功！</h4>");
				        	                    	   $('#calendar').fullCalendar('removeEvents' ,calEvent.id);
			        	                    	   }else{
			        	                    		   bootbox.alert("<h4><span class='label label-danger'>Error!</span>&nbsp;&nbsp;删除失败！</h4>");
			        	                    	   }
			        	                    	   $('#calendarModal').modal('hide');
			        	                       },
			        	                       error:function(){
			        	                      		alert("删除日程失败！");
			        	                       }
		        	                    });
       	                			}});
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
	                $(this).attr('title', "标题: " + calEvent.title+" 时间: "+startDate + " ~ " + endDate);
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
        				var para = {
       						id: event.id, 
		            		beginDate: $.fullCalendar.moment(event.start).format("YYYY-MM-DD HH:mm"), 
 		            		endDate: $.fullCalendar.moment(event.end).format("YYYY-MM-DD HH:mm")
       					};
        				$.ajax({
                            url: "${ctx}/calendarAction/dropOrResizeCalendar",
                            dataType : "json",
 	                        type : "POST",
                            data: para,
                            success: function (data) {
                           		if(data.id != 0 ){
                            	   event.allDay = data.allDay;
                            	   event.start = $.fullCalendar.moment(data.beginDate).format("YYYY-MM-DD HH:mm");
                            	   event.end = $.fullCalendar.moment(data.endDate).format("YYYY-MM-DD HH:mm");
       	                       	   bootbox.alert("<h4><span class='label label-success'>Success!</span>&nbsp;&nbsp;修改成功！</h4>");
   	                       	 	   $('#calendarModal').modal('hide');
  	                    		   $('#calendar').fullCalendar('updateEvent', event);
   	                    	    }else{
   	                    		   bootbox.alert("<h4><span class='label label-error'>Error!</span>&nbsp;&nbsp;修改失败！</h4>");
   	                    		   revertFunc();
   	                    	    }
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
		    				var para = {
	       						id: event.id, 
			            		beginDate: $.fullCalendar.moment(event.start).format("YYYY-MM-DD HH:mm"), 
	 		            		endDate: $.fullCalendar.moment(event.end).format("YYYY-MM-DD HH:mm")
	       					};
		    				$.ajax({
		                       url: "${ctx}/calendarAction/dropOrResizeCalendar",
		                       dataType : "json",
		                       type : "POST",
		                       data: para,
		                       success: function (data) {
		                    	   if(data.id != 0 ){
		                    		   event.allDay = data.allDay;
	                            	   event.start = $.fullCalendar.moment(data.beginDate).format("YYYY-MM-DD HH:mm");
	                            	   event.end = $.fullCalendar.moment(data.endDate).format("YYYY-MM-DD HH:mm");
       	                       	       bootbox.alert("<h4><span class='label label-success'>Success!</span>&nbsp;&nbsp;修改成功！</h4>");
       	                       	 	   $('#calendarModal').modal('hide');
		                    		   $('#calendar').fullCalendar('updateEvent', event);
    	                    	   }else{
    	                    		   bootbox.alert("<h4><span class='label label-error'>Error!</span>&nbsp;&nbsp;修改失败！</h4>");
    	                    	   }
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
	            	var modal = $('#calendarModal').modal('show');
	            	modal.find("#delBtn").addClass("sr-only");
	            	modal.find("input[name=beginDate]").val($.fullCalendar.moment(start).format("YYYY-MM-DD"));
	            	modal.find("input[name=endDate]").val($.fullCalendar.moment(end).format("YYYY-MM-DD"));
	            	modal.find("#modalLabel").html("添加预定信息");
	            	//modal.find('form').one('submit', function(ev){  //不能用on,因为每次都给form绑定一个submit事件，当modal隐藏的时候，绑定依然有效，第二次打开modal时就会执行两次submit
            		//modal.find('#savBtn').on('click', function(ev){  //one只希望事件执行一次，第二次打开modal时就不会多次click了
	            		//ev.preventDefault(); //阻止元素发生默认的行为（例如，当点击提交按钮时阻止对表单的提交）
	            	$("#savBtn").click(function(){	
	            		var c_title = modal.find("input[name=title]").val();
		            	var c_content = modal.find("textarea[name=content]").val();
		            	var c_beginDate = modal.find("input[name=beginDate]").val();
		            	var c_endDate = modal.find("input[name=endDate]").val();
		            	var c_remark = modal.find("textarea[name=remark]").val();
		            	
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
	                    		   event.allDay = data.allDay;
	                       	       bootbox.alert("<h4><span class='label label-success'>Success!</span>&nbsp;&nbsp;添加成功！</h4>");
	                       	       $('#calendarModal').modal('hide');
	                    		   $("#calendar").fullCalendar('renderEvent', event, true);
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
	   $('#calendarModal').on('hidden.bs.modal', function (e) {
		    //modal关闭时调用
		    e.preventDefault();
	       	$("input[name=title]").val("");
	    	$("textarea[name=content]").val("");
	    	$("textarea[name=remark]").val("");
	    	$('#calendarForm')[0].reset();
	    	//别忘了解绑事件，这个很重要
	    	$("#savBtn").unbind();
	    	$("#delBtn").unbind();
	    	//$("#calendarModal").remove();
	   })
	   
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
				<div class="pull-right">
					日期类型：
					<select id='lang-selector'>
						<option value="zh-cn">ZH-CN</option>
						<option value="en">EN</option>
						<option value="de">DE</option>
					</select>
				</div>
		  </blockquote>
		  <div class="row">
			<div class="col-xs-12">
				<div id="calendar"></div>
			</div>
		  </div>
		  
		  <!-- modal -->
		  <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <form id="calendarForm" class="no-margin">
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
			        <button type="button" id="savBtn" class="btn btn-success btn-sm">Save </button>
			        <button type="button" id="delBtn" class="btn btn-danger btn-sm">Delete</button>
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