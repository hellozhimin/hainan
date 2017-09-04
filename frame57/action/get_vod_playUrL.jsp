<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.zte.iptv.volcano.core.EpgResult" %>
<%
//    System.out.println("get_vod_playUrl.jsp-----qst--"+request.getQueryString());
    String programCodeArrayStr = request.getParameter("programList");
    if (programCodeArrayStr == null || programCodeArrayStr == "null") {
        programCodeArrayStr = " ";
    }
    String[] programCodeList = programCodeArrayStr.split(",");

    String vodListIndexStr = request.getParameter("vodListIndex");
    if (vodListIndexStr == null || vodListIndexStr == "null") {
        programCodeArrayStr = " ";
    }
    String[] vodListIndexList = vodListIndexStr.split(",");
    StringBuffer vodJsonDataOut = new StringBuffer();
    StringBuffer vodJsonData = new StringBuffer();
    vodJsonDataOut.append("[");
    int programCodeListLength = programCodeList.length;
    if (programCodeListLength > 0) {
        for (int i = 0; i < programCodeListLength; i++) {
            vodJsonData.append("{");
            String programcode = programCodeList[i];
            String vodListIndex=vodListIndexList[i];
            String sql = "programcode = '" + programcode + "'";
            String columncode="";
            String definition="1";
            String mediaservice="1";
            String playUrl="";
            String sql_detail = " mediaservice = " + mediaservice;
%>
<ex:search tablename="user_vod" fields="*" order="createtime desc" condition="<%=sql%>" var="programlist">
    <%
        List vodInfo = (ArrayList) pageContext.getAttribute("programlist");
        if (vodInfo != null && vodInfo.size() > 0) {
            Map map = (Map) vodInfo.get(0);
            columncode= String.valueOf(map.get("columncode"));
//            mediaservice= String.valueOf(map.get("mediaservices"));
        } else{
//            System.out.println(programcode+"---isNull!");
        }
    %>
</ex:search>
<ex:params var="params">
    <ex:param name="programcodeavailable" value="<%=programcode%>"/>
</ex:params>
<ex:search tablename="user_vod_detail" fields="*" inputparams="${params}" condition="<%=sql_detail%>"
           order="createtime desc" var="programlist_detail">
    <%
      List  vodDetailList = (ArrayList) pageContext.getAttribute("programlist_detail");
        if(vodDetailList!=null&&vodDetailList.size()>0){
//            System.out.println(vodDetailList);
            Map map = (Map) vodDetailList.get(0);
            definition = String.valueOf(map.get("definition"));
//            System.out.println("=====definition===="+definition);
        }
//        System.out.println("=====mediaservice===="+mediaservice);
    %>
</ex:search>    
<!--获取播放url-->
<ex:params var="inputhash">
    <ex:param name="authidsession" value=""/>
    <ex:param name="breakpoint" value="0"/>
    <ex:param name="mediaservice" value="<%=mediaservice%>"/>
    <ex:param name="definition" value="<%=definition%>"/>
    <ex:param name="programcode" value="<%=programcode%>"/>
</ex:params>
<ex:action name="vod_play" inputparams="${inputhash}" var="vodplay">
    <%
        EpgResult vodplay = (EpgResult) pageContext.getAttribute("vodplay");
        String returnCode=vodplay.getErrorCode();
        if ("0".equals(returnCode)) {//success
            playUrl = (String) vodplay.get("playurl");
        } else {
//            System.out.println(programcode+"---has not playUrl!");
        }
    %>
</ex:action>
<%
            vodJsonData.append("\"playUrl\":").append("\"").append(playUrl).append("\",");
            vodJsonData.append("\"vodListIndex\":").append("\"").append(vodListIndex).append("\",");
            vodJsonData.append("\"columncode\":").append("\"").append(columncode).append("\"},");
        }
        String temvodJsonDataToString=vodJsonData.toString();
        temvodJsonDataToString=temvodJsonDataToString.substring(0,temvodJsonDataToString.length()-1);
        vodJsonDataOut.append(temvodJsonDataToString);
    }
    vodJsonDataOut.append("]");
    JspWriter ot = pageContext.getOut();
//    System.out.println("----------vodJsonDataOut.toString()-----------"+vodJsonDataOut.toString());
    ot.write(vodJsonDataOut.toString());
%>