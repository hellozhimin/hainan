<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<epg:PageController name="live.jsp"/>
<%
	String action = request.getParameter("action")==null?"back":"out";
	String returnUrl = request.getParameter("returnUrl");
	String CHANNELNUM = request.getParameter("CHANNELNUM");
	String CHANNELID = request.getParameter("CHANNELID");
%>

<script type="text/javascript" src="js/utils.js"></script>
<script>
	if("<%=action%>" == "out"){
		setCookie("returnUrl","<%=returnUrl%>");
		/*top.window.document.onirkeypress = top.grabEvent;
		top.window.document.onkeypress = top.grabEvent;
		parent.TurnPage.addUrl("EuropeanCup/page/goto_play.jsp",1);*/
		window.location.href = "../../channel_play.jsp?mixno=<%=CHANNELNUM%>&columncode=0100";
	}else{
		var returnUrl = getCookie("returnUrl");
		delCookie("returnUrl");
		top.window.document.onirkeypress = undefined;
		top.window.document.onkeypress = undefined;
		window.location.href = returnUrl;
	}
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
</head>
<body bgcolor="#000000">
	<div style="position:absolute; color:#CCC; left: 600px; top: 355px;font-family:'微软雅黑';width:1280px;height:720px;">载入中...</div>
</body>
</html>