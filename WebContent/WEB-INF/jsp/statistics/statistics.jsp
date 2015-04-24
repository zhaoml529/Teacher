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
		  var ctx = document.getElementById("degree").getContext("2d");
		  var pieChartData = [
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
		  var myNewChart = new Chart(ctx).Doughnut(pieChartData,{
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
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;档案管理&nbsp;<span class="caret"></span>
		  </blockquote>
          <div class="row-fluid">
              <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="panel panel-info">
                  <div class="panel-heading">Pie Chart &amp; Doughnut Chart</div>
                </div>
                <div class="row templatemo-chart-row">
                  <div class="templatemo-chart-box col-lg-3 col-md-3 col-sm-4 col-xs-12">
                    <canvas id="templatemo-pie-chart"></canvas>
                    <h4>Pie Chart</h4>
                    <span class="text-muted">Maecenas non</span>  
                  </div>
                  
                  <div class="templatemo-chart-box col-lg-3 col-md-3 col-sm-4 col-xs-12">           
                    <canvas id="degree"></canvas>
                    <h4>学位统计</h4>
                    <span class="text-muted">统计：学士、硕士、博士学位</span> 
                  </div>
                  
                  <div class="templatemo-chart-box col-lg-3 col-md-3 col-sm-4 col-xs-12">           
                    <canvas id="templatemo-radar-chart"></canvas>
                    <h4>Radar Chart</h4>
                    <span class="text-muted">Lorem sed</span> 
                  </div>

                  <div class="templatemo-chart-box col-lg-3 col-md-3 col-sm-4 col-xs-12">           
                    <canvas id="templatemo-polar-chart"></canvas>
                    <h4>Polar Area Chart</h4>
                    <span class="text-muted">Curabitur</span> 
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