<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ page import="com.zte.iptv.epg.util.STBKeysNew" %>
<%@ page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="java.util.HashMap" %>
<%!
    public String getPath(String uri) {
        String path = "";
        int begin = 0;
        int end = uri.lastIndexOf('/');
        if (end > 0) {
            path = uri.substring(begin, end + 1) + path;
        }
        return path;
    }
%>
<%
    String page_url = ""; //处理封套返回路径
    String epg_info = request.getParameter("epg_info");
    if(null == epg_info || "".equals(epg_info) || "null".equals(epg_info) || "undefined".equals(epg_info)){
        epg_info = (String) session.getAttribute("epg_info_as");
    }
    if(null != epg_info && !"".equals(epg_info) && epg_info.length() > 20){
        session.setAttribute("epg_info_as",epg_info);
        page_url = epg_info.substring(epg_info.indexOf("<page_url>")+10,epg_info.indexOf("</page_url>"));
    }
%>
<%
	String path=getPath(request.getRequestURI());
	String path2 = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
	HashMap param = PortalUtils.getParams(path2, "UTF-8");
	String columncode = String.valueOf(param.get("column0"));
	String vodcolumnid = String.valueOf(param.get("column01"));
	String  channelcode = request.getParameter("channelcode");
	String contentcode = request.getParameter("prevuecode");
    String isfromchannel = request.getParameter("isfromchannel");
    String mixno = request.getParameter("mixno");
    String columncode1 = request.getParameter("columncode");

