<!doctype html>
<html>
    <head>
	<meta charset="gbk" />
        <title>获取服务器信息</title>
    </head>
    <body>
<?php 
    $sysos = $_SERVER["SERVER_SOFTWARE"];
    $sysversion = PHP_VERSION;

    mysql_connect("127.0.0.1", "root", "4470758");
    $mysqlinfo = mysql_get_server_info();

    if(function_exists("gd-info")){
	    $gd = gd_info();
	    $gdinfo = $gd['GD Version'];
    }else {
        $gdinfo = "未知";
    }
    $allowurl = ini_get("allow_url_fopen")?"支持" : "不支持";
    $max_upload = ini_get("file_uploads")?ini_get("upload_max_filesize") : "Disabled";
    $mqx_ex_time = ini_get("max_execution_time")."秒";

    date_default_timezone_set("Etc/GMT-8");
    $systemtime = date("y-m-d h:i:s", time());

    echo "<p>服务器： $sysos</p>";
    echo "<p>PHP版本  $sysversion</p>";
    echo "<p>Mysql版本 $mysqlinfo</p>";
    echo "<p>GD库版本 $gdinfo</p>";
    echo "<p>远程文件获取 $allowurl</p>";
    echo "<p>最大上传限制 $max_upload</p>";
    echo "<p>最大执行时间 $mqx_ex_time</p>";
    echo "<p>服务器时间 $systemtime</p>";
?>    
    </body>
</html>
