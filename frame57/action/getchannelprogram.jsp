<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.zte.iptv.volcano.frame.FrameUtil" %>
<%@ page import="com.zte.iptv.volcano.epg.account.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%!
    public String escapingQuotes(String str) {
        if (str != null && !"".equals(str)) {
            str = str.replaceAll("\\\\", "\\\\\\\\");
            str = str.replaceAll("\"", "\\\\\"");
            str = str.replaceAll("\'", "\\\\\'");
        } else {
            str = "";
        }
        return str;
    }
%>
<%
    User user = (User)session.getAttribute("user");
    String currDate = request.getParameter("currdate");
    String sessionid = request.getParameter("sessionid");
    java.text.SimpleDateFormat dateF = new java.text.SimpleDateFormat("yyyy.MM.dd");
    java.text.SimpleDateFormat dateF1  = new     java.text.SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
    java.text.SimpleDateFormat dateF2 = new java.text.SimpleDateFormat("HH:mm");
    String despageStr=String.valueOf(request.getParameter("destpage"));
    String numperpageStr=String.valueOf(request.getParameter("numperpage"));
    despageStr = (despageStr.equals("null") || despageStr.equals(""))?"1":despageStr;
    numperpageStr = (numperpageStr.equals("null") || numperpageStr.equals(""))?"500":numperpageStr;
    int destpage=Integer.valueOf(despageStr);
    int numerpage=Integer.valueOf(numperpageStr);
//    System.out.println(currDate+"========sql=====");
    if (currDate == null || "".equals(currDate)) {
        currDate = dateF.format(new Date());
    }
    String currDateBegin = currDate+" 00:00:00";
    String currDateEnd = currDate+" 23:59:59";
    String channelcode = request.getParameter("channelcode");
    String columncode = request.getParameter("columncode");
    StringBuffer sqlcon = new StringBuffer();
    if(channelcode!=null &&!"".equals(channelcode)){
        sqlcon.append(" channelcode = '").append(channelcode).append("'");
    }
    sqlcon.append(" and begintime >='").append(currDateBegin).append("'");
    sqlcon.append(" and endtime <='").append(currDateEnd).append("'");
    String prevueOrder="begintime asc";
    String preBeginTime = "";
    String preEndTime = "";
    String prevuecode="";
    String prevuename="";
    System.out.println(currDate+"========sql====="+sqlcon.toString());
    StringBuffer dataesult = new StringBuffer();
    long currtime=new Date().getTime();
    SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd HH:mm:SS");
%>
<ex:search tablename="user_channelprevue" fields="*" order="<%=prevueOrder%>" condition="<%=sqlcon.toString()%>"
           curpagenum="<%=destpage%>" pagecount="<%=numerpage%>" var="prevuelist">
    <%
        List prevuelist = (List) pageContext.getAttribute("prevuelist");
        String pageCount = String.valueOf(pageContext.getAttribute("pagecount"));
        String totalCount = String.valueOf(pageContext.getAttribute("totalcount"));
        dataesult.append("{totalCount:\"" + totalCount + "\",pageCount:\"" + pageCount + "\",sessionid:\""+sessionid+"\",prevuelist:[");
        if (prevuelist != null && prevuelist.size() > 0) {
            int length = prevuelist.size();
            for (int i = 0;i<length;i++) {
                Map preMap = (Map)prevuelist.get(i);
                preBeginTime = String.valueOf(preMap.get("begintime"));

                preEndTime = String.valueOf(preMap.get("endtime"));
                prevuename = preMap.get("prevuename")+"";
                prevuename=escapingQuotes(prevuename);
                prevuecode = String.valueOf(preMap.get("prevuecode"));
                long begintime=format.parse(preBeginTime).getTime();
                long endtime=format.parse(preEndTime).getTime();
                 String data="0";
                if(begintime<=currtime&&currtime<=endtime){
                    data="1";
                }
//               int recordStatus = FrameUtil.getRecordStatus(user, String.valueOf(prevuecode));
                if (i > 0 && i<prevuelist.size()) {
                    dataesult.append(",");
                }
                dataesult.append("{");
                dataesult.append("\"channelcode\":\"" + channelcode + "\",");
                dataesult.append("\"begintime\":\"" + preBeginTime + "\",");
                Date date = null;
                String showtime = "";
                try{
                    date = dateF1.parse(preBeginTime);
                    showtime = dateF2.format(date);
                }catch (Exception e){ }
                dataesult.append("\"showtime\":\"" + showtime + "\",");
                dataesult.append("\"endtime\":\"" + preEndTime + "\",");
                dataesult.append("\"status\":\"" + FrameUtil.getRecordStatus(user,prevuecode) + "\",");
                dataesult.append("\"prevuename\":\"" + prevuename + "\",");
                dataesult.append("\"data\":\"" + data + "\",");
                dataesult.append("\"prevuecode\":\"" + prevuecode + "\"");
                dataesult.append("}");
            }
        }
        dataesult.append("]}");
        JspWriter ot = pageContext.getOut();
        //System.out.println("gabe-------action4-----getchannelprogram = "+dataesult.toString());
        ot.write(dataesult.toString());
    %>
</ex:search>
