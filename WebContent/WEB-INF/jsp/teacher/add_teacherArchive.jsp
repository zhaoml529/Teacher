<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>教师个人档案</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <script charset="utf-8" src="${ctx}/kindeditor/kindeditor-min.js"></script>
  <script charset="utf-8" src="${ctx}/js/kindeditor.js"></script>
  <script type="text/javascript">
  $(function(){
    $("#birthday").datetimepicker({
    	language: 'zh-CN',
        format: "yyyy-mm-dd",
        minView: "month", //选择日期后，不会再跳转去选择时分秒 
        autoclose: true,
        todayBtn: true,
        todayHighlight: true,
        pickerPosition: "bottom-left"
    });
    
    $("#wordDate").datetimepicker({
    	language: 'zh-CN',
        format: "yyyy-mm-dd",
        minView: "month", //选择日期后，不会再跳转去选择时分秒 
        autoclose: true,
        todayBtn: true,
        todayHighlight: true,
        pickerPosition: "bottom-left"
    })
  })
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
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;${teacher.teacherName } 的个人档案&nbsp;<span class="caret"></span>
		  </blockquote>
          <div class="row-fluid">
          <form:form action="${ctx }/teacherArchiveAction/doAdd" modelAttribute="teacherArchive" method="POST">
          <div class="panel panel-default"> 
	          <div class="panel-body">
	          <table class="table table-bordered table-condensed">
			  	<tr class="active">
			  		<td colspan="4" align="center">添加个人档案信息</td>
			  	</tr>
			  	<tr>
			  		<td>教师姓名</td>
			  		<td>
			  			<form:errors path="title" cssClass="valid_text"></form:errors>
				    	<input type="text" name="teacherName" value="${teacher.teacherName }" class="form-control" placeholder="Enter teachers name">
			  		</td>
			  		<td colspan="2" rowspan="6">
			  			<img src="${ctx}/images/no_picture.gif" alt="个人照片" class="img-thumbnail carousel-inner img-responsive img-rounded">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>性别</td>
			  		<td>
			  			<form:errors path="sex" cssClass="valid_text"></form:errors>
			  			<label class="radio-inline">
						  <input type="radio" name="sex" id="sex" value="0"> 女
						</label>
						<label class="radio-inline">
						  <input type="radio" name="sex" id="sex" value="1"> 男
						</label>
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>出生日期</td>
			  		<td>
			  			<div class="input-group date form_datetime" id="birthday">
			  				<div class="input-group">
						    <input name="birthday" class="form-control" type="text" value="${teacher.birthday }" readonly />
						    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						    </div>
						</div>
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>籍贯</td>
			  		<td>
			  			<form:errors path="nativePlace" cssClass="valid_text col-xs-3"></form:errors>
				    	<input type="text" name="nativePlace" value="${teacher.nativePlace }" class="form-control" placeholder="Enter nativePlace">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>参加工作时间</td>
			  		<td>
						<div class="input-group date form_datetime" id="wordDate">
							<div class="input-group">
		                    <input name="workDate" class="form-control" type="text" value="${teacher.workDate }" readonly required />
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
							</div>
		                </div>
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>身份证号码</td>
			  		<td>
			  			<form:errors path="IDNumber" cssClass="valid_text"></form:errors>
				    	<input type="text" name="IDNumber" value="${teacher.IDNumber }" class="form-control" placeholder="Enter IDNumber">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>政治面貌</td>
			  		<td>
			  			<form:errors path="politicalStatus" cssClass="valid_text"></form:errors>
				    	<input type="text" name="politicalStatus" value="${teacher.politicalStatus }" class="form-control" placeholder="Enter IDNumber">
			  		</td>
			  	</tr>
		  		<tr>
			  		<td>联系电话</td>
			  		<td>
			  			<form:errors path="phoneNumber" cssClass="valid_text"></form:errors>
				    	<input type="text" name="phoneNumber" value="${teacher.phoneNumber }" class="form-control" placeholder="Enter phoneNumber">
			  		</td>
			  		<td>个人邮箱</td>
			  		<td>
			  			<form:errors path="email" cssClass="valid_text"></form:errors>
				    	<input type="text" name="email" value="${teacher.email }" class="form-control" placeholder="Enter email">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>第一学历</td>
			  		<td>
			  			<form:errors path="education1" cssClass="valid_text"></form:errors>
				    	<input type="text" name="education1" value="${teacher.education1 }" class="form-control" placeholder="Enter education1">
			  		</td>
					<td>第二学历取得时间</td>
			  		<td>
			  			<form:errors path="getEducation2" cssClass="valid_text"></form:errors>
				    	<input type="text" name="getEducation2" value="${teacher.getEducation2 }" class="form-control" placeholder="Enter getEducation2">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>第一学历取得时间</td>
			  		<td>
			  			<form:errors path="getEducation1" cssClass="valid_text"></form:errors>
				    	<input type="text" name="getEducation1" value="${teacher.getEducation1 }" class="form-control" placeholder="Enter IDNumber">
			  		</td>
			  		<td>第二学历毕业院校</td>
			  		<td>
			  			<form:errors path="graSchool2" cssClass="valid_text"></form:errors>
				    	<input type="text" name="graSchool2" value="${teacher.graSchool2 }" class="form-control" placeholder="Enter graSchool2">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>第一学历毕业院校</td>
			  		<td>
			  			<form:errors path="graSchool1" cssClass="valid_text"></form:errors>
				    	<input type="text" name="graSchool1" value="${teacher.graSchool1 }" class="form-control" placeholder="Enter graSchool1">
			  		</td>
			  		<td>第二学历</td>
			  		<td>
			  			<form:errors path="education2" cssClass="valid_text"></form:errors>
				    	<input type="text" name="education2" value="${teacher.education2 }" class="form-control" placeholder="Enter education2">
			  		</td>
			  	</tr>
			  	
			  	<tr>
			  		<td colspan="4">
			  			<textarea id="editor_id1" class="form-control" name="content" rows="3" cols="20">
							&lt;strong&gt;备注&lt;/strong&gt;
						</textarea>
			  		</td>
			  	</tr>
			  </table>
	          </div>
	          <div class="panel-footer"><button type="submit" class="btn btn-primary btn-sm">发布</button></div>
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