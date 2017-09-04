<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@	taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.epg.util.STBKeysNew" %>
<%@page import="com.zte.iptv.volcano.epg.account.User"%>
<%@page import="com.zte.iptv.volcano.data.QueryResult"%>
<%@page import="com.zte.iptv.volcano.epg.constants.NameConstants"%>
<%@ page import="java.util.*" %>
<%--<%@ include file="inc/words.jsp" %>--%>
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
    public String getPorgramnameVodInfo(User user, String telcode)
    {
        QueryResult qr = user.query(NameConstants.VIEWNAME_USER_CHANNEL, "",
                "channelcode='" + telcode + "'", "", 1, 1, null);
        String porgramname = "";
        if (null != qr)
        {
            List vodlist = qr.getResultList();
//            System.out.println("=======wwww====");
            if (null != vodlist && vodlist.size() > 0)
            {
                Map vod = (Map)vodlist.get(0);
                if (vod != null)
                {
                    porgramname = (String)vod.get("channelname");
//                    contentcode = (String)vod.get("contentcode");
                }
            }
        }
        return porgramname;

    }
%>
<%
    User user = User.getCurrentUser();

    String preview = "";
    if (request.getParameter("preview") != null) {
        preview = request.getParameter("preview");
    }
    String endTime = request.getParameter("endTime");
    if (endTime == null || "undefined".equals(endTime)){
        endTime = "0";
    }

    String path = getPath(request.getRequestURI());
    String columnId = request.getParameter(EpgConstants.COLUMN_ID);
    String channelId = request.getParameter(EpgConstants.CHANNEL_ID);
    String mixno = request.getParameter("mixno");
    String channelname =getPorgramnameVodInfo(user,channelId);
//    System.out.println("========channelname======="+channelname);
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
<script type="text/javascript" src="js/public_func.js"></script>
<script language="javascript" type="text/javascript">
top.jsClearVideoKeyFunction();
top.disableLocalUI();

var endTime = "<%=endTime%>";
var proEndtime;
var showinfotime=null;
var currTime=Date.parse(new Date()) / 1000;
function showInfo() {
    return;
    top.mainWin.document.location = "channel_infobar.jsp?channelcode=<%=channelId%>&columncode=<%=columnId%>&mixno=" + top.channelInfo.currentChannel;
    top.showOSD(2, 0, 0);
}
//showinfotime=setTimeout("showInfo()",1000);

function showSpeedFFInfo() {
    if ("Normal Play" == top.getStatus())
    {
        var currCh = parseInt(top.channelInfo.currentChannel);
        if (top.channelInfoArr[currCh] == undefined || top.channelInfoArr[currCh] == null)
        {
            return false;
        }
        if (top.channelInfoArr[currCh].timeShift == 1 && "<%=preview%>" != "1")
        {
            top.getTSTVTime();
            var TSTVCurrentTimeM = parseInt(top.TSTVCurrentTime.getTime() / 1000);
            var TSTVEndTimeM = parseInt(top.TSTVEndTime.getTime() / 1000);
            if (TSTVCurrentTimeM < TSTVEndTimeM)
            {
                top.doFastForward(2);
                top.mainWin.document.location = "<%=path%>channel_play_speed1.jsp?fast=FF&channelid=<%=channelId%>&endTime=" + endTime;
                top.showOSD(2, 0, 0);
            }
        }
    }
    return false;
}
function showSpeedRRInfo() {
    if ("Normal Play" == top.getStatus())
    {
        var currCh = parseInt(top.channelInfo.currentChannel);
        if (top.channelInfoArr[currCh] == undefined || top.channelInfoArr[currCh] == null)
        {
            return false;
        }
        if (top.channelInfoArr[currCh].timeShift == 1 && "<%=preview%>" != "1")
        {
            top.getTSTVTime();
            var TSTVCurrentTimeM = parseInt(top.TSTVCurrentTime.getTime() / 1000);
            var TSTVBeginTimeM = parseInt(top.TSTVBeginTime.getTime() / 1000);
            if (TSTVCurrentTimeM > TSTVBeginTimeM)
            {
                top.doFastRewind(2);
                top.mainWin.document.location = "<%=path%>channel_play_speed1.jsp?fast=RR&channelid=<%=channelId%>&endTime=" + endTime;
                top.showOSD(2, 0, 0);
            }
        }
    }
    return false;
}

