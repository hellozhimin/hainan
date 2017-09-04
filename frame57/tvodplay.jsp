<%@page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.zte.iptv.volcano.core.EpgResult" %>
<%@ page import="com.zte.iptv.epg.util.*" %>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page isELIgnored="false" %>
<epg:PageController name="back.jsp"/>
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
    String path = getPath(request.getRequestURI());
    String authid = request.getParameter("authid");
    String prevuecode = request.getParameter("prevuecode");
    String channelcode = request.getParameter("channelcode");
    String breakpoint = request.getParameter("breakpoint");
    breakpoint = (breakpoint==null)?"0":breakpoint;
    String playUrl = "";
    StringBuffer dataesult = new StringBuffer();
%>
<!--获取播放url-->
<ex:params var="inputhash">
    <ex:param name="authidsession" value="<%=authid%>"/>
    <ex:param name="mediaservice" value="1"/>
    <ex:param name="breakpoint" value="<%=breakpoint%>"/>
    <ex:param name="prevuecode" value="<%=prevuecode%>"/>
    <ex:param name="channelcode" value="<%=channelcode%>"/>
</ex:params>
<ex:action name="tvod_play" inputparams="${inputhash}" var="tvodplay">
    <%
        EpgResult tvodplay = (EpgResult) pageContext.getAttribute("tvodplay");
        String returnCode=tvodplay.getErrorCode();
        String errorMsg=tvodplay.getErrMsg();
//        errorMsg =  URLEncoder.encode(errorMsg);
        if ("0".equals(returnCode)) {
            playUrl = (String) tvodplay.get("playurl");
        }
//        playUrl="rtsp://10.47.215.107:1556/vod/00000050280001105407.mpg?userid=m3&stbip=10.47.224.112&clienttype=1&mediaid=0000000030010000012887&ifcharge=1&time=20151125062607+00&life=172800&usersessionid=29&vcdnid=001&boid=001&srcboid=001&columnid=0J000102&backupagent=10.47.215.107:1556&ctype=1&playtype=0&Drm=0&EpgId=epg_nj_003&programid=00000050280001105407&contname=&fathercont=&bp=0&authid=&tscnt=0&tstm=0&tsflow=0&ifpricereqsnd=1&stbid=CA1003990070308000004C16F139F7BA&nodelevel=3&terminalflag=1&bitrate=0&usercharge=C88FBB6FC46332930854C847246B58CB&breakpoint=0&bp=0";
//        playUrl="http://10.47.222.247:8080/iptvepg/frame1084/aaaa1.mp4?1=1";
    %>
</ex:action>
<html>
<head>
    <title>channel_tvod_play</title>
</head>
<body bgcolor="transparent">
<epg:script lasturl="false"/>
<script type="text/javascript">
    top.doStop();
//    top.clearOSDInfo();
    top.doStop();
    top.jsHideOSD();
    <%--var url = "<%=path%>control_transit_vod_play.jsp?columnid=<%=columncode%>&programid=<%=programcode%>&definition=<%=definition%>&contentcode=<%=contentcode%>&fromPoint=<%=fromPoint%>&fromBookMark=<%=fromBookMark%>&playChannel=<%=playChannel%>&seriesprogramcode=<%=seriesprogramcode%>&mediaservices=<%=mediaservice%>";--%>
    <%--top.extrWin.document.location = url;--%>
    <%--top.jsVodPlay("<%=playUrl%>", "0000000030010000012887");--%>
//    var pname = top.jsGetControl("P_NAME");
    top.extrWin.document.location = "<%=path%>control_transit_tvodplay.jsp?<%=request.getQueryString()%>";
    top.jsPlayTVOD("<%=playUrl%>");
</script>
</body>
</html>
<script type="text/javascript">

</script>