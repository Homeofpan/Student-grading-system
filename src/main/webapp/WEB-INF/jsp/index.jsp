<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta name=renderer content=webkit>
<meta charset="utf-8">
<title>学生信息绑定</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/css/build.min.18082018.css" rel="stylesheet" type="text/css" media="all">

   <!-- 1、Jquery组件引用 -->
    <script src="/js/jquery-3.3.1.min.js"></script>

	<!-- 2、bootstrap组件引用 -->
    <script src="/js/bootstrap.min.js"></script>
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
   
    <!-- 7、日历时间组件 -->
    <link href="/css/bootstrap-datetimepicker.css" rel="stylesheet" />
    <script src="/js/moment-with-locales.js"></script>
    <script src="/js/bootstrap-datetimepicker.js"></script>
    <script src="/js/bootstrap-datetimepicker.zh-CN.js"></script>
    
    <!-- 6、弹出框 -->
    <script src="/js/layer/layer.js"></script>
    
    <link href="/css/font-awesome.min.css" rel="stylesheet">
    


<script type="text/javascript" src="/js/layer/layer.js"></script>
</head>
<body>
	<div class="nav-container">
		<nav class="nav-1">
			<div class="container">
				<div class="row">
					<div class="col-xs-12">
						<a href="/" class="home-link">
							<!-- <img alt="IrAts" src="" class="logo"> -->
							<img alt="IrAts" class="logo">
						</a>
						<ul class="menu">
							<li><a href="">一</a></li>
							<li class="has-dropdown"><a href="#">二</a>
								<ul class="subnav">
									<li><a href="/docs/getting-started-guide">这个屌</a></li>
									<li><a href="/docs/user-guide">User Guide</a></li>
									<li><a href="/docs/industry-word2vec">Industry
											Word2Vec</a></li>
									<li><a href="/docs/api-reference">REST API</a></li>
								</ul>
							</li>
							<li><a href="">三</a></li>
							<li><a href="">四</a></li>
							<li><a href="">五</a></li>
						</ul>
						<ul class="social-links">
							<li><a href="" target="_blank">${user.username }</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="mobile-toggle">
				<div class="bar-1"></div>
				<div class="bar-2"></div>
			</div>
		</nav>
	</div>
	<div class="promo-1">
		<!-- <section class="promo-1"> -->
			<div class="promo-image-holder">
				<div class="background-image-holder fadeIn" style="background: url(&quot;/images/003.jpg&quot;) 50% 50%;">
					<img alt="Slide Background" src="/images/003.jpg" class="background-image" style="display: none;">
				</div>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1 text-center">
						<h1 class="text-white">来吧年轻人查询你的评分</h1>
					</div>
				</div>
			<div class="row">
					<div class="col-md-10 col-md-offset-1">
						<div class="col-sm-7 left-content">
							<div class="vertical-align" style="height: 90px;">
								分数:<input class="form-control" type="text" id="avgScore" name="avgScore" />
							<br>
							<br>
							<br>
							<!--日期  -->
									<label class="control-label col-sm-3" for="startTime">开始日期：</label>
								<div class="row">
									<div class="col-sm-5">
										<div class='input-group date' id='datetimepicker2'>
											<input type='text' class="form-control" id="startTime" readonly="readonly" /> <span class="input-group-addon">
												<span class="glyphicon glyphicon-calendar"></span>
											</span>
										</div>
									</div>
									<!-- <h4>请绑定您的学号与姓名</h4> -->
									<!-- <p class="lead">
									Create an Event<sup>n</sup> account and enjoy a free allocation<br>
									of compute time, every month.
								</p> -->
									<!-- 								<p class="lead">
									为了保护您的隐私<br>
									在第一次登录时需要绑定自己的学号信息<br>
								</p> -->
								</div>
								<label class="control-label col-sm-3" for="endTime">结束日期：</label>
								<div class="col-sm-5">
									<div class='input-group date' id='datetimepicker1'>
										<input type='text' class="form-control" id="endTime"  /> 
										<span class="input-group-addon">
											<span class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</div>
							</div>
							</div>
						<div class="col-sm-5 right-content">
							<div class="vertical-align">
								<h4><span class="sub">请输入您的学号姓名</span></h4>
								<div class="col-sm-3"></div>
								<div class="col-sm-6">
									<form method="post">
				                        <input class="form-control required" type="text" placeholder="学号" id="sno" name="sno" maxlength="11"/>
				                        <br>
				                    	<input class="form-control required" type="text" placeholder="姓名" id="truename" name="truename" maxlength="16"/>
				                    	<br>
				                    </form>
			                    </div>
								<a href="javascript:void(0)" id="select" target="_blank" class="btn btn-white">查询</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		<!-- </section> -->
	</div>
	<input type="hidden" id="uid" name="uid" value="${user.id }"/>
</body>
<script type="text/javascript">

var SELECT = {
		checkInput:function() {
			var sno = $("#sno").val();
			if(!$("#sno").val()) {
				layer.msg("请输入学号");
				return false;
			}
			if(!$("#truename").val()) {
				layer.msg("请输入姓名");
				return false;
			}
			var ret = /^1\d{10}$/;
			if(!ret.test(sno)){
				layer.alert("学号格式错误!")
				return false;
			}
			return true;
		},
		doSelect:function() {
			
			$.post("/selectMark/sno", 
					{
						sno:$("#sno").val(),
						trueName:$("#truename").val(),
						startTime:$("#startTime").val(),
						endTime:$("#endTime").val(),
					},
					function(data){	//e3Result
						if (data.status == 200) {
							layer.msg("查询成功,结果在左侧框中");
							$("#avgScore").val(data.data.average);
						}else {
							layer.alert(data.msg);
							$("#avgScore").val("");
						}
					});
		},
		selecting:function() {
			if (this.checkInput()) {
				this.doSelect();
			}
		}
	
};
//入口----------------------------------------------------------------------------------------------------------
$(function(){
	//初始化时间组件
		//初始化时间选择
    //初始化时间选择
    $("#datetimepicker2").datetimepicker({
    	format: "yyyy-mm-dd",
    	autoclose: true,
    	todayBtn: true,
    	language:'zh-CN',
    	pickerPosition:"bottom-right",
    	minView: "month"
    });
    $("#datetimepicker1").datetimepicker({
            format: "yyyy-mm-dd",
            autoclose: true,
            todayBtn: true,
            language:'zh-CN',
            pickerPosition:"bottom-left",
            minView: "month"
    });
    
	
	
	//绑定
	$("#select").click(function(){
		SELECT.selecting();
	});
	
});

</script>




</html>
