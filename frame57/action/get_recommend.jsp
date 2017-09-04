<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%!
    public String formatString(String newName) {
        newName = newName.replaceAll("\\\\", "\\\\\\\\");
        newName = newName.replaceAll("\"", "\\\\\"");
        newName = newName.replaceAll("\'", "\\\\\'");
        return newName;
    }
    public String getJsonStringFromMap (Map vodMap) {
        StringBuffer rec_vod_info =new StringBuffer("{");
        rec_vod_info.append("\"columncode\":\"").append(vodMap.get("columncode")).append("\",");
        rec_vod_info.append("\"programcode\":\"").append(vodMap.get("programcode")).append("\",");
        rec_vod_info.append("\"posterfilelist\":\"").append(vodMap.get("posterfilelist")).append("\",");
        rec_vod_info.append("\"mediaservices\":\"").append(vodMap.get("mediaservices")).append("\",");
        rec_vod_info.append("\"programtype\":\"").append(vodMap.get("programtype")).append("\",");
        rec_vod_info.append("\"programname\":\"").append(formatString((String)vodMap.get("programname"))).append("\"");
        rec_vod_info.append("}");
        return   rec_vod_info.toString();
    }
    public String getJsonString(List vodList,String programcode){
        int rec_num = vodList.size();
        int totalCount=vodList.size();
        int size=0;
        StringBuffer rec_vod_info =new StringBuffer("{\"programInfo\":[");
        if(rec_num>0){
            // 处理拼接字符串
            for(int i=0;i<rec_num;i++){
                Map vodMap = (Map)vodList.get(i);
                String  programId=(String)vodMap.get("programcode");
                if(programcode.equals(programId)){
                      // 相同的不取
                    totalCount--;
                }else{
                     if(size<7){
                         String vodInfo=getJsonStringFromMap(vodMap);
                         rec_vod_info.append(vodInfo);
                         if(i<rec_num-1){
                             rec_vod_info.append(",");
                         }
                         size++;
                     }
                }
            }
            rec_vod_info.append("],\"rec_num\":"+totalCount+"}");
        }else{
            rec_vod_info.append("],\"rec_num\":"+totalCount+"}");
        }
        return rec_vod_info.toString();
    }
%>
<%
    String columncode=request.getParameter("columncode");
    String programcode=request.getParameter("programcode");
    String validateSql= "columncode ='"+columncode+"'  and (programtype=1 or programtype=14)";
    List validateVod = new ArrayList();
%>
<ex:search tablename="user_vod" var="validateVodInfo" condition="<%=validateSql%>" curpagenum="1" pagecount="8" fields="*">
    <%
        List validateList =(ArrayList)pageContext.getAttribute("validateVodInfo");
        if(validateList!=null&&validateList.size()>0){
            for(int i=0;i<validateList.size();i++){
                Map vodInfo = (Map) validateList.get(i);
                validateVod.add(vodInfo);
            }
        }
    %>
</ex:search>
<%
    String resultLast=getJsonString(validateVod,programcode);
//    System.out.println("=====swb======get_recommend.jsp>>>resultLast>>"+resultLast);
    JspWriter ot=pageContext.getOut();
    ot.write(resultLast);
%>