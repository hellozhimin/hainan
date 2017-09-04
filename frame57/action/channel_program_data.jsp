<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.zte.iptv.volcano.epg.account.User" %>
<%@ page import="com.zte.iptv.volcano.frame.FrameUtil" %>
<%@ include file="../inc/utils.jsp" %>
<%
    String channelcode = request.getParameter("channelcode");
    User user=(User)session.getAttribute("user");

    StringBuffer dataesult = new StringBuffer();
    java.text.SimpleDateFormat dateF = new java.text.SimpleDateFormat("yyyy.MM.dd");
    String currDate = dateF.format(new Date());
    String currDateBegin = currDate+" 00:00:00";
    String currDateEnd = currDate+" 23:59:59";
    StringBuffer sqlcon = new StringBuffer();
    if(channelcode!=null &&!"".equals(channelcode)){
        sqlcon.append(" channelcode = '").append(channelcode).append("'");
    }
    sqlcon.append(" and endtime >'").append(currDateBegin).append("'");
    sqlcon.append(" and begintime <'").append(currDateEnd).append("'");
%>
<ex:search tablename="user_channelprevue" fields="*" order="begintime asc" condition="<%=sqlcon.toString()%>" var="prevuelist">
<%
	List prevuelist = (List)pageContext.getAttribute("prevuelist");
    String totalCount = String.valueOf(pageContext.getAttribute("totalcount"));
    String proBeginTime="";
    String proname="";
    String prevuecode="";
    String definition="";
    String endtime="";
    int state =0;
    dataesult.append("{\"totalCount\":\"" + totalCount + "\",\"prevuelist\":[");
	if(prevuelist != null && prevuelist.size()>0)
	{
		for(int i=0;i< prevuelist.size();i++)
		{
			Map preMap = (Map)prevuelist.get(i);
			proBeginTime = String.valueOf(preMap.get("begintime"));
            proname = String.valueOf(preMap.get("prevuename"));
            prevuecode = String.valueOf(preMap.get("prevuecode"));
            definition = String.valueOf(preMap.get("definition"));
            endtime=String.valueOf(preMap.get("endtime"));
            if (i > 0 && i<prevuelist.size()) {
                dataesult.append(",");
            }
            dataesult.append("{");
            dataesult.append("\"proBeginTime\":\"" + proBeginTime + "\",");
            dataesult.append("\"proname\":\"" + getJsonPattern(proname) + "\",");
            dataesult.append("\"state\":\"" + preMap.get("mediaservices") + "\",");
            dataesult.append("\"definition\":\"" + definition + "\",");
            dataesult.append("\"proEndTime\":\""+endtime+"\",");
            dataesult.append("\"prevuecode\":\"" + prevuecode + "\"}");
        }
	}
    dataesult.append("]");
%>
</ex:search>
<%------   获取频道信息       ---------%>
<%
    // String isHls = String.valueOf(getConfigurationByName(request,"isHls","0","UTF-8"));
    String isHls ="0";
    String mediaservice = (!"1".equals(isHls))?"1":"2";
    StringBuffer sqlcon2 = new StringBuffer();
	if(channelcode!=null&&!"".equals(channelcode))
	{
        sqlcon2.append(" channelcode = '").append(channelcode).append("'");
	}
    sqlcon2.append(" and mediaservices&"+mediaservice+"="+mediaservice);
%>
<ex:search tablename="user_channel" fields="*" order="sortnum des" condition="<%=sqlcon2.toString()%>" var="channellist">
<%
	//过滤
	List channelList = (List)pageContext.getAttribute("channellist");
	if(channelList != null &&channelList.size()>0)
	{
		Map ObjectMap = (Map)channelList.get(0);
		String mixno = String.valueOf(ObjectMap.get("mixno"));
		String channelname = String.valueOf(ObjectMap.get("channelname"));
		String filename = String.valueOf(ObjectMap.get("filename"));
        dataesult.append(",");
        dataesult.append("\"mixno\":\"" + mixno + "\",");
        dataesult.append("\"channelname\":\"" + getJsonPattern(channelname) + "\",");
        dataesult.append("\"filename\":\"" + filename + "\"");

	}
    dataesult.append("}");
    JspWriter ot = pageContext.getOut();
    ot.write(dataesult.toString());
%>
</ex:search>

