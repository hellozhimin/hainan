<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.*" %>
<%@ include file="../inc/utils.jsp" %>
        <%
           // String isHls = String.valueOf(getConfigurationByName(request,"isHls","0","UTF-8"));
            String isHls ="0";
            String mediaservice = (!"1".equals(isHls))?"1":"2";

            StringBuffer sb = new StringBuffer();
            StringBuffer JsonData = new StringBuffer();
            sb.append("{channels:[");
            String channelname="";
            String channelcode="";
            String mixno="";
            String usermixno="";
            String logo="";
            int length=0;
            String columnid= request.getParameter("columnid");
            String searchtype= request.getParameter("search");
            String sessionid = request.getParameter("sessionid");
            String fromtvod = request.getParameter("fromtvod");
            String sql = "columncode = '" + columnid + "' and mediaservices&"+mediaservice+"="+mediaservice;
            if(searchtype!=null&&!"".equals(searchtype)){
                sql=sql+" and tvodavailable = 1";
            }
            //System.out.println("YUAN========sql======================================" + sql);
        %>
        <ex:search tablename="user_channel" fields="channelname,channelcode,mixno,usermixno"
                   condition="<%=sql%>" order="sortnum desc" var="channelList"><!-- 修改直播节目排序问题 cny 2017/8/8 -->
            <%
                List channelData = (ArrayList) pageContext.getAttribute("channelList");
                List listcctv=new ArrayList();
                List listother=new ArrayList();
               System.out.println("========channelData========"+channelData.size());
                if(null!=channelData && channelData.size()>0)
                {
                        length = channelData.size();
                        for (int j = 0; j < length; j++) {
                            Map channelInfo = (Map) channelData.get(j);
                            channelname= (String) channelInfo.get("channelname");
//                            if(channelname.indexOf("CCTV")>-1){
//                                listcctv.add(channelInfo);
//                            }else{
//                                listother.add(channelInfo);
//                            }
                            channelcode= (String) channelInfo.get("channelcode");
                            mixno=(String) channelInfo.get("mixno");
                            usermixno=String.valueOf(channelInfo.get("usermixno")) ;
                            logo = String.valueOf(channelInfo.get("filename"));
                            JsonData.append("{channelname:\"" + getJsonPattern(channelname) + "\",");
                            JsonData.append("channelcode:\"" + channelcode + "\",");
                            JsonData.append("logo:\"" + logo + "\",");
                            JsonData.append("usermixno:\"" + mixno + "\",");
                            JsonData.append("mixno:\"" + usermixno + "\"},");
		                    //System.out.println("========usermixno:"+usermixno+"===mixno:"+mixno+"=====:getJsonPattern(channelname)"+getJsonPattern(channelname));
                        }
//                    System.out.println("========channelData===11111====="+listcctv);
//                    System.out.println("========channelData===222222====="+listother);
//                     for(int k=0;k<listother.size();k++){
//                          listcctv.add(listother.get(k));
//                     }
////                    System.out.println("========channelData====qqqq===="+listcctv);
////                    System.out.println("========channelData====qqqq=111==="+listcctv.size());
//                    for(int h=0;h<listcctv.size();h++){
//                        Map channelInfo = (Map) listcctv.get(h);
//                        channelname= (String) channelInfo.get("channelname");
//                           channelcode= (String) channelInfo.get("channelcode");
//                            mixno=(String) channelInfo.get("mixno");
//                            usermixno=String.valueOf(channelInfo.get("usermixno")) ;
//                            logo = String.valueOf(channelInfo.get("filename"));
//                            JsonData.append("{channelname:\"" + getJsonPattern(channelname) + "\",");
//                            JsonData.append("channelcode:\"" + channelcode + "\",");
//                            JsonData.append("logo:\"" + logo + "\",");
//                            JsonData.append("usermixno:\"" + mixno + "\",");
//                            JsonData.append("mixno:\"" + usermixno + "\"},");
//                    }
                }
            %>
        </ex:search>
     <%
       String JsonDatastr = JsonData.toString();
       if (JsonDatastr.length() > 0) {
       sb.append(JsonDatastr.substring(0, JsonDatastr.length() - 1));
       }
       sb.append("],sessionid:\""+sessionid+"\"}");
       JspWriter ot = pageContext.getOut();
       System.out.println("YUAN========sb=======================================" + sb.toString());
       ot.write(sb.toString());
       %>
