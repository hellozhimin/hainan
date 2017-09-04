<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex"%> 
<%@ page isELIgnored="false" %>
<%@ page import="com.zte.iptv.epg.utils.Utils" %>
<%@ page import="com.zte.iptv.epg.util.*" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>

<%
	String group_path = request.getParameter("group_path");
	String kc = request.getParameter("kc");
	UserInfo userInfo = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
	
    System.out.println("=======ret==kc====="+kc);
	if(null != group_path && !"".equals(group_path)){
		userInfo.setUserMainUrl(group_path);
		session.setAttribute("posterIndex",0);
   		System.out.println("=======ret==group_path=====已处理封套模板");
    }
	out.clear();
    out.print(true);
%>
