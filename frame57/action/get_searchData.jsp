<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.awt.geom.Rectangle2D" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.volcano.frame.FrameUtil" %>
<%@ page import="com.zte.iptv.volcano.epg.account.User" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ include file="../inc/utils.jsp" %>
<epg:PageController/>
<%
    String columnid = request.getParameter("columnid");
//    columnid="060200";
    String searchProgramType = "(programtype=1 or programtype=14)";
    String searchTitle = request.getParameter("searchTitle");
    searchTitle = URLDecoder.decode(searchTitle, "UTF-8");
    searchTitle = searchTitle.toLowerCase();
    String destpage = request.getParameter("destpage");
    int numperpage = 10;
    if (destpage.equals("")) {
        destpage = "1";
    }
    int destpageInt = Integer.parseInt(destpage);
    String sql = " columncode like '" + columnid + "%' and " + searchProgramType + " and mediaservices&1!=0 and programsearchkey like '" + searchTitle + "%'";
//    String sql = " columncode like '" + columnid + "%' and " + searchProgramType + " and mediaservices&1!=0";
//    System.out.println("=======sql====="+sql);
%>
<ex:params var="inputhash">
    <ex:param name="columnavailable" value="<%=columnid%>"/>
</ex:params>
<ex:search tablename="user_vod" fields="*" order="programname asc" inputparams="${inputhash}" condition="<%=sql%>"
           var="programlist" curpagenum="<%=destpageInt%>" pagecount="<%=numperpage%>">
    <%
        List vodData = (ArrayList) pageContext.getAttribute("programlist");
        if (null == vodData) vodData = new ArrayList();
        Object totalpage = pageContext.getAttribute("pagenums");
        String totalcountStr = String.valueOf(pageContext.getAttribute("totalcount"));
        if ("null".equals(totalcountStr) || "".equals(totalcountStr)) {
            totalcountStr = "0";
        }
        StringBuffer sb = new StringBuffer();
        String columnId = "";
        String programId = "";
        String normalPoster = "";
        String programType = "";
        String programName = "";
        String mediaservices = "";
        String starlevel = "";
        int totalCount = Integer.parseInt(totalcountStr);
        sb.append("{pageCount:\"" + totalpage + "\",totalCount:\"" + totalCount + "\",vodData:[");
        int length = vodData.size();
        for (int i = 0; i < length; i++) {
            Map vodInfo = (Map) vodData.get(i);
            columnId = (String) vodInfo.get("columncode");
            programId = (String) vodInfo.get("programcode");
            normalPoster = getNormalPoster((String)vodInfo.get("posterfilelist"));
            programType = (String) vodInfo.get("programtype");
            mediaservices = (String) vodInfo.get("mediaservices");
            starlevel = (String) vodInfo.get("starlevel");
            programName = (String) vodInfo.get("programname");
            programName = getJsonPattern(programName);
            if (i > 0 && i < length) {
                sb.append(",");
            }
            sb.append("{columnid:\"" + columnId + "\",");
            sb.append("programid:\"" + programId + "\",");
            sb.append("programtype:\"" + programType + "\",");
            sb.append("normalposter:\"" + normalPoster + "\",");
            sb.append("mediaservices:\"" + mediaservices + "\",");
            sb.append("starlevel:\"" + starlevel + "\",");
            sb.append("programname:\"" + programName + "\"}");
        }
        sb.append("]}");
//        System.out.println("=============1111====="+sb.toString());
        JspWriter ot = pageContext.getOut();
        ot.write(sb.toString());
    %>
</ex:search>





