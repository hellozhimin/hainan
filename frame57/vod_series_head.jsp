<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ page import="java.awt.geom.Rectangle2D" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<epg:PageController name="vod_series_head.jsp"/>
<%!
    public String getNormalPoster(String postfilelist) {
        String[] tempArr = postfilelist.split(";");
        if (tempArr.length > 0 && !tempArr[0].equals("")) {
            return "../images/poster/" + tempArr[0];
        } else {
            return "images/vod/default.png";
        }
    }

    public FontMetrics getFontObject(int px) {
        if (metrics == null) {
            Font font = new Font("Verdana", Font.PLAIN, px);
            FontMetrics metrics = new FontMetrics(font) {
            };
            return metrics;
        } else {
            return metrics;
        }
    }

    FontMetrics metrics = getFontObject(22);

    public int getNameLength(String programName) {
        int length = 0;
        Rectangle2D bounds = metrics.getStringBounds(programName, null);
        length = (int) bounds.getWidth();
        return length;
    }

    /*
   *取截取后的字符串
   * length当前字符串长度
   */
    public String getShowName(String programName, int Width, int px) {
        int length = 0;
        int maxWordlegth = 4 * Width / px;
        if (maxWordlegth < programName.length()) {//预截取字符串长度
            programName = programName.substring(0, maxWordlegth) + "...";
        }
        if (Width >= getNameLength(programName) && getNameLength(programName) != 0) {
            return programName;
        }
        char[] nameArray = programName.toCharArray();
        for (int i = 0; i < nameArray.length; i++) {
            if (length > Width) {
                programName = programName.substring(0, i - 1) + "...";
                break;
            } else {
                length += getNameLength(String.valueOf(nameArray[i]));
            }
        }
        return programName;
    }
%>
<%
    String page_url = ""; //处理封套返回路径
    String epg_info = request.getParameter("epg_info");
    if(null == epg_info || "".equals(epg_info) || "null".equals(epg_info) || "undefined".equals(epg_info)){
        epg_info = (String) session.getAttribute("epg_info_as");
    }
    if(null != epg_info && !"".equals(epg_info) && epg_info.length() > 20){
        session.setAttribute("epg_info_as",epg_info);
        page_url = epg_info.substring(epg_info.indexOf("<page_url>")+10,epg_info.indexOf("</page_url>"));
    }
    String columncode = String.valueOf(request.getParameter("columncode"));
    String programid = String.valueOf(request.getParameter("programid"));
    String mediaservices = "1";
    String sql = " columncode = '" + columncode + "' and programtype=14 and programcode='" + programid + "' and mediaservices&" + mediaservices + "!=0";
    String sql_detail = " mediaservice = " + mediaservices;
    List vodDetailList;
    String programname = "";
    String normalposter = "";
    int seriesnum1 = 0; // 连续剧总集数
    int seriesnum = 0;  // 连续剧当前更新到的集数
    String actor = "";
    String director = "";
    String description = "";
    String ajax_paramHD = "columncode=" + columncode + "&contentcode=";
    String contentcode = "";
    String programtype = "";
    //VOD详情页中，当前VOD是否存在与用户收藏列表中：true表示存在，false表示不存在
    String isfav = "";
    //VOD详情页中添加收藏和删除收藏两种状态对应的图标的图片文件名
    String fav_img = "";
    String programcode = "";
    int definitionFlag = 1;   // 1-SD, 4-HD
    String columnname = "";
    String columnSql = "columncode = '" + columncode + "'";
    String sql_JJ = " seriesprogramcode = '" + programid + "' and columncode='" + columncode + "'" + " and programtype=10 and mediaservices&" + mediaservices + "!=0";
    //保存连续剧单集信息List
    List allSingleSeries=new ArrayList();
	String is4K = request.getParameter("is4K"); 
	if(is4K==null){
        is4K="";
    }
%>
<ex:params var="inputhash">
    <ex:param name="columnavailable" value="<%=columncode%>"/>
</ex:params>
<%--查询栏目名称--%>
<ex:search tablename="user_column" inputparams="${inputhash}" fields="columnname" pagecount="1" curpagenum="1"
           condition="<%=columnSql%>" var="columnData">
    <%
        List columnList = (ArrayList) pageContext.getAttribute("columnData");
        if (columnList != null && columnList.size() > 0) {
            Map columnMap = (Map) columnList.get(0);
            columnname = (String) columnMap.get("columnname");
        }
    %>
</ex:search>
<%--查询连续剧导演、主演、海报、描述等信息--%>
<ex:search tablename="user_vod" fields="*" condition="<%=sql%>" order="createtime desc" var="programInfo">
    <%
        List vodList = (ArrayList) pageContext.getAttribute("programInfo");
		//System.out.println("-------------vodList:" + vodList);
		if (vodList != null && vodList.size() > 0) {
            Map map = (Map) vodList.get(0);
            programname = String.valueOf(map.get("programname"));
            actor = String.valueOf(map.get("actor"));
            director = String.valueOf(map.get("director"));
            description = String.valueOf(map.get("description"));
            seriesnum1 = Integer.parseInt(String.valueOf(map.get("seriesnum")));
            mediaservices = String.valueOf(map.get("mediaservices"));
            normalposter = getNormalPoster(String.valueOf(map.get("posterfilelist")));
            actor = actor.replaceAll(";", ",");
            director = director.replaceAll(";", ",");
            contentcode = String.valueOf(map.get("contentcode"));
            programtype = String.valueOf(map.get("programtype"));
            programcode = String.valueOf(map.get("programcode"));
            description = getShowName(description, 2700, 24);
        }
    %>
