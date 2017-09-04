<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<epg:PageController name="vod_back_zte.jsp"/>
<%
	String action = request.getParameter("action")==null?"back":"out";
	String returnUrl = request.getParameter("returnUrl");
	String vodId = request.getParameter("vodId");
	String contentcode = request.getParameter("contentcode");
	String contenttype = request.getParameter("contenttype");
	String columncode = request.getParameter("columncode");
	//out.print("<br>");
	//out.print("qwrrrrrrrrrrrrdfaefwefewfewfewfwefwefwefwef"+vodId);
%>
<script type="text/javascript" src="js/utils.js"></script>
<script>
	if("<%=action%>" == "out"){
		setCookie("vod_returnUrl","<%=returnUrl%>");
		//top.window.document.onirkeypress = top.grabEvent;
		//top.window.document.onkeypress = top.grabEvent;
		//parent.TurnPage.addUrl("EuropeanCup/page/goto_play.jsp",1);
		/*window.location.href = "../../page/vodplayer/newVodPlayer.jsp?PROGID=<%=vodId%>&TYPEID="+0
						+ "&PLAYTYPE=" + parent.EPGConstants.PLAY_TYPE_BOOKMARK
						+ "&CONTENTTYPE=" + parent.EPGConstants.CONTENT_TYPE_VOD
						+ "&BUSINESSTYPE=" + parent.EPGConstants.BUSINESS_TYPE_VOD
						+ "&FATHERPROGID=-1";*/
	   window.location.href="../../vod_play.jsp?programcode=<%=vodId%>&programtype=1&columncode=<%=columncode%>&contentcode=<%=vodId%>&definition=1&authid==undefined&breakpoint=0";
	   
	 
	   
	}else{
		var returnUrl = getCookie("vod_returnUrl");
		delCookie("vod_returnUrl");
		//top.window.document.onirkeypress = undefined;
		//top.window.document.onkeypress = undefined;
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