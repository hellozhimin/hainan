<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.volcano.frame.FrameUtil" %>
<%@ page import="com.zte.iptv.volcano.epg.account.User" %>
<%@ include file="../inc/utils.jsp" %>

<%
    String columnid = request.getParameter("columnid");
    String sessionid = request.getParameter("sessionid");
// System.out.println("-------------------------------columnid  " + columnid);
    String order = "sortnum desc";
    String strpage = request.getParameter("numperpage");
    String strnum = request.getParameter("destpage");
    int destpage = (strnum == null) ? 1 : Integer.parseInt(strnum);
    int numperpage = (strpage == null) ? 500 : Integer.parseInt(strpage);
    StringBuffer channelJsonData = new StringBuffer();
    channelJsonData.append("{param:[");
//    String sql = "columnc?ode like '" + columnid + "%'";
    String sql = "parentcode ='" + columnid + "'";
    String totalpages="";
%>
<ex:params var="inputhash">
    <ex:param name="columnavailable" value="<%=columnid%>"/>
</ex:params>
<ex:search tablename="user_column" fields="*" order="<%=order%>"  pagecount="<%=numperpage%>" curpagenum="<%=destpage%>"
          inputparams="${inputhash}" condition="<%=sql.toString()%>" var="columnlist">
    <%

        int dataNum = 0;
        String columnCode = "";
        String columnName = "";
        String posterfilelist="";
        String normalposter="";
         totalpages = String.valueOf(pageContext.getAttribute("pagenums"));
        String totalcount = String.valueOf(pageContext.getAttribute("totalcount"));
        List columnlistInfoList = (List) pageContext.getAttribute("columnlist");
        if (columnlistInfoList != null && columnlistInfoList.size() > 0) {
            dataNum = columnlistInfoList.size();
            for (int i = 0; i < dataNum; i++) {
                Map columnInfo = (Map) columnlistInfoList.get(i);
                columnCode = String.valueOf(columnInfo.get("columncode"));
                columnName = String.valueOf(columnInfo.get("columnname"));
                posterfilelist = String.valueOf(columnInfo.get("posterfilelist"));
                normalposter = getNormalPoster(posterfilelist);
                    if (i != 0) {
                        channelJsonData.append(",");
                    }
                        channelJsonData.append("{");
                        channelJsonData.append("\"columnname\":\"").append(getJsonPattern(columnName)).append("\",");
                        channelJsonData.append("\"normalposter\":\"").append(normalposter).append("\",");
                        channelJsonData.append("\"columncode\":\"").append(columnCode).append("\"");
                        channelJsonData.append("}");
            }
        }
    %>
</ex:search>
<%
    channelJsonData.append("],totalpages:\""+totalpages+"\"}");
//System.out.println("======channel_column--->" + channelJsonData.toString());
	//System.out.println("====sfw==> " + channelJsonData.toString());

    out.print(channelJsonData);
%>