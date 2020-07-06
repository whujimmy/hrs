<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>科室列表</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/beyond.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap-table.min.css" />
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table.min.js"></script>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.min.js"></script>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootbox.min.js"></script>
 	<script type="text/javascript">
 	$(function() {
		//获取科室列表
	    $('#patientTable').bootstrapTable({
	        method: 'post',//post避免中文乱码
	        contentType: "application/x-www-form-urlencoded",//必须要有！！！！
	        url:"${pageContext.request.contextPath}/admin/queryPatientList",//要请求数据的文件路径
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
	        clickToSelect: true,//是否启用点击选中行
	        columns:[{
	                title:'全选',
	                //复选框
	                checkbox:true,
	                width:25,
	                align:'center',
	                valign:'middle'
	            },{
	                title:'编号',
	                field:'patientNo',
	                align:'center'
	            },{
	                title:'姓名',
	                field:'patientName',
	                align:'center'
	            },{
	            	title:'性别',
	            	field:'patientSex',
	            	align:'center',
	                formatter: function (value, row, index) {
	                    return formatSex(value)
	                }
	            },{
	            	title:'出生年月日',
	            	field:'patientBirth',
	            	align:'center',
	                formatter: function (value, row, index) {
	                    return changeDateFormat(value)
	                }
	            },{
	            	title:'手机号',
	            	field:'patientPhone',
	            	align:'center'
	            }
// 	            ,{
// 	            	title:'操作',
// 	                field:'id',
// 	                align:'center',
// 	                formatter: actionFormatter
// 	            }
	        ]
	    })
// 	    function actionFormatter(value, row, index) {
//             var id = value;
//             var result = "<button class='btn btn-danger' name='deleteOne'><span class='glyphicon glyphicon-trash'></span></button>";
//             return result;
//         }
	    function formatSex(value) {
	    	return value==1?"男":"女";
	    }
 		//转换日期格式(时间戳转换为datetime格式)
 	    function changeDateFormat(cellval) {
 	        var dateVal = cellval + "";
 	        if (cellval != null) {
 	            var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
 	            var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
 	            var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
 	            
//  	            var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
//  	            var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
//  	            var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
 	            
//  	            return date.getFullYear() + "-" + month + "-" + currentDate + " " + hours + ":" + minutes + ":" + seconds;
 	            return date.getFullYear() + "-" + month + "-" + currentDate;
 	        }
 	    }
	    function queryParams(params){  
	        return {  
	                limit : this.limit, // 页面大小  
	                offset : this.offset, // 页码  
	                pageNumber : this.pageNumber,  
	                pageSize : this.pageSize,
	                patientName: $('#patientName').val(),
	                patientSex: $('#patientSex').val(),
	                patientMinAge: $('#patientMinAge').val(),
	                patientMaxAge: $('#patientMaxAge').val(),
	                patientPhone: $('#patientPhone').val()
	        } 
	    }  
	    //查询按钮事件
	    $('#search_btn').click(function(){
	        $('#patientTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/admin/queryPatientList'});
	    })
	    $('#reset_btn').click(function(){
	    	$('#patientName').val("");
	    	$('#patientSex').val("");
	    	$('#patientMinAge').val("");
	    	$('#patientMaxAge').val("");
	    	$('#patientPhone').val("");
	        $('#patientTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/admin/queryPatientList'});
	    })
	    //tableHeight函数
	    function tableHeight(){
	        //可以根据自己页面情况进行调整
	        return $(window).height() -280;
	    }
 	});
	</script>
</head>
<body>
	<form class="form-inline" role="form" style="margin-top: 30px; margin-left: 30px">
		<div class="form-group">
			<label>姓名:</label> <input type="text" class="form-control" id="patientName" name="patientName">
			<label style="margin-left:20px">性别:</label>
           	<select id="patientSex" name="patientSex" class="form-control" style="width: 100px;">
           		<option value="">请选择</option>
           		<option value="0">女</option>
           		<option value="1">男</option>
           	</select>
			<label style="margin-left:20px">年龄:</label> <input type="text" class="form-control" id="patientMinAge" name="patientMinAge" style="width: 100px;">
			<label>-</label> <input type="text" class="form-control" id="patientMaxAge" name="patientMaxAge" style="width: 100px;">
			<label style="margin-left:20px">手机号:</label> <input type="text" class="form-control" id="patientPhone" name="patientPhone">
		</div>
		<input class="btn btn-default" id="reset_btn" value="重置" style="width: 60px;" type="button"></input>
		<input class="btn btn-default" id="search_btn" value="查询" style="width: 60px;" type="button"></input>
	</form>
	<table id="patientTable" class="table table-hover table-striped"></table>
</body>
</html>