<%@page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<epg:PageController/>
<%
    String columncode = String.valueOf(request.getParameter("columncode"));
    String programid = String.valueOf(request.getParameter("programid"));
    StringBuffer jsonbuffer = new StringBuffer();
    String sql = " seriesprogramcode = '" + programid + "' and columncode='" + columncode + "'" + " and programtype=10 and mediaservices&1!=0";
%>
<ex:params var="inputhash">
    <ex:param name="columnavailable" value="<%=columncode%>"/>
</ex:params>
<ex:search tablename="user_vod" fields="*"  condition="<%=sql%>" var="programlist" order="seriesnum asc">
    <%
        List vodData = (ArrayList) pageContext.getAttribute("programlist");
        String totalcount = String.valueOf(pageContext.getAttribute("totalcount"));
        String pagecount = String.valueOf(pageContext.getAttribute("pagenums"));
        String programId = "";
        String contentcode="";
        String mediaservices = "";
        int definition = 1;
        jsonbuffer.append("{pagecount:\"" + pagecount + "\",totalcount:\"" + totalcount + "\",seriesData:[");
        int length = vodData.size();
        for (int j = 0; j < length; j++) {
            Map programInfo = (Map) vodData.get(j);
            programId = String.valueOf(programInfo.get("programcode"));
            contentcode = String.valueOf(programInfo.get("contentcode"));
            mediaservices = String.valueOf(programInfo.get("mediaservices"));
            if (j > 0 && j < length) {
                jsonbuffer.append(",");
            }                    
            String sql_detail = " mediaservice = " + mediaservices;
            %>
    <ex:params var="params">
        <ex:param name="programcodeavailable" value="<%=programId%>"/>
    </ex:params>
    <ex:search tablename="user_vod_detail" fields="*" inputparams="${params}" condition="<%=sql_detail%>"
               order="createtime desc" var="programlist_detail">
        <%
           List vodDetailList = (ArrayList) pageContext.getAttribute("programlist_detail");
            definition = 0;
            for (int i = 0; i < vodDetailList.size(); i++) {
                Map map = (Map) vodDetailList.get(i);
                if (!"20".equals(map.get("videotype"))) {
                    String definitionTemp = String.valueOf(map.get("definition"));
                    definition =  definition + Integer.parseInt(definitionTemp);
                }
            }
        %>
      </ex:search>
    <%
            jsonbuffer.append("{programid:\"" + programId + "\",");
            jsonbuffer.append("definition:\"" + definition + "\",");
            jsonbuffer.append("contentcode:\"" + contentcode + "\",");
            jsonbuffer.append("mediaservices:\"" + mediaservices + "\"}");
        }
        jsonbuffer.append("]}");
        JspWriter ot = pageContext.getOut();
        //System.out.println("=====swb====seriesSingleData============="+jsonbuffer.toString());
        ot.write(jsonbuffer.toString());
    %>
</ex:search>



