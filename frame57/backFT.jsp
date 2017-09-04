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

<%!
	public String unescape(String src) {  
        StringBuffer tmp = new StringBuffer();  
        tmp.ensureCapacity(src.length());  
        int lastPos = 0, pos = 0;  
        char ch;  
        while (lastPos < src.length()) {  
            pos = src.indexOf("%", lastPos);  
            if (pos == lastPos) {  
                if (src.charAt(pos + 1) == 'u') {  
                    ch = (char) Integer.parseInt(src  
                            .substring(pos + 2, pos + 6), 16);  
                    tmp.append(ch);  
                    lastPos = pos + 6;  
                } else {  
                    ch = (char) Integer.parseInt(src  
                            .substring(pos + 1, pos + 3), 16);  
                    tmp.append(ch);  
                    lastPos = pos + 3;  
                }  
            } else {  
                if (pos == -1) {  
                    tmp.append(src.substring(lastPos));  
                    lastPos = src.length();  
                } else {  
                    tmp.append(src.substring(lastPos, pos));  
                    lastPos = pos;  
                }  
            }  
        }  
        return tmp.toString();  
    } 
%>
<%
	//处理封套数据
	String epg_info = (String) session.getAttribute("epg_info_as");//request.getParameter("epg_info");
	String posterIndex = (String) session.getAttribute("posterIndex");
	String page_url = ""; //处理封套返回路径
	String group_path = ""; 
	String server_ip = ""; 
	
	if(null != epg_info && !"".equals(epg_info) && epg_info.length() > 20){
		group_path = epg_info.substring(epg_info.indexOf("<group_path>")+12,epg_info.indexOf("</group_path>"));
		page_url = epg_info.substring(epg_info.indexOf("<page_url>")+10,epg_info.indexOf("</page_url>"));
		server_ip = epg_info.substring(epg_info.indexOf("<server_ip>")+11,epg_info.indexOf("</server_ip>"));
	}
	
	if(!"".equals(group_path)){
		UserInfo userInfo = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
		userInfo.setUserMainUrl(group_path);
		System.out.println("--------已处理机顶盒用户主模板----------------");
	}
	/**/
	System.out.println("--------backFT----------------");
	System.out.println("--------group_path----------------"+group_path);
	System.out.println("--------page_url----------------"+page_url);
	
%>
<html>
<head>
    <title>back page</title>
</head>
<body bgcolor="transparent">

</body>
</html>
<script language="javascript" type="text/javascript">
	//if('<%=page_url%>' != '' && 0 == '<%=posterIndex%>'){
	if('<%=page_url%>' != '' && 0 == '<%=posterIndex%>'){
		window.location.href = '<%=page_url%>';
	}else{
		document.location = "portal.jsp";
	}
</script>