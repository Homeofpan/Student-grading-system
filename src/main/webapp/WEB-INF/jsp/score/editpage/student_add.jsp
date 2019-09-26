<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta name=renderer content=webkit>
<meta charset="utf-8">
    <title>新增学生</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/bootstrap-fileinput/css/bootstrap-fileinput.css" rel="stylesheet">
	<script src="/js/jquery-3.3.1.min.js"></script>
	<script src="/bootstrap-fileinput/js/bootstrap-fileinput.js"></script>
	<!--layer控件  -->
	<script src="/js/layer/layer.js"></script>
</head>
<body>
<div class="container">
    <div class="page-header">
        <form action="/student/addStudent" method="post" id="uploadForm" enctype="multipart/form-data">
        <div class="row">
			<div class="form-group">
	            <div class="col-sm-4">
	                <div class="h4">图片预览</div>
	                <div class="fileinput fileinput-new" data-provides="fileinput"  id="exampleInputUpload">
	                    <div class="fileinput-new thumbnail" style="width: 150px;height: auto;max-height:200px;">
	                        <img id='picImg' style="width: 100%;height: auto;max-width: 140px;" src="/bootstrap-fileinput/images/noimage.png" alt="" />
	                        	图片不得大于<font color="red">3M</font>
	                    </div>
	                    <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
	                    <div>
	                        <span class="btn btn-primary btn-file">
	                            <span class="fileinput-new">选择图片</span>
	                            <span class="fileinput-exists">换一张</span>
	                            <input type="file" name="img" id="img" accept="image/gif,image/jpeg,image/x-png"/>
	                        </span>
	                        <a href="javascript:;" class="btn btn-warning fileinput-exists" data-dismiss="fileinput">移除</a>
	                    </div>
	                </div>
	        	</div>
	        	<input type="hidden" id="id" name="id" value="${student.id }"/>
	            <div class="col-sm-8">
	            	<div class="form-group" style="margin-top:15px">
                        <label  class="control-label col-sm-2 col-md-1" for="sno">学号:</label>
                        <div class="col-sm-7">
                            <input id="sno" name="sno" type="text" class="form-control" placeholder="学号""/>
                        </div><br><br>
                    </div>
	            	<div class="form-group" style="margin-top:15px">
                        <label  class="control-label col-sm-2 col-md-1" for="name">姓名:</label>
                        <div class="col-sm-7">
                            <input id="name" name="name" type="text" class="form-control" placeholder="姓名""/>
                        </div><br><br>
                    </div>
	            	<div class="form-group" style="margin-top:15px">
                        <label  class="control-label col-sm-2 col-md-1" for="academy">学院:</label>
                        <div class="col-sm-7">
                            <input id="academy" name="academy" type="text" class="form-control" placeholder="学院""/>
                        </div><br><br>
                    </div>
	            	<div class="form-group" style="margin-top:15px">
                        <label  class="control-label col-sm-2 col-md-1" for="grade">班级:</label>
                        <div class="col-sm-7">
                            <input id="grade" name="grade" type="text" class="form-control" placeholder="班级""/>
                        </div><br><br>
                    </div>
	            	<div class="form-group" style="margin-top:15px">
                        <label  class="control-label col-sm-2 col-md-1" for="phone">手机:</label>
                        <div class="col-sm-7">
                            <input id="phone" name="phone" type="text" class="form-control" placeholder="手机号码""/>
                        </div><br><br>
                    </div>
	                        <label  class="control-label col-sm-2" for="sex">性别:</label>
	                        <div class="col-sm-3">
	                            <select class="input-xlarge" style="min-width: 100px;height: 30px;" id="sex" name="sex">
	                            	<option>女</option>
	                            	<option>男</option>
								</select> 
	                        </div>
	            	<div class="form-group" style="margin-top:15px">
                        <div class="col-sm-9"  style="text-align:right;">
			            	<input type="submit" id="uploadSubmit" class="btn btn-info" value="保存"/>
                        </div><br><br>
                    </div>
                    
	            </div>
        	</div>       
      	</div>
        </form>
    </div>
</div>
</body>
<script type="text/javascript">

	$(function(){
	var flag= false;
	var flag2 = false;
	$("#uploadSubmit").click(function(){
    //判断表单中的字段是否为空,若为空,不提交表单
		//判断姓名是否为空
		if($("#name").val() == ""){
			layer.msg("除图片外其他信息不能为空");
			return false;
		}
		//判断学号是否为空
		if($("#sno").val() == ""){
			layer.msg("除图片外其他信息不能为空");
			return false;
		}
		//判断学院是否为空
		if($("#academy").val() == ""){
			layer.msg("除图片外其他信息不能为空");
			return false;
		}
		//判断班级是否为空
		if($("#grade").val() == ""){
			layer.msg("除图片外其他信息不能为空");
			return false;
		}
		//判断手机号码是否为空
		if($("#phone").val() != ""){
			//判断手机号是否符合格式
			var phone = $("#phone").val();
			var re = /^1\d{10}$/;
			if(!re.test(phone)){
				layer.msg("手机号码格式为11为数字");
				return false;
			}
		}
		
		//判断性别
		if($("#sex").val() == ""){
			layer.msg("除图片外其他信息不能为空");
			return false;
		}
		
		if(flag2 == false){
			layer.msg("格式错误,学号为11位");
			return flag2;
		}
		
		//判断flag的值进行表单提交
		if(flag == false){
			layer.msg("该学号对应的学生已存在");
			return flag;
		}
		
	});
	
	//失去焦点判断学号
	
	$("#sno").blur(function(){
		//判断学号格式是否正确
		var sno =$("#sno").val();
		var ret = /^1\d{10}$/;
		if(ret.test(sno)){
		//正确则进行验证学号是否存在	
		flag2 = true;
		$.post('/check/sno',{
			sno: $("#sno").val(),
		},function(data){
			if(data.status == 200){
				layer.msg("该学号对应的学生不存在");
				flag = true;
			}else{
				layer.msg("该学号对应的学生已存在");
				flag = false;
			}
		});
		}else{
			layer.msg("格式错误,学号为11位");
			flag =false;
			flag2 = false;
		}
	});
	
	
	});
	
	

</script>
</html>