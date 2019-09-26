<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name=renderer content=webkit>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>密码修改</title>
	<link href="/css/font-awesome.min.css" rel="stylesheet">
	<!-- <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"> -->
	<link href="/css/bootstrap.min.css" rel="stylesheet">
	<link href="/css/password_edit.css" rel="stylesheet">
	<script src="/js/jquery-3.3.1.min.js"></script>
	<script src="/js/bootstrap.min.js"></script>
    <!-- 、弹出框 -->
	<script type="text/javascript" src="/js/layer/layer.js"></script>
</head>
<body>
<div class="container">
        <div class="form row">
            <div class="form-horizontal col-md-offset-3" id="login_form">
                <h3 class="form-title">修改用户名</h3>
                <div class="col-md-9">
                	<form method="post">
	                    <div class="form-group">
	                        <i class="fa fa-user fa-lg"></i>
	                        <input class="form-control required" type="text" placeholder="新用户名" id="newusername" name="newusername" maxlength="20">
	                    </div>
	                    <div class="form-group">
	                            <i class="fa fa-lock fa-lg"></i>
	                            <input class="form-control required" type="password" placeholder="原密码" id="password" name="password" maxlength="16"/>
	                    </div>
	                    <div class="form-group col-md-offset-9">
	                    	<a href="javascript:void(0)" id="changeUsername" class="btn btn-success pull-right">确认更改</a>
	                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
//修改用户名-----------------------------------------------------------------------------------------
	var CHANGE = {
			checkInput:function() {		
				//判断用户名是否为空
				if(!$("#newusername").val()) {
					layer.alert("用户名为空")
					return false;
				}
				if(!$("#password").val()) {
					layer.alert("密码为空")
			        return false;
				}
				return true;
			},
			doChange:function() {		
				$.post("/user/change", 
						{
							newusername:$("#newusername").val(),
							password:$("#password").val(),
						},function(data){
					if (data.status == 200) {
						layer.alert("修改成功,请重新登陆",
				    			{
				    				btn:['确定'],
				    			},function(){
				    				
				    				//刷新父页面
				    				window.parent.location.href="/score/scoreSys";
				    	});
					} else {
						layer.alert("修改失败 :" + data.msg);						
					}
				});
			},
			change:function() {
				if (this.checkInput()) {
					this.doChange();
				}
			}
		
	};
	
	//---------------------------入口函数---------------------
	$(function(){
		$("#changeUsername").click(function(){
			CHANGE.change();
		});
		
		
		//失去焦点判断注册的用户名是否存在
		$("#newusername").blur(function(){
			if($("#newusername").val() != ""){
			
			//发送异常请求,判断该用户名是否已经存在
			$.post('/checknew/user',{
				newusername: $("#newusername").val(),
			},function(data){
				if(data.status == 200){
					layer.msg("用户不存在,可以使用")
				}else{
					layer.msg("该用户名已存在,请更换");
				}
			});
			}else{
				layer.msg("请输入用户名")
			}
		});

	});


</script>
</html>