</ex:search>
<%--查询连续剧剧集的情况--%>
 <ex:search tablename="user_vod" fields="*" condition="<%=sql_JJ%>" order="createtime desc" var="seriesJJInfo">
     <%
         allSingleSeries=(ArrayList)pageContext.getAttribute("seriesJJInfo");
         if(allSingleSeries!=null&&allSingleSeries.size()>0){
               seriesnum=allSingleSeries.size();
         }
     %>
 </ex:search>
<ex:params var="params">
    <ex:param name="programcodeavailable" value="<%=programid%>"/>
</ex:params>
<ex:search tablename="user_vod_detail" fields="*" inputparams="${params}" condition="<%=sql_detail%>"
           order="createtime desc" var="programlist_detail">
    <%
        vodDetailList = (ArrayList) pageContext.getAttribute("programlist_detail");
        if (vodDetailList != null && vodDetailList.size() > 0) {
            for (int i = 0; i < vodDetailList.size(); i++) {
                Map map1 = (Map) vodDetailList.get(i);
                // videotype = 20为片花 issimpletrailer=0为高级片花
                if (!"20".equals(map1.get("videotype"))) {
                    String definitionTemp = String.valueOf(map1.get("definition"));
                    definitionFlag = definitionFlag + Integer.parseInt(definitionTemp);
                    contentcode = String.valueOf(map1.get("contentcode"));
                    programcode = String.valueOf(map1.get("programcode"));
                }
            }
        }
        definitionFlag = definitionFlag == 0 ? 1 : definitionFlag;
        ajax_paramHD += contentcode;
        ajax_paramHD += "&programtype=" + programtype + "&programcode=" + programcode;
    %>
</ex:search>
<%
    //检查收藏是使用的查询参数
    StringBuffer favorite_sql = new StringBuffer("state = 1");
    favorite_sql.append(" and columncode = '").append(columncode)
            .append("' and contentcode = '").append(contentcode).append("'");
%>
<ex:search tablename="user_favorite" fields="*" condition="<%=favorite_sql.toString()%>" order="savetime desc"
           var="favorite">
    <%
        List favoriteList = (ArrayList) pageContext.getAttribute("favorite");
        if (favoriteList != null && favoriteList.size() > 0) {
            isfav = "true";               //删除收藏
            fav_img = "cancelCollectBg.png";     //删除收藏对应的图标
        } else {
            isfav = "false";
            fav_img = "upListBg_3.png";         //添加收藏对应的图标
        }
    %>
</ex:search>
<%--查询剧头书签--%>
<%
    String bookmark_sql = "columncode='" + columncode + "' and contentcode='" + contentcode + "' and bookmarktype=4";
    String seriesHeadBookmark="1";
%>
<ex:search tablename="user_bookmark" fields="*" condition="<%=bookmark_sql%>" order="savetime desc" var="bookmark">
    <%
        List markList = (ArrayList) pageContext.getAttribute("bookmark");
        if (markList == null) markList = new ArrayList();
        if (markList.size() > 0) {
            Map bookMark = (Map) markList.get(0);
            seriesHeadBookmark = String.valueOf(bookMark.get("breakpoint"));
            if (seriesHeadBookmark.equals("0")) {
                seriesHeadBookmark = "1";
            }
        }
    %>
</ex:search>
<html>
<head>
<title>vod_portal</title>
<meta name="page-view-size" content="1280*720"/>
<style type="text/css">
    .page-title {
        position: absolute;
        left: 50px;
        line-height: 80px;
        top: 17px;
        width: 100px;
        height: 100px;
        /*font-weight: bold;*/
        font-size: 36px;
        color: #FFF;
    }

    .page-text {
        position: absolute;
        left: 70px;
        width: 645px;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        /*border: solid 1px yellow;*/
    }

    .font-ellipsis {
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }

    #focus_text {
        position: absolute;
        left: 424px;
        top: 520px;
        width: 160px;
        height: 30px;
        font-size: 22px;
        /*font-weight: bold;*/
        color: #01B8FA;
        text-align: center
    }

    .recommendposter {
        position: absolute;
        left: 0px;
        top: 180px;
        width: 124px;
        line-height: 35px;
        height: 35px;
        color: #FFF;
        font-size: 26px;
        text-align: center;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }

    .posterBig {
    }
    .seriesIndexGrounp{
        width: 110px;
        height: 30px;
        line-height: 30px;
        color:#ffffff;
        font-size: 22px;
        float:left;
        text-align: center;
        visibility: hidden;
        border-radius: 15px;
    }
    .btn-JJ{
        margin-top:19px;
        margin-right: 10px;
        margin-left: 10px;
        float: left;
        width: 89px;
        height:52px;
        color: #ffffff;
        line-height: 52px;
        text-align: center;
        font-size: 22px;
        background: url(images/vod/detail_vod_series_normal.png) no-repeat;
        visibility: hidden;
    }
