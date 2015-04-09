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
  <link rel="stylesheet" href="${ctx}/css/jquery.fileupload-ui.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/css/jquery.fileupload.css" type="text/css" />
  <script type="text/javascript" src="${ctx}/kindeditor/kindeditor-min.js"></script>
  <script type="text/javascript" src="${ctx}/js/kindeditor.js"></script>
  <script type="text/javascript" src="${ctx}/js/jquery.ui.widget.js"></script>
  <script type="text/javascript" src="${ctx}/js/jquery.iframe-transport.js"></script>
  <script type="text/javascript" src="${ctx}/js/jquery.fileupload.js"></script>
  <!--[if gte IE 8]><script type="text/javascript" src="${ctx}/js/jquery.xdr-transport.js"></script><![endif]-->
  <script type="text/javascript">
  $(function(){
    $("#birthday,#wordDate,#getEducation1,#getEducation2,#getDegree").datetimepicker({
    	language: 'zh-CN',
        format: "yyyy-mm-dd",
        minView: "month", //选择日期后，不会再跳转去选择时分秒 
        autoclose: true,
        todayBtn: true,
        todayHighlight: true,
        pickerPosition: "bottom-left"
    });
    $(function(){  
		  $('#fileupload').fileupload({
		     url: '${ctx }/teacherArchiveAction/uploadPic',
		     //dataType: 'json',
		     autoUpload: true,
		     acceptFileTypes:  /(\.|\/)(gif|jpe?g|png)$/i,
		     maxFileSize: 5000000,
		     progressall: function (e, data) { 
		    	$(".progress").css("display","block"); 
		    	var progress = parseInt(data.loaded / data.total * 100, 10);  
		        $("#progress").width(progress + '%');  
		        $("#progress").html(progress + '%');  
		     },
		     done: function (e, data) {
		    	if(data.result == "fail"){
		    		$(".progress").css("display","none"); 
		    		bootbox.alert("<h5><span class='label label-danger'>Fail</span>&nbsp;&nbsp;文件类型不正确！ </h5>");
		    		return false;
		    	}
		    	setTimeout(function () { 
		    	 	$(".progress").css("display","none"); 
		    		bootbox.alert("<h5><span class='label label-success'>Success!</span>&nbsp;&nbsp;头像上传成功！ </h5>");
	    	    }, 500);
	    		$("#photo").attr("src",'${ctx}'+data.result);  
	    		$("#pictureUrl").val(data.result);
		     },
		     fail: function(e, data) {
                 //错误提示 
		    	$(".progress").css("display","none"); 
		    	$.each(data.messages, function (index, error) {
		    		bootbox.alert("<h5><span class='label label-danger'>Fail</span>&nbsp;&nbsp;上传失败！ </h5>"+'<p style="color: red;">Upload file error: ' + error + '<i class="elusive-remove" style="padding-left:10px;"/></p>');
	    		});
	    	 }
		 });
	  });
  })
  
