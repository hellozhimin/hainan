<%@page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ page import="java.util.*" %>
<%@ page import="com.zte.iptv.volcano.core.EpgResult" %>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page isELIgnored="false" %>
<epg:PageController/>
<%
    String breakpoint = request.getParameter("breakpoint");
    String columncode = request.getParameter("columncode");
    String seriesprogramcode = request.getParameter("seriesprogramcode");
    //System.out.println("----wmk------frame1026---enter--add_bookmark.jsp---------->" );
    String contentcode="";
    String mediaservice = "32";
    mediaservice = String.valueOf(request.getParameter("mediaservices"));
   String sql = " seriesprogramcode = '" + seriesprogramcode + "' and mediaservices&"+mediaservice+"!=0 and  programtype=14";
   // System.out.println("======sql========"+sql);
%>
<ex:params var="inputhash">
    <ex:param name="columnavailable" value="<%=columncode%>"/>
</ex:params>
<ex:search tablename="user_vod" fields="*" 
           inputparams="${inputhash}" condition="<%=sql%>" var="programlist">
    <%
      List  vodList = (ArrayList) pageContext.getAttribute("programlist");
        if(vodList!=null&&vodList.size()>0){
            Map vodInfo = (Map) vodList.get(0);
            contentcode = String.valueOf(vodInfo.get("contentcode"));
           // System.out.println("======contentcode========"+contentcode);
        }
    %>
</ex:search>    
<ex:params var="inputparams">
    <ex:param name="isshared" value="1"/>
    <ex:param name="contentcode" value="<%=contentcode%>"/>
    <ex:param name="breakpoint" value="<%=breakpoint%>"/>
    <ex:param name="columncode" value="<%=columncode%>"/>
    <ex:param name="bookmarktype" value="4"/>
    <ex:param name="limitaction" value="4"/>
</ex:params>
<ex:action name="add_bookmark" inputparams="${inputparams}" var="result">
    <%
        StringBuffer sb = new StringBuffer();
        EpgResult bookMarkresult = (EpgResult) pageContext.getAttribute("result");
        String returnCode=bookMarkresult.getErrorCode();
        sb.append("{returnCode:\"" + returnCode + "\"}");
//        System.out.println("add_bookmark1.jsp========sb.toString()========"+sb.toString());
        JspWriter ot = pageContext.getOut();
        ot.write(sb.toString());
    %>
</ex:action>
