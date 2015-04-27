<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>教师列表</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <script type="text/javascript" src="${ctx}/js/Chart.min.js"></script>
  <script type="text/javascript">
	  $(function(){
		  var ctx_1 = document.getElementById("technicalPosition").getContext("2d");
		  var ctx_2 = document.getElementById("degree").getContext("2d");
		  var ctx_3 = document.getElementById("mandarinLevel").getContext("2d");
		  var technicalData = [
   		      {
   		        value: "${technicalMap['教授']}",
   		        color:"#F7464A",
   		        highlight: "#FF5A5E",
   		        label: "教授士"
   		      },
   		      {
   		        value: "${technicalMap['副教授']}",
   		        color: "#46BFBD",
   		        highlight: "#5AD3D1",
   		        label: "副教授"
   		      },
   		      {
   		        value: "${technicalMap['讲 师']}",
   		        color: "#FDB45C",
   		        highlight: "#FFC870",
   		        label: "讲 师"
   		      },
   		      {
   		        value: "${technicalMap['助理讲师']}",
   		        color: "#35FB6A",
   		        highlight: "#DD463D",
   		        label: "助理讲师"
   		      }
   	      ] // pie chart data
		  
		  var degreeData = [
		      {
		        value: "${degreeMap['学士']}",
		        color:"#F7464A",
		        highlight: "#FF5A5E",
		        label: "学士"
		      },
		      {
		        value: "${degreeMap['硕士']}",
		        color: "#46BFBD",
		        highlight: "#5AD3D1",
		        label: "硕士"
		      },
		      {
		        value: "${degreeMap['博士']}",
		        color: "#FDB45C",
		        highlight: "#FFC870",
		        label: "博士"
		      },
		      {
		        value: "${degreeMap['其他']}",
		        color: "#35FB6A",
		        highlight: "#DD463D",
		        label: "其他"
		      }
	      ] // pie chart data
	      
	      //暂时不用这个方式显示
		  var levelData1 = [
   		      {
   		        value: "${levelMap['一级甲等']}",
   		        color:"#F7464A",
   		        highlight: "#FF5A5E",
   		        label: "一级甲等"
   		      },
   		      {
   		        value: "${levelMap['一级乙等']}",
   		        color: "#46BFBD",
   		        highlight: "#5AD3D1",
   		        label: "一级乙等"
   		      },
   		      {
   		        value: "${levelMap['二级甲等']}",
   		        color: "#FDB45C",
   		        highlight: "#FFC870",
   		        label: "二级甲等"
   		      },
   		      {
   		        value: "${levelMap['二级乙等']}",
   		        color: "#35FB6A",
   		        highlight: "#FF9966",
   		        label: "二级乙等"
   		      },
   		      {
   		        value: "${levelMap['三级甲等']}",
   		        color: "#35FB6A",
   		        highlight: "#CC9966",
   		        label: "三级甲等"
   		      },
   		      {
   		        value: "${levelMap['三级乙等']}",
   		        color: "#35FB6A",
   		        highlight: "#CC0033",
   		        label: "三级乙等"
   		      }
   	      ] // pie chart data
	      
   	      
	   	  var levelData = {
	   			labels : ["一级甲等","一级乙等","二级甲等","二级乙等","三级甲等","三级乙等"],
	   			datasets : [
	   				{
	   					fillColor : "rgba(220,220,220,0.5)",
	   					strokeColor : "rgba(220,220,220,1)",
	   					pointColor : "rgba(220,220,220,1)",
	   					pointStrokeColor : "#fff",
	   					data : ["${levelMap['一级甲等']}","${levelMap['一级乙等']}","${levelMap['二级甲等']}","${levelMap['二级乙等']}","${levelMap['三级甲等']}","${levelMap['三级乙等']}"]
	   				}
	   			]
	      }
   	      
		  var myNewChart = new Chart(ctx_1).Doughnut(technicalData,{
	          responsive: true
	      });
		  var myNewChart = new Chart(ctx_2).Doughnut(degreeData,{
	          responsive: true
	      });
		  var myNewChart = new Chart(ctx_3).Radar(levelData,{
	          responsive: true
	      });
	  });
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
            <li><span class="glyphicon glyphicon-home"></span>&nbsp;<a href="${ctx }/loginAction/main">首页</a></li>
            <li class="active">数据统计</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;数据统计&nbsp;<span class="caret"></span>
		  </blockquote>
          <div class="row-fluid">
              <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="panel panel-info">
                  <div class="panel-heading">包括：技术职务等级统计、学位统计、普通话水平统计</div>
                </div>
                <div class="row templatemo-chart-row">
                  <div class="templatemo-chart-box col-lg-4 col-md-4 col-sm-4 col-xs-12">
                    <canvas id="technicalPosition"></canvas>
                    <h4>技术职务等级</h4>
                    <span class="text-muted">统计： 教授、副教授、讲 师、助理讲师</span>  
                  </div>
                  
                  <div class="templatemo-chart-box col-lg-4 col-md-4 col-sm-4 col-xs-12">           
                    <canvas id="degree"></canvas>
                    <h4>学位统计</h4>
                    <span class="text-muted">统计：学士、硕士、博士学位</span> 
                  </div>
                  
                  <div class="templatemo-chart-box col-lg-4 col-md-4 col-sm-4 col-xs-12">           
                    <canvas id="mandarinLevel"></canvas>
                    <h4>普通话水平</h4>
                    <span class="text-muted">统计：一级甲等、一级乙等、二级甲等、二级乙等、三级甲等、三级乙等</span> 
                  </div>
                </div>                  
              </div>
          </div><!-- row-fluid -->
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>