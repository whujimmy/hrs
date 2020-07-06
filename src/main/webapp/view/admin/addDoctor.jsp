<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>医生录入</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap-select.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-select.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/moment-with-locales.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootbox.min.js"></script>
	
	<script type="text/javascript">
		$(function() {
			$.ajax({
	            url: "${pageContext.request.contextPath}/department/loadDepartment",
	            type:"post",
	            dataType: "json",
	            success: function (data) {
	                for (var i = 0; i < data.length; i++) {
	                    $('#doctorDepartmentNo').append("<option value=" + data[i].departmentNo + ">" + data[i].departmentName + "</option>");
	                    $('#doctorDepartmentNo').selectpicker('refresh');//必须要有
	                }
	            }
	        });
			
			initValidator();
			
		    $('#reset_btn').click(function() {
				$('#doctorName').val("");
				$('#doctorDepartmentNo').val("");
				$('#doctorSex').val("");
				$('#doctorPassword').val("");
				$('#doctorPassword1').val("");
				$('#doctorBirth').val("");
				$('#doctorPhone').val("");
				$('#doctorRegistrationFee').val("");
				$('#doctorHireTime').val("");
				$("#addDoctor").data('bootstrapValidator').destroy();
				initValidator();
		    });
			$('#add').click(function() {
	    		$.ajax({
	                url: "${pageContext.request.contextPath}/admin/addDoctor",
					type : "POST",
					data : {
						doctorName: $('#doctorName').val(),
						doctorDepartmentNo: $('#doctorDepartmentNo').val(),
						doctorSex: $('#doctorSex').val(),
						doctorPassword: $('#doctorPassword').val(),
						birth: $('#doctorBirth').val(),
						doctorPhone: $('#doctorPhone').val(),
						doctorRegistrationFee: $('#doctorRegistrationFee').val(),
						hireTime: $('#doctorHireTime').val()
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
	function initValidator() {
		$("#addDoctor").bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				doctorName: {
					validators: {
						notEmpty: {
							message: '医生姓名不能为空'
						}
					}
				},
				doctorPassword: {
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
				doctorPassword1: {
					validators: {
						notEmpty: {
							message: '密码不能为空'
						},
						identical: {
							field: 'doctorPassword',
							message: '确认密码与输入的密码不相同'
						}
					}
				},
				doctorBirth: {
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
				doctorHireTime: {
					validators: {
						notEmpty: {
							message: '入职日期不能为空'
						},
						date: {
							format: 'YYYY-MM-DD',
							message: '请输入\'YYYY-MM-DD\'格式的日期，或者使用日期选择器'
						}
					}
				}, 
				doctorPhone: {
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
				},
				doctorRegistrationFee: {
					validators: {
						notEmpty: {
							message: '挂号收费价格不能为空'
						}
					}
				}
			}
		});
	}
	</script>
</head>
<body>
	<form id="addDoctor" class="form-horizontal col-sm-8" role="form" style="margin-top: 30px; margin-left: 30px">
		<div class="form-group">
			<label class="col-sm-2 control-label">医生姓名:</label>
		    <div class="col-sm-4">
				<input type="text" class="form-control"id="doctorName" name="doctorName">
		    </div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">所属部门:</label>
		    <div class="col-sm-4">
				<select class="selectpicker form-control" id="doctorDepartmentNo" name="doctorDepartmentNo" title="请选择"></select>
		    </div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">医生性别:</label>
		    <div class="col-sm-4">
				<select id="doctorSex" name="doctorSex" class="form-control" >
					<option value="1" selected>男</option>
					<option value="0">女</option>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">登录密码:</label>
		    <div class="col-sm-4">
				<input type="password" class="form-control"	id="doctorPassword" name="doctorPassword">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">确认密码:</label>
		    <div class="col-sm-4">
		    	<input type="password" class="form-control" id="doctorPassword1" name="doctorPassword1">
		    </div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">出生日期:</label>
		    <div class="col-sm-4">
				<div class='input-group date' id='birthDatetimepicker'>
					<input type="text" class="form-control" id="doctorBirth" name="birth" value="" style="width:286px">
					<span class="input-group-addon"> <span class="fa fa-calendar"></span></span>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">电话号码:</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="doctorPhone" name="doctorPhone">
		    </div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">挂号收费:</label>
		    <div class="col-sm-4">
		    	<input type="number" step="0.01" class="form-control" id="doctorRegistrationFee" name="doctorRegistrationFee">
		    </div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">入职日期:</label>
		    <div class="col-sm-4">
				<div class='input-group date' id='hireDatetimepicker'>
					<input type="text" class="form-control" id="doctorHireTime"name="hireTime" style="width:286px">
					<span class="input-group-addon"> <span class="fa fa-calendar"></span></span>
				</div>
			</div>
		</div>
		<div class="form-group">
			<button type="button" class="btn btn-default" id="add" style="margin-top: 10px">添加</button>
	  		<button class="btn btn-default" id="reset_btn" type="button" style="margin-top: 10px;width: 60px;">重置</button>
		</div>
	</form>
	<table id="mytab" class="table table-hover"></table>

	<script type="text/javascript">
	    $(function () {
	        $('#birthDatetimepicker').datetimepicker({
	            format: 'yyyy-mm-dd',//日期格式化，只显示日期
	            language: 'zh-CN',      //中文化
	            endDate: new Date(),
	            todayBtn: "linked",
	            autoclose: true,
	            startView: 'decade',
	            minView: 'month'
	        });
	    });
	    $(function () {
	        $('#hireDatetimepicker').datetimepicker({
	            format: 'yyyy-mm-dd',//日期格式化，只显示日期
	            language: 'zh-CN',      //中文化
	            endDate: new Date(),
	            todayBtn: "linked",
	            autoclose: true,
	            minView: 'month'
	        });
	    });
    </script>
</body>
</html>