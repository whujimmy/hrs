<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>根据科室统计预约数量</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
    <script type="text/javascript">
	    $(function() {
	    	$.ajax({
	            url: "/statistics/registrationAccountByDept",
	            dataType: "json",
	            success: function (data) {
	    	    	var deptName = new Array();
	    	    	var account = new Array();
	            	for (var i = 0; i<data.length; ++i) {
	            		account.push(data[i].account);
	            		deptName.push(data[i].departmentName);
	            	}
            		console.log(account);
            		console.log(deptName);
	    	        // 基于准备好的dom，初始化echarts实例
	    	        var myChart = echarts.init(document.getElementById('main'));
	    	
	    	        // 指定图表的配置项和数据
	    	        var option = {
	    	            title: {
	    	                text: '各科室预约挂号量'
	    	            },
	    	            tooltip: {},
	    	            legend: {},
	    	            xAxis: {
	    	                data: deptName,
	    	                axisLabel:{  
	    	                    interval: 0,
	    	                    rotate: -45
	    	                }
	    	            },
	    	            yAxis: {
	    	            	minInterval: 1,
	    	            	min: 0
	    	            },
	    	            series: [{
	    	                name: '预约量',
	    	                type: 'bar',
	    	                data: account
	    	            }]
	    	        };
	    	
	    	        // 使用刚指定的配置项和数据显示图表。
	    	        myChart.setOption(option);
	            }
	    	});
	    });
    </script>
</head>
<body>
    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
    <div id="main" style="height:400px;"></div>
</body>
</html>