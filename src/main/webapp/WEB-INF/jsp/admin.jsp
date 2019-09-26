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
    <link rel="stylesheet" href="/css/style.css">
	
</head>
<body>
    <div class="container">
        <div class="form row">
            <div class="form-horizontal col-md-offset-3" id="login_form">
                <h3 class="form-title">LOGIN</h3>
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
							<label class="checkbox"> 
							<input type="checkbox" name="remember" value="1" id="remeber"/>记住我
							</label>
						</div>
                    <div class="form-group col-md-offset-9">
                        	<button type="button" class="btn btn-success pull-right" name="submit" id="register">注册</button>
                        	<button type="button" class="btn btn-success pull-right" name="submit" id="login_1">登录</button>
                    </div>
                    <div>
                    	<input type="text" class="vcode" id="code" placeholder="请输入验证码"/>
                    	<img src="/checkCode" alt="" width="100" height="32" class="passcode" style="height:43px;cursor:pointer;" onclick="this.src=this.src+'?'">
                    </div>
					</form>
                </div>
            </div>
        </div>
    </div>
</body>

<script type="text/javascript">
	var LOGIN = {
			checkInput:function() {		
				//判断用户名是否为空
				if(!$("#username").val()) {
					layer.alert("用户名为空")
					return false;
				}
				if(!$("#password").val()) {
					layer.alert("密码为空")
			        return false;
				}
				if(!$("#code").val()) {
					layer.alert("验证码为空")
			        return false;
				}
				return true;
			},
			doLogin:function(flag) {		
				var flag = false;
				if($("#remeber").prop("checked"))
					{
						flag = true;
					}else{
						flag = false;
					}
				$.post("/user/login", 
						{
							username:$("#username").val(),
							password:$("#password").val(),
							flag: flag,
							code: $("#code").val(),
						},function(data){
					if (data.status == 200) {
						//判断用户的身份
						if(data.data.power == "0"){
							//如果是学生
							layer.alert("请联系管理员开通评分权限");
						}else{
						$(location).attr("href","/score/scoreSys");
						}
					} else {
						layer.alert("登录失败 :" + data.msg);						
					}
				});
			},
			login:function() {
				if (this.checkInput()) {
					this.doLogin();
				}
			}
		
	};
	$(function(){
		$("#login_1").click(function(){
			LOGIN.login();
		});
		$("#register").click(function(){
			$(location).attr("href","/register");
		});
		
/* 		$("#username").blur(function(){
			var mima = $.cookie("admin");
			alert(mima);
		}); */
		
	});
</script>
</html>
