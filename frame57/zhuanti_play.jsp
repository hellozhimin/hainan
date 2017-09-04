<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.zte.iptv.volcano.core.EpgResult" %>
<%@ include file="inc/errmsg.jsp" %>
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
//    System.out.println("get_vod_playUrl.jsp-----qst--" + request.getQueryString());
    String programcode = request.getParameter("programcode");

    String seriesprogramcode = request.getParameter("seriesprogramcode");
    String playChannel = request.getParameter("playChannel");
    String fromPoint = request.getParameter("fromPoint");
    String fromBookMark = request.getParameter("fromBookMark");
    String vodtype = request.getParameter("vodtype");
    if(vodtype==null||"".equals("vodtype")){
        vodtype="1";
    }
    String sql = "programcode = '" + programcode + "'";
    String columncode = "";
    String definition = "1";
    String mediaservice = "1";
    String contentcode = "";
    String playUrl = "";
    String sql_detail = " mediaservice = " + mediaservice;
%>
<ex:search tablename="user_vod" fields="*" order="createtime desc" condition="<%=sql%>" var="programlist">
    <%
        List vodInfo = (ArrayList) pageContext.getAttribute("programlist");
        if (vodInfo != null && vodInfo.size() > 0) {
            Map map = (Map) vodInfo.get(0);
            columncode = String.valueOf(map.get("columncode"));
            contentcode = String.valueOf(map.get("contentcode"));
//            mediaservice= String.valueOf(map.get("mediaservices"));
        } else {
//            System.out.println(programcode + "---isNull!");
        }
    %>
</ex:search>
<ex:params var="params">
    <ex:param name="programcodeavailable" value="<%=programcode%>"/>
</ex:params>
<ex:search tablename="user_vod_detail" fields="*" inputparams="${params}" condition="<%=sql_detail%>"
           order="createtime desc" var="programlist_detail">
    <%
        List vodDetailList = (ArrayList) pageContext.getAttribute("programlist_detail");
        if (vodDetailList != null && vodDetailList.size() > 0) {
//            System.out.println(vodDetailList);
            Map map = (Map) vodDetailList.get(0);
            definition = String.valueOf(map.get("definition"));
//            System.out.println("=====definition====" + definition);
        }
//        System.out.println("=====mediaservice====" + mediaservice);
//        System.out.println("=====columncode====" + columncode);
    %>
</ex:search>
<!--获取播放url-->
<ex:params var="inputhash">
    <ex:param name="authidsession" value=""/>
    <ex:param name="breakpoint" value="0"/>
    <ex:param name="mediaservice" value="<%=mediaservice%>"/>
    <ex:param name="definition" value="<%=definition%>"/>
    <ex:param name="programcode" value="<%=programcode%>"/>
</ex:params>
<ex:action name="vod_play" inputparams="${inputhash}" var="vodplay">
    <%
        EpgResult vodplay = (EpgResult) pageContext.getAttribute("vodplay");
        String returnCode = vodplay.getErrorCode();
        String errorMsg=getErrorMsg(returnCode);
        if ("0".equals(returnCode)) {//success
            playUrl = (String) vodplay.get("playurl");
        } else {
//            System.out.println("========jlsjdlfjasl=====");
            //--------??-----播放失败
            pageContext.forward("vod_failure.jsp?title=" + URLEncoder.encode(returnCode, "UTF-8"));
            return;
        }
    %>
</ex:action>
<html>
<head>
    <title></title>
<body bgcolor="transparent" text="#FFFFFF" link="#FFFFFF" vlink="#555555">
<script language="javascript">
    top.doStop();
    top.jsHideOSD();
    var url = "<%=path%>control_transit_vod_play.jsp?columnid=<%=columncode%>&programid=<%=programcode%>&definition=<%=definition%>&contentcode=<%=contentcode%>&fromPoint=<%=fromPoint%>&fromBookMark=<%=fromBookMark%>&playChannel=<%=playChannel%>&seriesprogramcode=<%=seriesprogramcode%>&mediaservices=<%=mediaservice%>&vodtype=<%=vodtype%>";
    top.extrWin.document.location = url;
    top.jsVodPlay("<%=playUrl%>&breakpoint=<%=0%>&bp=<%=0%>", "<%=programcode%>");
</script>
</body>
</html>