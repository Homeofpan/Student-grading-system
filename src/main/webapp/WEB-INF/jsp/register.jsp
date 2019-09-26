<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta name=renderer content=webkit>
    <meta charset="UTF-8">
    <title>login</title>

    <script src="/js/jquery-3.3.1.min.js"></script>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/font-awesome.min.css" rel="stylesheet">
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/layer/layer.js"></script>
    <link rel="stylesheet" href="css/style.css">

</head>
<body>
    <div class="container">
        <div class="form row">
            <div class="form-horizontal col-md-offset-3" id="login_form">
                <h3 class="form-title">REGISTER</h3>
                <div class="col-md-9">
                	<form  method="post" id="formLogin">
                    <div class="form-group">
                        <i class="fa fa-user fa-lg"></i>
                        <input class="form-control required" type="text" placeholder="用户名" id="username" name="username" autofocus="autofocus" maxlength="20" value="${username }"/>
                    </div>
                    <div class="form-group">
                            <i class="fa fa-lock fa-lg"></i>
                            <input class="form-control required" type="password" placeholder="密码" id="password" name="password" maxlength="8"/>
                    </div>
                    <div class="form-group">
                            <i class="fa fa-lock fa-lg"></i>
                            <input class="form-control required" type="password" placeholder="确认密码" id="password2" name="password2" maxlength="8"/>
                    </div>
                    <div class="form-group col-md-offset-9">
                        	<button type="button" class="btn btn-success pull-right" name="submit" id="register">注册</button>
                        	<button type="button" class="btn btn-success pull-right" name="submit2" id="register2">注册并登录</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>

<script type="text/javascript">
	var REGISTER = {
			checkInput:function() {		
				//判断用户名是否为空
				if(!$("#username").val()) {
					layer.alert("用户名为空")
					return false;
				}
				//判断密码是否为空
				if(!$("#password").val()) {
					layer.alert("密码为空")
			        return false;
				}
				//判断确认密码是否为空
				if(!$("#password2").val()){
					layer.alert("输入的确认密码为空");
					return false;
				}
				
				//判断密码是否一致
				if(!($("#password").val() == $("#password2").val())){
					layer.alert("输入的密码不一致");
					return false;
				}
				return true;
			},
			
			//进行注册
			doRegister:function() {				
				$.post("/user/register", 
						{
							username:$("#username").val(),
							password:$("#password").val(),
						},function(data){
					if (data.status == 200) {
						layer.alert("注册成功,请联系管理员开通评分权限才可以开始评分");
						setTimeout(function(){
						$(location).attr("href","/admin");
						}, 3000);
					}else{
						alert("注册失败");
					}
				});
			},
			register:function() {
				if (this.checkInput()) {
					this.doRegister();
				}
			},
			
			checkName:function() {				
				$.post("/checkName", 
						{
							username:$("#username").val(),
						},function(data){
					if (data.status == 200) {
						layer.msg("用户名能使用");
					} else {
						layer.msg(data.msg);
					}
				});
			},	
			registerAndLogin:function() {		
				$.post("/user/register-login", 
						{
							username:$("#username").val(),
							password:$("#password").val(),
						},function(data){
					if (data.status == 200) {
						layer.msg("注册成功");
						if(data.data.power == "0"){
						//如果是学生
						   	layer.alert("注册成功,要想登陆请联系管理员开通评分权限",
				    			{
				    				btn:['确定'],
				    			},function(){
									$(location).attr("href","/admin");
				    			});
						}else{
						$(location).attr("href","/score/scoreSys");
						}
					}else{
						layer.msg(data.msg)
					}
				});
			},
	};
	$(function(){
		$("#register").click(function(){
			REGISTER.register();
		});
		$("#register2").click(function(){
			if(REGISTER.checkInput()){
			REGISTER.registerAndLogin();
			}
		});
		
		//失去焦点判断用户名是否已经存在
		$("#username").blur(function(){
			//如果用户输入的用户名不为空才进行判断
			if($("#username").val() != ""){
			REGISTER.checkName();
			}else{
				layer.msg("用户名不能为空");
			}
		});
	});
</script>
</html>
