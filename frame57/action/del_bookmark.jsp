<%@page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.zte.iptv.volcano.core.EpgResult" %>
<%@ page import="com.zte.iptv.volcano.epg.account.User" %>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page isELIgnored="false" %>
<epg:PageController/>
<%
    String contentId = request.getParameter("contentId");
    String subjectId = request.getParameter("subjectId");
    User user = (User) request.getSession().getAttribute("user");
    String bookMarkType=request.getParameter("bookmarkType");
%>
 
<ex:params var="params">
    <ex:param name="contentcode" value="<%=contentId%>"/>
    <ex:param name="columncode" value="<%=subjectId%>"/>
    <ex:param name="bookmarktype" value="<%=bookMarkType%>"/>
    <ex:param name="userid" value="<%=user.getUserId()%>"/>
</ex:params>
<ex:action name="del_bookmark" inputparams="${params}" var="result">
    <%
        StringBuffer sb = new StringBuffer();
        EpgResult favresult = (EpgResult) pageContext.getAttribute("result");
        String returnCode=favresult.getErrorCode();
        sb.append("{returnCode:\"" + returnCode + "\"}");
        JspWriter ot = pageContext.getOut();
        ot.write(sb.toString());
    %>
</ex:action>
