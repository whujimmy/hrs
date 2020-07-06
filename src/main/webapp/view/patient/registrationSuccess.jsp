<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/templatemo_style.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/moment-with-locales.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<title>注册成功</title>
	
	<script type="text/javascript">
		$(function() {
			$('#no').text("${patient.patientNo}");
			$('#name').text("${patient.patientName}");
		});
	</script>
</head>
<body class="templatemo-bg-gray" style="background-image: url('../images/login_background.jpg');background-size: 100%; background-repeat:no-repeat; background-attachment: fixed;">
	<div class="container">
		<div class="col-xs-12">
			<h1 class="margin-bottom-15">注册成功</h1>
			<div class="templatemo-container templatemo-login-form-1 margin-bottom-30">
				欢迎您&nbsp;<strong id="name"></strong>，您的登陆ID为：<strong id="no"></strong><br/>
				<a href="${pageContext.request.contextPath}/toLogin">点击跳转登陆页面</a>
			</div>
			<div class="text-center">
				<label>&copy XXX</label>
			</div>
		</div>
	</div>
</body>
</html>