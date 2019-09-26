<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name=renderer content=webkit>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
                <h3 class="form-title">更改密码</h3>
                <div class="col-md-9">
                	<form method="post">
	                    <div class="form-group">
	                        <i class="fa fa-user fa-lg"></i>
	                        <input class="form-control required" type="password" placeholder="原密码" id="oldpassword" name="oldpassword" autofocus="autofocus" maxlength="20">
	                    </div>
	                    <div class="form-group">
	                            <i class="fa fa-lock fa-lg"></i>
	                            <input class="form-control required" type="password" placeholder="新密码" id="newpassword" name="newpassword" maxlength="8"/>
	                    </div>
	                    <div class="form-group">
	                            <i class="fa fa-lock fa-lg"></i>
	                            <input class="form-control required" type="password" placeholder="确认密码" id="passwordagain" name="passwordagain" maxlength="8"/>
	                    </div>
	                    <div class="form-group col-md-offset-9">
	                    	<a href="javascript:void(0)" id="changePassword" class="btn btn-success pull-right">确认更改</a>
	                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
//注册---------------------------------------------------------------------------------------------------------
var CHANGEPASSWORD = {
		checkInput:function() {
			
			if(!$("#oldpassword").val()) {
				layer.msg("请输入原密码");
				return false;
			}
			if(!$("#newpassword").val()) {
				layer.msg("请输入新密码");
				return false;
			}
			if(!$("#passwordagain").val()) {
				layer.msg("请确认密码");
				return false;
			}
			if($("#newpassword").val() != $("#passwordagain").val()){
				layer.msg("两次输入密码不一致");
				return false;
			}
			return true;
		},
		doChange:function() {
			
			$.post("/user/changePassword", 
					{
					oldpassword:$("#oldpassword").val(),
					newpassword:$("#newpassword").val()
					},
					function(data){	//e3Result
						if (data.status == 200) {
							layer.msg("修改成功")
							$("#oldpassword").val("")
							$("#newpassword").val("")
							$("#passwordagain").val("")
						} else {
							layer.alert("修改失败:" + data.msg);
						}
					});
		},
		change:function() {
			if (this.checkInput()) {
				this.doChange();
			}
		}
	
};
//入口----------------------------------------------------------------------------------------------------------
$(function(){
	//注册
	$("#changePassword").click(function(){
		CHANGEPASSWORD.change();
	});
	
});

</script>
</html>