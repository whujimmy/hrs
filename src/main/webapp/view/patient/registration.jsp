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
	<title>用户注册</title>
	
	<style type="text/css">
		.form-control-xxx {
		    width:200px;
		    display:inline;
		}
	</style>
	
	<script type="text/javascript">
		$(function() {
			$("#registerForm").bootstrapValidator({
				message: 'This value is not valid',
				feedbackIcons: {
		            valid: 'glyphicon glyphicon-ok',
		            invalid: 'glyphicon glyphicon-remove',
		            validating: 'glyphicon glyphicon-refresh'
				},
				fields: {
					name: {
						validators: {
							notEmpty: {
								message: '姓名不能为空'
							},
							stringLength: {
								min: 2,
								message: '姓名需要至少2个字符'
							}
						}
					},
					password: {
						validators: {
							notEmpty: {
								message: '密码不能为空'
							},
							stringLength: {
								min: 6,
								max: 16,
								message: '密码需要 6 至 16 个字符'
							}
						}
					},
					confirmPassword: {
						validators: {
							notEmpty: {
								message: '密码不能为空'
							},
							identical: {
								field: 'password',
								message: '确认密码与输入的密码不相同'
							}
						}
					},
					birth: {
						validators: {
							notEmpty: {
								message: '出生年月日不能为空'
							},
							date: {
								format: 'YYYY-MM-DD',
								message: '请输入\'YYYY-MM-DD\'格式的日期，或者使用日期选择器'
							}
						}
					},
					phone: {
						validators: {
							notEmpty: {
								message: '手机号码不能为空'
							},
							digit: {},
		                    phone: {
		                        country: 'CN',
		                        message: '请输入正确的手机号'
		                    }
						}
					}
				}
			});
		});
	</script>
</head>
<body class="templatemo-bg-gray" style="background-image: url('../images/login_background.jpg');background-size: 100%; background-repeat:no-repeat; background-attachment: fixed;">
	<div class="container">
		<div class="col-xs-12">
			<h1 class="margin-bottom-15">用户注册</h1>
			<form id="registerForm" class="form-horizontal templatemo-container templatemo-login-form-1 margin-bottom-30" role="form" action="${pageContext.request.contextPath}/patient/register" method="post">				
		        <div class="form-group">
		          <div class="col-xs-12">		            
		            <div class="control-wrapper">
		            	<label for="name" class="control-label fa-label"><i class="fa fa-user"></i></label>
		            	<input type="text" class="form-control" id="name" name="name" placeholder="姓名">
		            </div>		            	            
		          </div>              
		        </div>
		        <div class="form-group">
		          <div class="col-xs-12">
		          	<div class="control-wrapper">
		            	<label for="password" class="control-label fa-label"><i class="fa fa-lock"></i></label>
		            	<input type="password" class="form-control" id="password" name="password" placeholder="密码">
		            </div>
		          </div>
		        </div>
		        <div class="form-group">
		          <div class="col-xs-12">
		          	<div class="control-wrapper">
		            	<label for="confirmPassword" class="control-label fa-label"><i class="fa fa-lock"></i></label>
		            	<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="确认密码">
		            </div>
		          </div>
		        </div>
		        <div class="form-group">
		          <div class="col-xs-12">
		          	<div class="control-wrapper">
		            	<label for="phone" class="control-label fa-label"><i class="fa fa-phone"></i></label>
		            	<input type="tel" class="form-control" id="phone" name="phone" placeholder="手机号">
		            </div>
		          </div>
		        </div>
		        <div class="form-group">
		          <div class="col-xs-12">
		          	<div class="control-wrapper">
		            	<label for="birth" class="control-label fa-label"><i class="fa fa-birthday-cake"></i></label>
						<div class='input-group date' id='datetimepicker'>
					        <input type='text' class="form-control" id="birth" name="birth" value="" placeholder="出生年月日" />
					        <span class="input-group-addon">
					            <span class="fa fa-calendar"></span>
					        </span>
					    </div>
		            </div>
		          </div>
		        </div>
		        <div class="form-group">
		          <div class="">
		          	<div class="control-wrapper">
		            	<label for="gender" class="control-label fa-label" style="margin-left: 20px">性别：</label>
		            	<select id="gender" name="gender" class="form-control" style="width: 100px;margin-left: 70px">
		            		<option value="1" selected>男</option>
		            		<option value="0">女</option>
		            	</select>
		            </div>
		          </div>
		        </div>
		        <div class="form-group">
		          <div class="col-md-12">
		          	<div class="control-wrapper">
		          		<input type="submit" value="注册" class="btn btn-info">
		          		<input type="reset" value="重置" class="btn btn-info">
		          		<a href="${pageContext.request.contextPath}/toLogin" class="text-right pull-right">返回登陆</a>
		          	</div>
		          </div>
		        </div>
		        <hr>
		      </form>
		      <div class="text-center">
		      	<label>&copy XXX</label>	
		      </div>
		</div>
	</div>
	<script type="text/javascript">
    $(function () {
        $('#datetimepicker').datetimepicker({
            format: 'yyyy-mm-dd',//日期格式化，只显示日期
            language: 'zh-CN',      //中文化
            endDate: new Date(),
            todayBtn: "linked",
            autoclose: true,
            startView: 'decade',
            minView: 'month'
        });
    });
	</script> 
</body>
</html>