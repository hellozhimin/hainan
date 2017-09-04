<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@page import="java.util.HashMap" %>
<%@page import="com.zte.iptv.epg.util.EpgUtility"%>
<%@page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<html>
<head>

    <title>portal_key</title>
    <meta name="page-view-size" content="1280*720"/>
</head>
<%!

	 String partFrame(String reqURI) {
    	int start = reqURI.indexOf("frame");
    	int end = reqURI.indexOf("/", start);

    	return reqURI.substring(start, end);
	}
	

  public String getPath(String uri) {
    String path = "";
    int begin = 0;
    int end = uri.lastIndexOf('/');
    if (end > 0) {
      path = uri.substring(begin, end + 1) + path;
    }
    return path;
  }
    String getHTTPFrameCode(String reqURI) {
        int start = reqURI.indexOf("frame");
        int end = reqURI.indexOf("/", start);
        return reqURI.substring(start, end);
    }
%>

<body bgcolor="#000000"  onload="top.doStop();">
<script type="text/javascript" src="js/contentloader.js"></script>
<epg:PageController />
<%
    String reqFrame = partFrame(request.getRequestURI());
    UserInfo userInfo = (UserInfo)session.getAttribute(EpgConstants.USERINFO);
	String requestURL=request.getRequestURL().toString();
	String appUrl=requestURL.substring(0, requestURL.indexOf("frame"));
	String fremeUrl=appUrl+reqFrame;
	String path1 = getPath(request.getRequestURI());
    String action = request.getParameter("Action");

    String reqFrame1 = getHTTPFrameCode(request.getRequestURI());
//    String requestURL1 = request.getRequestURL().toString();
    String appUrl1 = requestURL.substring(0, requestURL.indexOf("frame"));
    String frameUrl = appUrl1 + reqFrame1;
    String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
     HashMap param = PortalUtils.getParams(pageContext.getServletContext().getResourceAsStream(path), "GBK");
    String redurl = String.valueOf(param.get("redurl"));     //vod
    String greenurl = String.valueOf(param.get("greenurl"));     //vod
    String yellowurl = String.valueOf(param.get("yellowurl"));     //vod
    String blueurl = String.valueOf(param.get("blueurl"));     //vod
	System.out.println("-------------frameUrl:" + frameUrl);
%>
<%--<script language="javascript" type="">--%>
    <%--top.doStop();--%>
    <%--top.jsSetControl("refreshOsdUrl","<%=frameUrl%>/refreshOSD.jsp");--%>
<%--</script>--%>
<%
 if ("1".equals(action)) {%>
<script language="javascript" type="">
       if("<%=redurl%>"!=null&&"<%=redurl%>"!=""){
           top.mainWin.document.location="<%=redurl%>";
       }
</script>
<%
} else if ("2".equals(action)) {
%>
<script language="javascript" type="">
    if("<%=greenurl%>"!=null&&"<%=greenurl%>"!=""){
        top.mainWin.document.location="<%=greenurl%>";
    }
</script>
<%
    }else if ("3".equals(action)) {
%>
<script language="javascript" type="">
    if("<%=yellowurl%>"!=null&&"<%=yellowurl%>"!=""){
        top.mainWin.document.location="<%=yellowurl%>";
    }
</script>
<%
    } else if("4".equals(action)) {
%>
<script language="javascript" type="">
    if("<%=blueurl%>"!=null&&"<%=blueurl%>"!=""){
        top.mainWin.document.location="<%=blueurl%>";
    }
</script>
<%
    }
%>
</body>
</html>