</style>
<script type="text/javascript" src="js/contentloader.js"></script>
<script type="text/javascript" src="js/toggleClass.js"></script>
<script type="text/javascript">
//top.OSDInfo.state = 0;
//top.currState = 0;
var timer = -1;
//top.jsClearVideoKeyFunction();

var lastfocus = "<%=request.getParameter("lastfocus")%>";
var $$ = [];
var btn_imgFocus = "<%=fav_img%>";
//焦点位置 0：在没有弹出连续剧剧集情况下的操作按钮上  1：推荐节目上  2：连续剧剧集分组 3：连续剧集数上 4：在弹出连续剧剧集情况下的操作按钮
var focusType = 0;
//当前操作按钮焦点所在位置的索引
var curFocusIndex = 0;
var definitionFlag = parseInt("<%=definitionFlag%>");
// 默认将片源的码率设置为S-HD
var curDefinition = definitionFlag;
var isFav = "<%=isfav%>";
var authid;
var favoriteFlag = false;  // 添加收藏和取消收藏时使用ajax时的按键保护

function $(id) {
    if (!$$[id]) {
        $$[id] = document.getElementById(id);
    }
    return $$[id];
}
/**
 * VOD详情页面，VOD详情下方的按钮是否在焦点状态时其显示的图片
 * @param btnIndex      按钮索引值
 * @param isOnfocus     即将变化的状态，为true表示获取焦点，为false表示失去焦点
 */
function changeImg(btnIndex, isOnfocus) {
    //取当前索引位置正常显示的图标的名称
    if (isOnfocus == "true") {
        //为当前焦点索引赋值
        curFocusIndex = btnIndex;
        //  将焦点图片大小修改，可恶的美工
//        $("borderfocus"+btnIndex).style.top="320px";
//        $("border_img"+btnIndex).style.width="142px";
//        $("border_img"+btnIndex).style.height="70px";
        if (curFocusIndex === 0) {
            // 播放
//            $("borderfocus0").style.left="380px";
//            $("border_img0").src = "images/vod/upListFocus_1.png";
            $("borderfocus0").style.display="block";
            $("borderfocus0_1").style.display="none";
        } else if (curFocusIndex === 1) {
            // 收藏
//            $("borderfocus1").style.left="526px";
            if (isFav == "true") {
                // 显示取消收藏的焦点图片
//                $("border_img1").src = "images/vod/cancelCollectFocus.png";
                $("borderfocus2_0").style.display="block";
                $("borderfocus1_0").style.display="none";
                $("borderfocus2_1").style.display="none";
                $("borderfocus1_1").style.display="none";
            } else {
                // 显示收藏的焦点图片
//                $("borderfocus"+btnIndex).style.top="322px";
//                $("border_img1").src = "images/vod/upListFocus_3.png";
                $("borderfocus2_1").style.display="block";
                $("borderfocus1_1").style.display="none";
                $("borderfocus2_0").style.display="none";
                $("borderfocus1_0").style.display="none";
            }
        }
    } else {
        curFocusIndex = btnIndex;
//        $("borderfocus"+btnIndex).style.top="334px";
//        $("border_img"+btnIndex).style.width="114px";
//        $("border_img"+btnIndex).style.height="43px";
        if (curFocusIndex === 0) {
            // 播放
//            $("borderfocus0").style.left="394px";
//            $("border_img0").src = "images/vod/upListBg_1.png";
            $("borderfocus0_1").style.display="block";
            $("borderfocus0").style.display="none";
        } else if (curFocusIndex === 1) {
            // 收藏
//            $("borderfocus1").style.left="540px";
            if (isFav == "true") {
                // 显示取消收藏的焦点图片
//                $("border_img1").src = "images/vod/cancelCollectBg.png";
                $("borderfocus1_0").style.display="block";
                $("borderfocus2_0").style.display="none";
                $("borderfocus1_1").style.display="none";
                $("borderfocus2_1").style.display="none";
            } else {
                // 显示收藏的焦点图片
//                $("border_img1").src = "images/vod/upListBg_3.png";
                $("borderfocus1_1").style.display="block";
                $("borderfocus2_1").style.display="none";
                $("borderfocus1_0").style.display="none";
                $("borderfocus2_0").style.display="none";
            }
        }
    }
}
/**
 * 下方推荐海报位焦点移动
 * @param btnIndex      按钮索引值
 * @param isOnfocus     即将变化的状态，为true表示获取焦点，为false表示失去焦点
 */
