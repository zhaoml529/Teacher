<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>个人档案</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <link rel="stylesheet" href="${ctx}/css/messenger.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/css/messenger-theme-flat.css" type="text/css" />
  <script type="text/javascript" src="${ctx}/kindeditor/kindeditor-min.js"></script>
  <script type="text/javascript" src="${ctx}/js/kindeditor.js"></script>
  <script type="text/javascript" src="${ctx}/js/messenger.min.js"></script>
  <script type="text/javascript" src="${ctx}/js/messenger-theme-flat.js"></script>
  <script type="text/javascript">
  	 $(function(){
  		if('${message}' != ""){
  			Messenger.options = {
			    extraClasses: 'messenger-fixed messenger-on-bottom messenger-on-right',
			    theme: 'flat'
			}
		 	Messenger().post({
			  message: "<h5>${message}</h5>",
		 	  hideAfter: 8,
		 	  status: 500,
		 	  showCloseButton: true,
		 	});
  		} 
  		
  		$("[data-toggle='tooltip']").tooltip();
  	 });
  
     function toAdd(){
    	 window.location.href="${ctx }/teacherArchiveAction/toAdd";
     }	
     //没用-ajax版本
     function toApprovalTest( id ){
    	 $.ajax({
	            type: "POST",
	            url: "${ctx }/teacherArchiveAction/toApproval",
	            data: {id : id},
	            success: function (data) {
	            	if(data.flag){
	            		alert("申请成功！请等待管理员的审核");
	            	}else{
	            		alert(data.content);
	            	}
	            }
			});
     }
     
     function toApproval( id ){
    	 window.location.href="${ctx }/teacherArchiveAction/toApproval/"+id;
     }
     
     function toUpdate( id ){
    	 window.location.href="${ctx }/teacherArchiveAction/toUpdate/"+id;
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
			  <li class="active">个人档案</li>
			</ol>
			<blockquote>
				<span class="glyphicon glyphicon-user"></span>&nbsp;个人档案&nbsp;<span class="caret"></span>
			</blockquote>
	         <div class="row-fluid">
	         <form:form action="${ctx }/teacherArchiveAction/doAdd" modelAttribute="teacherArchive" method="POST">
	         <input type="hidden" name="teacher.teacherId" value="${user.teacherId }"/>
	         <div class="panel panel-default"> 
	          <div class="panel-body">
	          <div class="table-responsive">
	          <c:choose>
	          	<c:when test="${teacherArchive == null }">
	          		<div class="alert alert-warning">
	          			<span class='label label-danger'>Message:</span>&nbsp;您还没有个人档案信息，点击&nbsp;<button type="button" onclick="toAdd();" class="btn btn-success btn-sm">创建</button>&nbsp;创建您的个人档案。
	          		</div>
	          	</c:when>
	          	<c:otherwise>
	          		<table class="table table-bordered table-condensed table-hover">
					  	<tr class="active">
					  		<td colspan="4" align="center">
					  			个人档案信息
					  			<c:choose>
					  				<c:when test="${teacherArchive.isPass == 'WAITING_FOR_APPROVAL' }">
							  			<span class="label label-warning pull-right">待审核</span>
					  				</c:when>
					  				<c:when test="${teacherArchive.isPass == 'PENDING' }">
							  			<span class="label label-info pull-right">审核中...</span>
					  				</c:when>
					  				<c:when test="${teacherArchive.isPass == 'APPROVAL_SUCCESS' }">
							  			<span class="label label-success pull-right">审核通过</span>
					  				</c:when>
					  				<c:when test="${teacherArchive.isPass == 'APPROVAL_FAILED' }">
							  			<span class="label label-danger pull-right">审核失败</span>
					  				</c:when>
					  			</c:choose>
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>教师姓名</td>
					  		<td>
					  			${user.teacherName }
					  		</td>
					  		<td colspan="2" rowspan="7" align="center">
				  			    <c:set var="noPic" value="/images/no_picture.gif" />
						        <img id="photo" src="${ctx }${! empty teacherArchive.teacherPic?teacherArchive.teacherPic :noPic }" alt="个人照片" width="200px" class="img-thumbnail">
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>性别</td>
					  		<td>
					  			${teacherArchive.sex == 0?'女':'男' }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>出生日期</td>
					  		<td>
					  			${teacherArchive.birthday }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>籍贯</td>
					  		<td>
					  			${teacherArchive.nativePlace }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>参加工作时间</td>
					  		<td>
								${teacherArchive.workDate }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>身份证号码</td>
					  		<td>
					  			${teacherArchive.IDNumber }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>政治面貌</td>
					  		<td>
					  			${teacherArchive.politicalStatus }
					  		</td>
					  	</tr>
				  		<tr>
					  		<td>联系电话</td>
					  		<td>
					  			${teacherArchive.phoneNumber }
					  		</td>
					  		<td>个人邮箱</td>
					  		<td>
					  			${teacherArchive.email }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>第一学历</td>
					  		<td>
					  			${teacherArchive.education1 }
					  		</td>
				  			<td>第二学历</td>
					  		<td>
					  			${teacherArchive.education2 }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>第一学历取得时间</td>
					  		<td>
					  			${teacherArchive.getEducation1 }
					  		</td>
							<td>第二学历取得时间</td>
					  		<td>
					  			${teacherArchive.getEducation2 }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>第一学历毕业院校</td>
					  		<td>
					  			${teacherArchive.graSchool1 }
					  		</td>
							<td>第二学历毕业院校</td>
					  		<td>
					  			${teacherArchive.graSchool2 }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>最高学位</td>
					  		<td>
					  			${teacherArchive.degree }
					  		</td>
					  		<td>学位取得时间</td>
					  		<td>
					  			${teacherArchive.getDegree }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>专业领域</td>
					  		<td>
					  			${teacherArchive.professionArea }
					  		</td>
					  		<td>普通话水平</td>
					  		<td>
					  			${teacherArchive.mandarinLevel }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>是否为双师型教师</td>
					  		<td>
					  			${teacherArchive.isDoubleTeachers==0?"否":"是" }
					  		</td>
					  		<td>技术职务等级</td>
					  		<td>
					  			${teacherArchive.technicalPosition }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>是否为骨干教师</td>
					  		<td>
					  			${teacherArchive.isBackbone==1?"是":"否" } 
					  		</td>
					  		<td>佐证证件及编号</td>
					  		<td>
					  			${teacherArchive.evidenceNumber }
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>是否为学科带头人</td>
					  		<td>
					  			${teacherArchive.isSubjectLeader==0?"否":"是" }
					  		</td>
					  		<td></td>
					  		<td></td>
					  	</tr>
					  	
					  	<tr>
					  		<td>备注</td>
					  		<td colspan="3">
					  			<c:out value="${teacherArchive.remark }" escapeXml="false" />
					  		</td>
					  	</tr>
					  </table>
					  <c:choose>
						  	<c:when test="${teacherArchive.isPass == 'PENDING'}">
						  		<button type="button" data-toggle="tooltip" data-placement="top" title="审核中请等待..." class="btn btn-success btn-sm">申请审核</button>
						  		<button type="button" data-toggle="tooltip" data-placement="top" title="审核中不能修改" class="btn btn-success btn-sm">修改</button>
						  	</c:when>
						  	<c:when test="${teacherArchive.isPass == 'APPROVAL_SUCCESS'}">
						  		<button type="button" data-toggle="tooltip" data-placement="top" title="审核已通过" class="btn btn-success btn-sm">申请审核</button>
						  		<button type="button" data-toggle="tooltip" data-placement="top" title="审核已通过不能修改" class="btn btn-success btn-sm">修改</button>
						  	</c:when>
						  	<c:otherwise>
						  		<button type="button" onclick="toApproval('${teacherArchive.id}');" class="btn btn-success btn-sm">申请审核</button>
						  		<button type="button" onclick="toUpdate('${teacherArchive.id}');" class="btn btn-success btn-sm">修改</button>
						  	</c:otherwise>
					  </c:choose>
	          	</c:otherwise>
	          </c:choose>
	          </div>
	          </div>
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