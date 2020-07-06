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
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap-editable.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css">
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table.min.js"></script>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.min.js"></script>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-editable.min.js"></script>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootbox.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
 	<script type="text/javascript">
 	$(function() {
		//获取挂号列表
	    $('#regTable').bootstrapTable({
	        method: 'post',//post避免中文乱码
	        contentType: "application/x-www-form-urlencoded",//必须要有！！！！
	        url:"${pageContext.request.contextPath}/doctor/queryRegisterList",//要请求数据的文件路径
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
	                title:'挂号编号',
	                field:'registrationNo',
	                align:'center'
	            },{
	                title:'姓名',
	                field:'patientName',
	                align:'center'
	            },{
   	            	title:'操作',
   	                field:'Button',
   	                align:'center',
   	                //events:operateEvents,
   	                formatter: confirmFunction
  	            }
	        ]
	    });
	    
	    
   	    function confirmFunction(value, row, index) {
               return [
                       '<button id="tableConfirm" onclick="confirm(\''+row.registrationNo+'\')" type="button" class="btn btn-default">确认就诊</button>'
                       ].join("");
        }
		
	    function queryParams(params){  
	        return {  
	                limit : this.limit, // 页面大小  
	                offset : this.offset, // 页码  
	                pageNumber : this.pageNumber,  
	                pageSize : this.pageSize,
	                regNo: $('#regNo').val()
	        } 
	    }  
	    //查询按钮事件
	    $('#search_btn').click(function(){
	        $('#regTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/doctor/queryRegisterList'});
	    });
	    $('#reset_btn').click(function() {
	    	$('#regNo').val("");
	        $('#regTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/doctor/queryRegisterList'});
	    });
	    //tableHeight函数
	    function tableHeight(){
	        //可以根据自己页面情况进行调整
	        return $(window).height() -280;
	    }
	    
	    //行内编辑配置
	    $('#edit').click(function() {
	  		var row = $("#regTable").bootstrapTable('getSelections');
	  		if(row.length == 1) {
	  			var departmentNo = '';
	  			$.each(row, function() {
	  				departmentNo = this.departmentNo;
				});
		        $.ajax({
	        		url: "${pageContext.request.contextPath}/admin/selectByDepNo",
	        		type: "post",
	        		data: "departmentNo="+departmentNo,    //如何拿到该行的depNo
	        		dataType: "json",
	        		async: true,
	        		success: function(data){
	        			$("input[name=departmentNo]").val(data.departmentNo);
	        			$("input[name=depName]").val(data.departmentName);
	        	        //显示模态框
	        	        $("#myModal").modal("show");
	        		}
		        });
	  		}else {
	  			bootbox.alert({
	    			  size: "small",
	    			  message: "只能选择一个科室进行修改操作！",
	    		});
	  		}
	    }); 
 	});
	</script>
	<script>
	    function confirm(registrationNo){
	    	location.href="${pageContext.request.contextPath}/doctor/confirmVisit?registrationNo="+registrationNo;
	    }
	</script>
</head>
<body>
	<form class="form-inline" role="form" style="margin-top: 30px; margin-left: 30px">
		<div class="form-group">
			<label>挂号编号:</label> <input type="text" class="form-control" id="regNo" name="regNo">
		</div>
		<input class="btn btn-default" id="reset_btn" value="重置" style="width: 60px;" type="button"></input>
		<input class="btn btn-default" id="search_btn" value="查询" style="width: 60px;" type="button"></input>
	</form>
	<table id="regTable" class="table table-hover table-striped"></table>
</body>
</html>