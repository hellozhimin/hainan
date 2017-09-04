<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ include file="../inc/utils.jsp" %>

<%
    String columnid = request.getParameter("columnid");
    String columnid1 = request.getParameter("columnid1");
    String sessionid = request.getParameter("sessionid");
    String destpage = request.getParameter("destpage");
    String numperpage=request.getParameter("numperpage");
    if(numperpage==null){
        numperpage="8";
    }
    int  numperpageno=Integer.parseInt(numperpage);
    int destpageno=Integer.parseInt(destpage);
    String order = "sortnum desc";
    StringBuffer channelJsonData = new StringBuffer();
    channelJsonData.append("{param:[");
    String sql = "parentcode ='" + columnid + "'";
    String totalcount="0";
    String totalpages="0";
    if(columnid1!=null&&!"".equals(columnid1)){
%>
<ex:params var="inputhash">
    <ex:param name="columnavailable" value="<%=columnid%>"/>
</ex:params>
<ex:search tablename="user_column" fields="*" order="<%=order%>"
           inputparams="${inputhash}" condition="<%=sql.toString()%>" var="columnlist" curpagenum="<%=1%>" pagecount="100">
    <%

        int dataNum = 0;
        String columnCode = "";
        String columnName = "";
		String subExist = "";
		String hasPoster = "";
		String posterfilelist = "";
        List columnlistInfoList = (List) pageContext.getAttribute("columnlist");
        totalcount = String.valueOf(pageContext.getAttribute("totalcount"));
//        String pagenums =  String.valueOf(pageContext.getAttribute("pagenums"));
        int index=0;
        if (columnlistInfoList != null && columnlistInfoList.size() > 0) {
            dataNum = columnlistInfoList.size();
            for (int i = 0; i < dataNum; i++) {
                Map columnInfo = (Map) columnlistInfoList.get(i);
                columnCode = String.valueOf(columnInfo.get("columncode"));
                if(columnCode.equals(columnid1)){
                    index=i;
                    break;
                }
//                columnName = String.valueOf(columnInfo.get("columnname"));
//                channelJsonData.append("{");
//                channelJsonData.append("\"columnname\":\"").append(getJsonPattern(columnName)).append("\",");
//                channelJsonData.append("\"columncode\":\"").append(columnCode).append("\"");
//                channelJsonData.append("}");
//                if(i<dataNum-1){
//                    channelJsonData.append(",");
//                }
            }

           int a=index/numperpageno+1;
            destpageno=a;
            int pagenums=dataNum/numperpageno+1;
            totalpages=pagenums+"";
           int lastindex=0;
//            System.out.println(a+"========111========="+pagenums);
            if(a==pagenums) {
                lastindex=Integer.parseInt(totalcount)-(a-1)*numperpageno;
            } else{
                lastindex=numperpageno;
            }
            for(int j=0;j<lastindex;j++){
                int foucsindex=0;
                if((j+(a-1)*numperpageno)==index){
                    foucsindex=1;
                }
//                System.out.println(j+"================lastindex===="+lastindex+"====="+(j+(a-1)*numperpageno));
                Map columnInfo = (Map) columnlistInfoList.get((j+(a-1)*numperpageno));
                columnCode = String.valueOf(columnInfo.get("columncode"));
                columnName = String.valueOf(columnInfo.get("columnname"));
				subExist = String.valueOf(columnInfo.get("subexist"));
                hasPoster = String.valueOf(columnInfo.get("hasposter"));
                posterfilelist = String.valueOf(columnInfo.get("posterfilelist"));
				
				String imgUrl = "../images/poster/";
				if("1".equals(hasPoster)){
					String[] posterfiles = posterfilelist.split(";");
					if(posterfiles != null && posterfiles.length > 0){
						imgUrl += posterfiles[0];
					}
				}
                channelJsonData.append("{");
                channelJsonData.append("\"columnname\":\"").append(getJsonPattern(columnName)).append("\",");
                channelJsonData.append("\"index\":\"").append(foucsindex).append("\",");
                channelJsonData.append("\"columncode\":\"").append(columnCode).append("\"").append(",");
                channelJsonData.append("\"subexist\":\"").append(subExist).append("\"").append(",");
                channelJsonData.append("\"hasposter\":\"").append(hasPoster).append("\"").append(",");
                channelJsonData.append("\"imgUrl\":\"").append(imgUrl).append("\"");
                channelJsonData.append("}");
                if(j<lastindex-1){
                    channelJsonData.append(",");
                }
				//System.out.println("---------------1111111111------columnname:"+columnName);
            }
        }

    %>
</ex:search>
<%}else{%>
<ex:params var="inputhash">
    <ex:param name="columnavailable" value="<%=columnid%>"/>
</ex:params>
<ex:search tablename="user_column" fields="*" order="<%=order%>"
           inputparams="${inputhash}" condition="<%=sql.toString()%>" var="columnlist" curpagenum="<%=destpageno%>" pagecount="<%=numperpageno%>">
    <%

        int dataNum = 0;
        String columnCode = "";
        String columnName = "";
		String subExist = "";
		String hasPoster = "";
		String posterfilelist = "";
        List columnlistInfoList = (List) pageContext.getAttribute("columnlist");
        totalcount = String.valueOf(pageContext.getAttribute("totalcount"));
        totalpages = String.valueOf(pageContext.getAttribute("pagenums"));
        if (columnlistInfoList != null && columnlistInfoList.size() > 0) {
            dataNum = columnlistInfoList.size();
			
			//System.out.println("---------------------dataNum:"+dataNum);
				
            for (int i = 0; i < dataNum; i++) {
                Map columnInfo = (Map) columnlistInfoList.get(i);
                columnCode = String.valueOf(columnInfo.get("columncode"));
                columnName = String.valueOf(columnInfo.get("columnname"));
                subExist = String.valueOf(columnInfo.get("subexist"));
                hasPoster = String.valueOf(columnInfo.get("hasposter"));
                posterfilelist = String.valueOf(columnInfo.get("posterfilelist"));
				
				String imgUrl = "../images/poster/";
				if("1".equals(hasPoster)){
					String[] posterfiles = posterfilelist.split(";");
					if(posterfiles != null && posterfiles.length > 0){
						imgUrl += posterfiles[0];
					}
				}
				/*
				else{
					if(posterfilelist != null && posterfilelist.length > 0){
						String[] posterfiles = posterfilelist.split(";");
						if(posterfiles != null && posterfiles.length > 0){
							imgUrl += posterfiles[0];
						}
					}
				}
				*/
                channelJsonData.append("{");
                channelJsonData.append("\"columnname\":\"").append(getJsonPattern(columnName)).append("\",");
                channelJsonData.append("\"index\":\"").append(0).append("\",");
                channelJsonData.append("\"columncode\":\"").append(columnCode).append("\"").append(",");
                channelJsonData.append("\"subexist\":\"").append(subExist).append("\"").append(",");
                channelJsonData.append("\"hasposter\":\"").append(hasPoster).append("\"").append(",");
                channelJsonData.append("\"imgUrl\":\"").append(imgUrl).append("\"");
                channelJsonData.append("}");
                if(i<dataNum-1){
                    channelJsonData.append(",");
                }
				/*
				System.out.println("---------------------dataNum  -----------    i:"+i);
				Set keySet = columnInfo.keySet();
				for (Object key : keySet) {   
					System.out.println("key:" + key + "|value:" + columnInfo.get(key) + "                 ");     
				}  
				System.out.println("---------------------");
				*/
            }
        }
    %>
</ex:search>
<%}%>
<%
    channelJsonData.append("],\"totalcount\":\""+totalcount+"\",\"destpageno\":\""+destpageno+"\",\"totalpages\":\""+totalpages+"\"}");
    //System.out.println("====swb==channel_column--->" + channelJsonData.toString());
    out.print(channelJsonData);
%>