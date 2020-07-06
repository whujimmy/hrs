<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人信息</title>
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
	    $('#editPhone').click(function() {
	        $("#myModal").modal("show");
	    }); 
	    $('#update').click(function() {
    		$.ajax({
                url: "${pageContext.request.contextPath}/patient/updatePhone",
				type : "POST",
				data : {
					phone: $('#phone').val(),
				},
                dataType: "json",
				async : true,
                success: function (data) {
                	bootbox.alert({
                		size: "small",
    		        	message: data.tips,
    		        	callback: function() {
    	                	$('#myModal').modal('hide')
    	                	location.reload();
    		        	}
                	})
                },
                error: function (data) {
                	bootbox.alert({
    		        	message: "网络错误"
                	})
                }
            });
	    });
		$("#updatePhone").bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
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
<body>
	<form class="form-horizontal" style="margin-top: 30px;">
		<div class="form-group">
			<label class="col-sm-2 control-label" style="width:150px">编号</label>
			<div class="col-sm-8">
				<p class="form-control-static">${patient.patientNo}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" style="width:150px">姓名</label>
			<div class="col-sm-8">
				<p class="form-control-static">${patient.patientName}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" style="width:150px">性别</label>
			<div class="col-sm-8">
				<p class="form-control-static">${patient.patientSex == '1'? '男' : '女'}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" style="width:150px">出生年月日</label>
			<div class="col-sm-8">
				<p class="form-control-static"><fmt:formatDate value="${patient.patientBirth}" type="date"/></p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" style="width:150px">手机号</label>
			<div class="col-sm-8" style="width:150px">
				<p class="form-control-static">${patient.patientPhone}</p>
			</div>
			<div class="col-sm-2">
				<input id="editPhone" class="btn btn-default" value="修改手机号" style="width:100px"></input>
			</div>
		</div>
	</form>
	<!-- 模态框 -->
   	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	        <h4 class="modal-title" id="myModalLabel">个人信息</h4>
	      </div>
	      <div class="modal-body">
	        <form id="updatePhone" class="form-horizontal" role="form">
			  <div class="form-group">
			    <label for="doctorPhone" class="col-sm-2 control-label">新手机号:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="phone" name="phone" value="">
			    </div>
			  </div>
		      <div class="modal-footer">
		        <input type="button" class="btn btn-primary" value="保存" id="update"/>
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