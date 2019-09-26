<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name=renderer content=webkit>
    <meta name="viewport" content="width=device-width" />
    <title>工作记录添加</title>
    
    <!-- 1、Jquery组件引用 -->
    <script src="/js/jquery-3.3.1.min.js"></script>
    
	<!-- 2、bootstrap组件引用 -->
    <script src="/js/bootstrap.min.js"></script>
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    
    <!-- 3、bootstrap table组件以及中文包的引用 -->
    <link href="/css/bootstrap-table.css" rel="stylesheet" />
    <script src="/js/bootstrap-table.js"></script>
    <script src="/js/bootstrap-table-zh-CN.js"></script>
    
    <!-- 4、导出excle插件 -->
    <script src="/js/tableExport.js"></script>
    <script src="/js/bootstrap-table-export.js"></script>
    <script src="/js/jquery.base64.js"></script>
    
    <!-- 5、弹出框 -->
    <script src="/js/layer/layer.js"></script>
    
    <!-- 6、日历时间组件 -->
    <script src="/js/moment-with-locales.js"></script>
    <script src="/js/bootstrap-datetimepicker.js"></script>
    <script src="/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <link href="/css/bootstrap-datetimepicker.css" rel="stylesheet" />
</head>
<body>
	<div style="padding: 20px 60px 0px;">
		<form class="bs-example bs-example-form" role="form">
			<div class="input-group">
				<span class="input-group-addon">学生:</span>
				 <input type="text"  class="form-control" placeholder="" id="sname" />
			</div><br>
			
			<div class="input-group">
				<span class="input-group-addon">学号:</span>
				 <input type="text"  class="form-control" placeholder="" id="ssno" />
			</div><br>
			
			<div class="input-group">
				<!--指定 date标记-->
				<div class='input-group date' id='dateform'>
				<span class="input-group-addon">工作日期:</span>
					<input type='text' class="form-control" id="date" readonly="readonly"/> 
					<span class="input-group-addon"> 
						<span class="glyphicon glyphicon-calendar"></span>
					</span>
				</div>
			</div><br>
			<div class="input-group">
				<span class="input-group-addon">开始时间:</span>
				<div class='input-group date' id='shadowtime'>
				<input type="text" class="form-control" id="date2" readonly="readonly"/> 
				<span class="input-group-addon"> 
				    <span class="glyphicon glyphicon-calendar"></span>
				</span>
			</div>
			</div><br>
			
			<div class="input-group">
				<span class="input-group-addon">结束时间:</span>
				<div class='input-group date' id='shadowtime2'>
				<input type='text' class="form-control" id="date3" readonly="readonly"/> 
				<span class="input-group-addon"> 
					<span class="glyphicon glyphicon-calendar"></span>
				</span>
			</div>
			</div><br>
			<div class="input-group">
				<span class="input-group-addon">工作地点:</span>
				<select class="input-xlarge" style="min-width: 100px;height: 30px;" id="workname">
					<option>二楼</option>
					<option>三楼</option>
					<option>四楼</option>
				</select> 
			</div><br>
			<div class="input-group">
				<span class="input-group-addon">班次:</span>
				<select class="input-xlarge" style="min-width: 100px;height: 30px;" id="shifts5">
					<option>早班</option>
					<option>中班</option>
					<option>晚班</option>
				</select>
			</div>
			<div class="form-group" style="margin-top:15px">
                <div class="col-sm-9"  style="text-align:right;">
       				<a href="javascript:void(0)" id="add-record" class="btn btn-success pull-right">保存</a>
                </div><br><br>
            </div>
		</form>
	</div>

</body>
<script type="text/javascript">
	$(function() {
		//判断下拉框
		$('#dateform').datetimepicker({
			format : "yyyy-mm-dd",
			autoclose : true,
			todayBtn : true,
			language : 'zh-CN',
			pickerPosition : "bottom-left",
			minView : "month"
		});
		$('#shadowtime').datetimepicker({
			language : 'zh-CN',
			format : 'hh:ii',
			startView : 0,
			minView : 0,
			viewSelect : 0,
			pickDate : false,
			minuteStep : 10,
			autoclose : true,
		});
		$('#shadowtime2').datetimepicker({
			language : 'zh-CN',
			format : 'hh:ii',
			startView : 0,
			minView : 0,
			viewSelect : 0,
			pickDate : false,
			minuteStep : 10,
			pickerPosition : 'top-right',
			autoclose : true,
		});

	$("#add-record").click(function() {
			$.post("/add/Record", {
				stuname: $("#sname").val(),
				sno: $("#ssno").val(),
				date: $("#date").val(),
				start: $("#date2").val(),
				end: $("#date3").val(),
				shifts: $("#shifts5 option:selected").val(),
				workname: $("#workname option:selected").val(),
			}, function(data) {
				if (data.status == 200) {
					layer.msg("保存成功")
					setTimeout(function(){
						var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				        parent.layer.close(index); //再执行关闭
					}, 1000);
				} else {
					layer.msg(data.msg);
				}
			});
		}); 
	});
	
</script>




</html>