function changePosterImg(btnIndex, isOnfocus) {
    if (isOnfocus == "true") {
		$("posterfocus").style.visibility="visible";
        $("posterfocus").style.left=74+ btnIndex * 160+"px";
		addClass($("posterfocus"),"posterBig");
		addClass($("posterDiv" + btnIndex),"posterBig");
        starScroll("postername" + btnIndex,recommendArr[btnIndex].programname,11);
    } else {
		removeClass($("posterfocus"), "posterBig");
		removeClass($("posterDiv" + btnIndex), "posterBig");
        $("posterfocus").style.visibility = "hidden";
        stopScroll("postername" + btnIndex,recommendArr[btnIndex].programname);
    }
}
// 剧集分组得到焦点
function groupGetFocus(){
     $("group"+curSeriesGroupIndex).style.backgroundColor="#E7820A";
     $("group"+curSeriesGroupIndex).style.color="#ffffff";
}
// 剧集分组驻留效果
function groupStay(){
    $("group"+curSeriesGroupIndex).style.backgroundColor="transparent";
    $("group"+curSeriesGroupIndex).style.color="#E7820A";
}
// 剧集分组普通效果
function groupNormal(){
    $("group"+curSeriesGroupIndex).style.backgroundColor="transparent";
    $("group"+curSeriesGroupIndex).style.color="#ffffff";
}
// 连续剧单集获得焦点
function singleGetFocus(){
     $("single"+curSeriesSingleIndex).style.background="url(images/vod/detail_vod_series_focus.png)";
}
function singleLoseFocus(){
    $("single"+curSeriesSingleIndex).style.background="url(images/vod/detail_vod_series_normal.png)";
}
/**
 * 按钮加入收藏/删除收藏处理
 * 处理逻辑：已经收藏的将其删除，未收藏的将其加入收藏
 */
function doFavorite() {
    if (favoriteFlag) {
        return;
    }
    favoriteFlag = true;
    var favUrl = "action/favorite_add.jsp?SubjectID=<%=columncode%>&ContentID=<%=contentcode%>&programtype=<%=programtype%>&isfav=" + isFav;
    new net.ContentLoader(encodeURI(favUrl), function () {
        var response = eval("(" + this.req.responseText + ")");
        //加入收藏或者删除收藏成功
        if (response.returnCode == 0) {
            if (isFav == "true") {  //删除收藏成功变成
                isFav = "false";
            } else {                //添加收藏成功
                isFav = "true";
            }
            changeImg(1, "true");
            favoriteFlag = false;
        }
    });
}
function doPlay(seriesIndex) {
    <%--var playUrl = "vod_play.jsp?programcode=" + seriesArr[seriesIndex-1].programid +--%>
            <%--"&columncode=<%=columncode%>&contentcode=" + seriesArr[seriesIndex-1].contentcode +--%>
            <%--"&definition=" + seriesArr[seriesIndex-1].definition+--%>
            <%--"&seriesIndex="+seriesIndex;--%>
    <%--document.location = playUrl + "&seriesprogramcode=<%=programid%>" ;--%>
//            columncode=" + columncode + "&contentcode=
    var requestUrl = "get_onebookmark.jsp?columncode=<%=columncode%>&contentcode="+seriesArr[seriesIndex-1].contentcode+"&definition=0" ;
    new net.ContentLoader("action/" + requestUrl, function() {
        var responseText = this.req.responseText;
        var breakpoint = parseInt(responseText, 10);
        top.doStop();
        var playUrl = "";
		
		if('<%=is4K%>' == '1'){
			playUrl = "vod_play.jsp?programcode=" + seriesArr[seriesIndex-1].programid +
			"&columncode=<%=columncode%>&contentcode=" + seriesArr[seriesIndex-1].contentcode +
			"&definition=4"
			"&breakpoint=" +breakpoint+
			"&seriesIndex="+seriesIndex;
		}else{
			playUrl = "vod_play.jsp?programcode=" + seriesArr[seriesIndex-1].programid +
			"&columncode=<%=columncode%>&contentcode=" + seriesArr[seriesIndex-1].contentcode +
			"&definition=" + seriesArr[seriesIndex-1].definition+
			"&breakpoint=" +breakpoint+
			"&seriesIndex="+seriesIndex;
		}
        document.location = playUrl + "&seriesprogramcode=<%=programid%>" ;
    });
}
function goDetail(index) {
    var url = "vod_detail.jsp?";
    if (recommendArr[index].programtype == "14") {
        url = "vod_series_head.jsp?";
    }
    url += "programid=" + recommendArr[index].programcode + "&columncode=" + recommendArr[index].columncode + "&mediaservices=" + recommendArr[index].mediaservices + "&is4K=<%=is4K%>";
    document.location = url;
}
/**
 * 遥控器返回按键处理
 */
function goBack() {
    if(focusType === 2||focusType === 3||focusType === 4){
        focusType=0;
        // 隐藏选集区域
        hideSeriesArea();
        // 展示推荐区域
        showRecArea();
        //  焦点落在播放按钮上
        changeImg(0,"true");
    }else{
        document.location = "back.jsp";
    }
}
function doOk() {
    if (focusType === 0) {
        if (curFocusIndex === 0) {
            // 显示选集
            changeImg(0,"false");
            focusType=3;
            hideRecArea();
            showSeriesArea();
            // 设置剧集分组停留样式
            groupStay();
            // 设置单集焦点
            singleGetFocus();
			$("group_col").style.color = "white";
        } else if (curFocusIndex === 1) {
            //收藏按钮
            doFavorite();
        }
    } else if (focusType === 1) {
        // 推荐区域
        goDetail(recommIndex);
    }else if(focusType === 4){
        if (curFocusIndex === 0) {
            // 播放第一集
            doPlay(1);
        } else if (curFocusIndex === 1) {
            //收藏按钮
            doFavorite();
        }
    }else if(focusType === 3){
         // 播放选择的单集
         doPlay(curSeriesSingleIndex+curSeriesGroupIndex*20+1);
    }else if(focusType === 2 && curSeriesGroupIndex == SeriesGroupNum -1 ){
		 goBack();
	}
}

