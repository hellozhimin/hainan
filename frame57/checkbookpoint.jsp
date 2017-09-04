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
    System.out.println("=============="+request.getQueryString());
    String columncode = String.valueOf(request.getParameter("columncode"));
    String programid = String.valueOf(request.getParameter("programid"));
    String programtype = String.valueOf(request.getParameter("programtype"));
    String breakInfo = String.valueOf(request.getParameter("breakInfo"));
    String contentcode="";
    String breakPoint = "0";
    String seriesprogramcode="";
    String definition="1";
    String sql ="";
    String sql_detail = " mediaservice = 1" ;
    if(programtype.equals("14")){
        sql=" columncode = '" + columncode + "' and programtype=14 and programcode='" + programid + "' and mediaservices&" + 1 + "!=0";
    }else{
        sql=" columncode = '" + columncode + "' and programtype=1 and programcode='" + programid + "' and mediaservices&" + 1 + "!=0";
        breakPoint= breakInfo;
    }

%>

<ex:params var="params">
    <ex:param name="programcodeavailable" value="<%=programid%>"/>
</ex:params>
<ex:search tablename="user_vod_detail" fields="*" inputparams="${params}" condition="<%=sql_detail%>"
           order="createtime desc" var="programlist_detail">
    <%
        List vodDetailList = (ArrayList) pageContext.getAttribute("programlist_detail");
        if (vodDetailList != null && vodDetailList.size() > 0) {
//            System.out.println(vodDetailList);
            Map map = (Map) vodDetailList.get(0);
            definition = String.valueOf(map.get("definition"));
//            contentcode = String.valueOf(map.get("contentcode"));
            contentcode = String.valueOf(map.get("contentcode"));
            seriesprogramcode = String.valueOf(map.get("seriesprogramcode"));
        }
    %>
</ex:search>
<%--查询剧头书签--%>
<%
  if(programtype.equals("14")){
      String sql_JJ = " seriesprogramcode = '" + programid + "' and columncode='" + columncode + "'" + " and programtype=10 and mediaservices&" + 1 + "!=0";

%>
<%--查询连续剧剧集的情况--%>
<ex:search tablename="user_vod" fields="*" condition="<%=sql_JJ%>" order="seriesnum asc" var="seriesJJInfo">
    <%
       List allSingleSeries=(ArrayList)pageContext.getAttribute("seriesJJInfo");
        if(allSingleSeries!=null&&allSingleSeries.size()>0){
            int breakpoint=1;
            if(breakInfo!=null){
                breakpoint= Integer.parseInt(breakInfo);
            }
            Map map = (Map)allSingleSeries.get(breakpoint-1);
            contentcode = String.valueOf(map.get("contentcode"));
            seriesprogramcode = String.valueOf(map.get("seriesprogramcode"));
            programid = String.valueOf(map.get("programcode"));
            programtype = String.valueOf(map.get("programtype"));
        }
    %>
</ex:search>
<%

    StringBuffer bookmark_sql = new StringBuffer("bookmarktype = 1");
    bookmark_sql.append(" and columncode = '").append(columncode)
            .append("' and contentcode = '").append(contentcode).append("' and state = 1");
%>
<ex:search tablename="user_bookmark" fields="*" condition="<%=bookmark_sql.toString()%>" order="savetime desc" var="bookmark">
    <%
        List markList = (ArrayList) pageContext.getAttribute("bookmark");
        if (markList != null && markList.size() > 0) {
            Map map = (Map) markList.get(0);
            breakPoint = String.valueOf(map.get("breakpoint"));
        }
    %>
</ex:search>
<%
    } 
    String playurl="vod_play.jsp?columncode=" + columncode + "&contentcode="+contentcode+"&programtype=" + programtype + "&programcode=" + programid+
            "&definition=" + definition + "&authid=&breakpoint="+breakPoint+
            "&seriesIndex="+breakInfo+
            "&seriesprogramcode="+seriesprogramcode;
    System.out.println("========playurl========"+playurl);
%>
<html>
<head>
    <title></title>
<body bgcolor="transparent" text="#FFFFFF" link="#FFFFFF" vlink="#555555">
  <script type="text/javascript">
      var playurl="<%=playurl%>";
      document.location=playurl;
  </script>
</body>
</html>