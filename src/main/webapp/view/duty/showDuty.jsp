<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>排班表</title>
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
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/icheck.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-select.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/moment-with-locales.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
 	<script type="text/javascript">
 	$(function() {
		//获取挂号列表
	    $('#DutyTable').bootstrapTable({
	        method: 'post',//post避免中文乱码
	        contentType: "application/x-www-form-urlencoded",//必须要有！！！！
	        url:"${pageContext.request.contextPath}/duty/queryDutyList",//要请求数据的文件路径
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
	                title:'医生',
	                field:'doctorName',
	                align:'center'
	            },{
	            	title:'周一',
	            	field:'monday',
	            	align:'center',
	                formatter: function (value, row, index) {
	                    return formatDuty(value)
	                }
	            },{
	                title:'周二',
	                field:'tuesday',
	                align:'center',
	                formatter: function (value, row, index) {
	                    return formatDuty(value)
	                }
	            },{
	            	title:'周三',
	            	field:'wednesday',
	            	align:'center',
	                formatter: function (value, row, index) {
	                    return formatDuty(value)
	                }
	            },{
	            	title:'周四',
	            	field:'thursday',
	            	align:'center',
	                formatter: function (value, row, index) {
	                    return formatDuty(value)
	                }
	            },{
	            	title:'周五',
	            	field:'friday',
	            	align:'center',
	                formatter: function (value, row, index) {
	                    return formatDuty(value)
	                }
	            },{
	            	title:'周六',
	            	field:'saturday',
	            	align:'center',
	                formatter: function (value, row, index) {
	                    return formatDuty(value)
	                }
	            },{
	            	title:'周日',
	            	field:'sunday',
	            	align:'center',
	                formatter: function (value, row, index) {
	                    return formatDuty(value)
	                }
	            },{
	            	title:'操作',
	                field:'doctorNo',
	                align:'center',
	                formatter: actionFormatter
	            }
	        ]
	    });
	  	//操作栏的格式化
        function actionFormatter(value, row, index) {
            var no = value;
            return "<a href='#' class='btn btn-info' onclick=\"editByNo('" + no + "')\" type='button'><span class='fa fa-pencil'></span></a>";
        }
		//状态格式化
	    function formatDuty(value) {
	    	if ("0" == value)
	    		return "-";
	    	else if ("1" == value)
	    		return "值班";
	    }
	    function queryParams(params){  
	        return {  
	                limit : this.limit, // 页面大小  
	                offset : this.offset, // 页码  
	                pageNumber : this.pageNumber,  
	                pageSize : this.pageSize,
	                doctorName: $('#doctorName').val()
	        } 
	    }  
	    //查询按钮事件
	    $('#search_btn').click(function(){
	        $('#DutyTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/duty/queryDutyList'});
	    })
	    $('#reset_btn').click(function() {
	    	$('#doctorName').val("");
	        $('#DutyTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/duty/queryDutyList'});
	    });
	    //tableHeight函数
	    function tableHeight(){
	        //可以根据自己页面情况进行调整
	        return $(window).height() -280;
	    }
	    $('#add').click(function() {
			//异步获取可是列表并动态填充select
			$.ajax({
	            url: "/doctor/selectDoctorNoDuty",
	            dataType: "json",
	            success: function (data) {
	            	if (data.length == 0) {
	                    $('#doctor').append("<option value=\"\">没有未排班医生</option>");
	                    $('#doctor').selectpicker('refresh');//必须要有
	            	}
	                for (var i = 0; i < data.length; i++) {
	                    $('#doctor').append("<option value=" + data[i].doctorNo + ">" + data[i].doctorName + "</option>");
	                    $('#doctor').selectpicker('refresh');//必须要有
	                }
	            }
	        });
	        $("#addModal").modal("show");
	    });
	    $('#save').click(function() {
	    	var dutyTime = new Array();
	    	$("input[name='ckbx1']:checked").each(function(i){
	    		dutyTime.push($(this).val());
	    	});
        	$.ajax({
        		url: "${pageContext.request.contextPath}/duty/addDuty",
        		type: "post",
        		data:{dutyTime:dutyTime.join(",") ,doctorNo:$(doctor).val()},
        		dataType: "json",
        		async: true,
        		success: function(data) {
        			if (data.status == false) {
    					bootbox.alert({
    		    			size: "small",
    			        	message: data.tips
    					});
        			}
        		},
				error : function() {
					bootbox.alert({
		    			size: "small",
			        	message: "添加出错"
					});
				}
        	});
	    });
	    $('#saveAlter').click(function() {
	    	var dutyTime = new Array();
	    	$("input[name='ckbx2']:checked").each(function(i){
	    		dutyTime.push($(this).val());
	    	});
        	$.ajax({
        		url: "${pageContext.request.contextPath}/duty/editDuty",
        		type: "post",
        		data:{dutyTime:dutyTime.join(",") ,doctorNo:$('#editForm #doctorNo').val()},
        		dataType: "json",
        		async: true,
        		success: function(data) {
        			if (data.status == false) {
    					bootbox.alert({
    		    			size: "small",
    			        	message: data.tips
    					});
        			}
        		},
				error : function() {
					bootbox.alert({
		    			size: "small",
			        	message: "修改出错"
					});
				}
        	});
	    });
 	});
	</script>
	<script>
	function editByNo(no) {
    	$.ajax({
    		url: "${pageContext.request.contextPath}/duty/selectDuty",
    		type: "get",
    		data:{doctorNo:no},
    		dataType: "json",
    		async: true,
    		success: function(data) {
    			var duty = new Array();
    			if (data.duty.monday == "1") {
    				duty.push("1");
    			}
    			if (data.duty.tuesday == "1") {
    				duty.push("2");
    			}
    			if (data.duty.wednesday == "1") {
    				duty.push("3");
    			}
    			if (data.duty.thursday == "1") {
    				duty.push("4");
    			}
    			if (data.duty.friday == "1") {
    				duty.push("5");
    			}
    			if (data.duty.saturday == "1") {
    				duty.push("6");
    			}
    			if (data.duty.sunday == "1") {
    				duty.push("7");
    			}
	            $("input[name='ckbx2']").each(function (i) {
	                for (var i = 0; i < duty.length; i++) {
	                    if ($(this).val() == duty[i]) {
	                    	$(this).iCheck('check');
	                    }
	                }
	            }); 
	            $('#editForm #doctorName').val(data.doctorName);
	            $('#editForm #doctorNo').val(no);
    		},
			error : function() {
				bootbox.alert({
	    			size: "small",
		        	message: "网络出错"
				});
			}
    	});
        $("#editModal").modal("show");
	}
	</script>
