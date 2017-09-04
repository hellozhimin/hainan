<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.zte.iptv.epg.util.STBKeysNew" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%!
    public String getPath(String uri) {
        String path = "";
        int begin = 0;
        int end = uri.lastIndexOf('/');
        if (end > 0) {
            path = uri.substring(begin, end + 1) + path;
        }
        return path;
    }

    String partFrame(String reqURI) {
        int start = reqURI.indexOf("frame");
        int end = reqURI.indexOf("/", start);
        return reqURI.substring(start, end);
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
%>
<%
    String authSNScode = (String) session.getAttribute("authSNScode");
    String path = getPath(request.getRequestURI());
    String columnid = request.getParameter("columnid");
    String programid = request.getParameter("programid");
    String fromPoint = request.getParameter("fromPoint");
    String definition = request.getParameter("definition");
    String contentcode = request.getParameter("contentcode");
    String isprevue = request.getParameter("isprevue");
    String subcontentid = request.getParameter("subcontentid");
    String fromBookMark = request.getParameter("fromBookMark");
    String seriesprogramcode=request.getParameter("seriesprogramcode");
    String allowed = (String) request.getParameter("allowed");
    String playChannel = request.getParameter("playChannel");
    String bp = request.getParameter("bp");
    if(bp==null){
        bp="0";
    }
    String vodtype = request.getParameter("vodtype");
    String mediaservice = "32";
    mediaservice = String.valueOf(request.getParameter("mediaservices"));
%>
<html>
<head>
    <title>control_transit_vod_play.jsp</title>
</head>
<body bgcolor="transparent" >
<script type="text/javascript" src="js/contentloader.js"></script>
<script language="javascript" type="text/javascript">
var isPlay = top.extrWin.isPlay;
var seriesprogramcode="<%=seriesprogramcode%>";
top.jsClearVideoKeyFunction();
top.disableLocalUI();

function showtvodInfo(){
  top.mainWin.document.location = "<%=path%>speed_osd.jsp?fast=normal&programid=<%=programid%>&columnid=<%=columnid%>&definition=<%=definition%>&seriesprogramcode=<%=seriesprogramcode%>&mediaservices=<%=mediaservice%>";
    top.showOSD(2, 0, 0);
}
if (top.OSDInfo.state != 0) {
    top.OSDInfo.state = 0;
}


 var seriesArr=[];
 var totalcount;
 var seriesLeng=0;;
 var SingleIndex=1;
 //首次进来播放的当前时间，用于用户统计
 var currTime=Date.parse(new Date()) / 1000;
function getSeriesData(){
    var requestUrl = "action/get_series_single_data.jsp?columncode=<%=columnid%>&programid=<%=seriesprogramcode%>";
    new net.ContentLoader(requestUrl, function () {
        var resultsdata = eval("(" + this.req.responseText + ")");
        seriesArr = resultsdata.seriesData;
        totalcount = resultsdata.totalcount;
        //pagecount = parseInt(resultsdata.pagecount, 10);
        seriesLeng = seriesArr.length;       
    });
}
if(seriesprogramcode !="" && !isNaN(seriesprogramcode)){
	getSeriesData();	
}


function playseries(Index){
    top.jsSetControl("series_Index", Index);
    var definition=seriesArr[Index-1].definition ;
    if(definition>4){
        definition=4;
    }else if(definition==3){
        definition=1;
    }
  var playUrl = "<%=path%>vod_play.jsp?programcode="+seriesArr[Index-1].programid+"&columncode=<%=columnid%>&contentcode="+ seriesArr[Index-1].contentcode+"&definition="+definition + "&seriesIndex="+(Index) ;
    top.mainWin.document.location = playUrl + "&breakpoint=0&seriesprogramcode=<%=seriesprogramcode %>&leefocus=linker" + Math.ceil(2);
    top.showOSD(2, 0, 0);
} 

//play end
function showThank() {
    var Index = top.jsGetControl("series_Index");
    if (Index != "" && !isNaN(Index)) //记忆为空
    {
        SingleIndex = parseInt(Index);
    }
    if (SingleIndex < seriesLeng) {
        SingleIndex++;
		//电视剧播放下一集
        playseries(SingleIndex);
		/**播放完推出
        top.mainWin.document.location = "<%=path%>vod_play_stop.jsp?fast=pause&contentcode=<%=contentcode%>&columnid=<%=columnid%>&definition=<%=definition%>&fromBookMark=<%=fromBookMark%>&mediaservices=<%=mediaservice%>&seriesprogramcode="+seriesprogramcode+"&vodtype=<%=vodtype%>";
        top.showOSD(2, 0, 0);
		*/
    } else {
        top.jsClearVideoKeyFunction();
        top.doStop();
        top.setBwAlpha(0);
        top.jsHideOSD();
        top.doStopVideo();
//        top.vodBackTimer = top.setTimeout("top.switchToStopOSDUrl(0)", 100);
        setTimeout(function(){
            top.switchToStopOSDUrl(0);
        },200);
    }
}

function FastRewind() {
    top.doFastRewind(-2);
    top.mainWin.document.location = "<%=path%>speed_osd1.jsp?fast=RR&programid=<%=programid%>&columnid=<%=columnid%>&definition=<%=definition%>&seriesprogramcode=<%=seriesprogramcode%>&mediaservices=<%=mediaservice%>";
    top.showOSD(2, 0, 0);
}

function FastForword() {
   top.doFastForward(2);
    top.mainWin.document.location = "<%=path%>speed_osd1.jsp?fast=FF&programid=<%=programid%>&columnid=<%=columnid%>&definition=<%=definition%>&seriesprogramcode=<%=seriesprogramcode%>&mediaservices=<%=mediaservice%>&path=<%=path%>";
    top.showOSD(2, 0, 0);
}

function pause() {
    top.mainWin.document.location = "<%=path%>speed_osd.jsp?isok=0&fast=pause&programid=<%=programid%>&columnid=<%=columnid%>&definition=<%=definition%>&seriesprogramcode=<%=seriesprogramcode%>&mediaservices=<%=mediaservice%>";
    top.doPause();
    top.showOSD(2, 0, 0);

}
function pause1() {
    top.mainWin.document.location = "<%=path%>speed_osd.jsp?isok=1&fast=pause&programid=<%=programid%>&columnid=<%=columnid%>&definition=<%=definition%>&seriesprogramcode=<%=seriesprogramcode%>&mediaservices=<%=mediaservice%>";
//    top.doPause();
    top.showOSD(2, 0, 0);

}
function VODPlayStop() {
        top.doPause();
        top.mainWin.document.location = "<%=path%>vod_play_stop.jsp?fast=pause&contentcode=<%=contentcode%>&columnid=<%=columnid%>&definition=<%=definition%>&fromBookMark=<%=fromBookMark%>&mediaservices=<%=mediaservice%>&seriesprogramcode="+seriesprogramcode+"&vodtype=<%=vodtype%>&currTime="+currTime;
        top.showOSD(2, 0, 0);
}

function pageVolumePlus()
{
    top.mainWin.document.location = "<%=path%>volumeOSD.jsp?type=add";
    top.showOSD(2, 0, 0);
}

function pageVolumeMinus()
{
    top.mainWin.document.location = "<%=path%>volumeOSD.jsp?type=minus";
    top.showOSD(2, 0, 0);
}
function gotoPortal() {
//首页键返回封套，停止播放  modify by cny 2017/8/9
 top.doStop();
 top.mainWin.document.location = '<%=page_url%>' ;
}

function doNothing() {
}
function pageVolumeMute(){
    top.mainWin.document.location = "<%=path%>volumeOSD.jsp?type=mute";
    top.showOSD(2, 0, 0);
}
function showVods(){
	if ("<%=vodtype%>" == "101") {
        top.mainWin.document.location = "<%=path%>show_all_vod.jsp?fast=series&programid=<%=programid%>&columnid=<%=columnid%>&definition=<%=definition%>&seriesprogramcode=<%=seriesprogramcode%>&mediaservices=<%=mediaservice%>";
        top.showOSD(2, 0, 0);
    }  else{
        if ("<%=vodtype%>" == "10") {
            if (seriesprogramcode != "" && !isNaN(seriesprogramcode)) {
                top.mainWin.document.location = "<%=path%>show_all_series.jsp?fast=series&programid=<%=programid%>&columnid=<%=columnid%>&definition=<%=definition%>&seriesprogramcode=<%=seriesprogramcode%>&mediaservices=<%=mediaservice%>";
                top.showOSD(2, 0, 0);
            }
        }
	}
}
top.jsSetVideoKeyFunction("top.extrWin.pause", <%=STBKeysNew.RmotePlayPause%>);
top.jsSetVideoKeyFunction("top.extrWin.FastRewind", <%=STBKeysNew.remoteFastRewind%>);
top.jsSetVideoKeyFunction("top.extrWin.FastForword", <%=STBKeysNew.remoteFastForword%>);

top.jsSetVideoKeyFunction("top.extrWin.FastForword", <%=STBKeysNew.onKeyRight%>);
top.jsSetVideoKeyFunction("top.extrWin.FastRewind", <%=STBKeysNew.onKeyLeft%>);
top.jsSetVideoKeyFunction("top.extrWin.showVods", <%=STBKeysNew.onKeyUp%>);

top.jsSetVideoKeyFunction("top.extrWin.pageVolumePlus", <%=STBKeysNew.remoteVolumePlus%>);
top.jsSetVideoKeyFunction("top.extrWin.pageVolumeMinus", <%=STBKeysNew.remoteVolumeMinus%>);
top.jsSetVideoKeyFunction("top.extrWin.pageVolumeMute", <%=STBKeysNew.remoteVolumeMute%>);
//修改频道加减跳到直播问题  modify by cny 2017/8/9
top.jsSetVideoKeyFunction("top.extrWin.doNothing", <%=STBKeysNew.remoteChannelPlus%>);
top.jsSetVideoKeyFunction("top.extrWin.doNothing", <%=STBKeysNew.remoteChannelMinus%>);

top.jsSetVideoKeyFunction("top.extrWin.doNothing", <%=STBKeysNew.remotePlayLast%>);
top.jsSetVideoKeyFunction("top.extrWin.doNothing", <%=STBKeysNew.remotePlayNext%>);
top.jsSetVideoKeyFunction("top.extrWin.showThank", "mediaEnd");
top.jsSetVideoKeyFunction("top.extrWin.gotoPortal", <%=STBKeysNew.remoteMenu%>);
top.jsSetVideoKeyFunction("top.extrWin.pause1", <%=STBKeysNew.onKeyOK%>);
top.jsSetVideoKeyFunction("top.extrWin.VODPlayStop", <%=STBKeysNew.remoteBack%>);
top.jsSetVideoKeyFunction("top.extrWin.showtvodInfo", <%=STBKeysNew.remoteInfo%>);
 var showinfotime=null;
   function playbytime(){
       top.mainWin.document.location = "<%=path%>vod_playbytime.jsp?bp=<%=bp%>&fast=normal&programid=<%=programid%>&columnid=<%=columnid%>&definition=<%=definition%>&seriesprogramcode=<%=seriesprogramcode%>&mediaservices=<%=mediaservice%>";
       top.showOSD(2, 0, 0);
   }
 if("<%=bp%>"!="0"){
    // playbytime();
//     setTimeout("showtvodInfo()",1000);
     showinfotime=setTimeout("playbytime()",1000);
 }else{
     showinfotime= setTimeout("showtvodInfo()",1000);
 }
//  showinfotime=setTimeout("showtvodInfo()",1000);
</script>
</body>
</html>