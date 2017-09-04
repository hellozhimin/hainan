<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="../inc/utils.jsp" %>
<%
    String mediaservice = "1";
    if("1".equals((String) session.getAttribute("isHls"))){
        mediaservice =  "2";
    }
    String dirid = request.getParameter("dirid");
    if(dirid==null || "".equals(dirid)){
        dirid="0";
    }
    String strpage = request.getParameter("numperpage");
    String strnum = request.getParameter("destpage");
    int destpage = (strnum == null) ? 1 : Integer.parseInt(strnum);
    int numperpage = (strpage == null) ? 500 : Integer.parseInt(strpage);
    StringBuffer favoriteSql = new StringBuffer(" favoritetype=5 and state=1 and dirid="+dirid);
    StringBuffer sb = new StringBuffer();
    sb.append("{");
    String channelcode = "";
    List favoriteList = new ArrayList();
    String totalpages = "";
    String totalcount = "";
%>
<ex:search tablename="user_favorite" fields="*" pagecount="<%=numperpage%>" curpagenum="<%=destpage%>"
           var="FavoriteList" order="usermixno asc" condition="<%=favoriteSql.toString()%>">
    <%
        favoriteList = (List) pageContext.getAttribute("FavoriteList");
       // System.out.println("======favoriteList======="+favoriteList);
        totalpages = String.valueOf(pageContext.getAttribute("pagenums"));
        totalcount = String.valueOf(pageContext.getAttribute("totalcount"));
        sb.append("\"totalpages\":"+totalpages+",");
        sb.append("\"totalcount\":"+totalcount+",");
        sb.append("\"channels\":[");
    %>
</ex:search>
<%
    if (favoriteList != null) {
        for (int i = 0; i < favoriteList.size(); i++) {             //favoriteList.size()
            Map tempMap = (Map) favoriteList.get(i);        //get(i)
            channelcode = String.valueOf(tempMap.get("contentcode"));
            String sql1 = "channelcode = '" + channelcode + "' and mediaservices&"+mediaservice+"="+mediaservice+" and  columncode='" + tempMap.get("columncode") + "'";
%>
<ex:search tablename="user_channel" fields="*" condition="<%=sql1.toString()%>" var="channellist">
    <%
        List channelInfoList1 = (List) pageContext.getAttribute("channellist");
        if (channelInfoList1.size() > 0) {
            Map map = (Map) channelInfoList1.get(0);
            sb.append("{");
            sb.append("\"mixno\":\"" + map.get("usermixno") + "\",");
            sb.append("\"usermixno\":\"" + map.get("mixno") + "\",");
            sb.append("\"channelname\":\"" + getJsonPattern(map.get("channelname")+"") + "\",");
            sb.append("\"channelcode\":\"" + map.get("channelcode") + "\",");
            sb.append("\"subjectid\":\"" + map.get("columncode") + "\",");
            sb.append("\"filename\":\"" + map.get("filename") + "\",");
            sb.append("\"ippvenable\":\"" + map.get("ippvenable") + "\",");
            sb.append("\"Ischildlock\":\"" + map.get("parentcontrolenable") + "\",");
            sb.append("}");
        }
        if(i < favoriteList.size())
        {
           sb.append(","); 
        }

    %>
</ex:search>
<%
        }
    }

    sb.append("]}");
//    System.out.println("SSSSSSSSSSSSSSSSSSsb=" + sb.toString());
    out.print(sb.toString());
%>