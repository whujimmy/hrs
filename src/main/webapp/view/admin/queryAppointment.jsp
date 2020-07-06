<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>挂号列表</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/beyond.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap-table.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap-select.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css">
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table.min.js"></script>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.min.js"></script>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootbox.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-select.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/moment-with-locales.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
 	<script type="text/javascript">
 	$(function() {
		//获取挂号列表
	    $('#registrationTable').bootstrapTable({
	        method: 'post',//post避免中文乱码
	        contentType: "application/x-www-form-urlencoded",//必须要有！！！！
	        url:"${pageContext.request.contextPath}/registration/queryRegistrationList",//要请求数据的文件路径
	        //height:tableHeight(),//高度调整
	        toolbar: '#toolbar',//指定工具栏 
	        dataType: "json",
	        pageNumber: 1, //初始化加载第一页，默认第一页
	        pagination:true,//是否分页
	        queryParams:queryParams,//请求服务器时所传的参数
	        sidePagination:'server',//指定服务器端分页
	        pageSize:10,//单页记录数
	        pageList:[5,10,20,30],//分页步进值
	        showRefresh:true,//刷新按钮
	        showColumns:false,
	        clickToSelect: false,//是否启用点击选中行
	        columns:[{
	                title:'挂号编号',
	                field:'registrationNo',
	                align:'center'
	            },{
	            	title:'病人',
	            	field:'patientName',
	            	align:'center'
	            },{
	                title:'科室',
	                field:'departmentName',
	                align:'center'
	            },{
	            	title:'医生',
	            	field:'doctorName',
	            	align:'center'
	            },{
	            	title:'时间',
	            	field:'visitTime',
	            	align:'center',
	                formatter: function (value, row, index) {
	                    return changeDateFormat(value)
	                }
	            },{
	            	title:'状态',
	            	field:'status',
	            	align:'center',
	                formatter: function (value, row, index) {
	                    return formatStatus(value)
	                }
	            }
	        ]
	    });
		//状态格式化
	    function formatStatus(value) {
	    	if ("0" == value)
	    		return "取消";
	    	else if ("1" == value)
	    		return "预约";
	    	else if ("2" == value)
	    		return "就诊";
	    	else if ("3" == value)
	    		return "过时未就诊";
	    }
 		//转换日期格式(时间戳转换为datetime格式)
 	    function changeDateFormat(cellval) {
 	        var dateVal = cellval + "";
 	        if (cellval != null) {
 	            var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
 	            var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
 	            var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
 	            return date.getFullYear() + "-" + month + "-" + currentDate;
 	        }
 	    }
	    function queryParams(params){  
	        return {  
	                limit : this.limit, // 页面大小  
	                offset : this.offset, // 页码  
	                pageNumber : this.pageNumber,  
	                pageSize : this.pageSize,
	                department: $('#department').val(),
	                beginDate: $('#beginDate').val(),
	                endDate: $('#endDate').val(),
	                status: $('#status').val()
	        } 
	    }  
	    //查询按钮事件
	    $('#search_btn').click(function(){
	        $('#registrationTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/registration/queryRegistrationList'});
	    })
	    $('#reset_btn').click(function() {
	    	$('#department').val("");
	    	$('#beginDate').val("");
	    	$('#endDate').val("");
	    	$('#status').val("");
            $('#status').selectpicker('refresh');//必须要有
            $('#department').selectpicker('refresh');//必须要有
	        $('#registrationTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/registration/queryRegistrationList'});
	    });
	    //tableHeight函数
	    function tableHeight(){
	        //可以根据自己页面情况进行调整
	        return $(window).height() -280;
	    }
		//异步获取可是列表并动态填充select
		$.ajax({
            url: "/department/loadDepartment",
            dataType: "json",
            success: function (data) {
                $('#department').append("<option value=\"\">选择科室</option>");
                for (var i = 0; i < data.length; i++) {
                    $('#department').append("<option value=" + data[i].departmentNo + ">" + data[i].departmentName + "</option>");
                    $('#department').selectpicker('refresh');//必须要有
                }
            }
        });
        $('#datetimepicker1,#datetimepicker2').datetimepicker({
            format: 'yyyy-mm-dd',//日期格式化，只显示日期
            language: 'zh-CN',      //中文化
            endDate: new Date(new Date().valueOf() + 6*86400000),
            todayBtn: "linked",
            autoclose: true,
            minView: 'month',
        });
 	});
	</script>
	<script>
		function cancelById(no) {
	        bootbox.confirm({
    			size: "small",
	        	message: "确认取消这个预约？",
	            buttons: {
	                confirm: {
	                    label: '确认',
	                    className: 'btn-success'
	                },
	                cancel: {
	                    label: '取消',
	                    className: 'btn-danger'
	                }
	            },
	        	callback: function(result){
	        	/* result is a boolean; true = OK, false = Cancel*/ 
	        		if (result) {
			        	$.ajax({
			        		url: "${pageContext.request.contextPath}/registration/cancelRegistration",
			        		type: "post",
			        		data: "registrationNo=" + no,
			        		dataType: "json",
			        		async: true,
			        		success: function(data) {
			        			if (data.status)
			        		        $('#registrationTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/registration/queryRegistrationList'});
			        			else {
									bootbox.alert({
						    			size: "small",
							        	message: data.tips
									});
			        			}
			        		},
							error : function() {
								bootbox.alert({
					    			size: "small",
						        	message: "取消出错"
								});
							}
			        	});
	        		}
	        	}
	        });
		}
	</script>
</head>
<body>
	<form class="form-inline" style="margin-top: 30px;">
		<div class="form-group">
			<label for="department">科室：</label>
			<select id="department" name="department" class="selectpicker" title="选择科室"></select>
		</div>
		<div class="form-group">
			<label for="beginDate">时间范围：</label>
			<div class='input-group date' id='datetimepicker1'>
		        <input type='text' class="form-control" id="beginDate" name=beginDate value="" placeholder="开始时间"/>
		        <span class="input-group-addon">
		            <span class="fa fa-calendar"></span>
		        </span>
		    </div>
			<label for="endDate">-</label>
			<div class='input-group date' id='datetimepicker2'>
		        <input type='text' class="form-control" id="endDate" name=endDate value="" placeholder="结束时间"/>
		        <span class="input-group-addon">
		            <span class="fa fa-calendar"></span>
		        </span>
		    </div>
		</div>
		<div class="form-group">
			<label for="status">状态：</label>
			<select id="status" name="status" class="selectpicker" title="选择状态">
				<option value="">选择状态</option>
				<option value="0">取消</option>
				<option value="1">预约</option>
				<option value="2">就诊</option>
				<option value="3">过时未就诊</option>
			</select>
		</div>
		<input class="btn btn-default" id="reset_btn" value="重置" style="width: 60px;" type="button"></input>
		<input class="btn btn-default" id="search_btn" value="查询" style="width: 60px;" type="button"></input>
	</form>
	<table id="registrationTable" class="table table-hover table-striped"></table>
</body>
</html>