<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>开药</title>
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
		//获取科室列表
	    $('#medicineTable').bootstrapTable({
	        method: 'post',//post避免中文乱码
	        contentType: "application/x-www-form-urlencoded",//必须要有！！！！
	        url:"${pageContext.request.contextPath}/doctor/queryMedicine",//要请求数据的文件路径
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
	                title:'药品编号',
	                field:'medicineNo',
	                align:'center'
	            },{
	                title:'药品名称',
	                field:'medicineName',
	                align:'center'
	            },{
	                title:'药品价格',
	                field:'medicinePrice',
	                align:'center'
	            },{
	                title:'剩余数量',
	                field:'medicineAmount',
	                align:'center'
	            },{
	                title:'操作',
	                field:'<a class="btn btn-primary" onclick="add(\"medicineNo\",\"medicineName\",\"medicineAmount\")">添加</a>',
	                align:'center'
	            }
	        ]
	    })

	    function queryParams(params){  
	        return {  
	                limit : this.limit, // 页面大小  
	                offset : this.offset, // 页码   
	                pageNumber : this.pageNumber,  
	                pageSize : this.pageSize,
	                medicineName: $('#medicineName').val()
	        } 
	    }  
	    //查询按钮事件
	    $('#search_btn').click(function(){
	        $('#medicineTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/doctor/queryMedicine'});
	    })
	    //tableHeight函数
	    function tableHeight(){
	        //可以根据自己页面情况进行调整
	        return $(window).height() -280;
	    }
	    
	    function add(medicineNo,medicineName,medicineAmount){
	    	if(medicineAmount<1){
	    		bootbox.alert({
	    			  size: "small",
	    			  message: "药品数量不足，请选择其他药品！",
	    		});
	    		return;
	    	}

	    	var registrationNo = ''; 
	    	var href = window.location.search;
	    	href = href.substr(1);
	    	var strs = href.split("&");
	    	for ( var i = 0; i < strs.length; i++ ) { 
	    		registrationNo = strs[ i ].split( "=" )[ 1 ];
	    	}
	    	
	    	$("input[name=medicineNo]").val(medicineNo);
	    	$("input[name=registrationNo]").val(registrationNo);
	    	var h = document.getElementById('medicineName');
	        h.innerHTML = medicineName;
	    	$("#myModal").model("show");
	    	
	    }
	    
 	});
	</script>
</head>
<body>
	<form class="form-inline" role="form" style="margin-top: 30px; margin-left: 30px">
		<div class="form-group">
			<label>药品名称:</label> <input type="text" class="form-control" id="medicineName" name="medicineName">
		</div>
		<input class="btn btn-default" id="search_btn" value="查询" style="width: 60px;"></input>
	</form>
	<table id="medicineTable" class="table table-hover table-striped"></table>
	
	<!-- 模态框  -->
   	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	        <h4 class="modal-title" id="myModalLabel">详情</h4>
	      </div>
	      <div class="modal-body">
	        <form id="editForm" class="form-horizontal" role="form" action="${pageContext.request.contextPath}/doctor/addMedicine" method="post">
	          <input type="hidden" name="medicineNo" value="">
	          <input type="hidden" name="registrationNo" value="">
			  <h2 id="medicineName"></h2>
			  <div class="form-group">
			    <label for="medicineAmount" class="col-sm-2 control-label">数量:</label>
			    <div class="col-sm-10">
			      <input type="number" class="form-control" id="medicineAmount" name="medicineAmount"/>
			    </div>
			  </div>
		      <div class="modal-footer">
		        <input type="submit" class="btn btn-primary" value="确认"/> 
		      </div>
			</form>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- ending -->
</body>
</html>