function dokeypress(evt) {
    if (favoriteFlag) {
        return;
    }
    var keyCode = parseInt(evt.which);
    if (keyCode == 0x0008) {            //遥控器返回键
        goBack();
    } else if (keyCode == 0x0110) {     //遥控器菜单键
            document.location = '<%=page_url%>' ;
    } else if (keyCode == 0x0027) {   //遥控器右键
        doRight();
    } else if (keyCode == 0x0025) {  //遥控器左键
        doLeft();
    } else if (keyCode == 0x0028) {
        doDown();
    } else if (keyCode == 0x0026) {
        doUp();
    } else if (keyCode == 0x000D) { //遥控器OK键
        doOk();
    } else if (keyCode == 0x0101) {
    	return;
		//remoteChannelPlus();
	} else if (keyCode == 0x0102) { 
		return;
		//remoteChannelMinus();
	} else {
        top.doKeyPress(evt);
        return true;
    }
    return false;
}

function doRight() {
    if (focusType == 0||focusType == 4) {
        if (curFocusIndex === 0) {
            changeImg(curFocusIndex, "false");
            curFocusIndex = 1;
            changeImg(curFocusIndex, "true");
        }
    } else if (focusType == 1) {
        if (recommIndex < recommtotal-1 && recommIndex < 6) {
            changePosterImg(recommIndex, "false");
            recommIndex++;
            changePosterImg(recommIndex, "true");
        }
    }else if(focusType == 2){
        //  此时焦点在剧集分组区域
        if(curSeriesGroupIndex<SeriesGroupNum-2){
            groupNormal();
            curSeriesGroupIndex++;
            curSeriesSingleIndex=0;
            groupGetFocus();
            drawMoreSingleArea();
        }else if(curSeriesGroupIndex == SeriesGroupNum-2){
        	groupNormal();
			curSeriesGroupIndex++
        	$("group_col").style.color = "red";
        }
    }else if(focusType == 3){
        //  此时焦点在单集区域
       if(curSeriesSingleIndex<curSeriesGroupSingleLeng-1){
           singleLoseFocus();
           curSeriesSingleIndex++;
           singleGetFocus();
       }
    }
}

function doLeft() {
    if (focusType == 0||focusType == 4) {
        if (curFocusIndex === 1) {
            changeImg(curFocusIndex, "false");
            curFocusIndex = 0;
            changeImg(curFocusIndex, "true");
        }
    } else if (focusType == 1) {
        if (recommIndex > 0) {
            changePosterImg(recommIndex, "false");
            recommIndex--;
            changePosterImg(recommIndex, "true");
        }
    }else if(focusType == 2){
       // 此时焦点在剧集分组区域
        if(curSeriesGroupIndex>0){
			if(curSeriesGroupIndex != SeriesGroupNum -1){
				 groupNormal();
				curSeriesGroupIndex--;
				curSeriesSingleIndex=0;
				groupGetFocus();
				drawMoreSingleArea();
			}else{
				curSeriesGroupIndex--;
				$("group_col").style.color = "white";
        		groupGetFocus();
			}
        }
    }else if(focusType == 3){
       // 此时焦点在单集区域
        if(curSeriesSingleIndex>0){
            singleLoseFocus();
            curSeriesSingleIndex--;
            singleGetFocus();
        }
    }
}

function doDown() {
    if (focusType == 0) {
        // 此时焦点在没有弹出连续剧剧集情况下的操作按钮上
        changeImg(curFocusIndex, "false");
        focusType = 1;
        changePosterImg(0, "true");
    }else if(focusType == 2){
         // 此时焦点在2：连续剧剧集分组
		 if(curSeriesGroupIndex == SeriesGroupNum-1){
			 curSeriesGroupIndex--;
			 $("group_col").style.color = "white";
		 }
        groupStay();
        focusType=3;
        singleGetFocus();
    }else if(focusType == 3){
         // 此时焦点在3：连续剧集数上
        if(curSeriesSingleIndex<10){
            if(curSeriesSingleIndex+10<curSeriesGroupSingleLeng){
                 singleLoseFocus();
                curSeriesSingleIndex+=10;
                singleGetFocus();
            }
        }
    }else if(focusType == 4){
         // 此时焦点在4：在弹出连续剧剧集情况下的操作按钮
         changeImg(curFocusIndex,"false");
        focusType=2;
        groupGetFocus();
    }
}
function doUp() {
    if (focusType == 1) {
        //  此时焦点处于推荐区域
        changePosterImg(recommIndex, "false");
        focusType = 0;
        changeImg(0, "true");
    }else if(focusType == 2){
        //  此时焦点处于剧集分组区域
		 if(curSeriesGroupIndex == SeriesGroupNum-1){
			 curSeriesGroupIndex--;
			 $("group_col").style.color = "white";
		 }
        groupStay();
        focusType=4;
        changeImg(0,"true");
    }else if(focusType == 3){
        //  此时焦点处于单集区域
        if(curSeriesSingleIndex>9){
            //  在单集区域的第二行
            singleLoseFocus();
            curSeriesSingleIndex-=10;
            singleGetFocus();
        }else{
            if(curSeriesSingleIndex<=curSeriesGroupIndex){
                 // 切换到剧集分组区域
                singleLoseFocus();
                focusType=2;
                groupGetFocus();
            }else{
                 //  切换到播放按钮区域，此时区域的值为4，即在剧集区域显示的情况下的播放按钮
                singleLoseFocus();
                focusType=4;
                curSeriesSingleIndex=0;
                changeImg(0,"true");
            }
        }
    }
}
function stopvideo() {
    top.doStop();
}
setTimeout("stopvideo()", 2000);
</script>
</head>
<body bgcolor="transparent" background="images/portal/recommend/bg.png" style="overflow: hidden;" onLoad="initPage()">
<%--<div style="visibility:hidden">--%>
    <%--<img src="images/vod/upListFocus_1.png">--%>
    <%--<img src="images/vod/cancelCollectBg.png">--%>
    <%--<img src="images/vod/upListBg_3.png">--%>
    <%--<img src="images/vod/upListFocus_1.png">--%>
