<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex"%> 
<%@ page isELIgnored="false" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../inc/util_getPosterPaths.jsp"%>
<%@ page import="com.zte.iptv.epg.utils.Utils" %>
<%@ page import="com.zte.iptv.epg.util.*" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>

<%
	JSONArray topicList = null;
	String topicOrder = " applytime desc ";
	int leftDestPage = Utils.toInt(request.getParameter("leftDestPage"), 1);
    int leftPageCount = 0;
    int leftCurPage = 0;
	Long total = 0l;
	int curLen = 0;
	
	String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
    path=path.replace("/action","");
    HashMap param = PortalUtils.getParams(path, "GBK");
	String framecode = String.valueOf(param.get("framecode"));
	String searchSql = "";
	String group_path = request.getParameter("group_path");
	
	UserInfo userInfo = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
	userInfo.setUserMainUrl(framecode);
	
    StringBuffer sb=new StringBuffer();
    sb.append("[");
%>
<ex:search tablename="user_frame_topic"  fields="*" condition="<%=searchSql%>" order="<%=topicOrder%>" var="datalist" curpagenum="<%=leftDestPage %>" pagecount="999">
	<%
		List<Map> listData = (List<Map>) pageContext.getAttribute("datalist");
		leftPageCount = (Integer) pageContext.getAttribute("pagenums");
		total = (Long) pageContext.getAttribute("totalcount");
		leftCurPage = leftDestPage;
		
		if (listData != null && listData.size() > 0) {
			curLen = listData.size();
			for (int i = 0; i < curLen; i++) {
				Map topicMap = (Map)listData.get(i);
				String indexurl = topicMap.get("indexurl").toString();
				String posterfile = topicMap.get("posterfile").toString();
				String topicname = topicMap.get("topicname").toString();
    			System.out.println("=======sb==posterfile====="+posterfile);
				sb.append("{");
        		sb.append("\"name\":\"").append(topicname).append("\",");
        		sb.append("\"images\":\"").append(getPosterPath(posterfile,request)).append("\",");
				sb.append("\"linkURL\":\"").append(indexurl).append("\"");
				sb.append("}");
				if(i<curLen-1){
					sb.append(",");
				}
			}
		}	
	%>
	</ex:search>
<%
	if(null != group_path && !"".equals(group_path)){
		userInfo.setUserMainUrl(group_path);	
    }	
    sb.append("]");
    System.out.println("=======sb==zhuanti====="+sb.toString());
    out.print(sb.toString());
%>