</head>
<body>
	<form class="form-inline" style="margin-top: 30px;">
		<div class="form-group">
			<label for="doctorName">医生：</label>
			<input id="doctorName" name="doctorName" class="form-control"></input>
		</div>
		<input class="btn btn-default" id="reset_btn" value="重置" style="width: 60px;" type="button"></input>
		<input class="btn btn-default" id="search_btn" value="查询" style="width: 60px;" type="button"></input>
	</form>
	<div id="toolbar">
		<input class="btn btn-success" id="add" value="添加" style="width: 60px;" type="button"></input>
	</div>
	<table id="DutyTable" class="table table-hover table-striped"></table>
	
	<!-- 模态框 -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加排班</h4>
				</div>
				<div class="modal-body">
					<form id="addForm" class="form-horizontal" role="form">
						<div class="form-group">
							<label for="doctor" class="col-sm-2 control-label">医生:</label>
							<select id="doctor" name="doctor" class="selectpicker" title="选择医生"></select>
						</div>
						<div style="margin-left:40px">
							<div class="checkbox-inline">
								<label>
									<input name="ckbx1" type="checkbox" value="1"> 周一
								</label>
							</div>
							<div class="checkbox-inline">
								<label>
									<input name="ckbx1" type="checkbox" value="2"> 周二
								</label>
							</div>
							<div class="checkbox-inline">
								<label>
									<input name="ckbx1" type="checkbox" value="3"> 周三
								</label>
							</div>
							<div class="checkbox-inline">
								<label>
									<input name="ckbx1" type="checkbox" value="4"> 周四
								</label>
							</div>
							<div class="checkbox-inline">
								<label>
									<input name="ckbx1" type="checkbox" value="5"> 周五
								</label>
							</div>
							<div class="checkbox-inline">
								<label>
									<input name="ckbx1" type="checkbox" value="6"> 周六
								</label>
							</div>
							<div class="checkbox-inline">
								<label>
									<input name="ckbx1" type="checkbox" value="7"> 周日
								</label>
							</div>
						</div>
						<div class="modal-footer">
							<input id="save" type="submit" class="btn btn-primary" value="保存" />
							<input type="reset" class="btn btn-default" data-dismiss="modal" value="取消" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- ending -->
	
	<!-- 模态框 -->
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改排班</h4>
				</div>
				<div class="modal-body">
					<form id="editForm" class="form-horizontal" role="form">
						<div class="form-group">
							<label for="doctorName" class="col-sm-2 control-label">医生:</label>
			    			<div class="col-sm-10">
			      				<input type="text" class="form-control" id="doctorName" name="doctorName" value="" readonly>
			      			</div>
						</div>
						<div class="form-group hidden">
							<label for="doctorNo" class="col-sm-2 control-label">医生编号:</label>
			    			<div class="col-sm-10">
			      				<input type="text" class="form-control" id="doctorNo" name="doctorNo" value="" readonly>
			      			</div>
						</div>
						<div style="margin-left:40px">
							<div class="checkbox-inline">
								<label>
									<input name="ckbx2" type="checkbox" value="1"> 周一
								</label>
							</div>
							<div class="checkbox-inline">
								<label>
									<input name="ckbx2" type="checkbox" value="2"> 周二
								</label>
							</div>
							<div class="checkbox-inline">
								<label>
									<input name="ckbx2" type="checkbox" value="3"> 周三
								</label>
							</div>
							<div class="checkbox-inline">
								<label>
									<input name="ckbx2" type="checkbox" value="4"> 周四
								</label>
							</div>
							<div class="checkbox-inline">
								<label>
									<input name="ckbx2" type="checkbox" value="5"> 周五
								</label>
							</div>
							<div class="checkbox-inline">
								<label>
									<input name="ckbx2" type="checkbox" value="6"> 周六
								</label>
							</div>
							<div class="checkbox-inline">
								<label>
									<input name="ckbx2" type="checkbox" value="7"> 周日
								</label>
							</div>
						</div>
						<div class="modal-footer">
							<input id="saveAlter" type="submit" class="btn btn-primary" value="保存" />
							<input type="reset" class="btn btn-default" data-dismiss="modal" value="取消" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- ending -->
</body>
</html>