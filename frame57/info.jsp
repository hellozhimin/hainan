<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<epg:PageController name="back.jsp"/>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="1280*720">

<title>错误页</title>

<style type="text/css">

body{
	background:url(images/bg.png) no-repeat;
	width:1280px;
	height:720px;
	position:absolute;
	top:0px;
	left:0px;
	line-height:720px;
	text-align:center;
	font-size:60px;
	color:#fff;
}
</style>

</head>

<body>
	此页面正在玩命开发中...
</body>
<script type="text/javascript" src="js/keyPress.js"></script>
<script>
	function pageBack(){
	   document.location="back.jsp";
	}
	 function dokeypress(evt){
        var keyCode = parseInt(evt.which);
        if (keyCode == 0x0008) {
            pageBack();
        } else if (keyCode == 1108) {
			window.location.href = 'portal_key.jsp?Action=1';
		} else if (keyCode == 1110) {
			window.location.href = 'portal_key.jsp?Action=2';
		} else if (keyCode == 1109) {
			window.location.href = 'portal_key.jsp?Action=3';
		} else if (keyCode == 1112) {
			window.location.href = 'portal_key.jsp?Action=4';
		} else {
            top.doKeyPress(evt);
            return true;
        }
        return false;
    }
	document.onkeydown = dokeypress;
</script>
</html>
