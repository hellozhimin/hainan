<%@page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ page import="com.zte.iptv.volcano.core.EpgResult" %>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page import="com.zte.iptv.epg.util.*" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored="false" %>
<epg:PageController/>
<%
    String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
    path=path.replace("/action","");
    HashMap param = PortalUtils.getParams(path, "GBK");
//    System.out.println("=======path======"+path);
    String index=request.getParameter("index");


//    System.out.println("=====daohangtotal========"+daohangtotalstr);
    String framecode=String.valueOf(param.get("framecode"));
    StringBuffer sb=new StringBuffer();
//    sb.append("[");
    //{"name":"推荐","code":"0"},
    for(int i=0;i<1;i++){
        sb.append("{");
        String sql="framepath='"+framecode+"'and positioncode='"+("zhuantibg"+index)+"'";
        String img="";
%>
<ex:search tablename="user_first_page" fields="firstpagefile,configinfo" condition="<%=sql%>" curpagenum="1" pagecount="1" var="frameposterlist">
    <%
        List posterList = (ArrayList<Map>) pageContext.getAttribute("frameposterlist");
//        System.out.println("==========1111======="+posterList);
        if(posterList!=null&&posterList.size()>0){
            Map postermap=(Map)posterList.get(0);
            img=String.valueOf(postermap.get("firstpagefile"));
            img="../images/firstpageposter/"+img;
        } else{
            img= String.valueOf(param.get("zhuantibg"+index));
        }

    %>
</ex:search>
<%
//        sb.append("\"images\":\"").append(String.valueOf(param.get(images+i))).append("\",");
        sb.append("\"images\":\"").append(img).append("\"");
        sb.append("}");

    }
//    sb.append("]");
    System.out.println("=======sb==1111====="+sb.toString());
    out.print(sb.toString());
%>
