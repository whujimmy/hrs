<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>药品列表</title>
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
	    $('#medicineTable').bootstrapTable({
	        method: 'post',//post避免中文乱码
	        contentType: "application/x-www-form-urlencoded",//必须要有！！！！
	        url:"${pageContext.request.contextPath}/medicine/queryMedicineList",//要请求数据的文件路径
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
	                title:'药品剩余数量',
	                field:'medicineAmount',
	                align:'center'
	            },{
	                title:'上一次添加药品数',
	                field:'medicineLastAddAccount',
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
	                medicineName: $('#name').val()
	        } 
	    }  
	    //查询按钮事件
	    $('#search_btn').click(function(){
	        $('#medicineTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/medicine/queryMedicineList'});
	    })
	    $('#reset_btn').click(function(){
	    	$('#name').val("");
	        $('#medicineTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/medicine/queryMedicineList'});
	    })
	    //tableHeight函数
	    function tableHeight(){
	        //可以根据自己页面情况进行调整
	        return $(window).height() -280;
	    }
	    
	    //行内编辑配置
	    $('#edit').click(function() {
	       /* var medicineNo = $("#medicineTable").bootstrapTable('onClickRow',function(row, $element){
	            return row.medicineNo;
	  		});	 */ 
	  		var row = $("#medicineTable").bootstrapTable('getSelections');
	  		if(row.length == 1) {
	  			var medicineNo = '';
	  			$.each(row, function() {
	  				medicineNo = this.medicineNo;
				});
		        $.ajax({
	        		url: "${pageContext.request.contextPath}/medicine/selectByMedicineNo",
	        		type: "post",
	        		data: "medicineNo="+medicineNo,    //如何拿到该行的medicineNo
	        		dataType: "json",
	        		async: true,
	        		success: function(data){
	        			$("input[name=medicineNo]").val(data.medicineNo);
	        			$("input[name=medicineName]").val(data.medicineName);
	        			$("input[name=medicinePrice]").val(data.medicinePrice);
	        			$("input[name=medicineAmount]").val(data.medicineAmount);
	        			$("input[name=medicineLastAddAccount]").val(data.medicineLastAddAccount);
	        			$("input[name=mNo]").val(data.medicineNo);
	        			$("input[name=mAmount]").val(data.medicineAmount);
	        	        //显示模态框
	        	        $("#myModal").modal("show");
	        		}
		        });
	  		}else {
	  			bootbox.alert({
	    			  size: "small",
	    			  message: "只能选择一种药品进行修改操作！",
	    		});
	  		}
	    }); 
	    
	    //删除按钮点击事件
	    $('#delete').click(function() {
	    	var rows = $("#medicineTable").bootstrapTable('getSelections');
	    	if (rows.length == 0) {
	    		bootbox.alert({
	    			  size: "small",
	    			  message: "请选择要删除的药品。",
	    		});
	    	} else {
		        bootbox.confirm({
	    			size: "small",
		        	message: "确认删除所选药品吗？",
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
		        		if (result) {
		    	    		var medicineNos = new Array();
		    	    		$.each(rows, function() {
		    	    			medicineNos.push(this.medicineNo);
		    				});
				        	$.ajax({
				        		url: "${pageContext.request.contextPath}/medicine/deleteMedicine",
				        		type: "post",
				        		data: "medicineNos=" + medicineNos.join(","),
				        		dataType: "json",
				        		async: true,
				        		success: function(data) {
				        			if (data.numOfSuccess == medicineNos.length)
				        	        	$('#medicineTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/medicine/queryMedicineList'});
				        			else {
				        				alert(data.tips);
				        			}
				        		},
								error : function() {
									bootbox.alert({
						    			size: "small",
							        	message: "删除出错"
									});
								}
				        	});
		        		}
		        	}
		        });
	    	}
	    });
 	});
	</script>
</head>
<body>
	<form class="form-inline" role="form" style="margin-top: 30px; margin-left: 30px">
		<div class="form-group">
			<label>药品名称:</label> <input type="text" class="form-control" id="name" name="name">
		</div>
		<input class="btn btn-default" id="reset_btn" value="重置" style="width: 60px;" type="button"></input>
		<input class="btn btn-default" id="search_btn" value="查询" style="width: 60px;" type="button"></input>
	</form>
	<div id="toolbar">
		<button id="edit" class="btn btn-primary">修改</button>
		<button id="delete" class="btn btn-danger">删除</button>
	</div>
	<table id="medicineTable" class="table table-hover table-striped"></table>
	
	<!-- 模态框 -->
   	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	        <h4 class="modal-title" id="myModalLabel">药品详情</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal" role="form" action="${pageContext.request.contextPath}/medicine/updateMedicine" method="post">
			  <input type="hidden" name="mNo" value="">
			  <input type="hidden" name="mAmount" value="">
			  <div class="form-group">
			    <label for="medicineNo" class="col-sm-2 control-label">药品编号:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="medicineNo" name="medicineNo" value="" readonly>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="medicineName" class="col-sm-2 control-label">药品名称:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="medicineName" name="medicineName" value="">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="medicinePrice" class="col-sm-2 control-label">药品价格:</label>
			    <div class="col-sm-10">
			      <input type="number" step="0.01" class="form-control" id="medicinePrice" name="medicinePrice" value="">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="medicineAmount" class="col-sm-2 control-label">药品剩余数量:</label>
			    <div class="col-sm-10">
			      <input type="number" class="form-control" id="medicineAmount" name="medicineAmount" value="" readonly>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="medicineLastAddAccount" class="col-sm-2 control-label">补充药品数量:</label>
			    <div class="col-sm-10">
			      <input type="number" class="form-control" id="medicineLastAddAccount" name="medicineLastAddAccount" value="">
			    </div>
			  </div>
			  <div class="modal-footer">
			      <input type="submit" class="btn btn-primary" value="保存"/>
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