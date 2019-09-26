<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name=renderer content=webkit>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script src="/js/jquery-3.3.1.min.js"></script>
	<link href="/css/bootstrap.min.css" rel="stylesheet">
	<script src="/js/bootstrap.min.js"></script>
</head>


<h4>保存成功</h4>
<body>
<script type="text/javascript">
	setTimeout(function(){
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	        parent.layer.close(index); //再执行关闭
		}, 2000);
</script>
</body>
</html>