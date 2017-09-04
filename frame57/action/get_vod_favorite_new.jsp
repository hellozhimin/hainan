<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.zte.iptv.volcano.epg.util.PortalUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.zte.iptv.volcano.epg.content.VodProgram"%>
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
//    System.out.println("=====swb=====get_vod_favorite_new.jsp>>"+request.getQueryString());
    int destpage = Integer.parseInt(String.valueOf(request.getParameter("destpage")));
    int pageno = Integer.parseInt(String.valueOf(request.getParameter("pagecount")));
    StringBuffer sql = new StringBuffer();
    sql.append(" (favoritetype=1 or favoritetype=4 ) and state=1");
    List result = new ArrayList();
    Map vChannelData = new HashMap();
    List favList = new ArrayList();
    String totalcount="0";
%>
<ex:params var="inputparams">
    <ex:param name="unique" value="1"/>
</ex:params>
<ex:search tablename="user_favorite" fields="*" inputparams="${inputparams}" condition="<%=sql.toString()%>"
           var="vodFavList" order="savetime desc">
    <%
        result = (List) pageContext.getAttribute("vodFavList");
//        System.out.println("-----swb--------result-----------" + result);
    %>
</ex:search>
<%
    if (result != null && result.size() > 0) {
        for (int i = 0; i < result.size(); i++) {
            vChannelData = (Map) result.get(i);
            String favColumncode=(String) vChannelData.get("columncode");
            String vodsql = " columncode = '" + vChannelData.get("columncode") + "' and (programtype=1 or programtype=10 or programtype=14) and contentcode='" + vChannelData.get("contentcode") + "' and mediaservices&1!=0";
%>
<ex:params var="inputhash">
    <ex:param name="columnavailable" value="<%=favColumncode%>"/>
</ex:params>
<ex:search tablename="user_vod" fields="*" inputparams="${inputhash}" order="createtime desc" condition="<%=vodsql%>"
           var="programlist" curpagenum="1" pagecount="1">
    <%
        List vodData = (ArrayList) pageContext.getAttribute("programlist");
        if (vodData.size() > 0) {
            favList.add(vodData.get(0));
        }
    %>
</ex:search>
<%
        }
    }

    StringBuffer favsb=new StringBuffer();
    //输出数据
    favsb.append("{favData:[");
	if(favList.size()>0){
		int startIndex = (destpage-1)*pageno;
        int endIndex = destpage*pageno-1;
		
		for(int i=startIndex;i<=endIndex;i++){
			if(i<favList.size()){
				VodProgram favInfo=(VodProgram)favList.get(i);
                String posterfilelist=(String)favInfo.get("posterfilelist");
				favsb.append("{");
				favsb.append("columnCode:\""+favInfo.get("columncode")+"\",");
				favsb.append("programType:\""+favInfo.get("programtype")+"\",");
				favsb.append("programName:\""+favInfo.get("programname")+"\",");
				favsb.append("programCode:\""+favInfo.get("programcode")+"\",");
				favsb.append("seriesProgramCode:\""+favInfo.get("seriesprogramcode")+"\",");
				favsb.append("contentCode:\""+favInfo.get("contentcode")+"\",");
				favsb.append("normalPoster:\""+getNormalPoster(posterfilelist,"images/vod/poster_empty.png")+"\",");
				favsb.append("mediaServices:\""+favInfo.get("mediaservices")+"\",");
				String starlevel = String.valueOf(favInfo.get("starlevel"));
				favsb.append("starLevel:\""+starlevel+"\"");
				favsb.append("}");
				if(i<favList.size()-1){
				   favsb.append(",");
				}
			}
		}
	}
    favsb.append("],totalcount:\""+favList.size()+"\"}");
//    System.out.println("=====swb=====favsb>>> "+favsb.toString());
    String   favJSON="";
//    if(destpage == 1){
//        favJSON= "{favData:[{\"programName\":\"劫案密云11\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"\"}," +
//                "{\"programName\":\"超人归来11\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来11\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来11\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来11\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来11\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来11\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来11\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来11\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"冰雪奇缘11\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}],totalcount:28}";
//
//    } else if(destpage == 2){
//        favJSON= "{favData:[{\"programName\":\"劫案密云12\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"\"}," +
//                "{\"programName\":\"超人归来12\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来12\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来12\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来12\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来12\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来12\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来12\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"超人归来12\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"冰雪奇缘12\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}],totalcount:28}";
//    } else if(destpage == 3){
//        favJSON= "{favData:[{\"programName\":\"劫案密云1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"\"}," +
//                "{\"programName\":\"超人归来1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"zhuanti_list.jsp\"}," +
//                "{\"programName\":\"环太平洋1\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"机械战警12014\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"赤焰战1场\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"大闹天1宫\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"温暖的1尸体\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}," +
//                "{\"programName\":\"冰雪奇1缘\",\"programCode\":\"\", \"normalPoster\":\"images/portal/my/poster_img0_0.png\", \"columnCode\":\"xxxx\"}],totalcount:28}";
//    }
    JspWriter ot = pageContext.getOut();
    ot.write(favsb.toString());
   // ot.print(favJSON);
%>