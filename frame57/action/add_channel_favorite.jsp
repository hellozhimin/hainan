<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.zte.iptv.volcano.core.EpgResult" %>
<%@ page import="com.sun.org.apache.xpath.internal.SourceTree" %>
<%@ page import="com.zte.iptv.volcano.epg.account.User" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.axis.encoding.ser.ArrayDeserializer" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%--<%@include file="../inc/errmsg.jsp"%>--%>
<%--<%@include file="../inc/words.jsp"%>--%>
<epg:PageController/>
<%
    String contentId = request.getParameter("ContentID");
    String dirid = request.getParameter("dirid");
    if(dirid==null || "".equals(dirid)){
        dirid="0";
    }
    String subjectId = request.getParameter("SubjectID");
    String writeflag = request.getParameter("writeflag");
    //判断是否已经添加过收藏了
    boolean isfav = false;
    String checkFavoriteStr = "";
    User user = (User) session.getAttribute("user");
    String returnCode="";
    String errorMsg="";
//    checkFavoriteStr = "5|" + contentId + "|" + subjectId+"|"+dirid;
    StringBuffer sql = new StringBuffer();
    sql.append(" favoritetype=5  and state=1");
    StringBuffer sb = new StringBuffer();
%>
<ex:params var="inputparams">
    <ex:param name="unique" value="1"/>
</ex:params>
<ex:search tablename="user_favorite" fields="*" inputparams="${inputparams}" condition="<%=sql.toString()%>"
           var="vodFavList" order="savetime desc">
    <%
//        Map returnMap = (Map) pageContext.getAttribute("returnMap");
//        System.out.println("========returnMap======"+returnMap);
//        if (returnMap != null && "1".equals(String.valueOf(returnMap.get("state")))) {
////            isfav = true;
////            returnCode="0";  // 3.21
////            errorMsg=getErrorMsg(returnCode);
//        }
        List favoriteList = (ArrayList) pageContext.getAttribute("vodFavList");
//        System.out.println("--------favoriteList.size()---1111111----" + favoriteList);
        if (favoriteList != null) {
//            System.out.println("--------favoriteList.size()-------" + favoriteList);
            for (int i = 0; i < favoriteList.size(); i++) {
                Map tempMap = (Map) favoriteList.get(i);
                String contentcode=String.valueOf(tempMap.get("contentcode"));
                if(contentcode.equals(contentId)){
                    isfav=true;
                    if(subjectId!=null&&subjectId.equals("xxx")){
                        subjectId=String.valueOf(tempMap.get("columncode"));
                    }
                    break;
                }
            }
        }
    %>
</ex:search>
<%
    if (!isfav) {
%>
<ex:params var="inputparams">
    <ex:param name="terminalflag" value="1"/>
    <ex:param name="contentcode" value="<%=contentId%>"/>
    <ex:param name="columncode" value="<%=subjectId%>"/>
    <ex:param name="favoritetype" value="5"/>
    <ex:param name="limitaction" value="4"/>
    <ex:param name="dirid" value="0"/>
    <ex:param name="isshared" value="1"/>
    <ex:param name="userid" value="<%=user.getUserId()%>"/>
</ex:params>
<ex:action name="add_favorite" inputparams="${inputparams}" var="favresult">
    <%
        EpgResult favresult = (EpgResult) pageContext.getAttribute("favresult");
        returnCode=favresult.getErrorCode();
//        errorMsg=getErrorMsg(returnCode);
//        System.out.println("add_channelfav======returnCode=========="+returnCode);
//        System.out.println("add_channelfav======errorMsg=========="+errorMsg);
    %>
</ex:action>
<%
    } else{
%>
<ex:params var="inputparams">
    <ex:param name="contentcode" value="<%=contentId%>"/>
    <ex:param name="columncode" value="<%=subjectId%>"/>
    <ex:param name="favoritetype" value="5"/>
    <ex:param name="userid" value="<%=user.getUserId()%>"/>
</ex:params>
<ex:action name="del_favorite" inputparams="${inputparams}" var="favresult">
    <%
        EpgResult favresult = (EpgResult) pageContext.getAttribute("favresult");
        returnCode = favresult.getErrorCode();
    %>
</ex:action>
<%
    }

        sb.append("{returnCode:\"" + returnCode + "\",");
        sb.append("errorMsg:\"" + errorMsg + "\"}");
//        System.out.println("sb========================"+sb.toString());
        JspWriter ot = pageContext.getOut();
        ot.write(sb.toString());

%>

