<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.zte.iptv.volcano.epg.util.PortalUtils" %>
<%@ page import="com.zte.iptv.volcano.epg.account.BookmarkInfo" %>
<%@ page import="com.zte.iptv.volcano.epg.content.VodProgram" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
 <%!
     /**
      * 获取影片的大海报
      * @param postfilelist 12张海报路径字符串
      * @return 影片的大海报URL
      **/
     public String getNormalPoster(String postfilelist, String defaultPoster) {
         if (null != postfilelist) {
             String[] tempArr = postfilelist.split(";");
             if (tempArr.length > 0 && !"".equals(tempArr[0])) {
                 return "../images/poster/" + tempArr[0];
             }
         }
         return defaultPoster;
     }
 %>
<%
//    System.out.println("=====swb=====get_bookmark.jsp?" + request.getQueryString());
    int destpage = Integer.parseInt(String.valueOf(request.getParameter("destpage")));
    int pagecount = Integer.parseInt(String.valueOf(request.getParameter("pagecount")));

    //用于存放书签的集合
   StringBuffer bookMarkJSON=new StringBuffer();
    List markList = new ArrayList();
    StringBuffer marksb = new StringBuffer("{markData:[");
    String markCondition = "state=1 and bookmarktype in(1,4)";
    List list=new ArrayList();
%>
<%--首先,先查询出书签--%>
<ex:search tablename="user_bookmark" fields="*" condition="<%=markCondition%>" var="bookmark"  order="savetime desc">
            <%
                markList=(ArrayList)pageContext.getAttribute("bookmark");
            %>
</ex:search>
<%--根据查询处的书签，再查询VOD等基本信息--%>
<%
    if(markList.size()>0){
        for(int i=0;i<markList.size();i++){
            BookmarkInfo bookmarkMap=(BookmarkInfo)markList.get(i);
            int breakpoint=(Integer)bookmarkMap.get("breakpoint");
            int bookmarkType=(Integer)bookmarkMap.get("bookmarktype");
//            System.out.println("=====swb=====bookmarkMap =====  "+i+"  bookmarkType>>> "+bookmarkType);
            String bookmarkColumncode=(String)bookmarkMap.get("columncode");
            String vodsql = " columncode  ='" + bookmarkMap.get("columncode") + "' and (programtype=1 or programtype=14) and contentcode='" + bookmarkMap.get("contentcode") + "' and mediaservices&1!=0";
//            System.out.println("=====swb=====vodsql=====>>> "+vodsql);
%>
            <ex:params var="vodinput">
                <ex:param name="columnavailable" value="<%=bookmarkColumncode%>" />
            </ex:params>
            <ex:search tablename="user_vod" inputparams="${vodinput}" pagecount="1" curpagenum="1" fields="*" var="vodInfo" condition="<%=vodsql%>" >
                   <%
                      List vodList=(ArrayList)pageContext.getAttribute("vodInfo");
                       if(vodList.size()>0){
                           Map mapTmp=(VodProgram)vodList.get(0);
                           mapTmp.put("breakpoint",breakpoint);
                           list.add(mapTmp);
                       }
                   %>
            </ex:search>
<%
        }//end for
    }//end if

    // 这里主要是由于连续剧单集在保存书签的时候也保存为了1所以需要进行过滤
    if(list.size()>0){

        int startIndex = (destpage-1)*pagecount;
        int endIndex = destpage*pagecount-1;

//        System.out.println("=====swb=====startIndex>>>"+startIndex+" endIndex>>>> "+endIndex);

        for (int i = startIndex; i <=endIndex; i++) {
            if(i<list.size()){
                Map vodMap = (VodProgram) list.get(i);
                String posterfilelist=(String)vodMap.get("posterfilelist");
                bookMarkJSON.append("{");
                bookMarkJSON.append("breakInfo:\"" + vodMap.get("breakpoint") + "\",");
                bookMarkJSON.append("columnCode:\"" + (String) vodMap.get("columncode") + "\",");
                bookMarkJSON.append("programType:\"" + (String) vodMap.get("programtype") + "\",");
                bookMarkJSON.append("programName:\"" + (String) vodMap.get("programname") + "\",");
                bookMarkJSON.append("programCode:\"" + (String) vodMap.get("programcode") + "\",");
                bookMarkJSON.append("seriesProgramCode:\"" + (String) vodMap.get("seriesprogramcode") + "\",");
                bookMarkJSON.append("contentCode:\"" + (String) vodMap.get("contentcode") + "\",");
                bookMarkJSON.append("normalPoster:\"" + getNormalPoster(posterfilelist,"images/vod/poster_empty.png") + "\",");
                bookMarkJSON.append("mediaServices:\"" + (String) vodMap.get("mediaservices") + "\"");
                bookMarkJSON.append("},");
            }
        }

    }
    String bookMarkJSONString=bookMarkJSON.toString();
    if(!"".equals(bookMarkJSONString)){
        bookMarkJSONString=bookMarkJSONString.substring(0,bookMarkJSONString.length()-1);
    }
     marksb.append(bookMarkJSONString);
     marksb.append("],totalcount:\""+list.size()+"\"}");
    //System.out.println("=====swb=====marksb>>> "+marksb.toString());
//    String markJSON = "";
//    if(destpage == 1){
//        markJSON= "{markData:[{\"programName\":\"劫案密云1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"\"}," +
//                "{\"programName\":\"超人归来1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"冰雪奇缘1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}],totalcount:28}";
//
//    } else if(destpage == 2){
//        markJSON= "{markData:[{\"programName\":\"劫案密云2\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"\"}," +
//                "{\"programName\":\"超人归来2\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来2\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来2\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来2\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来2\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来2\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来2\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来2\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"冰雪奇缘2\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}],totalcount:28}";
//    } else if(destpage == 3){
//        markJSON= "{markData:[{\"programName\":\"劫案密云\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"\"}," +
//                "{\"programName\":\"超人归来\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"环太平洋\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"机械战警2014\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"赤焰战场\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"大闹天宫\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"温暖的尸体\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"冰雪奇缘\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}],totalcount:28}";
//    }
//    System.out.println("=====swb======get_bookmark.jsp>>>"+marksb.toString());
	JspWriter ot = pageContext.getOut();
    ot.write(marksb.toString());
    //ot.print(markJSON);
	
%>