function showSpeedPauseInfo(){
    if ("Normal Play" == top.getStatus())
    {
        var currCh = parseInt(top.channelInfo.currentChannel);
        if (top.channelInfoArr[currCh] == undefined || top.channelInfoArr[currCh] == null)
        {
            return false;
        }
        if (top.channelInfoArr[currCh].timeShift == 1 && "<%=preview%>" != "1")
        {
            top.getTSTVTime();
            top.doPause();
            top.mainWin.document.location = "<%=path%>channel_play_speed.jsp?fast=pause&channelid=<%=channelId%>&endTime=" + endTime;
            top.showOSD(2, 0, 0);

        }
    }
    return false;
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

function onKeyOK() {
//    var curMixnoinnerHTML = top.mainWin.document.getElementById("channelNumber").innerHTML;
//    if (curMixnoinnerHTML) {
//        curMixnoinnerHTML = curMixnoinnerHTML.toLowerCase();
//    }
//
//    var _curChannel_last = top.channelInfo.currentChannel;
//    var curMixnoinner = parseInt(curMixnoinnerHTML);
//
//    if (!isNaN(curMixnoinner) && curMixnoinner != _curChannel_last) {//立即播放
//
//        if (top.showChannelId != null) {
//            top.clearTimeout(top.showChannelId);
//            var intChannel = parseInt(top.temChannel, 10);
//            top.jsRedirectChannel(intChannel);
//        }
//        return;
//    } else if (curMixnoinner == _curChannel_last) {//相同频道EPG会刷新下
//        top.clearTimeout(top.showChannelId);
//        top.temChannel = "";
//    }
    top.mainWin.document.location = "<%=path%>channel_all_ok.jsp?firstFlag=false&channelcode=<%=channelId%>&columncode=<%=columnId%>&mixno="+top.channelInfo.currentChannel+"&channelid=<%=channelId%>" + "&numToPlay=" + numToPlay;
    // document.location = "<%=path%>channel_all_ok.jsp?firstFlag=false&channelcode=<%=channelId%>&columncode=<%=columnId%>&mixno="+top.channelInfo.currentChannel+"&channelid=<%=channelId%>" + "&numToPlay=" + numToPlay;
    top.showOSD(2, 0, 0);
}

function remoteChannelMinus()
{
    top.remoteChannelMinus();
}
function remoteChannelPlus()
{
    top.remoteChannelPlus();
}
function remoteLastChannel()
{
    var lastChannel=top.channelInfo.lastChannel;
    var currentChannel=top.channelInfo.currentChannel;
    if(lastChannel!="" && lastChannel!= undefined && lastChannel !=-1 && lastChannel!=currentChannel)
    {
        top.jsRedirectChannel(lastChannel);
    }
}
function back() {
	var channelname=encodeURIComponent(encodeURIComponent("<%=channelname%>"))
    top.mainWin.document.location = "<%=path%>channel_playstop.jsp?channelcode=<%=channelId%>&columnid=<%=columnId%>&currTime="+currTime+"&channelname="+channelname;
    top.showOSD(2, 0, 0);
    //top.mainWin.document.location = null;
//    top.setBwAlpha(0);
}
function menu(){
	//首页键返回封套，停止播放  modify by cny 2017/8/9
	 top.doStop();
     top.currState = 0;
     top.jsClearVideoKeyFunction();
     top.mainWin.document.location = '<%=page_url%>' ;
}

function donothing() {

}
function pageVolumeMute(){
    top.mainWin.document.location = "<%=path%>volumeOSD.jsp?type=mute";
    top.showOSD(2, 0, 0);
}
top.jsSetControl("curMixno", top.channelInfo.currentChannel);
top.jsSetVideoKeyFunction("top.extrWin.onKeyOK", <%=STBKeysNew.onKeyOK%>);
top.jsSetVideoKeyFunction("top.extrWin.remoteLastChannel", <%=STBKeysNew.onKeyBlue%>);
top.jsSetVideoKeyFunction("top.extrWin.remoteLastChannel", <%=STBKeysNew.remoteLastChannel%>);
top.jsSetVideoKeyFunction("top.extrWin.back", <%=STBKeysNew.remoteBack%>);
top.jsSetVideoKeyFunction("top.extrWin.menu", <%=STBKeysNew.remoteMenu%>); 
top.jsSetVideoKeyFunction("top.extrWin.showInfo", <%=STBKeysNew.remoteInfo%>);
top.jsSetVideoKeyFunction("top.extrWin.showSpeedRRInfo", <%=STBKeysNew.onKeyLeft%>);
top.jsSetVideoKeyFunction("top.extrWin.showSpeedFFInfo", <%=STBKeysNew.onKeyRight%>);
top.jsSetVideoKeyFunction("top.extrWin.pageVolumePlus", <%=STBKeysNew.remoteVolumePlus%>);
top.jsSetVideoKeyFunction("top.extrWin.pageVolumeMinus", <%=STBKeysNew.remoteVolumeMinus%>);
top.jsSetVideoKeyFunction("top.extrWin.pageVolumeMute", <%=STBKeysNew.remoteVolumeMute%>);
top.jsSetVideoKeyFunction("top.extrWin.donothing", <%=STBKeysNew.remoteStop%>);
top.jsSetVideoKeyFunction("top.extrWin.showSpeedPauseInfo", <%=STBKeysNew.RmotePlayPause%>);
top.jsSetVideoKeyFunction("top.extrWin.showSpeedRRInfo", <%=STBKeysNew.remoteFastRewind%>);
top.jsSetVideoKeyFunction("top.extrWin.showSpeedFFInfo", <%=STBKeysNew.remoteFastForword%>);
top.jsSetVideoKeyFunction("top.extrWin.remoteChannelMinus", <%=STBKeysNew.onKeyDown%>);
top.jsSetVideoKeyFunction("top.extrWin.remoteChannelPlus", <%=STBKeysNew.onKeyUp%>);
top.jsSetVideoKeyFunction("top.extrWin.remoteChannelPlus", <%=STBKeysNew.remoteChannelPlus%>);
top.jsSetVideoKeyFunction("top.extrWin.remoteChannelMinus", <%=STBKeysNew.remoteChannelMinus%>);

var showchannelindex=top.jsGetControl("showchannelinfo");
var numToPlay = top.jsGetControl("NUM_TO_PLAY");
if(showchannelindex=="1"){
    top.jsSetControl("showchannelinfo",0);
    var showchannelindex1=top.jsGetControl("showchannelinfo1");
    //var columncode="<%=columnId%>";
    var columncode = top.channelInfo.columncode1111;
    if(showchannelindex1==1){
        top.jsSetControl("showchannelinfo1",0);
        columncode="xxx";
    }
    setTimeout(function(){
        top.mainWin.document.location = "<%=path%>channel_all_ok.jsp?firstFlag=false&channelcode=<%=channelId%>&columncode="+columncode+"&mixno="+top.channelInfo.currentChannel+"&channelid=<%=channelId%>" + "&numToPlay=" + numToPlay;
        top.showOSD(2, 0, 0);
    },1000);
}
top.jsSetControl("NUM_TO_PLAY", true);
</script>
<body bgcolor="transparent" onLoad="" onUnload="" >
</body>