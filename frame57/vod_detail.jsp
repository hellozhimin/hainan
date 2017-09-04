<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.zte.iptv.volcano.epg.account.User" %>
<%@ page import="java.util.*" %>
<%@ page import="java.awt.geom.Rectangle2D" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<epg:PageController name="vod_detail.jsp"/>
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
    String sql = " columncode = '" + columncode + "' and programtype=1 and programcode='" + programid + "' and mediaservices&" + mediaservices + "!=0";
    String sql_detail = " mediaservice = " + mediaservices;
    List vodDetailList;
    String programname = "";
    String normalposter = "";
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
	String is4K = request.getParameter("is4K"); 
	if(is4K==null){
        is4K="";
    }
%>
<ex:params var="inputhash">
    <ex:param name="columnavailable" value="<%=columncode%>"/>
</ex:params>
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
<ex:search tablename="user_vod" fields="*" condition="<%=sql%>" order="createtime desc" var="programInfo">
    <%
        List vodList = (ArrayList) pageContext.getAttribute("programInfo");
        if (vodList != null && vodList.size() > 0) {
            Map map = (Map) vodList.get(0);
            programname = String.valueOf(map.get("programname"));
			programname = getShowName(programname, 350, 20);
            actor = String.valueOf(map.get("actor"));
            director = String.valueOf(map.get("director"));
            description = String.valueOf(map.get("description"));
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
        definitionFlag=1;
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
            //fav_text=HAVE_FAVORITE;
        } else {
            isfav = "false";
            fav_img = "upListBg_3.png";         //添加收藏对应的图标
            //fav_text=FAVORITE;
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
</style>
<script type="text/javascript" src="js/contentloader.js"></script>
<script type="text/javascript" src="js/toggleClass.js"></script>
<script type="text/javascript">
top.OSDInfo.state = 0;
top.currState = 0;
var timer = -1;
var recommIndex = 0;  //推荐VOD的下标
top.jsClearVideoKeyFunction();

var lastfocus = "<%=request.getParameter("lastfocus")%>";
var $$ = [];
var btn_imgFocus = "<%=fav_img%>";
//焦点位置 0：操作按钮上  1：推荐节目上
var focusType = 0;
//当前焦点所在位置的索引
var curFocusIndex = 0;
var definitionFlag = parseInt("<%=definitionFlag%>");
// 默认将片源的码率设置为S-HD
var curDefinition = definitionFlag;
var isFav = "<%=isfav%>";
var authid;
var favoriteFlag = false;  // 添加收藏和取消收藏时使用ajax时的按键保护
var recommIsHasCurProgid = false;
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
//            alert("=====isFav====="+isFav);
            if (isFav == "true") {
                // 显示取消收藏的焦点图片
//                $("borderfocus1").style.left="526px";
//                $("border_img1").src = "images/vod/cancelCollectFocus.png";
                $("borderfocus2_0").style.display="block";
                $("borderfocus1_0").style.display="none";
                $("borderfocus2_1").style.display="none";
                $("borderfocus1_1").style.display="none";
            } else {
                // 显示收藏的焦点图片
//                $("borderfocus"+btnIndex).style.top="322px";
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
//            $("borderfocus0_1").style.display="block";
            $("borderfocus0_1").style.display="block";
            $("borderfocus0").style.display="none";
        } else if (curFocusIndex === 1) {
            // 收藏
//            $("borderfocus1").style.left="540px";
            if (isFav == "true") {
                // 显示取消收藏的焦点图片
                $("borderfocus1_0").style.display="block";
                $("borderfocus2_0").style.display="none";
                $("borderfocus1_1").style.display="none";
                $("borderfocus2_1").style.display="none";
            } else {
                // 显示收藏的焦点图片
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
    if (isOnfocus){
		$("posterfocus").style.visibility="visible";
//        $("posterfocus").style.left=44+ btnIndex * 160+"px";
        $("posterfocus").style.left= 76+btnIndex * 160+"px";
		addClass($("posterfocus"),"posterBig");
		addClass($("posterDiv" + btnIndex),"posterBig");
        starScroll("postername" + btnIndex,recommendArr[btnIndex].programname,11);
    } else {
        $("posterfocus").style.visibility = "hidden";
		removeClass($("posterfocus"), "posterBig");
		removeClass($("posterDiv" + btnIndex), "posterBig");
        stopScroll("postername" + btnIndex,recommendArr[btnIndex].programname);
    }
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
function doPlay() {
    var requestUrl = "get_onebookmark.jsp?<%=ajax_paramHD%>"+"&definition=0" ;
    new net.ContentLoader("action/" + requestUrl, function() {
        var responseText = this.req.responseText;
        var breakpoint = parseInt(responseText, 10);
        top.doStop();
        var playUrl = "vod_play.jsp?<%=ajax_paramHD%>";
		if('<%=is4K%>' == '1'){
	        document.location = playUrl + "&definition=4&authid=" + authid+"&breakpoint="+breakpoint;
		}else{
	        document.location = playUrl + "&definition=" + curDefinition + "&authid=" + authid+"&breakpoint="+breakpoint;
    	}
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
    document.location = "back.jsp";
}
function doOk() {
    if (focusType === 0) {
        if (curFocusIndex === 0) {
            // 播放按钮
            doPlay();
        } else if (curFocusIndex === 1) {
            //收藏按钮
            doFavorite();
        }
    } else if (focusType === 1) {
        // 推荐区域
        goDetail(recommIndex);
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
        //Authentication.CTCSetConfig("KeyValue", "0x110");
        //document.location = "portal.jsp";
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
    } else if (keyCode == 1108) {
		window.location.href = 'portal_key.jsp?Action=1';
	} else if (keyCode == 1110) {
		window.location.href = 'portal_key.jsp?Action=2';
	} else if (keyCode == 1109) {
		window.location.href = 'portal_key.jsp?Action=3';
	} else if (keyCode == 1112) {
		window.location.href = 'portal_key.jsp?Action=4';
	} else {
        top.doKeyPress(evt);
        return true;
    }
    return false;
}

function doRight() {
    if (focusType == 0) {
        if (curFocusIndex === 0) {
            changeImg(curFocusIndex, "false");
            curFocusIndex = 1;
            changeImg(curFocusIndex, "true");
        }
    } else if (focusType == 1) {
        if (recommIndex < 6 && recommIndex < recommtotal - 1) {
            changePosterImg(recommIndex, false);
            recommIndex++;
            changePosterImg(recommIndex, true);
        }
    }
}

function doLeft() {
    if (focusType == 0) {
        if (curFocusIndex === 1) {
            changeImg(curFocusIndex, "false");
            curFocusIndex = 0;
            changeImg(curFocusIndex, "true");
        }
    } else if (focusType == 1) {
        if (recommIndex > 0) {
            changePosterImg(recommIndex, false);
            recommIndex--;
            changePosterImg(recommIndex, true);
        }
    }
}

function doDown() {
    if (focusType == 0 && recommtotal > 0) {
        changeImg(curFocusIndex, "false");
        focusType = 1;
        changePosterImg(0,true);
    }
}
function doUp() {
    if (focusType == 1) {
        changePosterImg(recommIndex, false);
        focusType = 0;
        changeImg(0, "true");
    }
}
function stopvideo() {
    top.doStop();
}
setTimeout("stopvideo()", 2000);
</script>
</head>
<body bgcolor="transparent" background="images/portal/recommend/bg.png" style="overflow: hidden;" onLoad="initPage()">
<div id="showerror" style="position: absolute; color: red; font-size: 30px; top: 7px; height: 71px; left: 423px; width: 291px;">

</div>
<%--<div style="visibility:hidden">--%>
     <%--<img src="images/vod/upListFocus_1.png">--%>
     <%--<img src="images/vod/cancelCollectBg.png">--%>
     <%--<img src="images/vod/upListBg_3.png">--%>
     <%--<img src="images/vod/upListFocus_1.png">--%>
<%--</div>--%>
<!--vod的海报，三屏  级别 评级信息-->
<%@ include file="inc/vod_basicInfo.jsp" %>
<%@ include file="inc/scroll_detail.jsp" %><!-- 修改详情页推荐位节目名称显示不全 cny 2017/8/8 -->
<div style="position:absolute;left:370px;top:40px;width:850px;height:260px;color:#FFF;font-size:24px; ">
    <div style="position: absolute;left:1px;top:20px;width: 850px;height: 40px;">
        <div style="float:left;top:0px;height:40px;color:#FFF;font-size:35px;text-overflow: ellipsis; word-spacing:normal; overflow:hidden;"
             class="font-ellipsis"><%=programname%>
        </div>
        <div id="columnname" style="float:left;top:4px;width:200px;height:30px;padding-left: 15px;padding-top:10px; ">
            <%=columnname%>
        </div>
    </div>
    <div style="position:absolute;left:0px;top:70px;width:800px;height:30px;font-size:22px;color:#B6B6B6;">
        <div style="position:absolute;">导演:</div>
        <div class="page-text"><%=director%>
        </div>
    </div>
    <div style="position:absolute;left:0px;top:100px;width:800px;height:30px;font-size:22px;color:#B6B6B6;">
        <div style="position:absolute;">主演:</div>
        <div class="page-text"><%=actor%>
        </div>
    </div>
    <div style="position:absolute;left:0px;top:140px;width:850px;line-height:30px;height:120px;padding-top:10px;font-size:22px;color:#B6B6B6;overflow:hidden;text-overflow: ellipsis;word-wrap:break-word;">
        <%=description%>
    </div>
</div>
<%--播放按钮--%>
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

<%--<div id="borderfocus1" style="position:absolute; left:640px;top:330px;">--%>
    <%--&lt;%&ndash;<img id="border_img1" src="images/vod/<%=fav_img%>" style="width: 142px;height: 70px;">&ndash;%&gt;--%>
    <%--<img id="border_img1" src="images/vod/cancelCollectBg.png" >--%>
<%--</div>--%>

<%--<div id="borderfocus1" style="position:absolute; left:740px;top:330px;">--%>
    <%--&lt;%&ndash;<img id="border_img1" src="images/vod/<%=fav_img%>" style="width: 142px;height: 70px;">&ndash;%&gt;--%>
    <%--<img id="border_img1" src="images/vod/upListBg_1.png" >--%>
<%--</div>--%>
<%--<div id="borderfocus1" style="position:absolute; left:840px;top:320px;">--%>
    <%--&lt;%&ndash;<img id="border_img1" src="images/vod/<%=fav_img%>" style="width: 142px;height: 70px;">&ndash;%&gt;--%>
    <%--<img id="border_img1" src="images/vod/upListFocus_3.png" >--%>
<%--</div>--%>
<%--推荐区域--%>
<div id="recomenDiv" style="position:absolute;left:88px;top:454px;width:1190px;height:230px;">
    <%
        for (int i = 0; i < 7; i++) {
    %>
    <div id="posterDiv<%=i%>"
         style="position: absolute;left:<%=0+i*160%>px;top:0px;width:80px;height:215px;padding-right:40px;display:none;">
        <img id="poster<%=i%>" src="" width="120" height="180" >

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

<script type="text/javascript">
    //推荐相关参数
    var recommendArr = [];  // 推荐VOD的全部数据
    var recommtotal = 0; // 推荐数据的总数
    var recommendUrl = "";

    function getNomalposter(posterlist) {
        var posters = new Array();
        if (null != posterlist) {
            posters = posterlist.split(";");
        }
        if (posters.length > 0 && null != posters[0] && posters[0] != "") {
            return "../images/poster/" + posters[0];
        } else {
            return "images/poster/defaultposter_n.png";
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
                top.jsDebug("---------recommtotal---------" + recommtotal);
                for (var i = 0; i < 7; i++) {
					if(i < recommtotal){
						$("posterDiv" + i).style.display = "block";
						$("poster" + i).src = getNomalposter(recommendArr[i].posterfilelist);
						stopScroll("postername" +i, recommendArr[i].programname);
					}else{
						$("poster" + i).src = 'images/btn_trans.gif';
	                    $("postername" + i).innerText = '';
					}
                }
            }
        });
    }
    function initPage() {
        document.onkeypress = dokeypress;
        //显示VOD的基本信息
        $("basic_info").style.left = "58px";
        $("basic_info").style.top = "26px";
        $("basic_info").style.fontWeight = "bold";
        $("basic_info").style.visibility = "visible";
        $("cur_poster").src = "<%=normalposter%>";
        //初始化焦点
        changeImg(0, "true");
//        alert("========1111====="+isFav);
        if(isFav=="true"){
            $("borderfocus1_0").style.display="block";
        } else{
            $("borderfocus1_1").style.display="block";
        }
        // 获取推荐数据
        getRecommendData();
    }


</script>
<%@include file="inc/lastfocus.jsp" %>
</body>
</html>