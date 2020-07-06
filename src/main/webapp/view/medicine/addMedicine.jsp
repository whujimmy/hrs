<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>新增药品</title>
	<link rel="stylesheet" type="text/css"href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
	<link href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootbox.min.js"></script>
	
	<script type="text/javascript">
	$(function() {
		$("#addDept").bootstrapValidator({
	        container: '#tip',
			message: 'This value is not valid',
			feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				medicineName: {
					validators: {
						notEmpty: {
							message: '药品名称不能为空'
						}
					}
				},
				medicineName: {
					validators: {
						notEmpty: {
							message: '药品价格不能为空'
						}
					}
				},
				medicineName: {
					validators: {
						notEmpty: {
							message: '药品数量不能为空'
						}
					}
				}
			}
		});
		$('#add').click(function() {
    		$.ajax({
                url: "${pageContext.request.contextPath}/medicine/addMedicine",
				type : "POST",
				data : {
					medicineName: $('#medicineName').val(),
					medicinePrice: $('#medicinePrice').val(),
					medicineAmount: $('#medicineAmount').val()
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
	</head>
	<body>
		<form id="addMedicine" class="form-inline" role="form" style="margin-top: 30px; margin-left: 30px">
			<div class="form-group">
				<label>药品名称:</label> <input type="text" class="form-control" id="medicineName" name="medicineName">
			</div>
			<div class="form-group">
				<label>药品价格:</label> <input type="text" class="form-control" id="medicinePrice" name="medicinePrice">
			</div>
			<div class="form-group">
				<label>药品数量:</label> <input type="text" class="form-control" id="medicineAmount" name="medicineAmount">
			</div>
			<button type="button" class="btn btn-default" id="add">添加</button>
			<div id="tip"></div>
		</form>
	
	</body>
</html>