%>
<html>
<head>
<title>control_transit_tvodplay</title>
</head>
<body bgcolor="transparent">
<script language="javascript" type="text/javascript">
    top.jsClearVideoKeyFunction();
    top.disableLocalUI();

    function showThank()
    {
                delayStop();
    }
    function delayStop() {
        top.doStop();
        if ("<%=isfromchannel%>" == "1") {
            <%--var lastChannel = top.channelInfo.lastChannel;--%>
            <%--var currentChannel = top.channelInfo.currentChannel;--%>
            <%--if (currentChannel != "" && currentChannel != undefined && currentChannel != -1) {--%>
                <%--top.jsRedirectChannel(currentChannel);--%>
            <%--}--%>
            <%--else if (lastChannel != "" && lastChannel != undefined && lastChannel != -1 && lastChannel != currentChannel) {--%>
                <%--top.jsRedirectChannel(lastChannel);--%>
            <%--} else {--%>
                <%--top.vodBackTimer = top.setTimeout("top.showOSD(2, 0, 0);top.mainWin.document.location='<%=path%>/back.jsp'", 500);--%>
            <%--}--%>
            top.mainWin.document.location= "<%=path%>/channel_play.jsp?mixno=<%=mixno%>&columncode=<%=columncode1%>";
        } else {
            top.vodBackTimer = top.setTimeout("top.showOSD(2, 0, 0);top.mainWin.document.location='<%=path%>/back.jsp'", 500);
        }
    }
    top.jsSetVideoKeyFunction("top.extrWin.showThank", "mediaEnd");
    var pname = top.jsGetControl("P_NAME");
    function showmainmenu() {
          top.doStop();
          var frameid=top.jsGetControl("UserModel");
          top.mainWin.document.location = "/iptvepg/"+frameid+"/portal.jsp";
        top.showOSD(2, 0, 0);
    }
    top.jsSetVideoKeyFunction("top.extrWin.showmainmenu", <%=STBKeysNew.remoteMenu%>);

    function FastRewind() {
        top.doFastRewind(-2);
        top.mainWin.document.location = "<%=path%>tvod_speed_osd1.jsp?fast=RR&columncode=<%=columncode%>&channelcode=<%=channelcode%>&contentcode=<%=contentcode%>";
        top.showOSD(2, 0, 0);
    }

    function FastForword() {
        top.doFastForward(2);
        top.mainWin.document.location = "<%=path%>tvod_speed_osd1.jsp?fast=FF&columncode=<%=columncode%>&channelcode=<%=channelcode%>&contentcode=<%=contentcode%>";
        top.showOSD(2, 0, 0);
    }

    function pause() {
        top.doPause();
        top.mainWin.document.location = "<%=path%>tvod_speed_osd.jsp?isok=0&fast=pause&columncode=<%=columncode%>&channelcode=<%=channelcode%>&contentcode=<%=contentcode%>";
        top.showOSD(2, 0, 0);
    }
    function pause1() {
//        top.doPause();
        top.mainWin.document.location = "<%=path%>tvod_speed_osd.jsp?isok=1&fast=pause&columncode=<%=columncode%>&channelcode=<%=channelcode%>&contentcode=<%=contentcode%>";
        top.showOSD(2, 0, 0);
    }
    function pageVolumePlus()
	{
        top.mainWin.document.location = "<%=path%>volumeOSD.jsp?type=add";
        top.showOSD(2, 0, 0);
	}

	function pageVolumeMinus()
	{
        top.mainWin.document.location = "<%=path%>volumeOSD.jsp?type=minus";
        top.showOSD(2, 0, 0);
	}
    function pageVolumeMute(){
        top.mainWin.document.location = "<%=path%>volumeOSD.jsp?type=mute";
        top.showOSD(2, 0, 0);
    }
    function TVODPlayStop() {
        top.doPause();
        top.mainWin.document.location = "<%=path%>tvod_playstop.jsp?<%=request.getQueryString()%>";
        top.showOSD(2, 0, 0);
    }
    function menu(){
     top.doStop();
     top.currState = 0;
     top.jsClearVideoKeyFunction();
     top.mainWin.document.location = '<%=page_url%>' ;
}


    function donothing() {
        return false;
    }
    top.jsSetVideoKeyFunction("top.extrWin.donothing", <%=STBKeysNew.remoteLastChannel%>); 
    top.jsSetVideoKeyFunction("top.extrWin.FastForword", <%=STBKeysNew.onKeyRight%>);
    top.jsSetVideoKeyFunction("top.extrWin.FastForword", <%=STBKeysNew.onKeyLeft%>);
    top.jsSetVideoKeyFunction("top.extrWin.pageVolumePlus", <%=STBKeysNew.remoteVolumePlus%>);
    top.jsSetVideoKeyFunction("top.extrWin.pageVolumeMinus", <%=STBKeysNew.remoteVolumeMinus%>);
    top.jsSetVideoKeyFunction("top.extrWin.pageVolumeMute", <%=STBKeysNew.remoteVolumeMute%>);
    top.jsSetVideoKeyFunction("top.extrWin.FastRewind", <%=STBKeysNew.remoteFastRewind%>);
    top.jsSetVideoKeyFunction("top.extrWin.FastForword", <%=STBKeysNew.remoteFastForword%>);
    top.jsSetVideoKeyFunction("top.extrWin.pause", <%=STBKeysNew.RmotePlayPause%>);
    top.jsSetVideoKeyFunction("top.extrWin.pause1", <%=STBKeysNew.onKeyOK%>);
    top.jsSetVideoKeyFunction("top.extrWin.TVODPlayStop", <%=STBKeysNew.remoteStop%>);
    top.jsSetVideoKeyFunction("top.extrWin.TVODPlayStop", <%=STBKeysNew.remoteBack%>);
    top.jsSetVideoKeyFunction("top.extrWin.donothing", <%=STBKeysNew.onKeyUp%>);
    top.jsSetVideoKeyFunction("top.extrWin.donothing", <%=STBKeysNew.onKeyDown%>);
	top.jsSetVideoKeyFunction("top.extrWin.donothing", <%=STBKeysNew.remotePlayNext%>);
	top.jsSetVideoKeyFunction("top.extrWin.donothing", <%=STBKeysNew.remotePlayLast%>);
    top.jsSetVideoKeyFunction("top.extrWin.menu", <%=STBKeysNew.remoteMenu%>); 
    

    function showtvodInfo(){
        top.mainWin.document.location = "<%=path%>tvod_speed_osd.jsp?fast=normal&columncode=<%=columncode%>&channelcode=<%=channelcode%>&contentcode=<%=contentcode%>";
        top.showOSD(2, 0, 0);
    }
    var showinfotime=null;
    showinfotime= setTimeout("showtvodInfo()",2000);
</script>
</body>
</html>