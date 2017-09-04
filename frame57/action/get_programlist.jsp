<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page import="com.zte.iptv.volcano.frame.FrameUtil" %>
<%@ include file="../inc/utils.jsp" %>
<epg:PageController/>
<%!

    public String formatString(String newName) {
        newName = newName.replaceAll("\\\\", "\\\\\\\\");
        newName = newName.replaceAll("\"", "\\\\\"");
        newName = newName.replaceAll("\'", "\\\\\'");
        return newName;
    }
%>

<%
    String columnid = request.getParameter("columnid");
    String destpage=request.getParameter("curpagenum");
    StringBuffer sb = new StringBuffer();
    String sql = "columncode ='" + columnid + "' and (programtype=1 or programtype=14)";
%>
<ex:params var="inputhash">
    <ex:param name="columnavailable" value="<%=columnid%>"/>
</ex:params>
<ex:search tablename="user_vod" fields="*" inputparams="${inputhash}" curpagenum="<%=destpage%>"
           pagecount="8" condition="<%=sql%>"  var="programlist">
    <%
        List vodData = (ArrayList) pageContext.getAttribute("programlist");
        String totalcount = String.valueOf(pageContext.getAttribute("totalcount"));//total count
        String programId = "";
        String columncode="";
        String programType = "";
        String programName = "";
        String normalposter = "";
        String posterfilelist = "";
        String vodlevel = "";
        String starlevel = "";
        String mediaservices = "";
        String contentcode="";
        sb.append("{totalcount:\"" + totalcount + "\",fathercolumncode:\"" + columnid + "\",vodData:[");
        int length = vodData.size();
        for (int j = 0; j < length; j++) {
            Map programInfo = (Map) vodData.get(j);
            programId = String.valueOf(programInfo.get("programcode"));
            columncode = String.valueOf(programInfo.get("columncode"));
            programType = String.valueOf(programInfo.get("programtype"));
            programName = String.valueOf(programInfo.get("programname"));
            vodlevel = String.valueOf(programInfo.get("ratingid"));
            starlevel = String.valueOf(programInfo.get("starlevel"));
            mediaservices = String.valueOf(programInfo.get("mediaservices"));
            posterfilelist = String.valueOf(programInfo.get("posterfilelist"));
            contentcode= String.valueOf(programInfo.get("contentcode"));
            normalposter = getNormalPoster(posterfilelist);
            programName = formatString(programName);
            if (j > 0 && j < length) {
                sb.append(",");
            }
            sb.append("{programid:\"" + programId + "\",");
            sb.append("programtype:\"" + programType + "\",");
            sb.append("columnid:\"" + columncode + "\",");
            sb.append("programname:\"" + programName + "\",");
            sb.append("vodlevel:\"" + vodlevel + "\",");
            sb.append("starlevel:\"" + starlevel + "\",");
            sb.append("mediaservices:\"" + mediaservices + "\",");
            sb.append("contentcode:\"" + contentcode + "\",");
            sb.append("normalposter:\"" + normalposter + "\"}");
        }
        sb.append("]}");


    %>
</ex:search>

<%
//    System.out.println("--tj-------------------------------------jsonbuffer="+sb);
    JspWriter ot = pageContext.getOut();

    ot.write(sb.toString());
%>