</script>      
</head>
<body>
  <c:import url="../top.jsp" />
  <input type="hidden" id="ctx" value="${ctx }"/>
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
	          <table class="table table-bordered table-condensed">
			  	<tr class="active">
			  		<td colspan="4" align="center">添加个人档案信息</td>
			  	</tr>
			  	<tr>
			  		<td>教师姓名</td>
			  		<td>
				    	<input type="text" name="teacherName" value="${user.teacherName }" class="form-control" readonly placeholder="Enter teachers name">
			  		</td>
			  		<td colspan="2" rowspan="7" align="center">
			  			<input type="hidden" id="pictureUrl" name="pictureUrl" value="${teacherArchive.teacherPic }" />
			  			<div class="thumbnail">
			  			  <c:set var="noPic" value="/images/no_picture.gif" />
					      <img id="photo" src="${ctx }${! empty teacherArchive.teacherPic?teacherArchive.teacherPic :noPic }" alt="个人照片" width="200px" class="img-thumbnail">
						  <div class="progress" style="display: none;">
							  <div id="progress" class="progress-bar" role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100" style="min-width: 2em; width: 0%;">
							    0%
							  </div>
						  </div>
					      <div class="caption">
					        <h4>上传头像:文件类型为jpg/png/gif</h4>
						        <span class="btn btn-success fileinput-button btn-sm">
				                    <i class="glyphicon glyphicon-plus"></i>
				                    <span>选择头像...</span>
				                    <input id="fileupload" type="file" name="teacherPic" />
				                </span>
					      </div>
					    </div>
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>性别</td>
			  		<td>
			  			<form:errors path="sex" cssClass="valid_text"></form:errors>
			  			<label class="radio-inline">
						  <input type="radio" name="sex" ${teacherArchive.sex == 0?'checked':'' } id="sex" value="0"> 女
						</label>
						<label class="radio-inline">
						  <input type="radio" name="sex" ${teacherArchive.sex == 1?'checked':'' } id="sex" value="1"> 男
						</label>
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>出生日期</td>
			  		<td>
			  			<div class="input-group date form_datetime" id="birthday">
			  				<div class="input-group">
						    <input name="birthday" class="form-control" type="text" value="<fmt:formatDate value="${teacherArchive.birthday }" type="date" />" readonly />
						    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						    </div>
						</div>
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>籍贯</td>
			  		<td>
			  			<form:errors path="nativePlace" cssClass="valid_text"></form:errors>
				    	<input type="text" name="nativePlace" value="${teacherArchive.nativePlace }" class="form-control" placeholder="Enter nativePlace">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>参加工作时间</td>
			  		<td>
			  			<form:errors path="workDate" cssClass="valid_text"></form:errors>
						<div class="input-group date form_datetime" id="wordDate">
							<div class="input-group">
		                    <input name="workDate" class="form-control" type="text" value="<fmt:formatDate value="${teacherArchive.workDate }" type="date" />" readonly required />
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
							</div>
		                </div>
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>身份证号码</td>
			  		<td>
			  			<form:errors path="IDNumber" cssClass="valid_text"></form:errors>
				    	<input type="text" name="IDNumber" value="${teacherArchive.IDNumber }" class="form-control" placeholder="Enter IDNumber">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>政治面貌</td>
			  		<td>
			  			<form:errors path="politicalStatus" cssClass="valid_text"></form:errors>
				    	<input type="text" name="politicalStatus" value="${teacherArchive.politicalStatus }" class="form-control" placeholder="Enter IDNumber">
			  		</td>
			  	</tr>
		  		<tr>
			  		<td>联系电话</td>
			  		<td>
			  			<form:errors path="phoneNumber" cssClass="valid_text"></form:errors>
				    	<input type="text" name="phoneNumber" value="${teacherArchive.phoneNumber }" class="form-control" placeholder="Enter phoneNumber">
			  		</td>
			  		<td>个人邮箱</td>
			  		<td>
			  			<form:errors path="email" cssClass="valid_text"></form:errors>
				    	<input type="text" name="email" value="${teacherArchive.email }" class="form-control" placeholder="Enter email">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>第一学历</td>
			  		<td>
			  			<form:errors path="education1" cssClass="valid_text"></form:errors>
				    	<input type="text" name="education1" value="${teacherArchive.education1 }" class="form-control" placeholder="Enter education1">
			  		</td>
		  			<td>第二学历</td>
			  		<td>
			  			<form:errors path="education2" cssClass="valid_text"></form:errors>
				    	<input type="text" name="education2" value="${teacherArchive.education2 }" class="form-control" placeholder="Enter education2">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>第一学历取得时间</td>
			  		<td>
			  			<form:errors path="getEducation1" cssClass="valid_text"></form:errors>
			  			<div class="input-group date form_datetime" id="getEducation1">
			  				<div class="input-group">
				    		<input type="text" name="getEducation1" value="<fmt:formatDate value="${teacherArchive.getEducation1 }" type="date" />" class="form-control" readonly placeholder="Choose getEducation1">
						    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						    </div>
						</div>
			  		</td>
					<td>第二学历取得时间</td>
			  		<td>
		  				<form:errors path="getEducation2" cssClass="valid_text"></form:errors>
			  			<div class="input-group date form_datetime" id="getEducation2">
			  				<div class="input-group">
				    		<input type="text" name="getEducation2" value="<fmt:formatDate value="${teacherArchive.getEducation2 }" type="date" />" class="form-control" readonly placeholder="Choose getEducation2">
						    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						    </div>
						</div>
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>第一学历毕业院校</td>
			  		<td>
			  			<form:errors path="graSchool1" cssClass="valid_text"></form:errors>
				    	<input type="text" name="graSchool1" value="${teacherArchive.graSchool1 }" class="form-control" placeholder="Enter graSchool1">
			  		</td>
					<td>第二学历毕业院校</td>
			  		<td>
			  			<form:errors path="graSchool2" cssClass="valid_text"></form:errors>
				    	<input type="text" name="graSchool2" value="${teacherArchive.graSchool2 }" class="form-control" placeholder="Enter graSchool2">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>最高学位</td>
			  		<td>
			  			<form:errors path="degree" cssClass="valid_text"></form:errors>
			  			<input type="text" name="degree" value="${teacherArchive.degree }" class="form-control" placeholder="Enter degree">
			  		</td>
			  		<td>学位取得时间</td>
			  		<td>
	                    <form:errors path="getDegree" cssClass="valid_text"></form:errors>
			  			<div class="input-group date form_datetime" id="getDegree">
							<div class="input-group">
			  				<input type="text" name="getDegree" value="<fmt:formatDate value="${teacherArchive.getDegree }" type="date" />" class="form-control" readonly placeholder="Choose degree Date">
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
							</div>
		                </div>
			  			
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>专业领域</td>
			  		<td>
			  			<form:errors path="professionArea" cssClass="valid_text"></form:errors>
			  			<input type="text" name="professionArea" value="${teacherArchive.professionArea }" class="form-control" placeholder="Enter professionArea">
			  		</td>
			  		<td>普通话水平</td>
			  		<td>
			  			<form:errors path="mandarinLevel" cssClass="valid_text"></form:errors>
			  			<select class="form-control" name="mandarinLevel">
			  				<option value="0">--请选择--</option>
			  				<option ${teacherArchive.mandarinLevel == '一级甲等'?'selected':'' } value="一级甲等">一级甲等</option>
			  				<option ${teacherArchive.mandarinLevel == '一级乙等'?'selected':'' } value="一级乙等">一级乙等</option>
			  				<option ${teacherArchive.mandarinLevel == '二级甲等'?'selected':'' } value="二级甲等">二级甲等</option>
			  				<option ${teacherArchive.mandarinLevel == '二级乙等'?'selected':'' } value="二级乙等">二级乙等</option>
			  				<option ${teacherArchive.mandarinLevel == '三级甲等'?'selected':'' } value="三级甲等">三级甲等</option>
			  				<option ${teacherArchive.mandarinLevel == '三级乙等'?'selected':'' } value="三级乙等">三级乙等</option>
			  			</select>
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>是否为双师型教师</td>
			  		<td>
			  			<form:errors path="isDoubleTeachers" cssClass="valid_text"></form:errors>
			  			<div class="form-group">
				  			<input type="radio" name="isDoubleTeachers" ${teacherArchive.isDoubleTeachers==0?"checked":"" } value="0"> 否
				  			<input type="radio" name="isDoubleTeachers" ${teacherArchive.isDoubleTeachers==1?"checked":"" } value="1"> 是
			  			</div>
			  		</td>
			  		<td>技术职务等级</td>
			  		<td>
			  			<form:errors path="technicalPosition" cssClass="valid_text"></form:errors>
			  			<select class="form-control" name="technicalPosition">
			  				<option value="0">--请选择--</option>
			  				<option ${teacherArchive.technicalPosition == '教授'?'selected':'' } value="教授">教授</option>
			  				<option ${teacherArchive.technicalPosition == '副教授'?'selected':'' } value="副教授">副教授</option>
			  				<option ${teacherArchive.technicalPosition == '讲师'?'selected':'' } value="讲师">讲师</option>
			  				<option ${teacherArchive.technicalPosition == '助理讲师'?'selected':'' } value="助理讲师">助理讲师</option>
			  			</select>
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>是否为骨干教师</td>
			  		<td>
			  			<form:errors path="isBackbone" cssClass="valid_text"></form:errors>
			  			<div class="form-group">
				  			<input type="radio" name="isBackbone" ${teacherArchive.isBackbone==0?"checked":"" } value="0"> 否
				  			<input type="radio" name="isBackbone" ${teacherArchive.isBackbone==1?"checked":"" } value="1"> 是
			  			</div>
			  		</td>
			  		<td>佐证证件及编号</td>
			  		<td>
			  			<form:errors path="evidenceNumber" cssClass="valid_text"></form:errors>
				    	<input type="text" name="evidenceNumber" value="${teacherArchive.evidenceNumber }" class="form-control" placeholder="Enter evidenceNumber">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td>是否为学科带头人</td>
			  		<td>
			  			<form:errors path="isSubjectLeader" cssClass="valid_text"></form:errors>
			  			<div class="form-group">
				  			<input type="radio" name="isSubjectLeader" ${teacherArchive.isSubjectLeader==0?"checked":"" } value="0"> 否
				  			<input type="radio" name="isSubjectLeader" ${teacherArchive.isSubjectLeader==1?"checked":"" } value="1"> 是
			  			</div>
			  		</td>
			  		<td></td>
			  		<td></td>
			  	</tr>
			  	
			  	<tr>
			  		<td colspan="4">
			  			<textarea id="editor_id1" class="form-control" name="remark" rows="3" cols="20">
							&lt;strong&gt;备注&lt;/strong&gt;
						</textarea>
			  		</td>
			  	</tr>
			  </table>
	          </div>
	          </div>
	          <div class="panel-footer"><button type="submit" class="btn btn-success btn-sm">添加</button></div>
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