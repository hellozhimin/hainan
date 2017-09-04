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
    String daohangtotalstr =String.valueOf(param.get("zhuanti"+index+"total"));
    String name="zhuanti"+index+"_name";
    String subname="zhuanti"+index+"_programcode";
    String subname1="zhuanti"+index+"_subname";
    String images="zhuanti"+index+"_images";
    String linkurl="zhuanti"+index+"_linkURL";

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
        sb.append("\"name\":\"").append(String.valueOf(param.get(name+i))).append("\",");
        sb.append("\"programcode\":\"").append(String.valueOf(param.get(subname+i))).append("\",");
        sb.append("\"subname\":\"").append(String.valueOf(param.get(subname1+i))).append("\",");
        String sql="framepath='"+framecode+"'and positioncode='"+(images+i)+"'";
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
            img= String.valueOf(param.get(images+i));
        }

    %>
</ex:search>
<%
//        sb.append("\"images\":\"").append(String.valueOf(param.get(images+i))).append("\",");
        sb.append("\"images\":\"").append(img).append("\",");
        sb.append("\"linkURL\":\"").append(String.valueOf(param.get(linkurl+i))).append("\"");
        sb.append("}");
        if(i<daohangtotal-1){
            sb.append(",");
        }
    }
    sb.append("]");
//    System.out.println("=======sb==1111====="+sb.toString());
    out.print(sb.toString());
%>
