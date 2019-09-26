<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name=renderer content=webkit>
    <meta name="viewport" content="width=device-width" />
    <title>工作记录编辑</title>
    <!-- 1、Jquery组件引用 -->
    <script src="/js/jquery-3.3.1.min.js"></script>
    
	<!-- 2、bootstrap组件引用 -->
    <script src="/js/bootstrap.min.js"></script>
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    
    <!-- 3、bootstrap table组件以及中文包的引用 -->
    <script src="/js/bootstrap-table.js"></script>
    <link href="/css/bootstrap-table.css" rel="stylesheet" />
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
    
    <!--文件上传控件  -->
    <!-- <link href="/css/fileinput.css" rel="stylesheet"> -->
    <link href="/bootstrap-fileinput/css/bootstrap-fileinput.css" rel="stylesheet">
	<!-- <script src="/js/fileinput.js"></script> -->
	<script src="/bootstrap-fileinput/js/bootstrap-fileinput.js"></script>
	
</head>
<body>
<div class="container">
    <div class="page-header">
        <form action="/student/updateStudent" method="post" id="uploadForm" enctype="multipart/form-data">
        <div class="row">
			<div class="form-group">
				<!-- =====================================第一列================================== -->
	            <div class="col-sm-4 "><!--  style="height: 400px" -->
	            
	                <div class="fileinput fileinput-new" data-provides="fileinput"  id="exampleInputUpload">
	                    <div class="fileinput-new thumbnail" style="width: 150px;height: auto;max-height:240px;">
	                        <img id='picImg' style="width: 100%;height: auto;max-width: 140px;max-height:200px;" src="${(student_image==null)?'/bootstrap-fileinput/images/noimage.png':student_image }" alt="" />
	                    </div>
	                    <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
	                </div>
	                
	            	<div class="form-group" style="margin-top:10px">
                        	<font size="3">&nbsp;&nbsp;&nbsp;<strong>学号：${mark.sno }</strong></font><br>
                    </div>
	            	<div class="form-group" style="margin-top:10px">
                        	<font size="3">&nbsp;&nbsp;&nbsp;<strong>姓名：${mark.stuname }</strong></font><br>
                    </div>
	            	<div class="form-group" style="margin-top:10px">
                        	<font size="3">&nbsp;&nbsp;&nbsp;<strong>日期：${date }</strong></font><br>
                    </div>
	            	<div class="form-group" style="margin-top:10px">
                        	<font size="3">&nbsp;&nbsp;&nbsp;<strong>班次：${mark.shifts }</strong></font><br>
                    </div>
                    
	        	</div>
	        	<input type="hidden" id="id" name="id" value="${mark.id }"/>
	        	<input type="hidden" id="preimage" name="preimage" value="${student.imageadr }"/>
	        	<input type="hidden" id="markStatus" name="markStatus" value="${mark.ifmark }"/>
	        	
	        	<!-- ==============================第二列================================== -->
	            <div class="col-sm-4"><!--  style="height: 500px;width: 450px" -->
					<div class="input-group" style="margin-top:20px">
						<span class="input-group-addon">评价:</span>
						<select class="input-xlarge" style="min-width: 100px; height: 28px;"id="mark1">
							<option value="10">优秀</option>
							<option value="5">良好</option>
							<option value="0">中等</option>
							<option value="-5">差</option>
							<option value="-10">很差</option>
						</select>
					</div>
					<div class="input-group" style="margin-top:20px">
						<span class="input-group-addon">评价:</span>
						 <select class="input-xlarge" style="min-width: 100px; height: 28px;"id="mark2">
							<option value="10">优秀</option>
							<option value="5">良好</option>
							<option value="0">中等</option>
							<option value="-5">差</option>
							<option value="-10">很差</option>
						</select>
					</div>
					<div class="input-group" style="margin-top:20px">
						<span class="input-group-addon">评价:</span>
						 <select class="input-xlarge" style="min-width: 100px; height: 28px;" id="mark3">
							<option value="10">优秀</option>
							<option value="5">良好</option>
							<option value="0">中等</option>
							<option value="-5">差</option>
							<option value="-10">很差</option>
						</select>
					</div>
					<div class="input-group" style="margin-top:20px">
						<span class="input-group-addon">评价:</span>
						 <select class="input-xlarge" style="min-width: 100px; height: 28px;"id="mark4">
							<option value="10">优秀</option>
							<option value="5">良好</option>
							<option value="0">中等</option>
							<option value="-5">差</option>
							<option value="-10">很差</option>
						</select>
					</div>
					<div class="input-group" style="margin-top:20px">
						<span class="input-group-addon">评价:</span> 
						<select class="input-xlarge" style="min-width: 100px; height: 28px;"id="mark5">
							<option value="10">优秀</option>
							<option value="5">良好</option>
							<option value="0">中等</option>
							<option value="-5">差</option>
							<option value="-10">很差</option>
						</select>
					</div>
					<div class="input-group" style="margin-top:20px">
						<font size="3"><strong>备注:</strong></font><br>
		        		<textarea id="tip" rows="5" cols="27" >${mark.tip }</textarea>
						<%-- 备注:<input type="text" id="tip" value="${mark.tip }" /> --%>
					</div>
					
					
	            </div>
	            
	            <!-- ===================================第三列==================================== -->
	            <div class="col-sm-4"><!--  style="height: 300px;width: 300px" -->
	            		
	            	<div class="input-group col-sm-7 pull-left" style="margin-top:20px">
							<span class="input-group-addon" ><font size="3"><strong>总分:</strong></font></span>
				 			<font size="3"><strong><input type="text"  class="form-control " id="total" style="text-align:right;" readonly="readonly" /></strong></font>
					</div><br><br><br><br><br>
				 		
					<font size="3"><strong>
						<div>评分规则:<br>
								基础分50,优秀+10,良好+5<br>
								中等不加分,差-5,很差-10
						</div>
	                    <br><br><br><br><br>
                    </strong></font><br><br>
					<div class="form-group" style="margin-top:15px">
		                <div class="col-sm-9"  style="text-align:right;">
		       				<a href="javascript:void(0)" id="save-mark" class="btn btn-success pull-right">保存评价</a>
		                </div><br><br>
		            </div>
	            </div>
        	</div>       
      	</div><!-- ======================row================================= -->
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
 	var MARK = {
 			//-------提交评分和修改
			save:function() {				
				$.post("/mark/doScore", 
						{
							score: $("#total").val(),
							tip: $("#tip").val(),
							id: $("#id").val(),
						},function(data){
					if (data.status == 200) {
						layer.msg("评分成功");
						setTimeout(function(){
							var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					        parent.layer.close(index); //再执行关闭
						}, 1000);
					} else {
						$(location).attr("href","/fail");					
					}
				});
			},
			
			//-----------------显示总分-------
			total:function() {				
				var a = $("#mark1 option:selected").val();
				var b = $("#mark2 option:selected").val();
				var c = $("#mark3 option:selected").val();
				var d = $("#mark4 option:selected").val();
				var e = $("#mark5 option:selected").val();
				$("#total").val(parseInt(a)+parseInt(b)+parseInt(c)+parseInt(d)+parseInt(e)+50);
			},
	}; 
	$(function(){
		
		//当修改为已评分状态
		if($("#markStatus").val() == "已评分"){
			layer.alert("你已评分,已帮你初始化评分");
		};
 		$("#save-mark").click(function(){
			MARK.save();
		});
 		MARK.total();
 		//---------------下拉框改变触发的事件----------
 		$("#mark1").change(function(){
 		MARK.total();
 		});
 		$("#mark2").change(function(){
 		MARK.total();
 		});
 		$("#mark3").change(function(){
 		MARK.total();
 		});
 		$("#mark4").change(function(){
 		MARK.total();
 		});
 		$("#mark5").change(function(){
 		MARK.total();
 		});
	});
</script>

</html>