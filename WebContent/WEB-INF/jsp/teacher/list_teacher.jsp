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
</head>
<body>
<div id="container">
<div class="templatemo-content-wrapper">
    <div class="templatemo-content">
      <ol class="breadcrumb">
        <li><a href="index.html">Admin Panel</a></li>
        <li><a href="#">Dashboard</a></li>
        <li class="active">Overview</li>
        <li><a href="sign-in.html">Sign In Form</a></li>
      </ol>
    <div class="row">
	   <div class="col-md-12">
	     <div class="btn-group pull-right" id="templatemo_sort_btn">
	       <button type="button" class="btn btn-default">Sort by</button>
	       <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
	         <span class="caret"></span>
	         <span class="sr-only">Toggle Dropdown</span>
	       </button>
	       <ul class="dropdown-menu" role="menu">
	         <li><a href="#">First Name</a></li>
	         <li><a href="#">Last Name</a></li>
	         <li><a href="#">Username</a></li>
	       </ul>
	     </div>
	     <div class="table-responsive">
	       <h4 class="margin-bottom-15">New Users Table</h4>
	       <table class="table table-striped table-hover table-bordered">
	         <thead>
	           <tr>
	             <th>#</th>
	             <th>First Name</th>
	             <th>Last Name</th>
	             <th>Username</th>
	             <th>Email</th>
	             <th>Edit</th>
	             <th>Action</th>
	           </tr>
	         </thead>
	         <tbody>
	         <tr>
                <td>1</td>
                <td>John</td>
                <td>Smith</td>
                <td>@js</td>
                <td>a@company.com</td>
                <td><a href="#" class="btn btn-default">Edit</a></td>                    
                <td>
                  <!-- Split button -->
                  <div class="btn-group">
                    <button type="button" class="btn btn-info">Action</button>
                    <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
                      <span class="caret"></span>
                      <span class="sr-only">Toggle Dropdown</span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                      <li><a href="#">Bootstrap</a></li>
                      <li><a href="#">Font Awesome</a></li>
                      <li><a href="#">jQuery</a></li>
                    </ul>
                  </div>
                </td>
              </tr>
	        </tbody>
	      </table>
	    </div>
	   </div>
	  </div>
	  </div>
</div>
</div>
</body>
</html>