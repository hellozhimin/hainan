<%@ page import="java.net.URLDecoder" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%--<%@include file="inc/words.jsp" %>--%>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<epg:PageController name="back.jsp"/>
<%
    String title = String.valueOf(request.getParameter("title"));

    if (null == title) {
        title = "";
    }
    title = URLDecoder.decode(title, "UTF-8");
    String W_AUTOBACK="2秒自动返回";
    String msg = W_AUTOBACK;
    String timer = "1";
    
%>

<html>
<head>
    <title>订购失败</title>
    <meta http-equiv="refresh" content="<%=timer%>;url=<%="back.jsp"%>">
    <epg:script/>
    <style type="text/css">

    </style>
</head>
<body bgcolor="transparent" style="background: url(images/channel/allbg.png);">
<%--<div class="detail_alert">--%>
    <%--<div id="errorDiv" align="center"--%>
         <%--style="left:20; top:80;width:453;height:100px; position:absolute;font-size: 26px;">--%>
        <%--<%=title%>--%>
    <%--</div>--%>
    <%--<div id="backDiv" align="center"--%>
         <%--style="left:20; top:238px;width:453;height:30px; position:absolute;font-size: 28px;">--%>
        <%--<%=msg%>--%>
    <%--</div>--%>
<%--</div>--%>
<div style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px;">
    <%--<div id="errorDiv"  style="left:30; top:81;width:453;height:100px; position:absolute;font-size: 24px;">--%>
    <%--</div>--%>
    <div id="errorDiv" style="left:0; top:236;width:1280;height:100px; position:absolute;font-size: 35px;color: #fff;" align="center">
        <%=title%>  (<%=msg%>)
    </div>
    <%--<div style="position: absolute;top:328px;left: 564px;width: 151px;height: 64px;">--%>
        <%--<img src="images/channel/15.png" width="151" height="64" id="focusimg0">--%>
    <%--</div>--%>
    <%--<div id="backDiv"  style="left:564; top:328px;width:151;height:64px; position:absolute;font-size: 30px;color:#fff;line-height: 64px;" align="center">--%>
        <%--<%=msg%>--%>
    <%--</div>--%>
</div>
<%@include file="inc/lastfocus.jsp" %>
<%--<%@include file="inc/vod_menu_key.jsp" %>--%>
<%--<%@include file="inc/goback.jsp" %>--%>
<script type="text/javascript">
    top.jsSetupKeyFunction("top.mainWin.goPortalByChannel", <%=STBKeysNew.remoteMenu%>);
</script>
</body>
</html>