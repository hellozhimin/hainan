<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.zte.iptv.volcano.core.EpgResult" %>
<%@ page import="com.zte.iptv.volcano.epg.account.User" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<epg:PageController/>
<%
    String contentId = request.getParameter("ContentID");
    String subjectId = request.getParameter("SubjectID");
    String isfav = String.valueOf(request.getParameter("isfav"));
    String programtype=request.getParameter("programtype");
    User user = (User) session.getAttribute("user");
    String writeflag = request.getParameter("writeflag");
    int returnflag = 1;
    String returnCode = "";
    String errorMsg = "";
    StringBuffer sb = new StringBuffer();
    String favoritetype="1";
    if ("14".equals(programtype)) {
        favoritetype = "4";
    }
%>
<%
    if (isfav.equals("true")) {  //已经添加过收藏  删除收藏  屏收藏删除接口
%>
<ex:params var="inputparams">
    <ex:param name="contentcode" value="<%=contentId%>"/>
    <ex:param name="columncode" value="<%=subjectId%>"/>
    <ex:param name="favoritetype" value="<%=favoritetype %>"/>
    <ex:param name="userid" value="<%=user.getUserId()%>"/>
</ex:params>
<ex:action name="del_favorite" inputparams="${inputparams}" var="favresult">
    <%
        EpgResult favresult = (EpgResult) pageContext.getAttribute("favresult");
        returnCode = favresult.getErrorCode();
    %>
</ex:action>
<%
} else if (returnflag != 2) {  //添加收藏
%>
<ex:params var="inputparams">
    <ex:param name="terminalflag" value="1"/>
    <ex:param name="isshared" value="1"/>
    <ex:param name="contentcode" value="<%=contentId%>"/>
    <ex:param name="columncode" value="<%=subjectId%>"/>
    <ex:param name="favoritetype" value="<%=favoritetype %>"/>
    <ex:param name="dirid" value="0"/>
    <ex:param name="limitaction" value="4"/>
    <ex:param name="userid" value="<%=user.getUserId()%>"/>
</ex:params>
<ex:action name="add_favorite" inputparams="${inputparams}" var="favresult">
    <%
        EpgResult favresult = (EpgResult) pageContext.getAttribute("favresult");
        returnCode = favresult.getErrorCode(); //0:成功 其他：错误码
    %>
</ex:action>
<%
    }
    sb.append("{returnCode:\"" + returnCode + "\",");
    sb.append("errorMsg:\"" + errorMsg + "\"}");
    if (!"false".equals(writeflag)) {
        JspWriter ot = pageContext.getOut();
        ot.write(sb.toString());
    }
%>



