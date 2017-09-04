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
<%!
    String replaceApp(HttpServletRequest req, String expression)
            throws Exception {
        String ret = expression;
        if (ret == null)
            return "";
        UserInfo userInfo = (UserInfo) req.getSession().getAttribute(
                EpgConstants.USERINFO);
        if (userInfo == null) {
            return ret;
        }
        String pathTemp = PortalUtils.getPath(req.getRequestURI(),
                req.getContextPath());
		pathTemp = pathTemp.replace("/action","");
        HashMap paramTemp = PortalUtils.getParams(pathTemp, "GBK");
        //String backepgurl = String.valueOf(paramTemp.get("appBackepgurl"));

        String backepgurl = req.getRequestURL().toString();
        String back_epg_url_par = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getRequestURI()+"?leaveFocusId=" ;
        back_epg_url_par=back_epg_url_par.replace("action/getPortal_recommend.jsp","portal.jsp");
        ret = ret.replaceAll("\\{epgIp\\}", userInfo.getEpgserverip());
        ret = ret.replaceAll("\\{epgip\\}", userInfo.getEpgserverip());
        ret = ret.replaceAll("\\{stbId\\}", userInfo.getStbId());
        ret = ret.replaceAll("\\{stbid\\}", userInfo.getStbId());
        ret = ret.replaceAll("\\{userId\\}", userInfo.getUserId());
        ret = ret.replaceAll("\\{userid\\}", userInfo.getUserId());
        ret = ret.replaceAll("\\{userToken\\}", userInfo.getUserToken());
        ret = ret.replaceAll("\\{usertoken\\}", userInfo.getUserToken());
        ret = ret.replaceAll("\\{userTokenExpiretime\\}",
                userInfo.getUserTokenExpiretime());
        ret = ret.replaceAll("\\{usertokenexpiretime\\}",
                userInfo.getUserTokenExpiretime());
        ret = ret.replaceAll("\\{areaCode\\}", userInfo.getCitycode());
        ret = ret.replaceAll("\\{areacode\\}", userInfo.getCitycode());

        ret = ret.replaceAll("\\{returnUrl\\}", "RETURNURL");
        ret = ret.replaceAll("\\{returnurl\\}", back_epg_url_par);
        ret = ret.replaceAll("\\{backUrl\\}", "RETURNURL");
        ret = ret.replaceAll("\\{backurl\\}", "RETURNURL");
        return ret;
    }
%>
<%
    String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
    path=path.replace("/action","");
    HashMap param = PortalUtils.getParams(path, "GBK");
//    System.out.println("=======path======"+path);
    String index=request.getParameter("index");
	try{
    String daohangtotalstr ="";
    String name="";
    String subname="";
    String images="";
    String linkurl="";
    if(index.equals("0")){
        daohangtotalstr = String.valueOf(param.get("recommendtotal"));
        name="recomm_name";
        subname="recomm_subname";
        images="recomm_images";
        linkurl="recomm_linkURL";
    }else if(index.equals("1")){
        daohangtotalstr = String.valueOf(param.get("channeltotal"));
        name="channel_name";
        subname="channel_subname";
        images="channel_images";
        linkurl="channel_linkURL";
    }else if(index.equals("2")){
        daohangtotalstr = String.valueOf(param.get("vodtotal"));
        name="vod_name";
        subname="vod_subname";
        images="vod_images";
        linkurl="vod_linkURL";
    }else if(index.equals("3")){
        daohangtotalstr = String.valueOf(param.get("zhuantitotal"));
        name="zhuanti_name";
        subname="zhuanti_subname";
        images="zhuanti_images";
        linkurl="zhuanti_linkURL";
    }else if(index.equals("4")){
        daohangtotalstr = String.valueOf(param.get("mytotal"));
        name="my_name";
        subname="my_subname";
        images="my_images";
        linkurl="my_linkURL";
    }else if(index.equals("5")){
        daohangtotalstr = String.valueOf(param.get("jingpintotal"));
        name="jingpin_name";
        subname="jingpin_subname";
        images="jingpin_images";
        linkurl="jingpin_linkURL";
    }else if(index.equals("6")){
        daohangtotalstr = String.valueOf(param.get("benditotal"));
        name="bendi_name";
        subname="bendi_subname";
        images="bendi_images";
        linkurl="bendi_linkURL";
    }else if(index.equals("7")){
        daohangtotalstr = String.valueOf(param.get("yingyongtotal"));
        name="yingyong_name";
        subname="yingyong_subname";
        images="yingyong_images";
        linkurl="yingyong_linkURL";
    }

    String framecode=String.valueOf(param.get("framecode"));
    int daohangtotal=0;
    if(daohangtotalstr!=null&&!"".equals(daohangtotalstr)){
        daohangtotal=Integer.parseInt(daohangtotalstr);
    }
    StringBuffer sb=new StringBuffer();
    sb.append("[");
    for(int i=0;i<daohangtotal;i++){
        sb.append("{");
        sb.append("\"name\":\"").append(String.valueOf(param.get(name+i))).append("\",");
        sb.append("\"subname\":\"").append(String.valueOf(param.get(subname+i))).append("\",");
        String sql="framepath='"+framecode+"'and positioncode='"+(images+i)+"'";
        String img="";
        String url=replaceApp(request,String.valueOf(param.get(linkurl+i)));
%>
<ex:search tablename="user_first_page" fields="firstpagefile,configinfo" condition="<%=sql%>" curpagenum="1" pagecount="1" var="frameposterlist">
    <%
        List posterList = (ArrayList<Map>) pageContext.getAttribute("frameposterlist");
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
        sb.append("\"images\":\"").append(img).append("\",");
        sb.append("\"linkURL\":\"").append(url).append("\"");
        sb.append("}");
        if(i<daohangtotal-1){
            sb.append(",");
        }
    }
    sb.append("]");
    out.print(sb.toString());
	}catch(Exception e){
		e.printStackTrace();
	}
%>
