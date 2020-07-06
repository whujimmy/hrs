<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>预约挂号</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap-select.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css">
	<link href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/moment-with-locales.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-select.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootbox.min.js"></script>
	<script type="text/javascript">
	$(function() {
		//异步获取可是列表并动态填充select
		$.ajax({
            url: "/department/loadDepartment",
            dataType: "json",
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    $('#selectDepartment').append("<option value=" + data[i].departmentNo + ">" + data[i].departmentName + "</option>");
                    $('#selectDepartment').selectpicker('refresh');//必须要有
                }
            }
        });
		$('#selectDepartment').change(function() {
			$('#viewDate').val("");
		});
		$('#viewDate').change(function() {
			$('#selectDoctor').empty();
			$.ajax({
	            url: "/doctor/loadDoctor",
	            dataType: "json",
	            data: {
	            	departmentNo: $('#selectDepartment').val(),
	            	viewDate: $('#viewDate').val()
	            },
	            success: function (data) {
	            	if (data.length == 0) {
	                    $('#selectDoctor').append("<option disabled>没有值班医生或医生挂号已满 </option>");
	                    $('#selectDoctor').selectpicker('refresh');//必须要有
	                    return;
	            	}
	                for (var i = 0; i < data.length; i++) {
	                    $('#selectDoctor').append("<option value=" + data[i].doctorNo + ">" + data[i].doctorName + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + data[i].doctorRegistrationFee + "元" + "</option>");
	                    $('#selectDoctor').selectpicker('refresh');//必须要有
	                }
	            }
	        });
		});
		$('#selectDoctor').change(function() {
			var select = $('#selectDoctor').val();
		});
        $('#datetimepicker').datetimepicker({
            format: 'yyyy-mm-dd',//日期格式化，只显示日期
            language: 'zh-CN',      //中文化
            startDate: new Date(),
            endDate: new Date(new Date().valueOf() + 6*86400000),
            todayBtn: "linked",
            autoclose: true,
            minView: 'month',
        });
        $('#submit').click(function() {
    		$.ajax({
                url: "${pageContext.request.contextPath}/patient/appointment",
				type : "POST",
				data : {
					department: $('#selectDepartment').val(),
					doctor: $('#selectDoctor').val(),
					viewDate: $('#viewDate').val()
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
	<form id="appointmentForm" class="form-inline" style="margin-top: 30px; margin-left: 30px">
		<select id="selectDepartment" name="department" class="selectpicker" title="选择科室"></select>
		<div class='input-group date' id='datetimepicker'>
	        <input type='text' class="form-control" id="viewDate" name=viewDate value="" placeholder="就诊日期" />
	        <span class="input-group-addon">
	            <span class="fa fa-calendar"></span>
	        </span>
	    </div>
		<select id="selectDoctor" name="doctor" class="selectpicker" title="选择医生"></select>
		<input type="button" value="预约" class="btn btn-info" id="submit">
		<div id="tips"></div>
	</form>
</body>
</html>