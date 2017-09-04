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
        back_epg_url_par=back_epg_url_par.replace("action/getPortal_daohang.jsp","portal.jsp");
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
    String daohangtotalstr = String.valueOf(param.get("daohangtotal"));
//    System.out.println("=====daohangtotal========"+daohangtotalstr);
    int daohangtotal=0;
    if(daohangtotalstr!=null&&!"".equals(daohangtotalstr)){
        daohangtotal=Integer.parseInt(daohangtotalstr);
    }
    StringBuffer sb=new StringBuffer();
    sb.append("[");
    //{"name":"推荐","code":"0"},
    for(int i=0;i<daohangtotal;i++){
        sb.append("{");
        String url=String.valueOf(param.get("daohang_url"+i));
        url=replaceApp(request,url);
        //System.out.println("===========url==111=="+url);
        sb.append("\"name\":\"").append(String.valueOf(param.get("daohang_name"+i))).append("\",");
        sb.append("\"url\":\"").append(url).append("\",");
        sb.append("\"code\":\"").append(String.valueOf(param.get("daohang_code"+i))).append("\"");
        sb.append("}");
        if(i<daohangtotal-1){
            sb.append(",");
        }
    }
    sb.append("]");
//    System.out.println("=======sb======="+sb.toString());
    out.print(sb.toString());
%>