<%--</div>--%>
<!--vod的海报，三屏  级别 评级信息-->
<%@ include file="inc/vod_basicInfo.jsp" %>
<%@ include file="inc/scroll_detail.jsp" %><!-- 修改详情页推荐位节目名称显示不全 cny 2017/8/8 -->
<div style="position:absolute;left:370px;top:40px;width:850px;height:260px;color:#FFF;font-size:24px;">
    <div style="position: absolute;left:1px;top:20px;width: 850px;height: 40px;">
        <%--显示节目名称--%>
        <div style="float:left;top:0px;height:40px;color:#FFF;font-size:35px;text-overflow: ellipsis;"
             class="font-ellipsis"><%=programname%>
        </div>
        <%--显示栏目名称--%>
        <div id="columnname" style="float:left;top:4px;max-width:300px;height:30px;padding-left: 15px;padding-top:10px; ">
            <%=columnname%>
        </div>
        <%--显示连续剧剧集信息--%>
        <div id="seriesJJInfo" style="float:left;top:4px;width:200px;height:30px;padding-left: 15px;padding-top:10px;">更新至100集</div>
    </div>
    <div style="position:absolute;left:0px;top:70px;width:800px;height:30px;font-size:22px;color:#B6B6B6">
        <div style="position:absolute;">导演:</div>
        <div class="page-text"><%=director%>
        </div>
    </div>
    <div style="position:absolute;left:0px;top:100px;width:800px;height:30px;font-size:22px;color:#B6B6B6">
        <div style="position:absolute;">主演:</div>
        <div class="page-text"><%=actor%>
        </div>
    </div>
    <div style="position:absolute;left:0px;top:140px;width:850px;line-height:30px;height:120px;padding-top:10px;font-size:22px;color:#B6B6B6;overflow:hidden;text-overflow: ellipsis;word-wrap:break-word;">
        <%=description%>
    </div>
</div>
<%--播放按钮--%>
<%--<div id="borderfocus0" style="position:absolute; left:380px;top:320px;">--%>
    <%--<img id="border_img0" src="images/vod/upListFocus_1.png" >--%>
<%--</div>--%>
<%--&lt;%&ndash;收藏按钮&ndash;%&gt;--%>
<%--<div id="borderfocus1" style="position:absolute; left:540px;top:334px;">--%>
    <%--<img id="border_img1" src="images/vod/<%=fav_img%>" >--%>
<%--</div>--%>
<div id="borderfocus0" style="position:absolute; left:380px;top:320px;display:none">
    <%--<img id="border_img0" src="images/vod/upListFocus_1.png" style="width: 142px;height: 70px;">--%>
    <img id="border_img0" src="images/vod/upListFocus_1.png" >
</div>
<div id="borderfocus0_1" style="position:absolute; left:380px;top:334px;display: none;">
    <%--<img id="border_img0" src="images/vod/upListFocus_1.png" style="width: 142px;height: 70px;">--%>
    <img id="border_img0_1" src="images/vod/upListBg_1.png" >
</div>
<%--收藏按钮--%>
<div id="borderfocus1_0" style="position:absolute; left:540px;top:334px;display: none;">
    <%--<img id="border_img1" src="images/vod/<%=fav_img%>" style="width: 142px;height: 70px;">--%>
    <img id="border_img1_0" src="images/vod/cancelCollectBg.png" >
</div>
<div id="borderfocus1_1" style="position:absolute; left:540px;top:334px;display: none;">
    <%--<img id="border_img1" src="images/vod/<%=fav_img%>" style="width: 142px;height: 70px;">--%>
    <img id="border_img1" src="images/vod/upListBg_3.png" >
</div>
<div id="borderfocus2_0" style="position:absolute; left:520px;top:322px;display: none;">
    <%--<img id="border_img1" src="images/vod/<%=fav_img%>" style="width: 142px;height: 70px;">--%>
    <img id="border_img1" src="images/vod/cancelCollectFocus.png" >
</div>
<div id="borderfocus2_1" style="position:absolute; left:520px;top:322px;display: none;">
    <%--<img id="border_img1" src="images/vod/<%=fav_img%>" style="width: 142px;height: 70px;">--%>
    <img id="border_img1" src="images/vod/upListFocus_3.png" >
</div>

