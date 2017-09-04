<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@page isELIgnored="false" %>
<epg:PageController/>
<%!
    public String formatString(String newName) {
        newName = newName.replaceAll("\\\\", "\\\\\\\\");
        newName = newName.replaceAll("\"", "\\\\\"");
        newName = newName.replaceAll("\'", "\\\\\'");
        return newName;
    }

    public static String formatToDouble(String priceStr, String rateStr) {
        //保留两位小数且不用科学计算法
        DecimalFormat df = new DecimalFormat("#0.00");
        String finalPrice = null;
        double price = Double.parseDouble(priceStr);
        double rateInt = Double.parseDouble(rateStr);
        price = price / rateInt;
        finalPrice = df.format(price);
        return finalPrice;
    }

    public static String formatDate(String begintime) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
        Date d = new Date();
        try {
            d = format.parse(begintime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String la = "";
        SimpleDateFormat format2
                = new SimpleDateFormat("yyyy/MM/dd");
        begintime = format2.format(d);
        return begintime;
    }
%>

<%
    int curpage = Integer.parseInt(request.getParameter("curpage"));
    StringBuffer sb = new StringBuffer();
    List vodlist = new ArrayList();
    int terminaltype = 1;
    String totalpages = "";
    String totalcount = "";

%>

<%--PPV产品查询--%>
<ex:params var="inputhash">
    <ex:param name="columncode" value=""/>
    <ex:param name="terminalflag" value="<%=String.valueOf(terminaltype)%>"/>
</ex:params>
<ex:search tablename="user_ppv" fields="*" inputparams="${inputhash}" pagecount="8" curpagenum="<%=curpage%>"
           var="ppvlist">
    <%
        List ppvlist = (List) pageContext.getAttribute("ppvlist");
        totalpages = String.valueOf(pageContext.getAttribute("pagenums"));
        totalcount = String.valueOf(pageContext.getAttribute("totalcount"));
//        System.out.println(" totalpages=============" + totalpages);
//        System.out.println("totalcount==============" + totalcount);
        for (int i = 0; i < ppvlist.size(); i++) {
            Map tempmap = (Map) ppvlist.get(i);
            vodlist.add(tempmap);
        }
    %>
</ex:search>
<!--组装数据-->
<%
    String columnId = "";
    String programId = "";
    String programType = "";
    String seriesprogramcode = "";
    String contentid = "";
    String programName = "";
    String feecost1 = "";
    String begintime1 = "";
    String endtime1 = "";
//    int totalCount = vodlist.size();
    sb.append("{totalcount:\"" + totalcount + "\",totalpages:\"" + totalpages + "\",vodData:[");
    int length = vodlist.size();
    for (int i = 0; i < length; i++) {
        Map columnInfo = (Map) vodlist.get(i);
        columnId = String.valueOf(columnInfo.get("columncode"));
        programId = String.valueOf(columnInfo.get("programcode"));
        programType = String.valueOf(columnInfo.get("programtype"));
        seriesprogramcode = String.valueOf(columnInfo.get("seriesprogramcode"));
        contentid = String.valueOf(columnInfo.get("contentcode"));
        programName = String.valueOf(columnInfo.get("contentname"));
        feecost1 = String.valueOf(columnInfo.get("feecost"));
        begintime1 = formatDate(String.valueOf(columnInfo.get("begintime")));
        endtime1 = formatDate(String.valueOf(columnInfo.get("endtime")));
        programName = formatString(programName);

        sb.append("{columnId:\"" + columnId + "\",");
        sb.append("programId:\"" + programId + "\",");
        sb.append("programType:\"" + programType + "\",");
        sb.append("seriesprogramcode:\"" + seriesprogramcode + "\",");
        sb.append("programName:\"" + programName + "\",");
        sb.append("contentid:\"" + contentid + "\",");
        sb.append("feecost:\"" + feecost1 + "\",");
        sb.append("endtime:\"" + endtime1 + "\",");
        sb.append("begintime:\"" + begintime1 + "\"}");

        if (i < length - 1) {
            sb.append(",");
        }
    }
    sb.append("]}");
//    System.out.println("===============sb.toString()=========" + sb.toString());
//    String orderJSON = "";
//    if (curpage == 1) {
//        orderJSON = "{totalcount:18,vodData:[{\"programName\":\"劫案密云111\",\"feecost\":\"100\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"selfcare_myAccount.jsp\"}," +
//                "{\"programName\":\"超人归来111\",\"feecost\":\"200\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"环太平洋111\",\"feecost\":\"200\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"机械战警111\",\"feecost\":\"300\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"机械战警111\",\"feecost\":\"300\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"机械战警111\",\"feecost\":\"300\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"温暖的尸体11\",\"feecost\":\"400\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"冰雪奇缘111\",\"feecost\":\"500\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}]}";
//    } else if (curpage == 2) {
//        orderJSON = "{totalcount:18,vodData:[{\"programName\":\"劫案密云222\",\"feecost\":\"100\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"selfcare_myAccount.jsp\"}," +
//                "{\"programName\":\"超人归来222\",\"feecost\":\"200\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"环太平洋222\",\"feecost\":\"200\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"机械战警222\",\"feecost\":\"300\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"机械战警222\",\"feecost\":\"300\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"机械战警222\",\"feecost\":\"300\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"温暖的尸体222\",\"feecost\":\"400\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"冰雪奇缘222\",\"feecost\":\"500\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}]}";
//
//    } else if (curpage == 3) {
//        orderJSON = "{totalcount:18,vodData:[{\"programName\":\"劫案密云333\",\"feecost\":\"100\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"selfcare_myAccount.jsp\"}," +
//                "{\"programName\":\"冰雪奇缘333\",\"feecost\":\"500\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}]}";
//
//    }
    JspWriter ot = pageContext.getOut();
    ot.write(sb.toString());
%>






