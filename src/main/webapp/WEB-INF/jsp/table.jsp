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
    
    <script src="/js/edit/admin.js"></script>
    <script src="/js/tableExport.js"></script>
    <script src="/js/bootstrap-table-export.js"></script>
    <script src="/js/jquery.base64.js"></script>
    <script src="/js/layer/layer.js"></script>
</head>
<body>
    <div class="panel-body" style="padding-bottom:0px;">
        <div class="panel panel-default">
            <div class="panel-heading">学生</div>
            <div class="panel-body">
                <form id="formSearch" class="form-horizontal">
                    <div class="form-group" style="margin-top:15px">
                        <label class="control-label col-sm-1" for="txt_search_departmentname">用户名</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="username">
                        </div>
                        <div class="col-sm-4" style="text-align:left;">
                            <button type="button" style="margin-left:50px" id="select" class="btn btn-primary">查询</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>       

        <div id="toolbar" class="btn-group">
            <button id="edit" type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
            <button id="delete" type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
            </button>
        </div>
        <table id="tb_departments"></table>
    </div>
</body>
</html>