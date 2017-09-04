<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.zte.iptv.volcano.core.EpgResult" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ page isELIgnored="false" %>
<%
    String columncode = request.getParameter("columncode");
    String contentcode = request.getParameter("contentcode");
    String breakPoint = "0";
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
        JspWriter ot = pageContext.getOut();
        ot.write(breakPoint);
    %>
</ex:search>
