<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page isELIgnored="false" %>
<%@page import="com.zte.iptv.volcano.epg.account.User" %>
<%@page import="com.zte.iptv.volcano.core.EpgResult" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page isELIgnored="false" %>
<%@ include file="inc/errmsg.jsp" %>
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
    String partFrameUrl(String reqURI) {
        int start = reqURI.indexOf("frame");
        int end = reqURI.indexOf("/", start);

        return reqURI.substring(start, end);
    }
%>
<epg:PageController name="back.jsp"/>
<%
    String reqFrame = partFrameUrl(request.getRequestURI());
    String requestURL = request.getRequestURL().toString();
    String appUrl = requestURL.substring(0, requestURL.indexOf("frame"));
    String frameUrl = appUrl + reqFrame;
    String path = getPath(request.getRequestURI());
    String programcode = request.getParameter("programcode");
    String columncode = request.getParameter("columncode");
    String contentcode = request.getParameter("contentcode");
    String authid = request.getParameter("authid");
    String breakpoint = request.getParameter("breakpoint");
    String seriesprogramcode=request.getParameter("seriesprogramcode");
    String playChannel = request.getParameter("playChannel");
    String seriesIndex = request.getParameter("seriesIndex");
    if(breakpoint==null)
    {
        breakpoint="0";
    }
    String definition = String.valueOf(request.getParameter("definition"));
    String fromPoint = request.getParameter("fromPoint");
    String fromBookMark = request.getParameter("fromBookMark");
    if("".equals(definition) ||  "null".equals(definition))
    {
        definition = "1";
    }
    User user = (User) session.getAttribute("user");
    String url = null;
    String mediaservice = "1";
    String sql = " mediaservices&1!=0";
    String vodtype="1";
%>
<ex:params var="inputhash">
    <ex:param name="programcodeavailable" value="<%=programcode%>"/>
</ex:params>
<ex:search tablename="user_vod_detail" fields="*" inputparams="${inputhash}" condition="<%=sql%>" order="createtime desc"
           var="programInfo">
    <%
        List vodList = (ArrayList) pageContext.getAttribute("programInfo");
        if (vodList != null && vodList.size() > 0) {
            Map map = (Map) vodList.get(0);
            mediaservice = String.valueOf(map.get("mediaservice"));
            vodtype = String.valueOf(map.get("programtype"));
//            System.out.println("=======vodtype======="+vodtype);
        }
    %>
</ex:search>

<html>
<head>
    <title></title>
<body bgcolor="transparent" text="#FFFFFF" link="#FFFFFF" vlink="#555555">

<%
    if(breakpoint.equals("0")){
%>
 <!-- 删除节目三屏书签 -->
<ex:params var="params">
    <ex:param name="contentcode" value="<%=contentcode%>"/>
    <ex:param name="columncode" value="<%=columncode%>"/>
    <ex:param name="bookmarktype" value="1"/>
    <ex:param name="userid" value="<%=user.getUserId()%>"/>
</ex:params>
<ex:action name="del_bookmark" inputparams="${params}" var="result">
</ex:action>
<%
    }
%>
<!--获取播放url-->
<ex:params var="inputhash">
    <ex:param name="authidsession" value="<%=authid%>"/>
    <ex:param name="breakpoint" value="<%=breakpoint%>"/>
    <ex:param name="mediaservice" value="<%=mediaservice%>"/>
    <ex:param name="definition" value="<%=definition%>"/>
    <ex:param name="programcode" value="<%=programcode%>"/>
</ex:params>
<ex:action name="vod_play" inputparams="${inputhash}" var="vodplay">
    <%
        EpgResult vodplay = (EpgResult) pageContext.getAttribute("vodplay");
        String returnCode=vodplay.getErrorCode();
        String errorMsg=getErrorMsg(returnCode);
        String errorCode = vodplay.getReturnMessage();
//        System.out.println("errorMsg============="+errorMsg+"///////errorCode"+errorCode+"//////returnCode======"+returnCode);
        if ("0".equals(returnCode)) {//success
            url = (String) vodplay.get("playurl");
            if(url.indexOf("bp")>-1){
                int b=url.indexOf("bp");
                String a=url.substring(b,url.length());
                String e=a.substring(a.indexOf("&")+1,a.length());
                String c=url.substring(0,b);
//                System.out.println(a);
//                System.out.println(c);
//                System.out.println(e);
//                System.out.println(c+e);
              url=c+e;
            }
        } else {
        //--------??-----播放失败
        pageContext.forward("vod_failure.jsp?title=" + URLEncoder.encode(URLEncoder.encode(returnCode, "UTF-8"),"utf-8"));
        return;
     }
    %>
</ex:action>


<script language="javascript">
    <%--top.configPara["adplayurlList"] = null;--%>
    <%--top.jsSetVodLogoCfg(1,"<%=reqFrame%>/images/indication_vod.png",76,59);--%>
	
    top.jsSetControl("refreshOsdUrl","<%=frameUrl%>/refreshOSD.jsp");
    top.doStop();
    top.jsHideOSD();
    top.jsSetControl("playad","0");
    top.jsSetControl("series_Index", "<%=seriesIndex%>");
    var url = "<%=path%>control_transit_vod_play.jsp?columnid=<%=columncode%>&programid=<%=programcode%>&definition=<%=definition%>&contentcode=<%=contentcode%>&fromPoint=<%=fromPoint%>&fromBookMark=<%=fromBookMark%>&playChannel=<%=playChannel%>&seriesprogramcode=<%=seriesprogramcode%>&mediaservices=<%=mediaservice%>&vodtype=<%=vodtype%>&bp=<%=breakpoint%>";
     top.extrWin.document.location = url;
    top.jsVodPlay("<%=url%>&breakpoint=<%=0%>&bp=<%=0%>", "<%=programcode%>");
</script>
</body>
</html>