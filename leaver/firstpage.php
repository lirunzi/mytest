<!doctype html>
<html>
    <head>
	<meta charset="gbk" />
        <title>��ȡ��������Ϣ</title>
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
        $gdinfo = "δ֪";
    }
    $allowurl = ini_get("allow_url_fopen")?"֧��" : "��֧��";
    $max_upload = ini_get("file_uploads")?ini_get("upload_max_filesize") : "Disabled";
    $mqx_ex_time = ini_get("max_execution_time")."��";

    date_default_timezone_set("Etc/GMT-8");
    $systemtime = date("y-m-d h:i:s", time());

    echo "<p>�������� $sysos</p>";
    echo "<p>PHP�汾  $sysversion</p>";
    echo "<p>Mysql�汾 $mysqlinfo</p>";
    echo "<p>GD��汾 $gdinfo</p>";
    echo "<p>Զ���ļ���ȡ $allowurl</p>";
    echo "<p>����ϴ����� $max_upload</p>";
    echo "<p>���ִ��ʱ�� $mqx_ex_time</p>";
    echo "<p>������ʱ�� $systemtime</p>";
?>    
    </body>
</html>
