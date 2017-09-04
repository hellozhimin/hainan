<%@page contentType="text/html; charset=utf-8" %>
<%@page isELIgnored="false"%>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.json.*"%>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@page import="java.text.*" %>
<%@ page import="com.zte.iptv.volcano.frame.FrameUtil" %>
<%@ page import="com.zte.iptv.volcano.epg.account.User" %>
<%@ include file = "../utils/SubStringFunction.jsp"%>

<%!
    String requestAction = "";
    String userid = "";
    String contentCode = "";
    String programCode = "";
    String programType = "";
    String columnCode = "";
    String terminalflag = "1";
    String definition = "1";
    String authidsession = "";
	int len_px=1280;
    JSONObject obj = new JSONObject();
%>

<%
        UserInfo userInfo = (UserInfo) request.getSession().getAttribute(EpgConstants.USERINFO);
        userid = userInfo.getUserId();
        requestAction = request.getParameter("Action").toString();
        columnCode = request.getParameter("cat_id");
        if(null == columnCode){
            columnCode = "";
        }
    if(requestAction.equals("get_vod_detail_info"))
		{
       	obj.clear();
				String pCode =  (request.getParameter("global_code") != null) ? (String)request.getParameter("global_code") : "";
				String telecomCode =  (request.getParameter("telecom_code") != null) ? (String)request.getParameter("telecom_code") : "";
				String contentCode =  (request.getParameter("content_code") != null) ? (String)request.getParameter("content_code") : ""; 
				String categoryCode = (request.getParameter("column_code") != null) ? (String)request.getParameter("column_code") : "";   
				String pType = (request.getParameter("series_flag") != null) ? (String)request.getParameter("series_flag") : "0";
				StringBuffer programsql = new StringBuffer();
				programsql.append(" videotype = '28' ") ;
				/*
				StringBuffer judgeSeriesSql = new StringBuffer();
				judgeSeriesSql.append(" videotype = '28' ") ;
				if(telecomCode.equals("null"))
				{
							//out.print("telecom code is  null");
							if(pCode.equals("null"))
							{
										judgeSeriesSql.append("  and columncode = '").append(categoryCode).append("' ");
										%>
										<ex:params var="input">
										<ex:param name="contentcodeavailable" value="<%=contentCode%>"/>
										</ex:params>
										<c:set var="programsqlcon" value="<%=judgeSeriesSql.toString()%>"/>
										<ex:search tablename="user_vod" fields="*" inputparams="${input}"  condition="${programsqlcon}"  pagecount="100" var="detaillist">
										<%
										List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
										for (Map aVOD : list){
												if(null != aVOD.get("programtype")){
														programType = (String)(aVOD.get("programtype"));
												}
										}
										if(programType =="14")
										{
											pType ="1";
										}
										else
										{
											pType ="0";
										}
										%>
										</ex:search>
										<%
										 
							}
							else 
							{
									 	%>
										<ex:params var="input">
										<ex:param name="programcodeavailable" value="<%=pCode%>"/>
										</ex:params>
										<c:set var="programsqlcon" value="<%=judgeSeriesSql.toString()%>"/>
										<ex:search tablename="user_vod" fields="*" inputparams="${input}"  condition="${programsqlcon}"  pagecount="100" var="detaillist">
										<%
										List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
										for (Map aVOD : list){
												if(null != aVOD.get("programtype")){
														programType = (String)(aVOD.get("programtype"));
												}
												if(programType =="14")
												{
													pType ="1";
												}
												else
												{
													pType ="0";
												}
										
										}
										%>
										</ex:search>
										<%
							}
						}
						else
						{
									%>
									<ex:params var="input">
									<ex:param name="telecomcodeavailable" value="<%=telecomCode%>"/>
									</ex:params>
									<c:set var="programsqlcon" value="<%=judgeSeriesSql.toString()%>"/>
									<ex:search tablename="user_vod" fields="*" inputparams="${input}"  condition="${programsqlcon}"  pagecount="100" var="detaillist">
									<%
									List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
									for (Map aVOD : list){
											if(null != aVOD.get("programtype")){
													programType = (String)(aVOD.get("programtype"));
											}
											if(programType =="14")
												{
													pType ="1";
												}
												else
												{
													pType ="0";
												}
									}
									%>
									</ex:search>
									<%
				}
				*/
			//	pType ="0";
				if(pType.equals("0"))
				{
						if(telecomCode.equals("null"))
						{
							//out.print("telecom code is  null");
							if(pCode.equals("null"))
							{
										programsql.append("  and columncode = '").append(categoryCode).append("' ");
										%>
										<ex:params var="input">
										<ex:param name="contentcodeavailable" value="<%=contentCode%>"/>
										</ex:params>
										<c:set var="programsqlcon" value="<%=programsql.toString()%>"/>
										<ex:search tablename="user_vod_detail" fields="*" inputparams="${input}"  condition="${programsqlcon}"  pagecount="100" var="detaillist">
										<%
										List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
										for (Map aVOD : list){
												if(null != aVOD.get("programtype")){
														programType = (String)(aVOD.get("programtype"));
												}
												obj.put("result","1");
												obj.put("catCode",aVOD.get("columncode"));
												obj.put("programCode",aVOD.get("programcode"));
												obj.put("mediaName",aVOD.get("programname"));
												obj.put("seriesProgramCode",aVOD.get("seriesprogramcode"));
												obj.put("contentCode",aVOD.get("contentcode"));
												obj.put("actor",aVOD.get("actor"));
												obj.put("writer",aVOD.get("director"));
												obj.put("description",aVOD.get("detaildescribed"));
												obj.put("price","0");
												obj.put("telecomcode",aVOD.get("telecomcode"));
												obj.put("series_num",aVOD.get("seriesnum"));
												if(null != aVOD.get("poster1")){
														String picStr = (String)aVOD.get("poster1");
														picStr=picStr.replace("..","");
														obj.put("small_poster_url", picStr);
												}
												if(null != aVOD.get("poster2")){
														String picStr = (String)aVOD.get("poster2");
														picStr=picStr.replace("..","");
														obj.put("big_poster_url", picStr);
												}
										
										}
										%>
										</ex:search>
										<%
										obj.put("series_flag","0");
							}
							else
							{
									%>
								<ex:params var="input">
								<ex:param name="programcodeavailable" value="<%=pCode%>"/>
								</ex:params>
								<c:set var="programsqlcon" value="<%=programsql.toString()%>"/>
								<ex:search tablename="user_vod_detail" fields="*" inputparams="${input}"  condition="${programsqlcon}"  pagecount="100" var="detaillist">
								<%
								List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
								for (Map aVOD : list){
										if(null != aVOD.get("programtype")){
												programType = (String)(aVOD.get("programtype"));
										}
										obj.put("result","1");
										obj.put("catCode",aVOD.get("columncode"));
										obj.put("programCode",aVOD.get("programcode"));
										obj.put("mediaName",aVOD.get("programname"));
										obj.put("seriesProgramCode",aVOD.get("seriesprogramcode"));
										obj.put("contentCode",aVOD.get("contentcode"));
										obj.put("actor",aVOD.get("actor"));
										obj.put("writer",aVOD.get("director"));
										obj.put("description",aVOD.get("detaildescribed"));
										obj.put("price","0");
										obj.put("telecomcode",aVOD.get("telecomcode"));
										obj.put("series_num",aVOD.get("seriesnum"));
										if(null != aVOD.get("poster1")){
												String picStr = (String)aVOD.get("poster1");
												picStr=picStr.replace("..","");
												obj.put("small_poster_url", picStr);
										}
										if(null != aVOD.get("poster2")){
												String picStr = (String)aVOD.get("poster2");
												picStr=picStr.replace("..","");
												obj.put("big_poster_url", picStr);
										}
								
								}
								%>
								</ex:search>
								<%
								obj.put("series_flag","0");
							}
						}
						else
						{
								//out.print("telecom code is not null");
								%>
									<ex:params var="input">
									<ex:param name="telecomcodeavailable" value="<%=telecomCode%>"/>
									</ex:params>
									<c:set var="programsqlcon" value="<%=programsql.toString()%>"/>
									<ex:search tablename="user_vod_detail" fields="*" inputparams="${input}"  condition="${programsqlcon}"  pagecount="100" var="detaillist">
									<%
									List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
									for (Map aVOD : list){
											if(null != aVOD.get("programtype")){
													programType = (String)(aVOD.get("programtype"));
											}
											obj.put("result","1");
											obj.put("catCode",aVOD.get("columncode"));
											obj.put("programCode",aVOD.get("programcode"));
											obj.put("mediaName",aVOD.get("programname"));
											obj.put("seriesProgramCode",aVOD.get("seriesprogramcode"));
											obj.put("contentCode",aVOD.get("contentcode"));
											obj.put("actor",aVOD.get("actor"));
											obj.put("writer",aVOD.get("director"));
											obj.put("description",aVOD.get("detaildescribed"));
											obj.put("price","0");
											obj.put("telecomcode",aVOD.get("telecomcode"));
											obj.put("series_num",aVOD.get("seriesnum"));
											if(null != aVOD.get("poster1")){
													String picStr = (String)aVOD.get("poster1");
													picStr=picStr.replace("..","");
													obj.put("small_poster_url", picStr);
											}
											if(null != aVOD.get("poster2")){
													String picStr = (String)aVOD.get("poster2");
													picStr=picStr.replace("..","");
													obj.put("big_poster_url", picStr);
											}
									
									}
									%>
									</ex:search>
									<%
									obj.put("series_flag","0");
									
							
						}
				}
				else
				{
						if(telecomCode.equals("null"))
						{
								if(pCode.equals("null"))
								{
										StringBuffer seriessql = new StringBuffer();
										seriessql.append("  contentcode = '").append(contentCode).append("' ");
										seriessql.append("  and columncode = '").append(categoryCode).append("' ");
										%>
										<c:set var="seriessqlcon" value="<%=seriessql.toString()%>"/>
										<ex:search tablename="user_vod" fields="*"   condition="${seriessqlcon}"  pagecount="100" var="serieslist">
										<%
										List<Map> list = (List<Map>)pageContext.getAttribute("serieslist");
										for (Map aVOD : list){
												if(null != aVOD.get("programtype")){
												programType = (String)(aVOD.get("programtype"));
												}
												if(null != aVOD.get("programcode")){
												programCode = (String)(aVOD.get("programcode"));
												}
												
												obj.put("result","1");
												obj.put("programCode",aVOD.get("programcode"));
												obj.put("catCode",aVOD.get("columncode"));
												obj.put("mediaName",aVOD.get("programname"));
												obj.put("seriesProgramCode",aVOD.get("seriesprogramcode"));
												obj.put("contentCode",aVOD.get("contentcode"));
												obj.put("actor",aVOD.get("actor"));
												obj.put("writer",aVOD.get("director"));
												obj.put("description",aVOD.get("detaildescribed"));
												obj.put("price","0");
												obj.put("telecomcode",aVOD.get("telecomcode"));
												obj.put("series_num",aVOD.get("seriesnum"));
												if(null != aVOD.get("poster1")){
														String picStr = (String)aVOD.get("poster1");
														picStr=picStr.replace("..","");
														obj.put("small_poster_url", picStr);
												}
												if(null != aVOD.get("poster2")){
														String picStr = (String)aVOD.get("poster2");
														picStr=picStr.replace("..","");
														obj.put("big_poster_url", picStr);
												}
										
										
										}
										
										%>
										</ex:search>
										<%
										obj.put("series_flag","1");
										
										%>
										
										<ex:params var="input">
										<ex:param name="seriesprogramcodeavail" value="<%=programCode%>"/>
										</ex:params>
										<ex:search tablename="user_vod_detail" fields="*" inputparams="${input}"   pagecount="100" var="serieslist">
										<%
										List<Map> slist = (List<Map>)pageContext.getAttribute("serieslist");
										JSONArray arr = new JSONArray();
										for (Map series : slist){
												JSONObject seriesObj = new JSONObject();
												seriesObj.put("EpisodeIndex",series.get("seriesnum"));
												seriesObj.put("MediaCODE",series.get("programcode"));
												seriesObj.put("MediaID",series.get("programcode"));
												arr.add(seriesObj);
										}
										obj.put("series_info",arr);
										%>
										</ex:search>
										<%
								}
								else
								{
										StringBuffer seriessql = new StringBuffer();
										seriessql.append("programcode = '").append(pCode).append("' ");
										%>
										<c:set var="seriessqlcon" value="<%=seriessql.toString()%>"/>
										<ex:search tablename="user_vod" fields="*"   condition="${seriessqlcon}"  pagecount="100" var="serieslist">
										<%
										List<Map> list = (List<Map>)pageContext.getAttribute("serieslist");
										for (Map aVOD : list){
										if(null != aVOD.get("programtype")){
										programType = (String)(aVOD.get("programtype"));
										}
										obj.put("catCode",aVOD.get("columncode"));
										obj.put("programCode",aVOD.get("programcode"));
										obj.put("mediaName",aVOD.get("programname"));
										obj.put("seriesProgramCode",aVOD.get("seriesprogramcode"));
										obj.put("contentCode",aVOD.get("contentcode"));
										obj.put("actor",aVOD.get("actor"));
										obj.put("writer",aVOD.get("director"));
										obj.put("description",aVOD.get("detaildescribed"));
										obj.put("price","0");
										obj.put("series_num",aVOD.get("seriesnum"));
										obj.put("telecomcode",aVOD.get("telecomcode"));
										if(null != aVOD.get("poster1")){
										String picStr = (String)aVOD.get("poster1");
										picStr=picStr.replace("..","");
										obj.put("small_poster_url", picStr);
										}
										if(null != aVOD.get("poster2")){
										String picStr = (String)aVOD.get("poster2");
										picStr=picStr.replace("..","");
										obj.put("big_poster_url", picStr);
										}
										
										
										}
										
										%>
										</ex:search>
										<%
										obj.put("series_flag","1");
										%>
										<ex:params var="input">
										<ex:param name="seriesprogramcodeavail" value="<%=pCode%>"/>
										</ex:params>
										<ex:search tablename="user_vod_detail" fields="*" inputparams="${input}" pagecount="100" var="serieslist">
										<%
										List<Map> slist = (List<Map>)pageContext.getAttribute("serieslist");
										JSONArray arr = new JSONArray();
										for (Map series : slist){
										JSONObject seriesObj = new JSONObject();
										seriesObj.put("EpisodeIndex",series.get("seriesnum"));
										seriesObj.put("MediaCODE",series.get("programcode"));
										seriesObj.put("MediaID",series.get("programcode"));
										arr.add(seriesObj);
										}
										obj.put("series_info",arr);
										%>
										</ex:search>
										<%
								}
								
						}
						else
						{
										StringBuffer seriessql = new StringBuffer();
										seriessql.append("telecomcode = '").append(telecomCode).append("' ");
										%>
										<c:set var="seriessqlcon" value="<%=seriessql.toString()%>"/>
										<ex:search tablename="user_vod" fields="*"   condition="${seriessqlcon}"  pagecount="100" var="serieslist">
										<%
										List<Map> list = (List<Map>)pageContext.getAttribute("serieslist");
										for (Map aVOD : list){
										if(null != aVOD.get("programtype")){
										programType = (String)(aVOD.get("programtype"));
										}
										obj.put("catCode",aVOD.get("columncode"));
										obj.put("programCode",aVOD.get("programcode"));
										obj.put("mediaName",aVOD.get("programname"));
										obj.put("seriesProgramCode",aVOD.get("seriesprogramcode"));
										obj.put("contentCode",aVOD.get("contentcode"));
										obj.put("actor",aVOD.get("actor"));
										obj.put("writer",aVOD.get("director"));
										obj.put("description",aVOD.get("detaildescribed"));
										obj.put("price","0");
										obj.put("series_num",aVOD.get("seriesnum"));
										obj.put("telecomcode",aVOD.get("telecomcode"));
										if(null != aVOD.get("poster1")){
										String picStr = (String)aVOD.get("poster1");
										picStr=picStr.replace("..","");
										obj.put("small_poster_url", picStr);
										}
										if(null != aVOD.get("poster2")){
										String picStr = (String)aVOD.get("poster2");
										picStr=picStr.replace("..","");
										obj.put("big_poster_url", picStr);
										}
										
										
										}
										
										%>
										</ex:search>
										<%
										obj.put("series_flag","1");
										%>
										<ex:params var="input">
										<ex:param name="seriesprogramcodeavail" value="<%=pCode%>"/>
										</ex:params>
										<ex:search tablename="user_vod_detail" fields="*" inputparams="${input}" pagecount="100" var="serieslist">
										<%
										List<Map> slist = (List<Map>)pageContext.getAttribute("serieslist");
										JSONArray arr = new JSONArray();
										for (Map series : slist){
										JSONObject seriesObj = new JSONObject();
										seriesObj.put("EpisodeIndex",series.get("seriesnum"));
										seriesObj.put("MediaCODE",series.get("programcode"));
										seriesObj.put("MediaID",series.get("programcode"));
										arr.add(seriesObj);
										}
										obj.put("series_info",arr);
										%>
										</ex:search>
										<%
										
								
						}
				}
				%>
				<ex:params var="authParams">
				<ex:param name="contenttype"    value="<%=programType%>"/>
				<ex:param name="columncode"     value="<%=columnCode%>"/>
				<ex:param name="programcode"    value="<%=pCode%>"/>
				<ex:param name="terminalflag"   value="<%=terminalflag%>"/>
				<ex:param name="definition"     value="<%=definition%>"/>
				</ex:params>
				<ex:action name="auth" inputparams="${authParams}" var="authMap">
				<%
				JSONArray authArr = new JSONArray();
				Map authResult = (Map) pageContext.getAttribute("authMap");
				int flag = Integer.parseInt(authResult.get("_flag").toString());
				if(flag == 0){//auth success
				
						JSONObject authObj = new JSONObject();
						Vector vodData = (Vector) authResult.get("data");
						Map productInfo = (HashMap) vodData.get(0);
						authObj.put("TransactionId","");
						authObj.put("Ip","");
						authObj.put("Result","0");
						authObj.put("ResultDesc","");
						authObj.put("Mac","");
						authObj.put("LoginName","");
						authObj.put("ContentId",productInfo.get("ContentID"));
						authObj.put("ServiceId",productInfo.get("ServiceID"));
						authObj.put("StbId","");
						authObj.put("ExpiredTime",productInfo.get("ExpiredTime"));
						authObj.put("ProductId",productInfo.get("ProductID"));
						authArr.add(authObj);
				}
				else if(flag == 5)
				{
				
						Vector data = (Vector) authResult.get("data");
						Map productInfo = null;
						if(data != null && data.size()>0){
								for(int i = 0; i < data.size();i++){
										JSONObject authObj = new JSONObject();
										productInfo = (Map)data.get(i);
										authObj.put("TransactionId","");
										authObj.put("Ip","");
										authObj.put("Result","0");
										authObj.put("ResultDesc","");
										authObj.put("Mac","");
										authObj.put("LoginName","");
										authObj.put("ContentId",productInfo.get("ContentID"));
										authObj.put("ServiceId",productInfo.get("ServiceID"));
										authObj.put("StbId","");
										authObj.put("ExpiredTime",productInfo.get("ExpiredTime"));
										authObj.put("ProductId",productInfo.get("ProductID"));
										authArr.add(authObj);
								}
						}
				}
				else
				{
				
						String errorMsg = (String)authResult.get("_return_message");
						JSONObject authObj = new JSONObject();
						authObj.put("TransactionId","");
						authObj.put("Ip","");
						authObj.put("Result","0");
						authObj.put("ResultDesc",errorMsg);
						authObj.put("Mac","");
						authObj.put("LoginName","");
						authObj.put("ContentId","");
						authObj.put("ServiceId","");
						authObj.put("StbId","");
						authObj.put("ExpiredTime","");
						authObj.put("ProductId","");
						authArr.add(authObj);
				}
				obj.put("auth_info",authArr);
				%>
				</ex:action>
				<%
				if(null != obj.get("contentCode")){
				contentCode = (String)(obj.get("contentCode"));
				}
				if(null != obj.get("catCode")){
				columnCode = (String)(obj.get("catCode"));
				}
				//out.print(obj);
				StringBuffer favoritesql = new StringBuffer();
				favoritesql.append(" columncode = '").append(columnCode).append("' ");
				favoritesql.append(" and contentcode = '").append(contentCode).append("' ");
				
				%>
				<c:set var="favoritesqlcon" value="<%=favoritesql.toString()%>"/>
				<ex:search tablename="user_favorite" fields="*" condition="${favoritesqlcon}" var="favoritelist">
				<%
				List favoriteTempList = (List) pageContext.getAttribute("favoritelist");
				if(favoriteTempList != null && favoriteTempList.size() > 0){
				obj.put("favorite_info","1");
				}
				else
				{
				obj.put("favorite_info","0");
				}
				%>
				</ex:search>
				<%
				
				//categoryCode ="0100";
				//获取推荐vod
				StringBuffer recommendsql = new StringBuffer();
				recommendsql.append(" columncode = '").append(categoryCode).append("' ");
				recommendsql.append("  and (programtype='1' or programtype='14')");
				//recommendsql.append(" columncode <> ''");
				%>
				<c:set var="recommendsqlcon" value="<%=recommendsql.toString()%>"/>
				<ex:search tablename="user_vod" fields="*" condition="${recommendsqlcon}" var="recommendlist">
				<%
				List<Map> list = (List<Map>)pageContext.getAttribute("recommendlist");
				
				List<JSONObject> datalist = new ArrayList<JSONObject>();
				for (Map aFav : list){
						JSONObject oneFav = new JSONObject();
						oneFav.put("globalcode", aFav.get("programcode"));
						oneFav.put("contentcode", aFav.get("contentcode"));
						oneFav.put("title", aFav.get("programname"));
						oneFav.put("type", aFav.get("programtype"));
						oneFav.put("link",  "../epg/voddetail.htm?gc="+aFav.get("programcode"));
						if(null != aFav.get("poster1")){
								String picStr = (String)aFav.get("poster1");
								picStr=picStr.replace("..","");
								oneFav.put("picture", picStr);
						}
						else
						{
								oneFav.put("picture", "");
						}
						datalist.add(oneFav);
						
				}
				
				obj.put("recommends_info",datalist);
				%>
				</ex:search>
				<%
				JSONArray epgDetailArr = new JSONArray();
				epgDetailArr.add(obj);
				out.print(epgDetailArr.toString());
    }
    else if(requestAction.equals("get_vod_detail_order_info"))
    {
            obj.clear();

            String pCode =   request.getParameter("global_code").toString();
            StringBuffer programsql = new StringBuffer();

            programsql.append(" programcode = '").append(pCode).append("' ");
            obj.put("result","1");
%>


    <ex:params var="authParams">
            <ex:param name="contenttype"    value="<%=programType%>"/>
          <ex:param name="columncode"   value="<%=columnCode%>"/>
          <ex:param name="programcode"  value="<%=pCode%>"/>
          <ex:param name="terminalflag"     value="<%=terminalflag%>"/>
          <ex:param name="definition"   value="<%=definition%>"/>
    </ex:params>
    <ex:action name="auth" inputparams="${authParams}" var="authMap">
<%
        JSONArray authArr = new JSONArray();
        Map authResult = (Map) pageContext.getAttribute("authMap");
    int flag = Integer.parseInt(authResult.get("_flag").toString());
    if(flag == 0){//auth success

        JSONObject authObj = new JSONObject();
        Vector vodData = (Vector) authResult.get("data");
        Map productInfo = (HashMap) vodData.get(0);
        authObj.put("TransactionId","");
        authObj.put("Ip","");
        authObj.put("Result","0");
        authObj.put("ResultDesc","");
        authObj.put("Mac","");
        authObj.put("LoginName","");
        authObj.put("ContentId",productInfo.get("ContentID"));
        authObj.put("ServiceId",productInfo.get("ServiceID"));
        authObj.put("StbId","");
        authObj.put("ExpiredTime",productInfo.get("ExpiredTime"));
        authObj.put("ProductId",productInfo.get("ProductID"));
        authArr.add(authObj);
    }else if(flag == 5){

        Vector data = (Vector) authResult.get("data");
      Map productInfo = null;
      if(data != null && data.size()>0){
            for(int i = 0; i < data.size();i++){
                JSONObject authObj = new JSONObject();
                productInfo = (Map)data.get(i);
                authObj.put("TransactionId","");
                authObj.put("Ip","");
                authObj.put("Result","0");
                authObj.put("ResultDesc","");
                authObj.put("Mac","");
                authObj.put("LoginName","");
                authObj.put("ContentId",productInfo.get("ContentID"));
                authObj.put("ServiceId",productInfo.get("ServiceID"));
                authObj.put("StbId","");
                authObj.put("ExpiredTime",productInfo.get("ExpiredTime"));
                authObj.put("ProductId",productInfo.get("ProductID"));
                authArr.add(authObj);
            }
        }
    }else{

        String errorMsg = (String)authResult.get("_return_message");
        JSONObject authObj = new JSONObject();
        authObj.put("TransactionId","");
        authObj.put("Ip","");
        authObj.put("Result","0");
        authObj.put("ResultDesc",errorMsg);
        authObj.put("Mac","");
        authObj.put("LoginName","");
        authObj.put("ContentId","");
        authObj.put("ServiceId","");
        authObj.put("StbId","");
        authObj.put("ExpiredTime","");
        authObj.put("ProductId","");
        authArr.add(authObj);
    }
    obj.put("auth_info",authArr);
%>
</ex:action>
<%
        if(null != obj.get("contentcode")){
            contentCode = (String)(obj.get("contentcode"));
        }
        //obj.remove("contentcode");
        if(null != obj.get("catCode")){
            columnCode = (String)(obj.get("catCode"));
        }
        StringBuffer favoritesql = new StringBuffer();
        favoritesql.append(" columncode = '").append(columnCode).append("' ");
        favoritesql.append(" and contentcode = '").append(contentCode).append("' ");
%>
        <c:set var="favoritesqlcon" value="<%=favoritesql.toString()%>"/>
        <ex:search tablename="user_favorite" fields="*" condition="${favoritesqlcon}" var="favoritelist">
<%
        List favoriteTempList = (List) pageContext.getAttribute("favoritelist");
        if(favoriteTempList != null && favoriteTempList.size() > 0){
            obj.put("favorite_info","1");
        }
        else
        {
            obj.put("favorite_info","0");
        }
%>
    </ex:search>
<%

            if("14".equals(programType)){
                    //obj.remove("programtype");
                    obj.put("series_flag","1");
                    String seriesPCode = "";
                    if(null != obj.get("seriesprogramcode")){
                        seriesPCode = (String)(obj.get("seriesprogramcode"));
                    }
                    //obj.remove("seriesprogramcode");
%>
    <ex:params var="input">
    <ex:param name="seriesprogramcodeavail" value="<%=seriesPCode%>"/>
  </ex:params>
    <ex:search tablename="user_vod_detail" fields="*" inputparams="${input}" pagecount="100" var="serieslist">
<%
                    List<Map> slist = (List<Map>)pageContext.getAttribute("serieslist");
                    JSONArray arr = new JSONArray();
                    for (Map series : slist){
                        JSONObject seriesObj = new JSONObject();
                        seriesObj.put("EpisodeIndex",series.get("seriesnum"));
                        seriesObj.put("MediaCODE",series.get("programcode"));
                        seriesObj.put("MediaID",series.get("programcode"));
                        arr.add(seriesObj);
                    }
                    obj.put("series_info",arr);
%>
        </ex:search>
<%
        }
        else
        {
            obj.put("series_flag","0");
        }
        JSONArray epgDetailArr = new JSONArray();
        epgDetailArr.add(obj);
        out.print(epgDetailArr.toString());
    }
    else if (requestAction.equals("service_order"))
		{
				obj.clear();

        String pCode =   request.getParameter("global_code").toString();
        String productID =   request.getParameter("product_id").toString();
        String puchaseType =   request.getParameter("puchase_type").toString();
        String contentID =   request.getParameter("content_id").toString();
        
        
		
				%>
		    <ex:params var="orderParams">
				<ex:param name="action"    value="1"/>
				<ex:param name="contenttype"    value="1"/>
				<ex:param name="isautocontinue"     value="0"/>
				<ex:param name="productid"    value="<%=productID%>"/>
				<ex:param name="puchasetype"   value="<%=puchaseType%>"/>
				</ex:params>
				<ex:action name="subscribe" inputparams="${orderParams}" var="authMap">
				<%
				JSONArray authArr = new JSONArray();
				Map authResult = (Map) pageContext.getAttribute("authMap");
				int flag = Integer.parseInt(authResult.get("_flag").toString());
				if(flag == 0){//auth success
				
						JSONObject authObj = new JSONObject();
						Vector vodData = (Vector) authResult.get("data");
						Map productInfo = (HashMap) vodData.get(0);
						authObj.put("TransactionId","");
						authObj.put("Ip","");
						authObj.put("Result","0");
						authObj.put("ResultDesc","");
						authObj.put("Mac","");
						authObj.put("LoginName","");
						authObj.put("ContentId",productInfo.get("ContentID"));
						authObj.put("ServiceId",productInfo.get("ServiceID"));
						authObj.put("StbId","");
						authObj.put("ExpiredTime",productInfo.get("ExpiredTime"));
						authObj.put("ProductId",productInfo.get("ProductID"));
						authArr.add(authObj);
				}
				else if(flag == 5)
				{
				
						Vector data = (Vector) authResult.get("data");
						Map productInfo = null;
						if(data != null && data.size()>0){
								for(int i = 0; i < data.size();i++){
										JSONObject authObj = new JSONObject();
										productInfo = (Map)data.get(i);
										authObj.put("TransactionId","");
										authObj.put("Ip","");
										authObj.put("Result","0");
										authObj.put("ResultDesc","");
										authObj.put("Mac","");
										authObj.put("LoginName","");
										authObj.put("ContentId",productInfo.get("ContentID"));
										authObj.put("ServiceId",productInfo.get("ServiceID"));
										authObj.put("StbId","");
										authObj.put("ExpiredTime",productInfo.get("ExpiredTime"));
										authObj.put("ProductId",productInfo.get("ProductID"));
										authArr.add(authObj);
								}
						}
				}
				else
				{
				
						String errorMsg = (String)authResult.get("_return_message");
						JSONObject authObj = new JSONObject();
						authObj.put("TransactionId","");
						authObj.put("Ip","");
						authObj.put("Result","0");
						authObj.put("ResultDesc",errorMsg);
						authObj.put("Mac","");
						authObj.put("LoginName","");
						authObj.put("ContentId","");
						authObj.put("ServiceId","");
						authObj.put("StbId","");
						authObj.put("ExpiredTime","");
						authObj.put("ProductId","");
						authArr.add(authObj);
				}
				obj.put("auth_info",authArr);
				%>
				</ex:action>
				<%
		
		}
    else if(requestAction.equals("get_play_info"))
    {
        obj.clear();
        String pCode =  (request.getParameter("global_code") != null) ? (String)request.getParameter("global_code") : "";
				String telecomCode =  (request.getParameter("telecom_code") != null) ? (String)request.getParameter("telecom_code") : "";
				if(telecomCode.equals("null"))
				{
						%>
		        <ex:params var="input">
		        <ex:param name="programcodeavailable" value="<%=pCode%>"/>
		    		</ex:params>
		        <ex:search tablename="user_vod_detail" fields="*" inputparams="${input}" pagecount="100" var="detaillist">
						<%
		            List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
		            if(list.size() > 0){
		                Map detailMap = (Map)(list.get(0));
		                obj.put("MediaName",detailMap.get("programname"));
		                obj.put("contentcode",detailMap.get("contentcode"));
		                obj.put("bookMarkFlag","0");
		            }
						%>
		        </ex:search>
						<%
		        StringBuffer programsql = new StringBuffer();
		        programsql.append(" programcode = '").append(pCode).append("' ");
						%>
		    		<c:set var="programsqlcon" value="<%=programsql.toString()%>"/>
		    		<ex:search tablename="user_vod_detail" fields="*" condition="${programsqlcon}" pagecount="100" var="detaillist">
						<%
		            List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
		            for (Map aFav : list){
		                if(null != aFav.get("programtype")){
		                    programType = (String)(aFav.get("programtype"));
		                }
		            }
						%>
						</ex:search>
				<%
				}
				else
				{
						%>
		        <ex:params var="input">
		        <ex:param name="telecomcodeavailable" value="<%=telecomCode%>"/>
		    		</ex:params>
		        <ex:search tablename="user_vod_detail" fields="*" inputparams="${input}" pagecount="100" var="detaillist">
						<%
		            List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
		            if(list.size() > 0){
		                Map detailMap = (Map)(list.get(0));
		                obj.put("MediaName",detailMap.get("programname"));
		                obj.put("contentcode",detailMap.get("contentcode"));
		                 if(null != detailMap.get("programcode")){
		                    pCode = (String)(detailMap.get("programcode"));
		                }
		                obj.put("bookMarkFlag","0");
		            }
						%>
		        </ex:search>
						<%
		        StringBuffer programsql = new StringBuffer();
		        programsql.append(" telecomcode = '").append(telecomCode).append("' ");
						%>
		    		<c:set var="programsqlcon" value="<%=programsql.toString()%>"/>
		    		<ex:search tablename="user_vod_detail" fields="*" condition="${programsqlcon}" pagecount="100" var="detaillist">
						<%
		            List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
		            for (Map aFav : list){
		                if(null != aFav.get("programtype")){
		                    programType = (String)(aFav.get("programtype"));
		                }
		            }
						%>
						</ex:search>
				<%
				}
				%>
								
				<ex:params var="authParams">
            <ex:param name="contenttype"    value="<%=programType%>"/>
          	<ex:param name="columncode"   value="<%=columnCode%>"/>
          	<ex:param name="programcode"  value="<%=pCode%>"/>
          	<ex:param name="terminalflag"     value="<%=terminalflag%>"/>
          	<ex:param name="definition"   value="<%=definition%>"/>
    		</ex:params>
    		<ex:action name="auth" inputparams="${authParams}" var="authMap">
				<%
        JSONArray authArr = new JSONArray();
        Map authResult = (Map) pageContext.getAttribute("authMap");
    		int flag = Integer.parseInt(authResult.get("_flag").toString());
    		if(flag == 0){//auth success
		        JSONObject authObj = new JSONObject();
		        Vector vodData = (Vector) authResult.get("data");
		        Map productInfo = (HashMap) vodData.get(0);
		        authidsession = (String)productInfo.get("AuthorizationID");
    		}
				%>
				</ex:action>
        <ex:params var="inputPlayParams">
            <ex:param name="authidsession"  value="<%=authidsession%>"/>
          <ex:param name="programcode"  value="<%=pCode%>"/>
        </ex:params>
        <ex:action name="vod_play" inputparams="${inputPlayParams}" var="playMap">
				<%
        Map result = (Map) pageContext.getAttribute ("playMap");
        String playurl = String.valueOf (result.get("playurl"));
        obj.put("mediaUrl",playurl);
				%>
        </ex:action>
				<%
        if(null != obj.get("contentcode")){
            contentCode = (String)(obj.get("contentcode"));
        }
        if(null != obj.get("catCode")){
            columnCode = (String)(obj.get("catCode"));
        }

        StringBuffer bookMarksql = new StringBuffer();
        bookMarksql.append(" columncode = '").append(columnCode).append("' ");
        bookMarksql.append(" and contentcode = '").append(contentCode).append("' ");
				%>
        <c:set var="bookMarksqlcon" value="<%=bookMarksql.toString()%>"/>
        <ex:search tablename="user_bookmark"  fields="*"  condition="${bookMarksqlcon}" var="bookmarklist">
				<%
        List bookmarkTemplist = (List) pageContext.getAttribute("bookmarklist");
        if(bookmarkTemplist != null && bookmarkTemplist.size() > 0){
            obj.put("bookMarkFlag","1");
            Map bookmarkMap = (Map)(bookmarkTemplist.get(0));
            String bookMarkTime = String.valueOf(bookmarkMap.get("savetime"));
            obj.put("bookMarkTime",bookMarkTime);
        }
				%>
        </ex:search>
				<%
        //JSONArray epgPlayArr = new JSONArray();
		  List<JSONObject> epgPlayArr = new ArrayList<JSONObject>();
        epgPlayArr.add(obj);
        out.print(epgPlayArr.toString());

    } 
    else if(requestAction.equals("get_tvod_info"))
    {
/**
 * Action   get_tvod_metadata
 * input parameter: schedule_code=UT20131021210010674508
 * Response: [{'result':1,'mediaUrl':'rtsp://10.0.1.78:554/1334/UT20131021210010674508?AuthInfo=6htPniNAT95U0Ho3e6dhrN6CRz3jAEJP9CZLwoZNAPa1F7%2BJPllJPgMniDM%2Bp6O0gJt0MxxMk%2FBehWBAiP9uAKB6FU%2BcuzymjKfMzNC5%2B%2Bb0a2nyyoIYfstM255iRPEx&userID=IPTVSD003&requestIP=172.25.41.41&itemID=UT20131021210010674508&itemType=1&startTime=&cmsType=1&CMSId=','MediaName':'%E7%BB%8F%E6%B5%8E%E5%8D%8A%E5%B0%8F%E6%97%B6','duration_str':'00:33:00','starttime':'1382546880000','endtime':'1382548860000'}]
 */
        obj.clear();
        String scheduleCode = request.getParameter("schedule_proId").toString();
        String channelCode = "";
        programType="4";//4：TVOD
        //out.print("prevuecode"+scheduleCode);
%>
        <ex:params var="input">
        <ex:param name="prevuecode" value="<%=scheduleCode%>"/>
        <ex:param name="unique" value="1"/>
        </ex:params>
        <ex:search tablename="user_channelprevue_record" fields="*" inputparams="${input}" pagecount="1" curpagenum="1" var="detaillist">
<%
            List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
            if(list.size() > 0){
                Map detailMap = (Map)(list.get(0));
                //obj.put("starttime","1382201700000");
                SimpleDateFormat sdf_start = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
                Date startdate = sdf_start.parse(detailMap.get("begintime").toString());
                obj.put("starttime",startdate.getTime() );
                //obj.put("endtime","1382204460000");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
                Date enddate = sdf.parse(detailMap.get("endtime").toString());
                obj.put("endtime",enddate.getTime() );
                long duration_second = (enddate.getTime()-startdate.getTime()) / 1000;
                long hour_val=duration_second / 3600;
                long minute_val=(duration_second - hour_val * 3600) / 60;
                long second_val=duration_second % 60;
                String hour_str = (hour_val > 9)? hour_val+"" : "0"+hour_val;
                String minute_str = (minute_val > 9)? minute_val+"" : "0"+minute_val;
                String second_str = (second_val > 9)? second_val+"" : "0"+second_val;
                obj.put("duration_str",""+hour_str+":"+minute_str+":"+second_str);//obj.put("duration_str","00:46:00");
                obj.put("MediaName",detailMap.get("prevuename").toString());
                channelCode=detailMap.get("channelcode").toString();
            }
           // out.print(channelCode+"list.size==="+list.size() );
%>
        </ex:search>

        <ex:params var="input">
            <ex:param name="channelcode" value="<%=channelCode%>"/>
        </ex:params>
        <ex:search tablename="user_sub_channel" fields="*" inputparams="${input}" pagecount="1" curpagenum="1" var="channellist">
<%
            List<Map> list = (List<Map>)pageContext.getAttribute("channellist");
            if(list.size() > 0){
                Map detailMap = (Map)(list.get(0));
                columnCode=detailMap.get("columncode").toString();
            }
            //out.println(list.size()+"columnCode"+columnCode);
%>
        </ex:search>

        <ex:params var="authParams">
            <ex:param name="terminalflag" value="<%=terminalflag%>"/>
            <ex:param name="contenttype" value="<%=programType%>"/>
            <ex:param name="columncode" value="<%=columnCode%>"/>
            <ex:param name="definition"  value="<%=definition%>"/>
            <ex:param name="programcode" value="<%=scheduleCode%>"/>
        </ex:params>
        <ex:action name="auth" inputparams="${authParams}" var="authMap">
<%
        JSONArray authArr = new JSONArray();
        Map authResult = (Map) pageContext.getAttribute("authMap");
        int flag = Integer.parseInt(authResult.get("_flag").toString());
        if(flag == 0){//auth success
            JSONObject authObj = new JSONObject();
            Vector vodData = (Vector) authResult.get("data");
            Map productInfo = (HashMap) vodData.get(0);
            authidsession = (String)productInfo.get("AuthorizationID");
        }
        //out.println("authidsession"+authidsession);
%>
        </ex:action>
        <ex:params var="inputPlayParams">
            <ex:param name="authidsession"  value="<%=authidsession%>"/>
            <ex:param name="prevuecode"     value="<%=scheduleCode%>"/>
            <ex:param name="channelcode"    value="<%=channelCode%>"/>
        </ex:params>
        <ex:action name="tvod_play" inputparams="${inputPlayParams}" var="playMap">
<%
        Map result = (Map) pageContext.getAttribute ("playMap");
        String playurl = String.valueOf (result.get("playurl"));
        String result_flag=result.get("_flag").toString();
        obj.put("result",result_flag.equals("1") ? 0 : 1);
        obj.put("err_code",result.get("_error_code"));
        obj.put("err_text",result.get("_return_message"));
        obj.put("mediaUrl",playurl);
%>
        </ex:action>

<%
        JSONArray epgPlayArr = new JSONArray();
        epgPlayArr.add(obj);
        out.print(epgPlayArr.toString());

    } else if(requestAction.equals("tvod_one_channel_list")){		//---------------------------need
/**
 * Action   get_live_tv_info
 * input parameter: channel_code=00000001000000050000000000000055
 * Response: [{"result":1, "err_code":0,"err_text":"","dataDetail":{ "cur_schedule_info":[{"StartTime":"15:27:00","ScheduleName":"%E6%AD%A3%E9%98%B3%E9%97%A8%E4%B8%8B%284%29"}],"next_schedule_info":[{"StartTime":"16:15:00","ScheduleName":"%E6%AD%A3%E9%98%B3%E9%97%A8%E4%B8%8B%285%29"},{"StartTime":"17:08:00","ScheduleName":"%E7%AC%AC%E4%B8%80%E5%8A%A8%E7%94%BB%E4%B9%90%E5%9B%AD"},{"StartTime":"18:02:00","ScheduleName":"%E5%AF%BB%E5%AE%9D"}]}}]
 */
        obj.clear();
        String channelCode = request.getParameter("channelId").toString();
		len_px = Integer.parseInt(request.getParameter("len_px")==null?"1280":request.getParameter("len_px"));
       
	   	Integer prevCount = Integer.parseInt(request.getParameter("prevCount")==null?"99":request.getParameter("prevCount"));	//回看节目单数量
		Integer nextCount = Integer.parseInt(request.getParameter("nextCount")==null?"99":request.getParameter("nextCount"));	//正播和节目预告数量
	   
	    //Date nowCalendar = Calendar.getInstance();
        SimpleDateFormat sdf_now = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
        Date now_date = new Date();
        String now_time_string=sdf_now.format(now_date);//"begintime":"2013.10.16 18:30:00","endtime":"2013.10.16 19:00:00"
		String start_time_string = now_time_string.substring(0,10)+" 00:00:00";
        
		
		User user = (User)session.getAttribute("user");
		
		JSONArray channel_content_list = new JSONArray();
		int cur_channel_content_index = 0;
		
		JSONObject dataDetail = new JSONObject();
        StringBuffer currTvodSql = new StringBuffer();
        currTvodSql.append(" channelcode = '").append(channelCode).append("'");
        currTvodSql.append(" and begintime >= '").append(start_time_string).append("'");
        currTvodSql.append(" and endtime <= '").append(now_time_string).append("'");
%>
        <c:set var="tvodChannsqlcon" value="<%=currTvodSql.toString()%>"/>
        <ex:search tablename="user_channelprevue" fields="*" condition="${tvodChannsqlcon}" var="currenttvod">
<%
        List<Map> list = (List<Map>)pageContext.getAttribute("currenttvod");
		if(list.size()>prevCount){
			cur_channel_content_index = prevCount;
		}else{
			cur_channel_content_index = list.size();
		}
		
		JSONArray current_arr = new JSONArray();
        for (int k=(list.size()-cur_channel_content_index);k<list.size();k++){
            JSONObject currSchObj = new JSONObject();
            String f_starttime = list.get(k).get("begintime").toString();
            currSchObj.put("time", f_starttime.substring(11,19));
            currSchObj.put("name",list.get(k).get("prevuename"));
			currSchObj.put("proID",list.get(k).get("prevuecode"));
			//currSchObj.put("proID",list.get(k).get("prevueid"));
			currSchObj.put("cut_name",subStringFunction(list.get(k).get("prevuename").toString(),1,len_px));
			String tmp_prevuecode = list.get(k).get("prevuecode").toString();
			
			currSchObj.put("play_status",FrameUtil.getRecordStatus(user,tmp_prevuecode));
			
            current_arr.add(currSchObj);//currjson
        }
        //dataDetail.put("cur_schedule_info",current_arr);
		channel_content_list.addAll(current_arr);
		
/*        JSONArray current_arr = new JSONArray();
        for (Map currschedules : list){
            JSONObject currSchObj = new JSONObject();
            String f_starttime = currschedules.get("begintime").toString();
            currSchObj.put("time", f_starttime.substring(11,19));
            currSchObj.put("name",currschedules.get("prevuename"));
			currSchObj.put("cut_name",subStringFunction(currschedules.get("prevuename").toString(),1,120));
			
            //JSONArray currjson = JSONArray.fromObject(currSchObj);
            current_arr.add(currSchObj);//currjson
        }
        //dataDetail.put("cur_schedule_info",current_arr);
		channel_content_list.addAll(current_arr);
*/		
		
%>
        </ex:search>
<%

		java.util.Calendar calendar = java.util.Calendar.getInstance();
		String dateStr = (calendar.get(java.util.Calendar.MONTH)+1)>10?(""+(calendar.get(java.util.Calendar.MONTH)+1)):("0"+(calendar.get(java.util.Calendar.MONTH)+1));
		String max_end_time = calendar.get(java.util.Calendar.YEAR)+"."+dateStr+"."+(calendar.get(java.util.Calendar.DATE)+1)+" 00:00:00";

        StringBuffer nextTvodSql = new StringBuffer();
        nextTvodSql.append(" channelcode = '").append(channelCode).append("'");
        nextTvodSql.append(" and endtime >= '").append(now_time_string).append("'");
		nextTvodSql.append(" and endtime <= '").append(max_end_time).append("'");
        //nextTvodSql.append(" order by begintime limit 3 ");
%>

        <c:set var="nextTvodSqlcon" value="<%=nextTvodSql.toString()%>"/>
        <ex:search tablename="user_channelprevue" fields="*" order="begintime asc" pagecount="<%=nextCount%>" curpagenum="1" condition="${nextTvodSqlcon}" var="nexttvod">
<%
        List<Map> listn = (List<Map>)pageContext.getAttribute("nexttvod");
        JSONArray next_arr = new JSONArray();
        for (Map nextschedules : listn){
            JSONObject nextSchObj = new JSONObject();
            String f_starttime = nextschedules.get("begintime").toString();
            nextSchObj.put("time", f_starttime.substring(11,19));
            nextSchObj.put("name",nextschedules.get("prevuename"));
			nextSchObj.put("proID",nextschedules.get("prevuecode"));
			//nextSchObj.put("proID",nextschedules.get("prevueid"));
			nextSchObj.put("cut_name",subStringFunction(nextschedules.get("prevuename").toString(),1,len_px));
            //JSONArray nextjson = JSONArray.fromObject(nextSchObj);
            next_arr.add(nextSchObj);
        }
       // dataDetail.put("next_schedule_info",next_arr);
	   channel_content_list.addAll(next_arr);
%>
        </ex:search>
<%
        /*obj.put("result",1);
        obj.put("err_code","");
        obj.put("err_text","");
        obj.put("dataDetail",dataDetail);*/
        //JSONArray json = JSONArray.fromObject(obj);
       // response.getWriter().write(json.toString());
	   JSONArray json = new JSONArray();
	   JSONObject tvodList = new JSONObject();
	   tvodList.put("tvodList",channel_content_list);
	   tvodList.put("cur_channel_content_index",cur_channel_content_index);
	   json.add(tvodList);
	   out.print(json.toString());
	   
    } else if(requestAction.equals("category_channles")){			//----------------------need
/**
 * Action   epg_basic
 * input parameter: user_id=IPTVSD003&user_token=D90C66341B8787D1E040A8C017BC33E3
 * Response: [{"result":"1","dataDetail":[{"UserToken":"gAZ5EH0GFK53F@3lsIGz7Hc133004339","UserID":"guestpc","GroupPath":"","PicServerUrl":"","MetaServerUrl":"","3AAddress":"","ClientIP":""}],"channelList":[{"ChannelCode":"ch00000000000000001002","ChannelID":"ch00000000000000001002","UserChannelID":"1","HasAuth":"1","TimeShift":"60","ChannelName":"测试频道-1"},{"ChannelCode":"ch00000000000000001001","ChannelID":"ch00000000000000001001","UserChannelID":"2","HasAuth":"1","TimeShift":"60","ChannelName":"测试频道-2"}]}]
 
 * Response: [{"ChannelCode":"ch00000000000000001002","ChannelID":"ch00000000000000001002","UserChannelID":"1","HasAuth":"1","TimeShift":"60","ChannelName":"测试频道-1"},{"ChannelCode":"ch00000000000000001001","ChannelID":"ch00000000000000001001","UserChannelID":"2","HasAuth":"1","TimeShift":"60","ChannelName":"测试频道-2"}]
 
 */
            obj.clear();//
            String subCategoryId =  request.getParameter("subCategoryId")==null?"02":request.getParameter("subCategoryId");
            String userToken =  request.getParameter("user_token")==null?"":request.getParameter("user_token");
            String userId = request.getParameter("user_id")==null?"":request.getParameter("user_id");
            obj.put("result","1");
            JSONObject dataDetailObj = new JSONObject();
            JSONArray dataArr = new JSONArray();
            dataDetailObj.put("UserToken","");
            dataDetailObj.put("UserID","");
            dataDetailObj.put("GroupPath","");
            dataDetailObj.put("PicServerUrl","");
            dataDetailObj.put("MetaServerUrl","");
            dataDetailObj.put("3AAddress","");
            dataDetailObj.put("ClientIP","");
            dataArr.add(dataDetailObj);
            //obj.put("dataDetail",dataArr);
 
  		 JSONArray channel_list = new JSONArray();
       
						StringBuffer sqlChannel = new StringBuffer();
						sqlChannel.append(" columncode='"+subCategoryId+"'");
						 
						%>
						
						<c:set var="sqlChannelcon" value="<%=sqlChannel.toString()%>"/>
						<ex:params var="input">
						<ex:param name="unique" value="1"/>
						</ex:params>
       			<ex:search tablename="user_channel" fields="*" pagecount="5" condition="${sqlChannelcon}" var="channlist">
       	
      
						<%			  
            List<Map> list = (List<Map>)pageContext.getAttribute("channlist");
            JSONArray arr = new JSONArray();
            for (Map channel : list){
                JSONObject channObj = new JSONObject();
                channObj.put("CODE",channel.get("channelcode"));
                channObj.put("ChannelID",channel.get("channelcode"));
                channObj.put("ChannelIndex",channel.get("mixno"));
                channObj.put("HasAuth",channel.get("tvavailable"));
                channObj.put("TimeShift",channel.get("tsavailable"));
                channObj.put("TVODavailable",channel.get("tvodavailable"));
                channObj.put("ChannelName",channel.get("channelname"));
                channel_list.add(channObj);
            }
            //obj.put("channelList",arr);
%>
        </ex:search>
<%
    JSONArray epgBasicArr = new JSONArray();
    epgBasicArr.add(obj);
    out.print(channel_list.toString());
    }else if(requestAction.equals("test")){
%>
<ex:search tablename="user_vod" fields="*" pagecount="100" var="favlist">
<%
            List<Map> list = (List<Map>)pageContext.getAttribute("favlist");
            StringBuffer sb = new StringBuffer();
            for (Map aFav : list){
                sb.append(aFav.get("programcode"));
                sb.append(",");
                sb.append(aFav.get("programname"));
                sb.append(",");
                sb.append(aFav.get("programtype"));
                sb.append(",");
                sb.append(aFav.get("videotype"));
                sb.append(",");
                sb.append(aFav.get("contentcode"));
                sb.append(",");
                sb.append(aFav.get("poster1"));
                sb.append(",");
                sb.append(aFav.get("columncode"));
                sb.append("\n");

            }

            out.print(sb.toString());
            out.flush();
%>
        </ex:search>
<%
    }
    else if(requestAction.equals("testcolumn")){
        %>
        <ex:search tablename="user_column" fields="*" pagecount="100" var="favlist">
        <%
                    List<Map> list = (List<Map>)pageContext.getAttribute("favlist");
                   // out.print(list);
                    StringBuffer sb = new StringBuffer();
                    for (Map aFav : list){
                    out.print(aFav);
                        sb.append(aFav.get("columncode"));
                        sb.append(",");
                        sb.append(aFav.get("columnname"));
                        sb.append(",");
                        sb.append(aFav.get("parentcode"));
                        sb.append(",");
                        sb.append(aFav.get("columntype"));
                        sb.append(",");
                        sb.append(aFav.get("sortnum"));
                        sb.append(",");
                        sb.append(aFav.get("posterfilelist"));
                        sb.append(",");
                        sb.append(aFav.get("poster1"));
                        sb.append("\n");

                    }

                    out.print(sb.toString());
                    out.flush();
        %>
                </ex:search>
        <%
    }
    else if(requestAction.equals("get_trailer_info"))
    {
            String userToken = request.getParameter("global_code").toString();
            List<Map> list = (List<Map>)pageContext.getAttribute("favlist");
            StringBuffer sb = new StringBuffer();

            sb.append("[{'result':'1', 'trailerType':'1','UserChannelID':'3','MediaCODE':'"+request.getParameter("global_code").toString()+"'}]");//sb.append("[{'result':'0' }]");
            out.print(sb.toString());
            out.flush();

    }
    else if(requestAction.equals("get_live_tv_info"))
    {
            StringBuffer sb = new StringBuffer();

            sb.append("[{'result':'0' }]");
            out.print(sb.toString());
            out.flush();

    }
    else if(requestAction.equals("add_favorite"))
    {
            //String r_user_id =  (String)request.getParameter("user_id");
            String contentcode = (String)request.getParameter("content_code");  //必传
            String favoritetype = (request.getParameter("favorite_type") != null) ? (String)request.getParameter("favorite_type") : "1";


            String terminalflag = (request.getParameter("terminalflag") != null) ? (String)request.getParameter("terminalflag") : "1";
            String isshared = (request.getParameter("isshared") != null) ? (String)request.getParameter("isshared") : "1";
            String columncode = (request.getParameter("column_code") != null) ? (String)request.getParameter("column_code") : "";
            String limitaction = (request.getParameter("limitaction") != null) ? (String)request.getParameter("limitaction") : "1";
            String dirid = (request.getParameter("dirid") != null) ? (String)request.getParameter("dirid") : "0";
            // out.print("contentcode="+contentcode+"&favoritetype="+favoritetype+"&terminalflag="+terminalflag+"&isshared=="+isshared);
            // out.print("columncode="+columncode+"&limitaction="+limitaction+"&dirid="+dirid );
            
            %>

            <ex:params var="inputhash">
                   <ex:param name="contentcode" value="<%=contentcode%>"/>
                   <ex:param name="terminalflag" value="<%=terminalflag%>"/>
                   <ex:param name="isshared" value="<%=isshared%>"/>
                   <ex:param name="columncode" value="<%=columncode%>"/>
                   <ex:param name="favoritetype" value="<%=favoritetype%>"/>
                   <ex:param name="limitaction" value="<%=limitaction%>"/>
                   <ex:param name="dirid" value="<%=dirid%>"/>
            </ex:params>
            <ex:action name="add_favorite" inputparams="${inputhash}" var="addFav">
            <%

            Map result = (Map) pageContext.getAttribute("addFav");
            int flag = Integer.parseInt(String.valueOf(result.get("_flag")));
            if(flag == 0)
            {
                flag =1;
            }
            else
            {
             flag = 0;
            }
            String errorCode = String.valueOf (result.get ("_error_code"));
            String returnMessage = String.valueOf (result.get ("_return_message"));

            JSONObject resultObj = new JSONObject();
            resultObj.put("result", Integer.toString(flag));
            resultObj.put("err_code", errorCode);
            resultObj.put("err_text", returnMessage);

            JSONArray json = JSONArray.fromObject(resultObj);
            response.getWriter().write(json.toString());

            %>
            </ex:action>
            <%
    }
    else if(requestAction.equals("remove_favorite"))
    {

            String r_user_id = (String)request.getParameter("user_id");

        String contentcode = (String)request.getParameter("content_code");  //必传
        String favoritetype = (request.getParameter("favorite_type") != null) ? (String)request.getParameter("favorite_type") : "1";
        String columncode = (request.getParameter("column_code") != null) ? (String)request.getParameter("column_code") : "";
        %>

        <ex:params var="inputhash">
               <ex:param name="contentcode" value="<%=contentcode%>"/>
               <ex:param name="columncode" value="<%=columncode%>"/>
               <ex:param name="favoritetype" value="<%=favoritetype%>"/>
        </ex:params>
        <ex:action name="del_favorite" inputparams="${inputhash}" var="delFav">
        <%
        Map result = (Map) pageContext.getAttribute("delFav");
        int flag = Integer.parseInt(String.valueOf(result.get("_flag")));
        if(flag == 0)
            {
                flag =1;
            }
            else
            {
             flag = 0;
            }
        String errorCode = String.valueOf (result.get ("_error_code"));
        String returnMessage = String.valueOf (result.get ("_return_message"));

        JSONObject resultObj = new JSONObject();
        resultObj.put("result", Integer.toString(flag));
        resultObj.put("err_code", errorCode);
        resultObj.put("err_text", returnMessage);

        JSONArray json = JSONArray.fromObject(resultObj);
        response.getWriter().write(json.toString());

        %>
        </ex:action>
        <%
    }
    else if(requestAction.equals("get_favorite_list"))
    {
        String r_user_id= (String)request.getParameter("user_id");
        StringBuffer sql = new StringBuffer();
        sql.append(" userid='").append(r_user_id).append("'");
        String favorite_list_div_id =(String)request.getParameter("favorite_list_div_id");
        %>

        <c:set var="sqlcon" value="<%=sql.toString()%>"/>
        <ex:params var="input">
        <ex:param name="unique" value="1"/>
    </ex:params>
        <ex:search tablename="user_favorite" fields="*" order="savetime desc"  inputparams="${input}" condition="${sqlcon}" curpagenum="${param.pageNo}" pagecount="${param.numPage}" var="favlist">
        <%
        List<Map> list = (List<Map>)pageContext.getAttribute("favlist");
        String totalcount = String.valueOf (pageContext.getAttribute ("totalcount"));
        JSONObject jallmarks = new JSONObject();
        jallmarks.put("result","1");
        jallmarks.put("err_code","0");
        jallmarks.put("err_text", "");
        jallmarks.put("perPageCount",(String)request.getParameter("perPageCount")); //因为是全集， 这个参数没有意义了
        jallmarks.put("favorite_total", totalcount);
        jallmarks.put("favorite_list_div_id", favorite_list_div_id);

        int perPageCount= Integer.parseInt((String)request.getParameter("perPageCount")) ;
        double pages=(double)(Integer.parseInt(totalcount))/perPageCount;//列表页数
        int totalPage=(int)Math.ceil(pages);
        jallmarks.put("pageCount",totalPage);

        List<JSONObject> datalist = new ArrayList<JSONObject>();
        for (Map aFav : list){
            JSONObject oneFav = new JSONObject();
            oneFav.put("D_ID", "");
            oneFav.put("D_USERID", aFav.get("userid"));
            oneFav.put("D_ITEMTYPE", aFav.get("favoritetype"));
            oneFav.put("D_TMTYPE", aFav.get("terminalflag"));
            oneFav.put("D_EPGID", "");
            oneFav.put("RN", "");
            oneFav.put("D_FAVORITETYPE", aFav.get("favoritetype"));
            oneFav.put("D_GLOBAL_CODE", aFav.get("contentcode"));
            oneFav.put("D_ITEMNAME", aFav.get("favoritename"));
            oneFav.put("D_CATALOGID", aFav.get("columncode"));
            oneFav.put("D_URL", "");
            //获取图片
            String tempContentcode = (String)aFav.get("contentcode");
            String tempColumncode = (String)aFav.get("columncode");
            StringBuffer detailPicSql = new StringBuffer();
            detailPicSql.append("  contentcode = '").append(tempContentcode).append("' ");
            detailPicSql.append("  and columncode = '").append(tempColumncode).append("' ");
            %>
             	<c:set var="detailPicSqlcon" value="<%=detailPicSql.toString()%>"/>
         			<ex:search tablename="user_vod" fields="*"   condition="${detailPicSqlcon}"  pagecount="100" var="detaillist">
            <%
            List<Map> detailList = (List<Map>)pageContext.getAttribute("detaillist");
            for (Map aVOD : detailList){
               
                if(null != aVOD.get("poster1")){
              		String picStr = (String)aVOD.get("poster1");
              		picStr=picStr.replace("..","");
              		oneFav.put("small_poster_url", picStr);
        				}
        				if(null != aVOD.get("poster2")){
              		String picStr = (String)aVOD.get("poster2");
              		picStr=picStr.replace("..","");
              		oneFav.put("big_poster_url", picStr);
        				}
            }
           	%>
            </ex:search>
            <%
            ///获取图片结束
            datalist.add(oneFav);
        }

        jallmarks.put("data", datalist);
        JSONArray json = JSONArray.fromObject(jallmarks);
        response.getWriter().write(json.toString());
        %>
        </ex:search>
        <%
    }
    else if(requestAction.equals("save_bookmark"))
    {


     ///
        String r_global_code =  (String)request.getParameter("global_code");
        String r_bookmark_type = "1";//(String)request.getParameter("bookmark_type");
        String r_bookmark_breakpoint = (String)request.getParameter("bookmark_time");
        String r_bookmark_cotentcode ="";
        String r_bookmark_columncode="";
         %>
        <ex:params var="input">
    <ex:param name="programcodeavailable" value="<%=r_global_code%>"/>
    </ex:params>
        <ex:search tablename="user_vod_detail" fields="*" inputparams="${input}"  condition="${programsql}"  pagecount="100" var="detaillist">
        <%
            List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
            for (Map aVOD : list){
                if(null != aVOD.get("contentcode")){
                      r_bookmark_cotentcode = (String)(aVOD.get("contentcode"));
                }
                if(null != aVOD.get("columncode")){
                      r_bookmark_columncode = (String)(aVOD.get("columncode"));
                }


            }

    %>
    </ex:search>
        <ex:params var="inputhash">
            <ex:param name="terminalflag" value="1"/>
            <ex:param name="isshared" value="1"/>
            <ex:param name="contentcode" value="<%=r_bookmark_cotentcode%>"/>
            <ex:param name="breakpoint" value="<%=r_bookmark_breakpoint%>"/>
            <ex:param name="columncode" value="<%=r_bookmark_columncode%>"/>
            <ex:param name="bookmarktype" value="<%=r_bookmark_type%>"/>
            <ex:param name="limitaction" value="1"/>
        </ex:params>
        <ex:action name="add_bookmark" inputparams="${inputhash}" var="addBookmark">
        <%
            Map result = (Map) pageContext.getAttribute ("addBookmark");
            int flag = Integer.parseInt(String.valueOf(result.get("_flag")));
            if(flag == 0)
            {
                flag =1;
            }
            else
            {
             flag = 0;
            }
            String errorCode = String.valueOf (result.get ("_error_code"));
            String errorMsg = String.valueOf (result.get ("_return_message"));

            JSONObject resultObj = new JSONObject();
            resultObj.put("result", flag);
            resultObj.put("err_code", errorCode);
            resultObj.put("err_text", errorMsg);

            JSONArray json = JSONArray.fromObject(resultObj);
            response.getWriter().write(json.toString());
        %>
        </ex:action>
        <%
    }
    else if(requestAction.equals("delete_bookmark_list"))
    {

        String r_global_code =  (String)request.getParameter("bookmark_list_id");
        String r_bookmark_type = "1";//(String)request.getParameter("bookmark_type");
        String r_bookmark_columncode =  (String)request.getParameter("column_code");
        %>

        <ex:params var="inputhash">
            <ex:param name="contentcode" value="<%=r_global_code%>"/>
            <ex:param name="columncode" value="<%=r_bookmark_columncode%>"/>
            <ex:param name="bookmarktype" value="<%=r_bookmark_type%>"/>
        </ex:params>
        <ex:action name="del_bookmark" inputparams="${inputhash}" var="delBookmark">
        <%
            Map result = (Map) pageContext.getAttribute ("delBookmark");
            int flag = Integer.parseInt(String.valueOf(result.get("_flag")));
            if(flag == 0)
            {
                flag =1;
            }
            else
            {
             flag = 0;
            }
            String errorCode = String.valueOf (result.get ("_error_code"));
            String errorMsg = String.valueOf (result.get ("_return_message"));

            JSONObject resultObj = new JSONObject();
            resultObj.put("result", flag);
            resultObj.put("err_code", errorCode);
            resultObj.put("err_text", errorMsg);

            JSONArray json = JSONArray.fromObject(resultObj);
            response.getWriter().write(json.toString());
        %>
        </ex:action>
        <%
    }
    else if(requestAction.equals("get_bookmark_list"))
    {
        String r_user_id= (String)request.getParameter("user_id");
        String bookmark_list_div_id =(String)request.getParameter("bookmark_list_div_id");
        StringBuffer bookMarksql = new StringBuffer();
        bookMarksql.append(" userid = '").append(r_user_id).append("'");

        %>

        <c:set var="bookMarksqlcon" value="<%=bookMarksql.toString()%>"/>
        <ex:search tablename="user_bookmark"  fields="*"  condition="${bookMarksqlcon}" var="bookmarklist">
        <%




        List<Map> list = (List<Map>)pageContext.getAttribute("bookmarklist");

        String totalcount = String.valueOf (pageContext.getAttribute ("totalcount"));
        JSONObject jallmarks = new JSONObject();
        jallmarks.put("result","1");
        jallmarks.put("err_code","0");
        jallmarks.put("err_text", "");
        jallmarks.put("perPageCount",Integer.parseInt((String)request.getParameter("perPageCount"))); //因为是全集， 这个参数没有意义了
        jallmarks.put("bookmark_total", totalcount);
        jallmarks.put("bookmark_list_div_id", bookmark_list_div_id);



        int perPageCount= Integer.parseInt((String)request.getParameter("perPageCount"));
        double pages=(double)(Integer.parseInt(totalcount))/perPageCount;//列表页数
        int totalPage=(int)Math.ceil(pages);
        jallmarks.put("pageCount",totalPage);

        List<JSONObject> datalist = new ArrayList<JSONObject>();
        for (Map aFav : list){
            JSONObject oneFav = new JSONObject();
            oneFav.put("D_ID", aFav.get("contentcode"));
            oneFav.put("D_USERID", aFav.get("userid"));
            oneFav.put("D_BOOKMARKTYPE", aFav.get("bookmarktype"));
            oneFav.put("D_TMTYPE", aFav.get("terminalflag"));
            oneFav.put("D_EPGID", "");
            oneFav.put("RN", "");
            oneFav.put("D_CONTENT_CODE", aFav.get("contentcode"));
            String tempContentCode = (String)aFav.get("contentcode");
            %>
		        <ex:params var="input">
		        <ex:param name="contentcodeavailable" value="<%=tempContentCode%>"/>
		    		</ex:params>
		        <ex:search tablename="user_vod_detail" fields="*" inputparams="${input}" pagecount="100" var="detaillist">
						<%
		            List<Map> detaillist = (List<Map>)pageContext.getAttribute("detaillist");
		            if(detaillist.size() > 0){
		                Map detailMap = (Map)(detaillist.get(0));
		                oneFav.put("D_GLOBAL_CODE", detailMap.get("programcode"));
		            }
						%>
		        </ex:search>
		        <%
            oneFav.put("D_BOOKMARK_TIME", aFav.get("breakpoint"));
            oneFav.put("D_CATALOGID", aFav.get("columncode"));
            oneFav.put("D_ITEMNAME", aFav.get("bookmarkname"));
            //获取图片
            String tempContentcode = (String)aFav.get("contentcode");
            String tempColumncode = (String)aFav.get("columncode");
            StringBuffer detailPicSql = new StringBuffer();
            detailPicSql.append("  contentcode = '").append(tempContentcode).append("' ");
            detailPicSql.append("  and columncode = '").append(tempColumncode).append("' ");
            %>
             	<c:set var="detailPicSqlcon" value="<%=detailPicSql.toString()%>"/>
         			<ex:search tablename="user_vod" fields="*"   condition="${detailPicSqlcon}"  pagecount="100" var="detaillist">
            <%
            List<Map> detailList = (List<Map>)pageContext.getAttribute("detaillist");
            for (Map aVOD : detailList){
               
                if(null != aVOD.get("poster1")){
              		String picStr = (String)aVOD.get("poster1");
              		picStr=picStr.replace("..","");
              		oneFav.put("small_poster_url", picStr);
        				}
        				if(null != aVOD.get("poster2")){
              		String picStr = (String)aVOD.get("poster2");
              		picStr=picStr.replace("..","");
              		oneFav.put("big_poster_url", picStr);
        				}
            }
           	%>
            </ex:search>
            <%
            ///获取图片结束
            datalist.add(oneFav);
        }

        jallmarks.put("data", datalist);
        JSONArray json = JSONArray.fromObject(jallmarks);
        response.getWriter().write(json.toString());
        %>
        </ex:search>
<%
            }else if(requestAction.equals("get_tvod_channellist")){
            obj.clear();
            StringBuffer tvodChannSql = new StringBuffer();
            tvodChannSql.append(" tvodavailable = '").append("1").append("'");
            tvodChannSql.append("  and columncode='0J'");
            //tvodChannSql.append(" order by mixno ");
%>
        <c:set var="tvodChannsqlcon" value="<%=tvodChannSql.toString()%>"/>
        <ex:search tablename="user_channel" fields="*" condition="${tvodChannsqlcon}" var="tvodchannlist">
<%
            List<Map> list = (List<Map>)pageContext.getAttribute("tvodchannlist");
            JSONArray arr = new JSONArray();
            for (Map channel : list){
                JSONObject channObj = new JSONObject();
                channObj.put("ChannelCode",channel.get("channelcode"));
                channObj.put("ChannelID",channel.get("channelcode"));
                channObj.put("UserChannelID",channel.get("mixno"));
                channObj.put("HasAuth",channel.get("tvavailable"));
                channObj.put("TimeShift",channel.get("tsavailable"));
                channObj.put("ChannelName",channel.get("channelname"));
                arr.add(channObj);
            }
            obj.put("result","1");
            obj.put("channelList",arr);
            JSONArray json = JSONArray.fromObject(obj);
            response.getWriter().write(json.toString());
%>
        </ex:search>
<%
} else if(requestAction.equals("vodList")) {
        //检测有没有子分类
        String  subCategoryFlag="";
        String r_column_code=(String)request.getParameter("subCategoryId");
		int length =  Integer.parseInt(request.getParameter("length")==null?"1000":request.getParameter("length"));	//单次查询最大数（翻页修改）
		    String vodPosterFlag = (request.getParameter("posterflag") != null) ? (String)request.getParameter("posterflag") : "0";			
		String station = "1";//从指定位置开始获取（翻页上层传递）
		  //out.print("<br>");
					//out.print(r_column_code);
				//	out.flush();

       len_px = Integer.parseInt(request.getParameter("len_px")==null?"1280":request.getParameter("len_px"));	
                 StringBuffer prog_sql = new StringBuffer();
                prog_sql.append(" columncode='").append(r_column_code).append("'");
                prog_sql.append("  and (programtype='1' or programtype='14')");
                    %>
            <c:set var="prog_sqlcon" value="<%=prog_sql.toString()%>"/>
            <ex:params var="prog_input">
                <ex:param name="unique" value="1"/>
              
                </ex:params>
            <ex:search tablename="user_vod" fields="*" order="sortnum desc"  inputparams="${prog_input}" condition="${prog_sqlcon}" curpagenum="1" pagecount="<%=length%>" var="proglist">
            <%
                    List<Map> list = (List<Map>)pageContext.getAttribute("proglist");
                    String totalcount = String.valueOf (pageContext.getAttribute ("totalcount"));

                    JSONObject jallmarks = new JSONObject();
                    jallmarks.put("result","1");
                    jallmarks.put("err_code","0");
                    jallmarks.put("err_text", "");
                    jallmarks.put("subCatFlag", "0");
                    jallmarks.put("catglobalcode", r_column_code);
                   // jallmarks.put("perPageCount",(String)request.getParameter("perPageCount")); //因为是全集， 这个参数没有意义了
                    jallmarks.put("contentTotal", totalcount);


                   // int perPageCount= Integer.parseInt((String)request.getParameter("perPageCount")) ;
                    //double pages=(double)(Integer.parseInt(totalcount))/perPageCount;//列表页数
                    //int totalPage=(int)Math.ceil(pages);
                    //jallmarks.put("pageCount",totalPage);

                    List<JSONObject> datalist = new ArrayList<JSONObject>();
                    for (Map aFav : list){
						// out.print(aFav);
						 int posterFlag = Integer.parseInt(vodPosterFlag);
                        JSONObject oneFav = new JSONObject();
                        //oneFav.put("vodId", aFav.get("programcode"));
						oneFav.put("vodId", aFav.get("programcode"));
                        oneFav.put("VodCode", aFav.get("contentcode"));
                       	oneFav.put("columncode", r_column_code);
                        oneFav.put("vodName", aFav.get("programname"));
                        oneFav.put("type", aFav.get("programtype"));
                        oneFav.put("link",  "../epg/voddetail_h.htm?gc="+aFav.get("programcode"));
						  oneFav.put("cut_vodName", subStringFunction(aFav.get("programname").toString(),1,len_px));
						
                       	if(posterFlag == 0){
							if(null != aFav.get("poster2")){
								String picStr = (String)aFav.get("poster2");
								picStr=picStr.replace("..","");
								oneFav.put("vod_picPath", picStr);
									}
													else
													{
														oneFav.put("vod_picPath", "");
													}
						}else if(posterFlag == 1){
							if(null != aFav.get("poster1")){
								String picStr = (String)aFav.get("poster1");
								picStr=picStr.replace("..","");
								oneFav.put("vod_picPath", picStr);
									}
													else
													{
														oneFav.put("vod_picPath", "");
													}
						}else if(posterFlag == 2){
							if(null != aFav.get("poster3")){
								String picStr = (String)aFav.get("poster3");
								picStr=picStr.replace("..","");
								oneFav.put("vod_picPath", picStr);
									}
													else
													{
														oneFav.put("vod_picPath", "");
													}
						}
                        
                        datalist.add(oneFav);

                    }

                    jallmarks.put("data", datalist);
                    JSONArray json = JSONArray.fromObject(jallmarks);
                   // response.getWriter().write(jallmarks.toString());
					  //out.print("<br>");
					out.print(datalist.toString());
					//out.flush();

            %>
        </ex:search>
            <%
       // }
    }
     else if(requestAction.equals("vod_categories")) {
            //检测有没有子分类
            String  subCategoryFlag="";
            String parent_column_code= (String)request.getParameter("category_id");
            String cur_column_code =  (request.getParameter("global_code") != null) ? (String)request.getParameter("global_code") : "";
            String telecomCode =  (request.getParameter("telecom_code") != null) ? (String)request.getParameter("telecom_code") : "";
				int length =  Integer.parseInt(request.getParameter("length")==null?"1000":request.getParameter("length"));	//单次查询最大数（翻页修改）
				
		    String categoryPosterFlag = (request.getParameter("posterflag") != null) ? (String)request.getParameter("posterflag") : "0";	
		String station = "1";//从指定位置开始获取（翻页上层传递）
			 len_px = Integer.parseInt(request.getParameter("len_px")==null?"1280":request.getParameter("len_px"));	
			//	out.print("<br>");
              //     out.print(cur_column_code);
				//   out.print(parent_column_code);
					//out.flush();

			
		
						
            JSONObject jallmarks = new JSONObject();
            //jallmarks.put("result","1");
           // jallmarks.put("series_flag","1");
            //获取分类名称
            StringBuffer columnname_sql = new StringBuffer();
            columnname_sql.append(" columncode='").append(cur_column_code).append("'");
            %>
            <c:set var="columnname_sqlcon" value="<%=columnname_sql.toString()%>"/>
            <ex:params var="column_input">
                <ex:param name="unique" value="1"/>
                 
                </ex:params>
            <ex:search tablename="user_column" fields="*"    inputparams="${column_input}" condition="${columnname_sqlcon}"  var="detaillist">
            <%
            List<Map> list = (List<Map>)pageContext.getAttribute("detaillist");
                    for (Map aVOD : list){
						out.print(aVOD);
                        if(null != aVOD.get("columnname")){
							
                            String columnNameStr  = (String)(aVOD.get("columnname"));
                        		jallmarks.put("mediaName",columnNameStr);
                        		  
                        }
                        jallmarks.put("telecomcode",aVOD.get("telecomcode"));
                    }
            %>
            </ex:search>
            <%
            
            
         
            
             StringBuffer column_sql = new StringBuffer();
            column_sql.append(" parentcode='").append(parent_column_code).append("'");
            //response.getWriter().write(column_sql.toString());
            %>
            <c:set var="column_sqlcon" value="<%=column_sql.toString()%>"/>
            <ex:params var="column_input">
                <ex:param name="unique" value="1"/>
          
                </ex:params>
            <ex:search tablename="user_column" fields="*" order="sortnum desc"  inputparams="${column_input}" condition="${column_sqlcon}" curpagenum="1" pagecount="<%=length%>" var="favlist">
            <%
                    List<Map> list = (List<Map>)pageContext.getAttribute("favlist");
                    String totalcount = String.valueOf (pageContext.getAttribute ("totalcount"));

              	//out.print("<br>");
                  // out.print("wrwetqewgggggggggggggggggggg");
				   
					//out.flush();

                   // int perPageCount= Integer.parseInt((String)request.getParameter("perPageCount")) ;
                   // double pages=(double)(Integer.parseInt(totalcount))/perPageCount;//列表页数
                  //  int totalPage=(int)Math.ceil(pages);
                   // jallmarks.put("pageCount",totalPage);
	//* @param posterFlag：  获得海报类型的标志。 0：缩略图 1：海报 2：剧照  其他：以上三种之和
                    List<JSONObject> datalist = new ArrayList<JSONObject>();
                    for (Map aFav : list){
						//out.print("<br>");
                   //out.print(aFav);
				   
					//out.flush();
						int categoryposterFlag = Integer.parseInt(categoryPosterFlag);
                        JSONObject oneFav = new JSONObject();
                        oneFav.put("category_id", aFav.get("columncode"));
                        oneFav.put("category_name", aFav.get("columnname"));
                        oneFav.put("type", aFav.get("columntype"));
                        oneFav.put("telecomcode",aFav.get("telecomcode"));
						oneFav.put("category_introduce",aFav.get("description"));
						oneFav.put("subexist",aFav.get("subexist"));	//是否有子栏目0无，1有
						
                        
						  oneFav.put("cut_category_name", subStringFunction(aFav.get("columnname").toString(),1,len_px));
						if(categoryposterFlag == 0){
							if(null != aFav.get("smallposter")){
								String picStr = (String)aFav.get("smallposter");
								picStr=picStr.replace("..","");
								oneFav.put("category_picPath", picStr);
							}
							else
							{
								oneFav.put("category_picPath", "");
							}
						}else if(categoryposterFlag == 1){
							if(null != aFav.get("normalposter")){
								String picStr = (String)aFav.get("normalposter");
								picStr=picStr.replace("..","");
								oneFav.put("category_picPath", picStr);
							}
							else
							{
								oneFav.put("category_picPath", "");
							}
						}else if(categoryposterFlag == 2){
							if(null != aFav.get("bigposter")){
								String picStr = (String)aFav.get("bigposter");
								picStr=picStr.replace("..","");
								oneFav.put("category_picPath", picStr);
							}
							else
							{
								oneFav.put("category_picPath", "");
							}
						}
                        
						//单独添加缩略图
						if(null != aFav.get("smallposter")){
							String picStr_0 = (String)aFav.get("smallposter");
							picStr_0=picStr_0.replace("..","");
							oneFav.put("category_picPath_0", picStr_0);
						}else{
							oneFav.put("category_picPath_0", "");
						}
						
                        oneFav.put("parentcode", aFav.get("parentcode"));
                        datalist.add(oneFav);

                    }

                    jallmarks.put("recommends_info", datalist);
                    JSONArray json = JSONArray.fromObject(jallmarks);
                    JSONArray obj = JSONArray.fromObject(json);
        						//response.getWriter().write(obj.toString());
					//out.print("<br>");
						//out.print("<br>");
							//out.print("<br>");
                   out.print(datalist.toString());
					//out.flush();

          %>

          </ex:search>
          <%
          
        }
     
%>