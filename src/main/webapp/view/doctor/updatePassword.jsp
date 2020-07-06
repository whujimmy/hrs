<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/beyond.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css">
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootbox.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootbox.min.js"></script>
	<script type="text/javascript">
		$(function() {
			initValidator();
			$('#update').click(function() {
	    		$.ajax({
	                url: "${pageContext.request.contextPath}/doctor/updatePassword",
					type : "POST",
					data : {
						oldPassword: $('#oldPassword').val(),
						newPassword: $('#newPassword').val(),
					},
	                dataType: "json",
					async : true,
	                success: function (data) {
	                	bootbox.alert({
	                		size: "small",
	    		        	message: data.tips
	                	})
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
	<script>
	function initValidator(){
		$("#updatePasswordForm").bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				oldPassword: {
					validators: {
						notEmpty: {
							message: '旧密码不能为空'
						}
					}
				},
				newPassword: {
					validators: {
						notEmpty: {
							message: '新密码不能为空'
						},
						stringLength: {
							min: 6,
							max: 16,
							message: '新密码需要 6 至 16 个字符'
						},
						different: {
							field: 'oldPassword',
							message: '新密码不能与旧密码相同'
						}
					}
				},
				confirmPassword: {
					validators: {
						notEmpty: {
							message: '密码不能为空'
						},
						identical: {
							field: 'newPassword',
							message: '确认密码与输入的密码不相同'
						}
					}
				}
			}
		});
	}
	</script>
</head>
<body>
	<div class="panel panel-default">
		  <div class="panel-heading">
			<table class="table" border="0px">
				<tr>
					<td>
						<label for="docNo" class="col-sm-4 control-label" style="margin-top: 5px">医生编号：</label>
					    <div class="col-sm-5">
					      <input type="text" class="form-control" id="docNo" name="docNo" value="${doctor.doctorNo}" readonly/>
					    </div>
					</td>
					<td>
						<label for="docName" class="col-sm-4 control-label" style="margin-top: 5px">医生姓名：</label>
					    <div class="col-sm-5">
					      <input type="text" class="form-control" id="docName" name="docName" value="${doctor.doctorName}" readonly/>
					    </div>
					</td>
					<td>
						<label for="deptName" class="col-sm-4 control-label" style="margin-top: 5px">所属科室：</label>
					    <div class="col-sm-5">
					      <input type="text" class="form-control" id="deptName" name="deptName" value="${doctor.doctorDepartmentNo}" readonly/>
					    </div>
					</td>
				</tr>
			</table>
		  </div>
		</div>
	<form id="updatePasswordForm" class="form-horizontal" style="margin-top: 30px;">
		<div class="form-group">
			<label for="oldPassword" class="col-sm-2 control-label" style="width:150px">旧密码</label>
			<div class="col-sm-10">
				<input type="password" class="form-control" id="oldPassword" name="oldPassword" placeholder="旧密码" style="width:250px">
			</div>
		</div>
		<div class="form-group">
			<label for="newPassword" class="col-sm-2 control-label" style="width:150px">新密码</label>
			<div class="col-sm-10">
				<input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="新密码" style="width:250px">
			</div>
		</div>
		<div class="form-group">
			<label for="confirmPassword" class="col-sm-2 control-label" style="width:150px">确认密码</label>
			<div class="col-sm-10">
				<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="确认密码" style="width:250px">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-1 col-sm-10" style="margin-left:150px">
				<button id="update" type="button" class="btn btn-default">修改</button>
			</div>
		</div>
	</form>
</body>
</html>