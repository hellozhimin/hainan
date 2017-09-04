<%
	String backFlag = request.getParameter("backFlag")==null?"0":request.getParameter("backFlag");
	String leefocus = request.getParameter("leefocus")==null?"0|0|0":request.getParameter("leefocus");
	String returnUrl = request.getParameter("backUrl")==null?request.getHeader("Referer"):request.getParameter("backUrl");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
</head>
<body bgcolor="#000000">
	<div id="test" style="position:absolute; color:#CCC; left: 600px; top: 355px;font-family:'微软雅黑';width:1280px;height:720px;">载入中...</div>

</body>
</html>
<script type="text/javascript" src="page/js/utils.js"></script>
<script>

	top.mp.stop();
	top.mp.leaveChannel();

	if("<%=backFlag%>" == 1){
		var returnUrl = getCookie("returnUrl");
		var leefocus = getCookie("European_leefocus");
		delCookie("returnUrl");
		returnUrl = unescape(returnUrl);
		leefocus = unescape(leefocus);
		var url = "";
		var url1 = "";
		var url2 = "";
		if(returnUrl.indexOf("lastfocus") != -1){
			url = returnUrl.split("lastfocus");
			url1 = url[0];
			if(url[1].indexOf("&")!=-1){
				url2 = url[1].substring(url[1].indexOf("&"));
			}
			returnUrl = url1+"lastfocus="+leefocus+url2;
		}else{
			returnUrl = returnUrl+"?lastfocus="+leefocus;
		}
		window.location.href = returnUrl;
	}else{
		setCookie("returnUrl",escape("<%=returnUrl%>"));
		setCookie("European_leefocus",escape("<%=leefocus%>"));
		window.location.href = "page/portal.jsp?isFirstIn=1";
	}
</script>
