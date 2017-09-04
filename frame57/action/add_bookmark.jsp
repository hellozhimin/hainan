<%@page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ page import="com.zte.iptv.volcano.core.EpgResult" %>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page isELIgnored="false" %>
<epg:PageController/>
<%
    String breakpoint = request.getParameter("breakpoint");
    String columncode = request.getParameter("columncode");
    String contentcode = request.getParameter("contentcode");
    //System.out.println("----wmk------frame1026---enter--add_bookmark.jsp---------->" );
%>
<ex:params var="inputparams">
    <ex:param name="isshared" value="1"/>
    <ex:param name="contentcode" value="<%=contentcode%>"/>
    <ex:param name="breakpoint" value="<%=breakpoint%>"/>
    <ex:param name="columncode" value="<%=columncode%>"/>
    <ex:param name="bookmarktype" value="1"/>
    <ex:param name="limitaction" value="4"/>
</ex:params>
<ex:action name="add_bookmark" inputparams="${inputparams}" var="result">
    <%
        StringBuffer sb = new StringBuffer();
        EpgResult bookMarkresult = (EpgResult) pageContext.getAttribute("result");
        String returnCode=bookMarkresult.getErrorCode();
        sb.append("{returnCode:\"" + returnCode + "\"}");
        JspWriter ot = pageContext.getOut();
        ot.write(sb.toString());
    %>
</ex:action>
