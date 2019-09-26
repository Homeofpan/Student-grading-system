<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name=renderer content=webkit>
    <meta name="viewport" content="width=device-width" />
    <title>BootStrap Table使用</title>
    <script src="/js/jquery-3.3.1.min.js"></script>

    <script src="/js/bootstrap.min.js"></script>
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    
    <script src="/js/bootstrap-table.js"></script>
    <link href="/css/bootstrap-table.css" rel="stylesheet" />
    <script src="/js/bootstrap-table-zh-CN.js"></script>
    
    <script src="/js/tableExport.js"></script>
    <script src="/js/bootstrap-table-export.js"></script>
    <script src="/js/jquery.base64.js"></script>
    <script src="/js/layer/layer.js"></script>
</head>
<body>
	<div style="padding: 50px 60px 0px;">
		<form class="bs-example bs-example-form" role="form">
			<div class="input-group">
				<span class="input-group-addon">目标用户</span>
				 <input type="text" value="${username }" class="form-control" placeholder="Twitterhandle" id="user">
			</div>
		</form>
	</div>
	<br>
	<br>
	<br>
<%-- <div class="form-group">
    <label for="email" class="col-sm-2 control-label">所属角色</label>	
    <div class="col-sm-6">	
    	<!-- 样式2 -->
		<div class="btn-group dropdown" id="dropdown">
		  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    ${power } 
		    <span class="caret"></span>
		  </button>
		  <input type="hidden" name="hidedrop_1" id="hidedrop_1" value="${power }" />
		  <ul class="dropdown-menu">
		    <li><a href="#">超级管理员</a></li>
		  </ul>
		</div>
    </div>
    <div class="col-sm-4 tips"></div>
</div> --%>
<div class="page-header" style="padding: 0px;border: 0px;">
    <div class="form-horizontal">
        <div class="control-label col-lg-1">所属角色</div>
        <div class="col-lg-2">
            <select class="form-control" id="change">
                <option>${power }</option>
                <option>${power2 }</option>
            </select>
        </div>
    </div>
</div>
<br>
<br>
<br>

 <input type="button" value="保存" style="float:right;" id="save"/>


</body>
<script type="text/javascript">
	$(function(){
			$("#save").click(function(){
				var power ="";
				if($("#change option:selected").val() == "用户"){
					power = "0";
				}else{
					power ="1" ;
				}
				$.post("/edit",{
					username:$("#user").val(),
					power:power,
				},function(data){
					if(data.status == 200){
						layer.alert("修改成功");
					}else{
						layer.alert(data.msg);
					}
				});
			});
	});
	

</script>




</html>