<%--推荐区域--%>
<div id="recomenDiv" style="position:absolute;left:88px;top:454px;width:1190px;height:230px;display:block;">
    <%
        for (int i = 0; i < 7; i++) {
    %>
    <div id="posterDiv<%=i%>"
         style="position: absolute;left:<%=0+i*160%>px;top:0px;width:80px;height:215px;padding-right:40px;display:none;">
        <img id="poster<%=i%>" src="" width="120" height="180" style="">

        <div id="postername<%=i%>"
             style="position: absolute;left:0px;bottom: 0px;width: 120px;line-height: 35px;height: 35px;
                     color: #b9b6b7;
                     font-size: 22px;
                     text-align: center;
                     overflow: hidden;
                     ">
        </div>
    </div>
    <%
        }
    %>
</div>
<%--推荐VOD的焦点--%>
<div id="posterfocus"
     style="position:absolute;left:74px;top:443px;width:210px;height:270px;visibility:hidden;">
    <img src="images/vod/detailsRecoListFocus.png" width="150" height="204">
</div>
<!-- 连续剧更多剧集区域 -->
<div id="moreSeriesIndex" style="position:absolute;left:88px;top:454px;width:1100px;height:230px;display:none;">
    <!-- 头部剧集分组区域 -->
    <div style="position: absolute;left: 0px;top:0px;width: 1100px;height:30px;">
        <!-- 1-20集 -->
        <div id="group0" class="seriesIndexGrounp">01-20</div>
        <div id="group1" class="seriesIndexGrounp">21-40</div>
        <div id="group2" class="seriesIndexGrounp">41-60</div>
        <div id="group3" class="seriesIndexGrounp">61-80</div>
        <div id="group4" class="seriesIndexGrounp">81-100</div>
        <div id="group5" class="seriesIndexGrounp">101-120</div>
        <div id="group6" class="seriesIndexGrounp">121-140</div>
        <div id="group7" class="seriesIndexGrounp">141-160</div>
        <div id="group8" class="seriesIndexGrounp">161-180</div>
        <div id="group9" class="seriesIndexGrounp">181-200</div>
        <div id="group_col" style="color: white; position:absolute; left: 1066px; top: 5px;">X</div>
    </div>
    <!-- 底部剧集分组每集按钮区域 -->
    <div style="position:absolute;left:0px;bottom: 0px;width: 1100px;height:200px;">
        <div style="position:absolute;left:0px;top: 0px;width: 1100px;height:100px;">
            <div id="single0" class="btn-JJ">01</div>
            <div id="single1" class="btn-JJ">02</div>
            <div id="single2" class="btn-JJ">03</div>
            <div id="single3" class="btn-JJ">04</div>
            <div id="single4" class="btn-JJ">05</div>
            <div id="single5" class="btn-JJ">06</div>
            <div id="single6" class="btn-JJ">07</div>
            <div id="single7" class="btn-JJ">08</div>
            <div id="single8" class="btn-JJ">09</div>
            <div id="single9" class="btn-JJ">10</div>
        </div>
        <div style="position:absolute;left:0px;bottom: 0px;width: 1100px;height:100px;">
            <div id="single10" class="btn-JJ">11</div>
            <div id="single11" class="btn-JJ">12</div>
            <div id="single12" class="btn-JJ">13</div>
            <div id="single13" class="btn-JJ">14</div>
            <div id="single14" class="btn-JJ">15</div>
            <div id="single15" class="btn-JJ">16</div>
            <div id="single16" class="btn-JJ">17</div>
            <div id="single17" class="btn-JJ">18</div>
            <div id="single18" class="btn-JJ">19</div>
            <div id="single19" class="btn-JJ">20</div>
        </div>


    </div>
