<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.zte.iptv.epg.account.UserInfo" %>
<%@page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@page import="java.util.*" %>
<%@page import="com.zte.iptv.epg.util.*" %>
<%@page import="com.zte.iptv.newepg.tag.PageReturnStack" %>
<%@ page import="com.zte.iptv.volcano.epg.account.User" %>
<%@ page import="com.zte.iptv.volcano.frame.FrameUtil" %>
<%@include file="inc/chan_addjsset.jsp" %>
<html>
<meta name="page-view-size" content="1280*720">
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<head>
<%! ///reqFrame  and     framecode

    String partFrame(String reqURI) {
        int start = reqURI.indexOf("frame");
        int end = reqURI.indexOf("/", start);

        return reqURI.substring(start, end);
    }

%>
<%
	String epg_info = request.getParameter("epg_info");
	session.setAttribute("epg_info_as",epg_info);
	
    reqFrame = partFrame(request.getRequestURI());
    requestURL = request.getRequestURL().toString();
    appUrl = requestURL.substring(0, requestURL.indexOf("frame"));
    String fremeUrl = appUrl + reqFrame;
	System.out.println("***************< reqFrame >******************:"+reqFrame);
	System.out.println("***************< fremeUrl >******************:"+fremeUrl);


//    String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
//    HashMap param = PortalUtils.getParams(path, "GBK");
    UserInfo userInfo1 = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
    User user = (User) session.getAttribute("user");
    //设置主菜单与当前页面一致
    if (reqFrame != null && !reqFrame.equals(userInfo.getUserMainUrl())) {
        //userInfo.setUserMainUrl(reqFrame);
    }
    String framecode = user.getFrameCode();
    String frameMainUrl = "";
    String userId = user.getUserId();

    //if (framecode.indexOf("frame") > -1) {
       frameMainUrl = "/iptvepg/" + reqFrame + "/portal.jsp";
        // frameMainUrl = "/iptvepg/" + reqFrame + "/portal.jsp";
//    } else {
//        frameMainUrl = "/iptvepg/frame" + reqFrame + "/portal.jsp";
//    }
    if (user == null){
        pageContext.setAttribute(EpgConstants.TIPS, "EPGPgE0013", PageContext.REQUEST_SCOPE); // Unable to get userinfo,please re-login
        pageContext.forward("/errorHandler.jsp");
        return;
    }

    PageReturnStack stack = (PageReturnStack)pageContext.getAttribute(EpgConstants.STACK, PageContext.SESSION_SCOPE);
    if (null!=stack){
        pageContext.setAttribute(EpgConstants.STACK, null, PageContext.SESSION_SCOPE);
    }
    int tempno = -1;

    if (request.getParameter("tempno") != null){
        tempno = EpgUtils.toInt(request.getParameter("tempno"),-1);
    }
    System.out.println("==============tempno======="+tempno);
    System.out.println("==============frameMainUrl======="+frameMainUrl);
	response.sendRedirect("portal.jsp?epg_info=" + epg_info);
%>
</head>
<body bgcolor="#FFFFFF">
<div id="test" style="left:0px;top:100px;width:1280px; height:30px; position:absolute;" align="center">
	
</div>
</body>
</html>

