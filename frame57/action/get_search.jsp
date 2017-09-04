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
    String daohangtotalstr = String.valueOf(param.get("searchtotal"));
//    System.out.println("=====daohangtotal========"+daohangtotalstr);
    String framecode=String.valueOf(param.get("framecode"));
    int daohangtotal=0;
    if(daohangtotalstr!=null&&!"".equals(daohangtotalstr)){
        daohangtotal=Integer.parseInt(daohangtotalstr);
    }
    StringBuffer sb=new StringBuffer();
    sb.append("[");
    //{"name":"推荐","code":"0"},
    for(int i=0;i<daohangtotal;i++){
        sb.append("{");
        sb.append("\"vodName\":\"").append(String.valueOf(param.get("vodName"+i))).append("\",");
        String sql="framepath='"+framecode+"'and positioncode='"+("vodImgUrl"+i)+"'";
        String img="";
        %>
        <ex:search tablename="user_first_page" fields="firstpagefile,configinfo" condition="<%=sql%>" curpagenum="1" pagecount="1" var="frameposterlist">
<%
    List posterList = (ArrayList<Map>) pageContext.getAttribute("frameposterlist");
//    System.out.println("==========1111======="+posterList);
    if(posterList!=null&&posterList.size()>0){
        Map postermap=(Map)posterList.get(0);
        img=String.valueOf(postermap.get("firstpagefile"));
        img="../images/firstpageposter/"+img;
    } else{
        img= String.valueOf(param.get("vodImgUrl"+i));
    }

%>
</ex:search>
<%
//        sb.append("\"vodImgUrl\":\"").append(String.valueOf(param.get("vodImgUrl"+i))).append("\",");
        sb.append("\"vodImgUrl\":\"").append(img).append("\",");
        sb.append("\"vodUrl\":\"").append(String.valueOf(param.get("vodUrl"+i))).append("\"");
        sb.append("}");
        if(i<daohangtotal-1){
            sb.append(",");
        }
    }
    sb.append("]");
//    System.out.println("=======sb======="+sb.toString());
    out.print(sb.toString());
%>