</div>
<script type="text/javascript">
    //推荐相关参数
    var recommendArr = [];  // 推荐VOD的全部数据
    var recommIndex = 0;  //推荐VOD的下标
    var recommtotal = 0; // 推荐数据的总数
    var recommendUrl = "";

    // 连续剧剧头书签
    var seriesHeadBookmark=parseInt("<%=seriesHeadBookmark%>",10);
    var seriesArr=[]; // 连续剧单集数据
    // 当前连续剧剧集分组焦点所在位置索引,以及分组数
    var curSeriesGroupIndex= Math.ceil(seriesHeadBookmark/20)-1,SeriesGroupNum=1;
    // 当前连续剧集数的焦点所在位置索引 ,以及当前剧集分组下的单集个数
    var curSeriesSingleIndex=(seriesHeadBookmark-1)%20 ,curSeriesGroupSingleLeng=20;
    //  连续剧总集数
    var SeriesSingleTotal=parseInt("<%=seriesnum1%>",10);
    //  当前连续剧集数
    var curSeriesSingleTotal=parseInt("<%=seriesnum%>",10);

    function getNomalposter(posterlist) {
        var posters = new Array();
        if (null != posterlist) {
            posters = posterlist.split(";");
        }
        if (posters.length > 0 && null != posters[0] && posters[0] != "") {
            return "../images/poster/" + posters[0];
        } else {
            return "images/vod/default.png";
        }
    }
    function getRecommendData() {
        var requestUrl = "action/get_recommend.jsp?columncode=<%=columncode%>&programcode=<%=programcode%>";
        new net.ContentLoader(requestUrl, function () {
            var datatext = this.req.responseText;
            if (datatext.indexOf("programInfo") != -1) {
                var data = eval("(" + this.req.responseText + ")");
                if (data.rec_num == 0) {
                    return;
                }
                recommendArr = data.programInfo;
                recommtotal = recommendArr.length;
//                top.jsDebug("---------recommtotal---------" + recommtotal);
                for (var i = 0; i < recommtotal; i++) {
					if(i < recommtotal){
						$("posterDiv" + i).style.display = "block";
						$("poster" + i).src = getNomalposter(recommendArr[i].posterfilelist);
						stopScroll("postername" +i, recommendArr[i].programname);
					}else{
						$("poster" + i).src = 'images/btn_trans.gif';
	                    $("postername" + i).innerText = '';
					}                }
            }
        });
    }
    function getSeriesSingleData(){
        var requestUrl = "action/get_series_single_data.jsp?columncode=<%=columncode%>&programid=<%=programcode%>";
        new net.ContentLoader(requestUrl,function(){
                  var seriesData=eval("("+this.req.responseText+")");
                    seriesArr=seriesData.seriesData;
        });
    }
    // 显示连续剧选集
    function showSeriesArea(){
          $("areaName").innerText="更多选集";
          $("moreSeriesIndex").style.display="block";
    }
    //  隐藏连续剧选集
    function hideSeriesArea(){
        // 此时需要将焦点和选集分组的情况设置为默认，
        singleLoseFocus();
        groupNormal();
        // 并将焦点恢复到书签焦点
        curSeriesGroupIndex=Math.ceil(seriesHeadBookmark/20)-1;
        curSeriesSingleIndex=(seriesHeadBookmark-1)%20;
        drawMoreSingleArea();
        $("moreSeriesIndex").style.display="none";
    }
    // 显示推荐区域
    function showRecArea(){
        $("areaName").innerText="相关推荐";
        $("recomenDiv").style.display="block";
    }
    // 隐藏推荐区域
    function hideRecArea(){
        recommIndex=0;
        $("recomenDiv").style.display="none";
        $("posterfocus").style.visibility="hidden";
    }
    //  清空连续剧剧集分组信息
    function clearSeriesGroup(){
          for(var i=0;i<10;i++){
             $("group"+i).style.visibility="hidden";
          }
    }
    //  画出连续剧剧集分组情况，以及第一组的单集情况
    function drawSeriesGroupInfo(){
        clearSeriesGroup();
        SeriesGroupNum=Math.ceil(curSeriesSingleTotal/20);
        for(var i=0;i<SeriesGroupNum;i++){
            $("group"+i).style.visibility="visible";
        }
		SeriesGroupNum = SeriesGroupNum + 1;
        //  画出默认的第一组单集数据
        drawMoreSingleArea();
    }
    // 计算出当前剧集分组含有的单集数
    function hasSingleNumCurGroup(){
       if(curSeriesGroupIndex<SeriesGroupNum-2){
           curSeriesGroupSingleLeng=20;
       }else{
           curSeriesGroupSingleLeng=curSeriesSingleTotal-curSeriesGroupIndex*20;
       }
    }
    // 清空剧集分组单集信息
    function clearSeriesGroupSingle(){
        var i;
        for( i=0;i<20;i++){
            $("single"+i).innerText="";
            $("single"+i).style.visibility="hidden";
        }
    }
    // 画出当前连续剧剧集分组中的单集信息
    function drawMoreSingleArea(){
            clearSeriesGroupSingle();
            hasSingleNumCurGroup();
            var i;
            // 判断当前剧集分组是否是最后一组
           if(curSeriesGroupIndex<SeriesGroupNum-2){
                 // 非最后一组,画20集
                for( i=0;i<20;i++){
                    $("single"+i).innerText=one2two(curSeriesGroupIndex*20+i+1);
                    $("single"+i).style.visibility="visible";
                }
           }else{
               //  最后一组
              for(i=0;i<curSeriesGroupSingleLeng;i++ ){
                  $("single"+i).innerText=one2two(curSeriesGroupIndex*20+i+1);
                  $("single"+i).style.visibility="visible";
              }
           }
    }
    // 将个位数字变成两位数字
    function one2two(no){
          if(no<10){
              no="0"+no;
          }
        return no;
    }
    function initPage() {
        document.onkeypress = dokeypress;
        //显示VOD的基本信息
        $("basic_info").style.left = "58px";
        $("basic_info").style.top = "26px";
        $("basic_info").style.fontWeight = "bold";
        $("basic_info").style.visibility = "visible";
        $("cur_poster").src = "<%=normalposter%>";

        if(SeriesSingleTotal===curSeriesSingleTotal){
            $("seriesJJInfo").innerText=curSeriesSingleTotal+"集全";
        }else{
            $("seriesJJInfo").innerText="更新至第"+curSeriesSingleTotal+"集";
        }

        //初始化焦点
        changeImg(0, "true");
        if(isFav=="true"){
            $("borderfocus1_0").style.display="block";
        } else{
            $("borderfocus1_1").style.display="block";
        }
        // 获取推荐数据
        getRecommendData();
        //  画出连续剧剧集分组情况，以及第一组的单集情况
        drawSeriesGroupInfo();
        // 获取连续剧单集数据
        getSeriesSingleData();
    }
</script>
<%@include file="inc/lastfocus.jsp" %>
</body>
</html>