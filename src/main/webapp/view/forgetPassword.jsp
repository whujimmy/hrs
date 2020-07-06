<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.zjy.entity.Doctor"%>
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
	<link href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootbox.min.js"></script>
	<title>忘记密码</title>
	
	<script type="text/javascript">
		$(function() {
			$("#form").bootstrapValidator({
				message: 'This value is not valid',
				feedbackIcons: {
		            valid: 'glyphicon glyphicon-ok',
		            invalid: 'glyphicon glyphicon-remove',
		            validating: 'glyphicon glyphicon-refresh'
				},
				fields: {
					id: {
						validators: {
							notEmpty: {
								message: '编号不能为空'
							},
							remote: {
								type: 'POST',
								url: '${pageContext.request.contextPath}/check/id',
								data: {
									id: function() {
										return $('#id').val();
									},
									type: function() {
										return $('#type').val();
									}
								},
								message: '账号不存在'
							}
						}
					}
				}
			});
			$("#editForm").bootstrapValidator({
				message: 'This value is not valid',
				feedbackIcons: {
		            valid: 'glyphicon glyphicon-ok',
		            invalid: 'glyphicon glyphicon-remove',
		            validating: 'glyphicon glyphicon-refresh'
				},
				fields: {
					password: {
						validators: {
							notEmpty: {
								message: '新密码不能为空'
							},
							stringLength: {
								min: 6,
								max: 16,
								message: '新密码需要 6 至 16 个字符'
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
					code: {
						validators: {
							notEmpty: {
								message: '验证码不能为空'
							},
							remote: {
								type: 'POST',
								url: '${pageContext.request.contextPath}/check/phoneCode',
								data: {
									phoneCode: function() {
										return $('#code').val();
									}
								},
								message: '验证码不正确'
							}
						}
					}
				}
			});
			$('#btn').click(function() {
	    		$.ajax({
	                url: "${pageContext.request.contextPath}/getPhone",
					type : "POST",
					data : {
						type: $('#type').val(),
						no: $('#id').val(),
					},
	                dataType: "json",
					async : true,
	                success: function (data) {
	                	$('#phone').val(data.phone);
	                	$('#typeHide').val(data.type);
	                	$('#noHide').val(data.no);
	                },
	                error: function (data) {
	                	bootbox.alert({
	    		        	message: "网络错误"
	                	})
	                }
	            });
				$('#myModal').modal("show");
			});
			$('#save').click(function() {
	    		$.ajax({
	                url: "${pageContext.request.contextPath}/updatePassword",
					type : "POST",
					data : {
						type: $('#typeHide').val(),
						no: $('#noHide').val(),
						password: $('#password').val()
					},
	                dataType: "json",
					async : true,
	                success: function (data) {
	                	if (data.status) {
		                	bootbox.alert({
		                		size: "small",
		    		        	message: data.tips,
		    		        	callback: function() {
		    	    				window.location.href = "${pageContext.request.contextPath}/toLogin";
		    		        	}
		                	})
	                	} else {
		                	bootbox.alert({
		                		size: "small",
		    		        	message: data.tips
		                	})
	                	}
	                },
	                error: function (data) {
	                	bootbox.alert({
	    		        	message: "网络错误"
	                	})
	                }
	            });
			});
		});
	</script>
</head>
<body class="templatemo-bg-gray" style="background-image: url('images/login_background.jpg');background-size: 100%; background-repeat:no-repeat; background-attachment: fixed;">
	<div class="container">
		<div class="col-md-12">
			<h1 class="margin-bottom-15">忘记密码</h1>
			<form id="form" class="form-horizontal templatemo-container templatemo-login-form-1 margin-bottom-30" role="form">
		        <div class="form-group">
		          <div class="">
		          	<div class="control-wrapper">
		            	<label for="type" class="control-label fa-label">类型：</label>
		            	<select id="type" name="type" class="form-control" style="width: 100px;margin-left: 30px">
		            		<option value="0" selected>医生</option>
		            		<option value="2">病人</option>
		            	</select>
		            </div>
		          </div>
		        </div>
				<div class="form-group">
					<input type="text" class="form-control" id="id" name="id" placeholder="编号">
				</div>
				<input id="btn" type="button" value="确认" class="btn btn-info">
			</form>
		      <div class="text-center">
		      	<label>&copy XXX</label>	
		      </div>
		</div>
	</div>
	<!-- 模态框 -->
   	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	        <h4 class="modal-title" id="myModalLabel">验证手机</h4>
	      </div>
	      <div class="modal-body">
	        <form id="editForm" class="form-horizontal" role="form">
			  <div class="form-group hidden">
			    <label for="typeHide" class="col-sm-2 control-label">类型:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="typeHide" name="typeHide" value="" readonly>
			    </div>
			  </div>
			  <div class="form-group hidden">
			    <label for="noHide" class="col-sm-2 control-label">编号:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="noHide" name="noHide" value="" readonly>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="phone" class="col-sm-2 control-label">手机号:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="phone" name="phone" value="" readonly>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="code" class="col-sm-2 control-label">验证码:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="code" name="code" value="">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="password" class="col-sm-2 control-label">新密码:</label>
			    <div class="col-sm-10">
			      <input type="password" class="form-control" id="password" name="password" value="">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="confirmPossword" class="col-sm-2 control-label">确认密码:</label>
			    <div class="col-sm-10">
			      <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" value="">
			    </div>
			  </div>
		      <div class="modal-footer">
		        <input id="save" type="button" class="btn btn-primary" value="保存"/>
		        <input type="reset" class="btn btn-default" data-dismiss="modal" value="取消"/> 
		      </div>
			</form>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- ending -->
</body>
</html>