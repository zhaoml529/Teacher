<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
$(function(){
	$.ajax({
        url: "${ctx}/teacherArchiveAction/getArchiveCount", 
        dataType : "json",
        type : "POST",
        data: {},
        success: function (data) {
        	if(data.count > 0){
        		$("#approvalArchive").html(data.count);
        	}
        }
   });
});
</script>
<div class="navbar-collapse collapse templatemo-sidebar">
<div class="well" style="padding: 8px 3px;">
<ul class="templatemo-sidebar-menu">
  <c:if test="${user.role == 'teacher' or user.role == 'manager'}">
  	  <!-- <li class="active"></li> -->
	  <li><a href="${ctx }/teacherArchiveAction/details"><i class="fa fa-home"></i>我的档案</a></li>
	  <li class="sub">
	    <a href="javascript:;">
	      <i class="fa fa-cubes"></i>教学研究 <div class="pull-right"><span class="caret"></span></div>
	    </a>
	    <ul class="templatemo-submenu">
	      <!--宽度 templatemo_main.css 120  -->
	      <!--li 背景颜色 templatemo_main.css 131  -->
	      <li><a href="${ctx }/subjectAction/toList_page?type=teaching">在研课题</a></li>
	      <li><a href="${ctx }/paperAction/toList_page?type=teaching">发表论文</a></li>
	      <li><a href="${ctx }/bookAction/toList_page?type=teaching">发表论著</a></li>             
	      <li class="active"><a href="${ctx }/awardAction/toList_page?type=teaching">获奖情况</a></li>
	    </ul>
	  </li>
	  <li class="sub">
	    <a href="javascript:;">
	      <i class="fa fa-database"></i>科学研究 <div class="pull-right"><span class="caret"></span></div>
	    </a>
	    <ul class="templatemo-submenu">
	      <li><a href="${ctx }/subjectAction/toList_page?type=science">在研课题</a></li>
	      <li><a href="${ctx }/paperAction/toList_page?type=science">发表论文</a></li>
	      <li><a href="${ctx }/bookAction/toList_page?type=science">论著情况</a></li>             
	      <li><a href="${ctx }/awardAction/toList_page?type=science">获奖情况</a></li>
	    </ul>
	  </li>
	  <li><a href="${ctx }/calendarAction/toCalendar"><i class="glyphicon glyphicon-calendar"></i>日程管理</a></li>
  </c:if>
  <c:if test="${user.role == 'manager'}">
  	  <li><a href="${ctx }/teacherArchiveAction/toApprovalList_page?dept_id=${user.department.id}"><i class="glyphicon glyphicon-tasks"></i><span id="approvalArchive" class="badge pull-right"></span>档案管理</a></li>
  	  <li><a href="${ctx }/teacherAction/toList_page?dept_id=${user.department.id}"><i class="fa fa-users"></i>教师列表</a></li>
  </c:if>
  <c:if test="${user.role == 'admin'}">
  	  <li><a href="${ctx }/teacherAction/toList_page"><i class="fa fa-users"></i>教师列表</a></li>
  	  <li><a href="${ctx }/teacherArchiveAction/getArchiveList_page"><i class="glyphicon glyphicon-tasks"></i><span id="approvalArchive" class="badge pull-right"></span>档案管理</a></li>
  	  <li><a href="${ctx }/statisticsAction/toStatistics"><i class="fa fa-cubes"></i>数据统计</a></li>
  </c:if>
  <c:if test="${user.role == 'manager' or user.role == 'admin' }">
	  <li class="sub">
	    <a href="javascript:;">
	      <i class="fa fa-cog"></i>系统设置 <div class="pull-right"><span class="caret"></span></div>
	    </a>
	    <ul class="templatemo-submenu">
	      <li><a href="${ctx }/newsAction/toAdd">发布新闻</a></li>
	      <li><a href="${ctx }/teacherAction/toList_page">系部管理</a></li>
	    </ul>
	  </li>
  </c:if>
  <li><a href="javascript:;" data-toggle="modal" data-target="#confirmModal"><i class="fa fa-sign-out"></i>退出</a></li>
</ul>
</div>
</div><!--/.navbar-collapse -->

<!-- Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">确定退出吗?</h4>
      </div>
      <div class="modal-footer">
        <a href="${ctx }/loginAction/login_view" class="btn btn-primary">Yes</a>
        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
      </div>
    </div>
  </div>
</div>