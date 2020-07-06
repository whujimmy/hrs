<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>医生列表</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/beyond.css" />
	<link href="${pageContext.request.contextPath}/css/bootstrap-table.min.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap-select.min.css" />
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table.min.js"></script>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.min.js"></script>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootbox.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/moment-with-locales.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-select.min.js"></script>
 	
 	<script type="text/javascript">
 	$(function() {
 		$.ajax({
            url: "${pageContext.request.contextPath}/department/loadDepartment",
            type:"post",
            dataType: "json",
            success: function (data) {
            	$('#depNo').append("<option value=\"\">请选择</option>");
                for (var i = 0; i < data.length; i++) {
                    $('#depNo').append("<option value=" + data[i].departmentNo + ">" + data[i].departmentName + "</option>");
                    $('#depNo').selectpicker('refresh');//必须要有
                }
            }
        });
 		/* $.ajax({
            url: "${pageContext.request.contextPath}/department/loadDepartment",
            type:"post",
            dataType: "json",
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    $('#doctorDepartmentNo').append("<option value=" + data[i].departmentNo + ">" + data[i].departmentName + "</option>");
                    $('#doctorDepartmentNo').selectpicker('refresh');//必须要有
                }
            }
        }); */
 		
		//获取科室列表
	    $('#mytab').bootstrapTable({
	        method: 'post',//post避免中文乱码
	        contentType: "application/x-www-form-urlencoded",//必须要有！！！！
	        url:"${pageContext.request.contextPath}/admin/queryDoctorList",//要请求数据的文件路径
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
	                title:'医生编号',
	                field:'doctorNo',
	                align:'center'
	            },{
	                title:'医生姓名',
	                field:'doctorName',
	                align:'center'
	            },{
	                title:'所属部门',
	                field:'departmentName',
	                align:'center'
	            },{
	                title:'医生性别',
	                field:'doctorSex',
	                align:'center',
	                formatter:function(value,row,index){
	                	var str = ''; 
	                	if(row.doctorSex==1){
	                		str = '男';
	                	}else if(row.doctorSex==0){
	                		str = '女';
	                	}
	                	return str
	                }
	            },{
	                title:'出生日期',
	                field:'doctorBirth',
	                align:'center',
	                formatter:function(value,row,index){
	                	return timestampToTime(value)
	                }
	            },{
	                title:'电话号码',
	                field:'doctorPhone',
	                align:'center'
	            },{
	                title:'挂号费用',
	                field:'doctorRegistrationFee',
	                align:'center'
	            },{
	                title:'入职日期',
	                field:'doctorHireTime',
	                align:'center',
	                formatter:function(value,row,index){
	                	return timestampToTime(value)
	                }
	            }
	        ]
	    })
	    
	    function queryParams(params){  
	        return {  
	                limit : this.limit, // 页面大小  
	                offset : this.offset, // 页码  
	                pageNumber : this.pageNumber,  
	                pageSize : this.pageSize,
	                name: $('#name').val(),
	                depNo: $('#depNo').val(),
	                status: $('#status').val(),
	                startTime: $('#startTime').val(),
	                endTime: $('#endTime').val()
	        } 
	    }  
	    //查询按钮事件
	    $('#search_btn').click(function(){
	        $('#mytab').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/admin/queryDoctorList'});
	    })
	    $('#reset_btn').click(function() {
	    	$('#name').val("");
	    	$('#depNo').val("");
	    	$('#status').val("1");
	    	$('#startTime').val("");
	    	$('#endTime').val("");
            $('#status').selectpicker('refresh');//必须要有
	        $('#mytab').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/admin/queryDoctorList'});
	    });
	    //tableHeight函数
	    function tableHeight(){
	        //可以根据自己页面情况进行调整
	        return $(window).height() -280;
	    }
	    
	    //行内编辑配置
	    $('#edit').click(function() {
	        var row = $("#mytab").bootstrapTable('getSelections');
	  		if(row.length == 1) {
	  			var doctorNo = '';
	  			$.each(row, function() {
	  				doctorNo = this.doctorNo;
				});
		        $.ajax({
	        		url: "${pageContext.request.contextPath}/admin/selectByDoctorNo",
	        		type: "post",
	        		data: "doctorNo="+doctorNo,    //如何拿到该行的depNo
	        		dataType: "json",
	        		async: true,
	        		success: function(data){
	        			$("input[name=doctorNo]").val(data.doctorNo);
	        			$("input[name=doctorName]").val(data.doctorName);
	        			$("#doctorSex").val(data.doctorSex);
	        			$('#doctorSex').selectpicker('refresh');
	        			$("input[name=birth]").val(timestampToTime(data.doctorBirth));
	        			$("input[name=doctorPhone]").val(data.doctorPhone);
	        			$("#doctorDepartmentNo").val(data.doctorDepartmentNo);
	        			$("#doctorDepartmentNo").selectpicker('refresh');
	        			$("input[name=doctorRegistrationFee]").val(data.doctorRegistrationFee);
	        	        //显示模态框
	        	        $("#myModal").modal("show");
	        		}
		        });
	  		}else {
	  			bootbox.alert({
	    			  size: "small",
	    			  message: "只能选择一个医生进行修改操作！",
	    		});
	  		}
	    }); 
	    
	    function timestampToTime(timestamp) {
	        var date = new Date(timestamp);
	        Y = date.getFullYear() + '-';
	        M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
	        D = (date.getDate()<10? '0'+date.getDate(): date.getDate()) + ' ';
	        return Y+M+D;
	    }
	    
	    //删除按钮点击事件
	    $('#delete').click(function() {
	    	var rows = $("#mytab").bootstrapTable('getSelections');
	    	if (rows.length == 0) {
	    		bootbox.alert({
	    			  size: "small",
	    			  message: "请选择要离职的医生！",
	    		});
	    	} else {
		        bootbox.confirm({
	    			size: "small",
		        	message: "确认该医生离职？",
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
		    	    		var doctorNos = new Array();
		    	    		$.each(rows, function() {
		    	    			doctorNos.push(this.doctorNo);
		    				});
//		     				alert(departmentIds.toString());
				        	$.ajax({
				        		url: "${pageContext.request.contextPath}/admin/deleteDoctor",
				        		type: "post",
				        		data: "doctorNos=" + doctorNos.join(","),
				        		dataType: "json",
				        		async: true,
				        		success: function(data) {
				        			if (data.numOfSuccess == doctorNos.length)
				        	        	$('#mytab').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/admin/queryDoctorList'});
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
							        	message: "离职出错"
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
	    <label>姓名:</label>
	    <input type="text" class="form-control" id="name" name="name" style="width:120px">
	  </div>
	  <div class="form-group">
	    <label>科室:</label>
	    <select class="selectpicker" name="depNo" id="depNo" title="请选择"></select>
	  </div>
	  <div class="form-group">
	    <label>状态:</label>
	    <select class="selectpicker" name="status" id="status">
	    	<option value="1" selected="selected">在职</option>
	    	<option value="0">离职</option>
	    </select>
	  </div>
	  <div class="form-group">
	    <label>入职时间:</label>
 	    <!-- <input type="date" class="form-control" id="startTime" name="startTime"> -->
		<div class='input-group date' id='startTimepicker'>
			<input type="text" class="form-control" id="startTime"name="startTime" style="width:150px">
			<span class="input-group-addon"> <span class="fa fa-calendar"></span></span>
		</div>
	  </div>
	  <label>-</label>
	  <div class="form-group">
 	    <!-- <input type="date" class="form-control" id="endTime" name="endTime"> -->
		<div class='input-group date' id='endTimepicker'>
			<input type="text" class="form-control" id="endTime"name="endTime" style="width:150px">
			<span class="input-group-addon"> <span class="fa fa-calendar"></span></span>
		</div>
	  </div>
		<input class="btn btn-default" id="reset_btn" value="重置" style="width: 60px;" type="button"></input>
	  <input class="btn btn-default" id="search_btn" value="查询" type="button" style="width: 60px;"></input>
	</form>
	<div id="toolbar">
		<button id="edit" class="btn btn-primary">修改</button>
		<button id="delete" class="btn btn-danger">离职</button>
	</div>
	<table id="mytab" class="table table-hover table-striped"></table>

	
  
	<!-- 模态框 -->
   	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	        <h4 class="modal-title" id="myModalLabel">医生个人信息</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal" role="form" action="${pageContext.request.contextPath}/admin/updateDoctor" method="post">
			  <div class="form-group">
			    <label for="doctorNo" class="col-sm-2 control-label">医生编号:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="doctorNo" name="doctorNo" value="" readonly>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="doctorName" class="col-sm-2 control-label">医生姓名:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="doctorName" name="doctorName" value="">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="doctorSex" class="col-sm-2 control-label">医生性别:</label>
			    <div class="col-sm-10">
			    	<select id="doctorSex" name="doctorSex" class="selectpicker">
			    		<option value="1">男</option>
			    		<option value="0">女</option>
			    	</select>
<!-- 			      <input type="text" class="form-control" id="doctorSex" name="doctorSex" value=""> -->
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="birth" class="col-sm-2 control-label">出生日期:</label>
			    <div class="col-sm-10">
					<div class='input-group date' id='datetimepicker'>
						<input type="text" class="form-control" id="birth" name="birth" value="">
						<span class="input-group-addon"> <span class="fa fa-calendar"></span></span>
					</div>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="doctorPhone" class="col-sm-2 control-label">电话号码:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="doctorPhone" name="doctorPhone" value="">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="doctorDepartmentNo" class="col-sm-2 control-label">所属部门:</label>
			    <div class="col-sm-10">
					<select id="doctorDepartmentNo" name="doctorDepartmentNo" class="selectpicker" title="请选择"></select>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="doctorRegistrationFee" class="col-sm-2 control-label">挂号费用:</label>
			    <div class="col-sm-10">
			      <input type="number" class="form-control" id="doctorRegistrationFee" name="doctorRegistrationFee" value="">
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
	
	<script type="text/javascript">
	    $(function () {
	        $('#startTimepicker,#endTimepicker').datetimepicker({
	            format: 'yyyy-mm-dd',//日期格式化，只显示日期
	            language: 'zh-CN',      //中文化
	            endDate: new Date(),
	            todayBtn: "linked",
	            autoclose: true,
	            minView: 'month'
	        });
	    }); 
	    $(function () {
	        $('#datetimepicker').datetimepicker({
	            format: 'yyyy-mm-dd',//日期格式化，只显示日期
	            language: 'zh-CN',      //中文化
	            endDate: new Date(),
	            todayBtn: "linked",
	            autoclose: true,
	            startView: 'decade',
	            minView: 'month'
	        });
	    });
	</script>
</body>
</html>