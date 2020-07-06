<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.zjy.vo.ConfirmVo"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
	    $('#search_btn').click(function(){
	    	var medicineName = $("#medicineName").val();
	        $('#medicineTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/doctor/queryMedicine'});
	    })
 	});
 	</script>
</head>
<body>
	<div class="panel panel-default">
		<table class="table" border="0px">
			<tr>
				<td>
					<label for="patientNo" class="col-sm-4 control-label" style="margin-top: 5px">病人编号：</label>
				    <div class="col-sm-5">
				      <input type="text" class="form-control" id="patientNo" name="patientNo" value="${confirm.patientNo}" readonly/>
				    </div>
				</td>
				<td>
					<label for="" class="col-sm-4 control-label" style="margin-top: 5px">病人姓名：</label>
				    <div class="col-sm-5">
				      <input type="text" class="form-control" id="" name="" value="${confirm.patientName}" readonly/>
				    </div>
				</td>
				<td>
					<label for="" class="col-sm-4 control-label" style="margin-top: 5px">病人性别：</label>
				    <div class="col-sm-5">
				    	<%-- <c:if test="${confirm.patientSex }"></c:if> --%>
				      <input type="text" class="form-control" id="" name="" value="${confirm.patientSex==0?'女':'男'}" readonly/>
				    </div>
				</td>
			</tr>
			<tr>
				<td>
					<label for="registrationNo" class="col-sm-4 control-label" style="margin-top: 5px">预约编号：</label>
				    <div class="col-sm-5">
				      <input type="text" class="form-control" id="registrationNo" name="registrationNo" value="${confirm.registrationNo}" readonly/>
				    </div>
				</td>
				<td>
					<label for="" class="col-sm-4 control-label" style="margin-top: 5px">就诊科室：</label>
				    <div class="col-sm-5">
				      <input type="text" class="form-control" id="" name="" value="${confirm.departmentName}" readonly/>
				    </div>
				</td>
				<td>
					<label for="" class="col-sm-4 control-label" style="margin-top: 5px">医生姓名：</label>
				    <div class="col-sm-5">
				      <input type="text" class="form-control" id="" name="" value="${confirm.doctorName}" readonly/>
				    </div>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="panel panel-default">
		<table class="table" border="0px">
			<tr>
				<td align="center">
					<input type="button" value="就诊记录" onclick="queryRecord();" class="btn btn-default"/>
				</td>
				<td align="center">
					<input type="button" value="录入病例" onclick="writeDesc();" class="btn btn-default"/>
				</td>
				<td align="center">
					<input type="button" value="开药" onclick="queryMedicine();" class="btn btn-default"/>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="panel panel-default">
		<textarea rows="10" cols="225" id="write" style="resize:none;"></textarea>
	</div>
	
	<!-- 模态框 -->
   	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	        <h4 class="modal-title" id="myModalLabel">就诊记录</h4>
	      </div>
	      <div class="modal-body">
			<input class="hidden" id="registrationNo" value="">
			<table id="visitTable" class="table table-hover table-striped"></table>
		  </div>
		  <div class="modal-footer">
			<input type="reset" class="btn btn-default" data-dismiss="modal" value="OK" />
		  </div>
	    </div>
	  </div>
	</div>
	<!-- ending -->
	<!-- 模态框 -->
	<div class="modal fade" id="medicineModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">药品详情</h4>
				</div>
				<div class="modal-body">
					<input class="hidden" id="registrationNo" value="">
					<table id="prescriptionTable" class="table table-hover table-striped"></table>
				</div>
				<div class="modal-footer">
					<input type="reset" class="btn btn-default" data-dismiss="modal" value="OK" />
				</div>
			</div>
		</div>
	</div>
	<!-- ending -->
	
	<!-- 模态框 -->
   	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	        <h4 class="modal-title" id="myModalLabel">开药</h4>
	      </div>
	      <div class="modal-body">
	        <form id="addMedicineForm" class="form-horizontal" role="form">
			  <div class="form-group">
			    <label for="medicineName" class="col-sm-2 control-label">药品名称:</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="medicineName" name="medicineName" >
			    </div>
			    <div class="col-sm-2">
			      <input id="search_btn" type="button" class="btn btn-primary" value="搜索"/>
			    </div>
			  </div>
			</form>
			<table id="medicineTable" class="table table-hover table-striped"></table>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- ending -->
	<input id="hid" type="hidden" value="${confirm.registrationNo}"/>
	<script type="text/javascript">
		function line2br(text){
			  return text.split("\n").join("<br/>");
		}
		function queryMedicine(){
			var medicineName = $("#medicineName").val();
			$('#medicineTable').bootstrapTable({
		        method: 'post',//post避免中文乱码
		        contentType: "application/x-www-form-urlencoded",//必须要有！！！！
		        url:"${pageContext.request.contextPath}/doctor/queryMedicine",//要请求数据的文件路径
		        //height:tableHeight(),//高度调整
		        //toolbar: '#toolbar',//指定工具栏 
		        dataType: "json",
		        pageNumber: 1, //初始化加载第一页，默认第一页
		        pagination:true,//是否分页
		        queryParams:medicineParams,//请求服务器时所传的参数
		        sidePagination:'server',//指定服务器端分页
		        pageSize:10,//单页记录数
		        pageList:[5,10,20,30],//分页步进值
		        showRefresh:false,//刷新按钮
		        showColumns:false,
		        clickToSelect: false,//是否启用点击选中行
		        columns:[{
		        		title:'药品ID',
		        		field:'medicineNo',
		        		hidden:true
	        		},{
		                title:'药品名称',
		                field:'medicineName',
		                align:'center'
		            },{
		            	title:'药品数量',
		            	field:'medicineAmount',
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
		    function medicineParams(params){  
		        return {  
		                limit : this.limit, // 页面大小  
		                offset : this.offset, // 页码  
		                pageNumber : this.pageNumber,  
		                pageSize : this.pageSize,
		                medicineName: $("#medicineName").val()
		        } 
		    }  
	        $("#myModal2").modal("show");
		}

		
		function confirmFunction(value, row, index) {
               return [
                       '<button id="tableConfirm" onclick="add(\''+row.medicineNo+'\')" type="button" class="btn btn-default">添加</button>'
                       ].join("");
        }
		
		function queryRecord(){
			$('#visitTable').bootstrapTable({
		        method: 'post',//post避免中文乱码
		        contentType: "application/x-www-form-urlencoded",//必须要有！！！！
		        url:"${pageContext.request.contextPath}/visit/queryCasesList",//要请求数据的文件路径
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
		            	title:'病历详情',
		            	field:'diagnosticDescription',
		            	align:'center',
		                formatter: function (value, row, index) {
		                    return formatCase(value)
		                }
		            },{
		            	title:'开药详情',
		            	field:'registrationNo',
		            	align:'center',
		                formatter: function (value, row, index) {
		                    return formatMedicine(value)
		                }
		            }
		        ]
		    });

			$("#myModal").modal("show");
		  	//病历详情的格式化
	        function formatCase(value, row, index) {
	            var description = value;
	            return "<a href='#' onclick=\"showDescription('" + description + "')\">查看详情</a>";
	        }
		  	//开药详情的格式化
	        function formatMedicine(value, row, index) {
	            var no = value;
	            return "<a href='#' onclick=\"showMedicine('" + no + "')\">查看详情</a>";
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
		                patientNo: $('#patientNo').val(),
		                department: '',
		                beginDate: '',
		                endDate: '',
		        } 
		    }  
		}
		
		function writeDesc(){
			var write = $("#write").val();
			var registrationNo = $("#registrationNo").val();
    		$.ajax({
                url: "${pageContext.request.contextPath}/doctor/insertVisit",
				type : "POST",
				data : {
					registrationNo: $("#registrationNo").val(),
					write: line2br($("#write").val()),
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
		}
		

	</script>
	<script>
		function showDescription(description) {
	        bootbox.alert({
	        	message: description,
	        	title: '病历详情'
	        });
		}
		function showMedicine(no) {
		    $('#prescriptionTable').bootstrapTable({
		        method: 'post',//post避免中文乱码
		        contentType: "application/x-www-form-urlencoded",//必须要有！！！！
		        url:"${pageContext.request.contextPath}/prescription/queryPrescriptionList?registrationNo="+no,//要请求数据的文件路径
		        //height:tableHeight(),//高度调整
		        //toolbar: '#toolbar',//指定工具栏 
		        dataType: "json",
		        pageNumber: 1, //初始化加载第一页，默认第一页
		        //pagination:true,//是否分页
		        //queryParams:queryParams,//请求服务器时所传的参数
		        sidePagination:'server',//指定服务器端分页
		        pageSize:10,//单页记录数
		        pageList:[5,10,20,30],//分页步进值
		        showRefresh:false,//刷新按钮
		        showColumns:false,
		        clickToSelect: false,//是否启用点击选中行
		        columns:[{
		                title:'药品名',
		                field:'medicineName',
		                align:'center'
		            },{
		            	title:'药品数量',
		            	field:'medicineAmount',
		            	align:'center'
		            }
		        ]
		    });
	        $('#prescriptionTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/prescription/queryPrescriptionList?registrationNo='+no});
	        $("#medicineModal").modal("show");
	    }
	</script>
	<script type="text/javascript">
		var hid = $("#hid").val();
		function add(medicineNo){
			$.ajax({
				url: "${pageContext.request.contextPath}/consultationQuery/addMedicine",
        		type: "post",
        		data: {'registrationNo':hid,
        				'medicineNo':medicineNo},    //如何拿到该行的depNo
        		dataType: "json",
        		async: true,
        		success: function(data){
        			if(data.msg=="success"){
        				alert("添加成功！");
        		        $('#medicineTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/doctor/queryMedicine'});
        			}
        		}	
			});
		}
	</script>
</body>
</html>