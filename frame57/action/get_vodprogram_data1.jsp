<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ include file="../inc/utils.jsp" %>
<epg:PageController/>
<%
    String columnIdParam = request.getParameter("columnid");
    String programid = request.getParameter("programid");
    String sessionid = request.getParameter("sessionid");
    String sql = " columncode like '" + columnIdParam + "%' and mediaservices&1!=0 and (programtype=1 or programtype=14)";
    //最新查询的时候按发布时间和创建时间排序并允许查询的最大条数
   //  String order = "createtime desc";
//    System.out.println("=============sql====="+sql);
    String order = "sortnum desc";
    /*-------------*/
    String curpagenumStr = request.getParameter("curpage");
    String numperpageStr = request.getParameter("numperpage");
//    if (curpagenumStr == null || "".equals(curpagenumStr)) {
//        curpagenumStr = "1";
//    }
//    if (numperpageStr == null || "".equals(numperpageStr)) {
//        numperpageStr = "10";
//    }
//    int curpage = Integer.valueOf(curpagenumStr);
//    int numperpage = Integer.valueOf(numperpageStr);
    ArrayList vodList = new ArrayList();
    String totalcount = "";
%>
<ex:params var="inputhash">
    <ex:param name="columnavailable" value="<%=columnIdParam%>"/>
</ex:params>
<ex:search tablename="user_vod" fields="*" order="<%=order%>"
           inputparams="${inputhash}" condition="<%=sql%>" var="programlist"
           >
    <%
        vodList = (ArrayList) pageContext.getAttribute("programlist");
        if (null == vodList) vodList = new ArrayList();
        totalcount = String.valueOf(pageContext.getAttribute("totalcount"));
        if ("null".equals(totalcount)) {
            totalcount = "0";
        }
        String pagenums = String.valueOf(pageContext.getAttribute("pagenums"));
        if ("null".equals(pagenums)) {
            pagenums = "0";
        }
        StringBuffer sb = new StringBuffer();
        String columnId = "";
        String programId = "";
        String programType = "";
        String seriesprogramcode = "";
        String contentid = "";

        String programName = "";
        String actor = "";
        String year = "2011";
        String country = "";
        String season = "";
        String genre = "genre";
        String contentleng = "";
        String description = "";
        String normalposter = "";
        String posterfilelist = "";
        String offlinetime = "";
        String shorttitle = "";
        String isFav = "0";
        String mediaservices = "";
        String starlevel = "0";

        sb.append("{totalCount:\"" + totalcount + "\",sessionid:\"" + sessionid + "\",pagenums:\"" + pagenums + "\",vodData:[");
        int length = vodList.size();
        for (int i = 0; i < vodList.size(); i++) {
            String index="0";
            Map vodInfo = (Map) vodList.get(i);
            columnId = String.valueOf(vodInfo.get("columncode"));
            programId = String.valueOf(vodInfo.get("programcode"));
            programType = String.valueOf(vodInfo.get("programtype"));
            seriesprogramcode = String.valueOf(vodInfo.get("seriesprogramcode"));
            contentid = String.valueOf(vodInfo.get("contentcode"));
            programName = (String) vodInfo.get("programname");
            shorttitle = (String) vodInfo.get("shorttitle");
            genre = String.valueOf(vodInfo.get("genre"));
            season = String.valueOf(vodInfo.get("seriesseason"));
            year = String.valueOf(vodInfo.get("releasedate"));
            country = (String) vodInfo.get("countryname");
            offlinetime = String.valueOf(vodInfo.get("offlinetime"));
            description = (String) vodInfo.get("description");
            mediaservices = (String) vodInfo.get("mediaservices");
            contentleng = String.valueOf(vodInfo.get("elapsedtime"));
            starlevel = String.valueOf(vodInfo.get("starlevel"));
            if(programId.equals(programid)){
                index="1";
            }
            if (offlinetime.length() >= 10) {
                offlinetime = offlinetime.substring(8, 10) + "." + offlinetime.substring(5, 7) + "." + offlinetime.substring(0, 4);
            }
            posterfilelist = String.valueOf(vodInfo.get("posterfilelist"));
            normalposter = getNormalPoster(posterfilelist);
            programName = getJsonPattern(programName);
            shorttitle = getJsonPattern(shorttitle);
            description = getJsonPattern(description);
            country = getJsonPattern(country);
            genre = getJsonPattern(genre);
            if (i > 0 && i < length) {
                sb.append(",");
            }
            sb.append("{columnId:\"" + columnId + "\",");
            sb.append("programId:\"" + programId + "\",");
            sb.append("programType:\"" + programType + "\",");
            sb.append("seriesprogramcode:\"" + seriesprogramcode + "\",");
            sb.append("programName:\"" + programName + "\",");
            sb.append("seriesnum:\"" + vodInfo.get("seriesnum") + "\",");
            sb.append("contentid:\"" + contentid + "\",");
            sb.append("mediaservices:\"" + mediaservices + "\",");
            sb.append("index:\"" + index + "\"}");
        }
        sb.append("]}");
//        System.out.println( "=====swb======get_vodprogram_data.jsp>>>"+sb.toString());
        JspWriter ot = pageContext.getOut();
        ot.write(sb.toString());
    %>
</ex:search>