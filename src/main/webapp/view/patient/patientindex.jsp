<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/beyond.css" />
	<title>导航</title>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading text-right">
			<strong><%=session.getAttribute("hrs_session_name")%></strong>&nbsp;&nbsp;&nbsp;&nbsp;欢迎您使用挂号预约就诊系统&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="${pageContext.request.contextPath}/logout">退出登录</a>
		</div>
	</div>
	<!-- 导航 -->
	<div class="page-sidebar">
	    <ul class="nav panel-group sidebar-menu" id="nav_parent">
	    	<li class="panel">
	    		<a class="panel-heading collapsed" href="#collapse1" data-toggle="collapse" data-parent="#nav_parent">
	    			<span class="menu-text"> 个人信息 </span>
	  			</a>
	  			<ul class="nav submenu collapse" id="collapse1">
	  				<li>
					    <a href="${pageContext.request.contextPath}/patient/showInformation?no=${patient.patientNo}" target="frame">
					    	<span class="menu-text">个人信息</span>
					    </a>
				    </li>
	  				<li>
					    <a href="${pageContext.request.contextPath}/patient/showUpdatePassword" target="frame">
					    	<span class="menu-text">修改密码</span>
					    </a>
				    </li>
	  			</ul>
	 		</li>
	    	<li class="panel">
	    		<a class="panel-heading collapsed" href="#collapse2" data-toggle="collapse" data-parent="#nav_parent">
	    			<span class="menu-text"> 预约挂号 </span>
	  			</a>
	  			<ul class="nav submenu collapse" id="collapse2">
	  				<li>
					    <a href="${pageContext.request.contextPath}/patient/showAppointment" target="frame">
					    	<span class="menu-text">预约挂号</span>
					    </a>
				    </li>
	  				<li>
					    <a href="${pageContext.request.contextPath}/patient/showQueryRegistration?no=${patient.patientNo}" target="frame">
					    	<span class="menu-text">挂号历史</span>
					    </a>
				    </li>
	  			</ul>
	 		</li>
	 		<li class="panel">
	  			<a class="panel-heading collapsed" href="#collapse3" data-toggle="collapse" data-parent="#nav_parent">
	  				<span class="menu-text"> 病历 </span>
	 			</a>
	  			<ul class="nav submenu collapse" id="collapse3">
	  				<li>
	   					<a href="${pageContext.request.contextPath}/patient/showQueryCases?no=${patient.patientNo}" target="frame">
	   						<span class="menu-text">既往病例</span>
	   					</a>
	  				</li>
	  			</ul>
	 		</li>
	 	</ul>
	</div>
	<div style="left: 250px;position: absolute;" name="div_auto" id="div_auto">
		<iframe name="frame" id="frame" scrolling="no" frameborder="0" style="padding: 0px; width: 1600px; height: 920px;">
			
		</iframe>
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		
		$(function(){
			 //点击菜单箭头变化
			 $(".page-sidebar .sidebar-menu a").each(function(){
				 $(this).click(function(){
					  var Oele = $(this).children('.menu-expand');
					  if($(Oele)){
						  if($(Oele).hasClass('glyphicon-chevron-right')){
						      $(Oele).removeClass('glyphicon-chevron-right').addClass('glyphicon-chevron-down');
						  }else{
						      $(Oele).removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-right');
						  }
					  }
					 
					  //选中增加active
					  if(! $(this).hasClass('panel-heading')){
						  $(".page-sidebar .sidebar-menu a").removeClass('active');
						  $(this).addClass('active');
					  }
				 });
			 });
		})
	</script>
</body>
</html>