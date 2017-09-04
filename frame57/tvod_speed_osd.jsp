<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%--<%@ include file="inc/words.jsp" %>--%>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@ page import="com.zte.iptv.epg.util.STBKeysNew" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@page import="com.zte.iptv.volcano.epg.account.User"%>
<%@page import="com.zte.iptv.volcano.data.QueryResult"%>
<%@page import="com.zte.iptv.volcano.epg.constants.NameConstants"%>
<%!
//    public String getPorgramnameVodInfo(User user, String telcode,String channelcode)
//    {
//        QueryResult qr = user.query(NameConstants.VIEWNAME_USER_CHANNELPREVUE, "",
//                "prevuecode='" + telcode + "' and channelcode='"+channelcode+"'", "", 1, 1, null);
//        String porgramname = "";
//        if (null != qr)
//        {
//            List vodlist = qr.getResultList();
//            System.out.println("=======wwww====");
//            if (null != vodlist && vodlist.size() > 0)
//            {
//                Map vod = (Map)vodlist.get(0);
//                if (vod != null)
//                {
//                    porgramname = (String)vod.get("prevuename");
////                    contentcode = (String)vod.get("contentcode");
//                }
//            }
//        }
//        return porgramname;
//
//    }
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
    String columncode = request.getParameter("columncode");
    String contentcode = request.getParameter("contentcode");
    String channelcode = request.getParameter("channelcode");
    String isnpvr = request.getParameter("isnpvr");
    StringBuffer sqlcon = new StringBuffer();
    String ishls="1";
    String isok=request.getParameter("isok");
    if (columncode != null && !"".equals(channelcode)) {
        sqlcon.append(" channelcode = '").append(channelcode).append("'");
    }
    if (contentcode != null && !"".equals(contentcode)) {
        sqlcon.append(" and prevuecode = '").append(contentcode).append("'");
    }
    String currprevuename = "暂无节目";
    User user = User.getCurrentUser();
//    currprevuename=getPorgramnameVodInfo(user,contentcode,channelcode);
    String nextprevuename = "暂无节目";
    String time111 = "";
    String time222 = "";
    String begintime = "";
    String endtime = "";
    String mixno = "";
    String channelname = "";
    String pdescription = "";
    int index = 0;
    int index1=0;
    long currtime = new Date().getTime();
    SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd HH:mm:SS");
//    System.out.println("===============sqlcon==="+sqlcon.toString());
%>
<ex:search tablename="user_channelprevue" fields="*"
           condition="<%=sqlcon.toString()%>" var="channelprevuelist">
    <%
        List channelprevuelist = (List) pageContext.getAttribute("channelprevuelist");
        if (channelprevuelist != null && channelprevuelist.size() > 0) {
            for (int i = 0; i < channelprevuelist.size(); i++) {
                Map tvodMap = (Map) channelprevuelist.get(i);
                String prevuename = String.valueOf(tvodMap.get("prevuename"));
//                System.out.println("=============111111=====prevuename============1"+prevuename);
                begintime = String.valueOf(tvodMap.get("begintime"));
                endtime = String.valueOf(tvodMap.get("endtime"));
//                long begintime1 = format.parse(begintime).getTime();
//                long endtime1 = format.parse(endtime).getTime();
                if (contentcode.equals(String.valueOf(tvodMap.get("prevuecode")))) {
                    currprevuename = prevuename;
                    time111 = begintime.substring(11, 16) + "-" + endtime.substring(11, 16);
                    index = i;
                    break;
                }

            }
        }

    %>
</ex:search>
<%
    String channelsql = "channelcode = '" + channelcode + "' and columncode='" + columncode + "'";
%>
<ex:search tablename="user_channel" fields="*" condition="<%=channelsql%>" var="channellist">
    <%
        List channellist = (List) pageContext.getAttribute("channellist");
//        System.out.println("=========channellist======"+channellist);
        if (channellist != null && channellist.size() > 0) {
            Map tvodMap = (Map) channellist.get(0);
            mixno = String.valueOf(tvodMap.get("usermixno"));
            if (mixno.length() == 1) {
                mixno = "00" + mixno;
            } else if (mixno.length() == 2) {
                mixno = "0" + mixno;
            }
            channelname = String.valueOf(tvodMap.get("channelname"));

        }

    %>
</ex:search>
<html>
<head>
    <title>TVOD Flipbar</title>
    <meta name="page-view-size" content="1280*720"/>
</head>
<body bgcolor="transparent" >
<%--<%@ include file="inc/scrollString.jsp" %>--%>
<%--下方进度条背景图片--%>
<div style="left:582px; top:217px;width:143px;height:142px; position:absolute;">
    <img src="images/btn_trans.gif" id="showimg">
</div>
<div style="left:582px; top:217px;width:143px;height:142px; position:absolute;line-height: 142px;font-size: 35px;color: #fff;"
     align="center" id="speedDiv">

</div>
<div style="left:0px; top:468px;width:1172px;height:234px; position:absolute;">
    <img src="images/tvod/mini_bg.png" border="0" width="1280" height="234" alt=""/>

    <div id="name" class=""
         style="left:35px; top:121px; position:absolute; width: 411px; height: 50px;font-size:35px;color:#fff;"
         >
        <%=mixno%>  <%=channelname%>  
    </div>

    <div style="left:126px; top:17px;width:88px;height:62px;position:absolute;font-size:28px;color:#CCCCCC;line-height: 62px;"
         id="currentTimeDiv"></div>
    <div style="left:1126px;top:17px;width:88px;height:62px;position:absolute;font-size:28px;color:#CCCCCC;line-height: 62px;"
         id="endTimeDiv"></div>

    <div style="left:46px; top:17px;width:25px;height:25px; position:absolute">
        <img border="0" src="images/btn_trans.gif" id="stateImg" alt=""/>
    </div>
    <div align="left"
         style="left:170px; top:60px;width:42px;height:22; position:absolute;font-size:25px;color:#02A9FA"></div>

    <div style="left:250px; top:42px; position:absolute; width: 858px;height: 10px;background-color:#3F434B;">
        <%--<img src="images/bg_grey.png" alt="" width="930" height="10">--%>
    </div>

    <div id="speedBarDiv"
         style="position:absolute; width:1px; height:10px; left:250px; top:42px;background-color:#00B7F9;">
        <%--<img id="speedBarDiv" src="images/bg_fill.png" border="0" width="30" height="28">--%>
    </div>
    <div id="speedBarDiv1"
         style="position:absolute; width:48px; height:47px; left:228px; top:24px;">
        <img  src="images/seek.png" >
    </div>
    <%--<div style="left:462px; top:103px;width:25px;height:25px; position:absolute">--%>
        <%--<img src="images/tvod/xu.png"/>--%>
    <%--</div>--%>
    <div style="left:490px; top:119px;width:750px;height:50px; position:absolute;color: #fff;font-size: 28px;"
         class="">

        <span style="position:absolute;left:10px;width: 200px;"><%=time111%></span>
        <span style="position:absolute;left:180px;width: 370px;" class=""><%=currprevuename%></span>
    </div>
    <%--<div style="left:510px; top:162px;width:750px;height:50px; position:absolute;color: #fff;font-size: 28px;"--%>
         <%--class="">--%>
        <%--稍后播放：<span style="position:absolute;left:140px;width: 370px;" class=""> <%=nextprevuename%></span>--%>
        <%--<span style="position:absolute;left:520px;width: 200px;"><%=time222%></span>--%>
    <%--</div>--%>
    <div id="procesTimeLogo" style="position:absolute;width:29px;height:25px;left:208px;top:51px;visibility: hidden;">
        <img src="images/btn_trans.gif" alt="" width="29" height="25"></div>
    <div id="currenttime"
         style="position:absolute; width:10px; height:10px; left:208px; top:35px;color:#15a8f7;visibility: hidden;"></div>
</div>
<div id="test" style="position:absolute; width: 373px; height: 80px; left: 376px; top: 470px; font-size:30px; color:#FFF;"></div>
<script type="text/javascript" src="js/stb_keys_new.js"></script>
<script type="text/javascript" src="js/public_func.js"></script>
<script type="text/javascript">
var type = "<%=request.getParameter("fast")%>";
var speed = 1;
var flag = 0;
var pasuse_ad;
var allfastf = 0;
var timeseek = null;
var refreshBarTimer = null;
var showtime=0;
var isok="<%=isok%>";
var tempLength=0;
var hiddenTime=null;
var showtimebar=null;
var isoktime=0;
function pageResume() {
	top.doStop();
    if (top.isPlay()) {
        top.pageResume();
        top.mainWin.document.location = '<%=page_url%>' ;
        top.showOSD(2, 0, 0);
    }
}
top.jsSetupKeyFunction("top.mainWin.pageResume", <%=STBKeysNew.remoteMenu%>);

function pagePlayPause() {
    if(allfastf==0){
        top.jsDoResume();
    }   else{
        newFastRewind();
    }

    top.jsHideOSD();
}

//在这个页面按OK和按暂停效果是一样的都是重新播放。
function pageOnKeyOK() {
    pagePlayPause();
}

//快进
function pageFastForword() {
    type = "FF";
    if ("<%=ishls%>" == "1") {
        fastf();
    } else {
        speed = top.getStbPlaySpeed();
        top.jsDebug("pageFastForword:speed:[Before Modify]" + speed);
        //对机顶盒进行兼容处理：部分盒子视频播放过程中暂停状态的返回码为0而非-1，导致兼容问题
        if (speed == 0) {
            speed = -1;
        }
        top.jsDebug("pageFastForword:speed:[After  Modify]" + speed);
        if (speed < 0 || speed == 32) {
            speed = 2;
        }
        else {
            speed = speed * 2;
        }
        //top.mp.fastForward(speed);
        top.doFastForward(speed);
        top.mainWin.document.all.speedDiv.innerHTML = speed + "X";
        top.mainWin.document.all.stateImg.src = "images/tvod/flip_bar_forward.png";
        document.getElementById("showimg").src = "images/tvod/showsu.png";
    }
}

//快退
function pageFastRewind() {
    type = "RR";
    if ("<%=ishls%>" == "1") {
        fastr();
    } else {
        speed = top.getStbPlaySpeed();
        top.jsDebug("pageFastRewind:speed:[Before Modify]" + speed);
        //对机顶盒进行兼容处理：部分盒子视频播放过程中暂停状态的返回码为0而非-1，导致兼容问题
        if (speed == 0) {
            speed = -1;
        }
        top.jsDebug("pageFastRewind:speed:[After  Modify]" + speed);
        if (speed > 0 || speed == -32) {
            speed = -2;
        }
        else {
            speed = speed * 2;
        }
        var nowspeed = -speed;
        top.mainWin.document.all.speedDiv.innerHTML = nowspeed + "X";
        top.mainWin.document.all.stateImg.src = "images/tvod/flip_bar_backward.png";
        document.getElementById("showimg").src = "images/tvod/showsu.png";
        //top.mp.fastRewind(speed);
        top.doFastRewind(speed);
    }
}

function convertSecondTime(secondTime) {
    var VODHours = secondTime / 3600;
    VODHours = parseInt(VODHours);

    if (("" + VODHours).length == 1) {
        VODHours = "0" + VODHours;
    }
    var StrVODHours = VODHours;
    VODHours = parseInt(VODHours, 10);
    var VODMinutes = (secondTime - VODHours * 3600) / 60;
    VODMinutes = parseInt(VODMinutes);
    if (("" + VODMinutes).length == 1) {
        VODMinutes = "0" + VODMinutes;
    }
    var VODSeconds = secondTime - VODHours * 3600 - VODMinutes * 60;
    if (("" + VODSeconds).length == 1) {
        VODSeconds = "0" + VODSeconds;
    }

    return StrVODHours + ":" + VODMinutes + ":" + VODSeconds;
//    return StrVODHours + ":" + VODMinutes ;
}

function convertMinTime(secondTime) {
    var VODHours = secondTime / 3600;
    VODHours = parseInt(VODHours);

    if (("" + VODHours).length == 1) {
        VODHours = "0" + VODHours;
    }
    var StrVODHours = VODHours;
    VODHours = parseInt(VODHours, 10);
    var VODMinutes = (secondTime - VODHours * 3600) / 60;
    VODMinutes = parseInt(VODMinutes);
    if (("" + VODMinutes).length == 1) {
        VODMinutes = "0" + VODMinutes;
    }
    return StrVODHours + ":" + VODMinutes;
}
function prinLog(value){
    var logImg=new Image();
    logImg.src="action/get_ad2.jsp?log="+value+"&time="+new Date();
}
//展示开始和结束的时间
function pageVODSpeedInitStartAndEnd() {
   // var duration = top.jsDoGetVODTimeInfo();
    var duration = top.mp.getMediaDuration();
   //document.getElementById("test").innerHTML=top.mp.getMediaDuration()+"==***=="+top.jsDoGetVODTimeInfo();
    var VODTimeInfo = parseInt(duration);
   // prinLog("========"+VODTimeInfo);
//    alert("=======VODTimeInfo========="+VODTimeInfo);
    var endTimeStr = convertSecondTime(VODTimeInfo);
    if(VODTimeInfo==0||VODTimeInfo<3){
        showtime=0;
        setTimeout("pageVODSpeedInitStartAndEnd()",50) ;
        return;
    }
    if(isok==1){
        showtime=30 ;
        isoktime= top.mp.getCurrentPlayTime();
    }  else{
        var tempEndTime = top.jsDoGetVODTimeInfo();
        showtime=parseInt(tempEndTime/20);
    }
    top.mainWin.document.all.endTimeDiv.innerHTML = endTimeStr;
}

//刷新当前播放时间
function refreshCurrentTime() {
    var currentTime = top.jsGetCurrentPlayTime();
    if (currentTime == undefined || currentTime == null) {
        currentTime = top.jsGetCurrentPlayTime();
    }
    var VODTimeInfo = parseInt(currentTime);
    if (VODTimeInfo == 0) {
        top.mainWin.document.all.currentTimeDiv.innerHTML = "00:00:00";
        return;
    }
    var endTimeStr = convertSecondTime(currentTime);
    top.mainWin.document.all.currentTimeDiv.innerHTML = endTimeStr;
}

function setRefreshBarTimer() {
    //if (type != "pause") {
        pageRefreshBarState();
   // }
    isoktime=top.mp.getCurrentPlayTime();
    showtimebar= setTimeout("setRefreshBarTimer()", 1000);
}

//控制当前播放时间的进度展示
function pageRefreshBarState() {
//    var state = top.getStatus();
//    if (flag == 3 && state == "Normal Play") {
//        top.hideOSD();
//        return;
//    }
//    else {
//        flag += 1;
//    }
    var currTime = parseInt(top.jsGetCurrentPlayTime());
    if (currTime == -1) {
        return;
    }
    refreshCurrentTime();
    refreshBarLength();
}

//刷新进度条播放长度
function refreshBarLength() {
    var tempCurrentTime = top.jsGetCurrentPlayTime();
    var tempEndTime = top.jsDoGetVODTimeInfo();
    tempLength = (tempCurrentTime * 858) / tempEndTime;
    tempLength = parseInt(tempLength);
    if (tempLength == 0) {
        top.mainWin.document.all.speedBarDiv.style.width = 1;
        top.mainWin.document.all.speedBarDiv1.style.left = 228;
    }
    else if (tempLength >= 858) {
        top.mainWin.document.all.speedBarDiv.style.width = 858;
        top.mainWin.document.all.speedBarDiv1.style.left = 858+228;
        document.getElementById("procesTimeLogo").style.left = 858 + 208 + "px";
        document.getElementById("currenttime").style.left = 858 + 208 + "px";
    }
    else {
        document.getElementById("procesTimeLogo").style.left = tempLength + 208 + "px";
        document.getElementById("currenttime").style.left = tempLength + 208 + "px";
        top.mainWin.document.all.speedBarDiv.style.width = tempLength;
        top.mainWin.document.all.speedBarDiv1.style.left = tempLength+228;
    }
}
function donothing(){}
function pageInit() {
    top.jsSetupKeyFunction("top.mainWin.pageFastRewind", 0x0109);
    top.jsSetupKeyFunction("top.mainWin.pageFastForword", 0x0108);
    top.jsSetupKeyFunction("top.mainWin.pageOnKeyOK", 0x000d);
    top.jsSetupKeyFunction("top.mainWin.pagePlayPause", 0x0107);
    top.jsSetupKeyFunction("top.mainWin.pagePlayPause", 0x0008);
    top.jsSetupKeyFunction("top.mainWin.pageFastRewind", <%=STBKeysNew.onKeyLeft%>);
    top.jsSetupKeyFunction("top.mainWin.pageFastForword", <%=STBKeysNew.onKeyRight%>);
    if (type == "FF") {
        top.mainWin.document.all.stateImg.src = "images/flip_bar_forward.png";
        if ("<%=(String) session.getAttribute("isHls")%>" != "1") {
            top.mainWin.document.all.speedDiv.innerHTML =  "2X" ;
            document.getElementById("showimg").src = "images/tvod/showsu.png";
        } else {
            pageFastForword();
        }
    } else if (type == "RR") {
        top.mainWin.document.all.stateImg.src = "images/tvod/trans_rewind.png";
        if ("<%=(String) session.getAttribute("isHls")%>" != "1") {
            top.mainWin.document.all.speedDiv.innerHTML = "2X";
            document.getElementById("showimg").src = "images/tvod/showsu.png";
        } else {
            pageFastRewind();
        }
    } else if (type == "pause") {
        if (top.OSDInfo.state != 2) {
            top.OSDInfo.state = 2;
        }
        if(isok==1){
            showtime=30 ;
            isoktime= top.mp.getCurrentPlayTime();
            hiddenTime= setTimeout(function(){
                top.jsHideOSD();
            },10000) ;
        }  else{
            var tempEndTime = top.jsDoGetVODTimeInfo();
            showtime=parseInt(tempEndTime/20);
            top.mainWin.document.all.stateImg.src = "images/tvod/flip_bar_pause.png";
            top.mainWin.document.all.speedDiv.innerHTML = "";
            document.getElementById("showimg").src = "images/tvod/puse.png";
        }

        pageRefreshBarState();
    }else if(type=="normal") {
        top.mainWin.document.all.stateImg.src = "images/tvod/flip_bar_pause.png";
        top.mainWin.document.all.speedDiv.innerHTML = "";
//       var stopTime= setTimeout("pageRefreshBarState()",1000) ;
        isok=1;
        if(isok==1){
            showtime=30 ;
            isoktime= top.mp.getCurrentPlayTime();
            hlsRefreshBarLength(isoktime);
        }
        showtimebar= setTimeout("setRefreshBarTimer();",100);
        hiddenTime= setTimeout(function(){
            top.jsHideOSD();
        },10000) ;
//        document.onkeydown=donothing;
    }
    if ("<%=ishls%>" != "1") {
        setRefreshBarTimer();
    }
    pageVODSpeedInitStartAndEnd();
}
function loadProgramInfo() {
    if ("<%=isnpvr%>" == "1") {
        document.getElementById("endTimeDiv").style.left = "1100px";
        document.getElementById("procesTimeLogo").style.visibility = "visible";
        document.getElementById("currenttime").style.visibility = "visible";
        pageVODSpeedInitStartAndEnd();
    } else {
        var tempEndTime = top.jsDoGetVODTimeInfo();
        top.mainWin.document.all.currentTimeDiv.innerHTML = top.FONTHEAD + "00:00:00" + top.FONTTAIL;
        top.mainWin.document.all.endTimeDiv.innerHTML = top.FONTHEAD + convertSecondTime(tempEndTime) + top.FONTTAIL;
    }
}
  var isfirst=0;
<%-- is HLS --%>
function fastr() {
    if(showtimebar!=null){
        clearTimeout(showtimebar);
    }
    if(hiddenTime!=null){
        clearTimeout(hiddenTime);
    }
    if (timeseek) {
        clearTimeout(timeseek);
        timeseek = null;
    }
    if (refreshBarTimer) {
        clearTimeout(refreshBarTimer);
        refreshBarTimer = null;
    }
    if(isfirst==0){
        allfastf--;
    } else{
        if(tempLength ==858){
            isfirst=0;
            allfastf--;
        }
    }

//    top.mainWin.document.all.stateImg.src = "images/flip_bar_backward.png";
    hlsRefreshBarLength(getHlsCurTime());
    if(isok==1){
        timeseek = setTimeout("newFastRewind()", 1000);
    }

}
function fastf() {
    if(showtimebar!=null){
        clearTimeout(showtimebar);
    }
    if(hiddenTime!=null){
        clearTimeout(hiddenTime);
    }
    if (timeseek) {
        clearTimeout(timeseek);
        timeseek = null;
    }
    if (refreshBarTimer) {
        clearTimeout(refreshBarTimer);
        refreshBarTimer = null;
    }
    if(isfirst==0){
        if(isok==1){
            var currentTime = top.mp.getCurrentPlayTime();
            currentTime = parseInt(currentTime);
            var endTime = top.getMediaDuration();
            endTime = parseInt(endTime);
            var curr = currentTime + (allfastf+1) * showtime;
//            alert(curr+"======================="+endTime);
            if(curr>=endTime){

            }else{
                allfastf++;
            }
        } else{
            allfastf++;
        }
    }else{
        if(tempLength ==0){
            isfirst=0;
            allfastf++;
        }
    }

//    top.mainWin.document.all.stateImg.src = "images/flip_bar_forward.png";
    hlsRefreshBarLength(getHlsCurTime());
    if(isok==1){
        timeseek = setTimeout("newFastForword()", 1000);
    }
//    timeseek = setTimeout("newFastForword()", 1000);
}
function getHlsCurTime() {
    var currentTime = top.mp.getCurrentPlayTime();
    currentTime = parseInt(currentTime);
    if(isok==1){
//        alert("=============111========="+convertSecondTime(isoktime));
        currentTime=isoktime;
    }
    currentTime = parseInt(currentTime);
    var endTime = top.getMediaDuration();
    endTime = parseInt(endTime);
    var curr = currentTime + allfastf * showtime;
//    curr = (curr > endTime) ? endTime : curr;
    if(isok==0){
        curr = (curr > (endTime-10)) ? endTime-10 : curr;
    }  else{
        curr = (curr > endTime) ? endTime : curr;
    }
    curr = (curr < 0) ? 0 : curr;
//    isoktime=curr;
    return curr;
}
function newFastRewind() {
    var curr = getHlsCurTime();
    var endTime = top.getMediaDuration();
    endTime = parseInt(endTime);
    if(curr>=endTime){
        curr=curr-10;
    }
    top.jsDoSeekTargetTime(1, curr);
    allfastf = 0;
    showtimebar=setTimeout("setRefreshBarTimer()", 1000);
    hiddenTime= setTimeout(function(){
        top.jsHideOSD();
    },10000) ;
//    setTimeout("top.hideOSD();", 500);
}
function newFastForword() {
    var curr = getHlsCurTime();
    var endTime = top.getMediaDuration();
    endTime = parseInt(endTime);
    if(curr>=endTime){
        curr=curr-10;
    }
    top.jsDoSeekTargetTime(1, curr);
    allfastf = 0;
    showtimebar=setTimeout("setRefreshBarTimer()", 1000);
    hiddenTime= setTimeout(function(){
        top.jsHideOSD();
    },10000) ;
//    setTimeout("top.hideOSD();", 500);
}
function hlsRefreshBarLength(curr) {
    var tempCurrentTime = curr;
    var tempEndTime = top.jsDoGetVODTimeInfo();
    tempLength = (tempCurrentTime * 858) / tempEndTime;
    tempLength = parseInt(tempLength);
    if (tempLength == 0) {
        isfirst=1;
        tempLength=0;
        top.mainWin.document.all.speedBarDiv.style.width = 1;
        top.mainWin.document.all.speedBarDiv1.style.left = 228;
    } else if (tempLength >= 858) {
        isfirst=1;
        tempLength=858;
        top.mainWin.document.all.speedBarDiv.style.width = 858;
        top.mainWin.document.all.speedBarDiv1.style.left = 858+228;
    } else {
        isfirst=0;
        top.mainWin.document.all.speedBarDiv.style.width = tempLength;
        top.mainWin.document.all.speedBarDiv1.style.left = tempLength+228;
    }
    hlsRefreshCurrentTime(tempCurrentTime);
}
function hlsRefreshCurrentTime(tempCurrentTime) {
    var currentTime = tempCurrentTime;
    if (currentTime == undefined || currentTime == null) {
        currentTime = top.jsGetCurrentPlayTime();
    }
    var VODTimeInfo = parseInt(currentTime);
    if (VODTimeInfo == 0) {
        top.mainWin.document.all.currentTimeDiv.innerHTML = "00:00:00";
        return;
    }
    var endTimeStr = convertSecondTime(currentTime);
    top.mainWin.document.all.currentTimeDiv.innerHTML = endTimeStr;
}
//document.onkeypress = top.doKeyPress;
function dokeypress(evt){
    var keyCode = parseInt(evt.which);
    if (keyCode == 768) {
        var dummyKeyCode = Utility.getEvent();
        var  eventType="";
        if(dummyKeyCode.length>0){
            var values=eval('('+dummyKeyCode+')');
            eventType= values["type"]||values["Type"];
        }
        //alert("======eventType========="+eventType);
        if(eventType=="EVENT_MEDIA_END"){
            top.doStop();
//            top.setBwAlpha(0);
            top.jsHideOSD();
            top.doStopVideo();
            document.location="back.jsp";
//            top.vodBackTimer = top.setTimeout("top.switchToStopOSDUrl(0)", 100);
        } else{
            top.doKeyPress(evt) ;
            return true;
        }
    }  else{
        top.doKeyPress(evt) ;
        return true;
    }
}
//document.onkeydown = dokeypress;
pageInit();
document.onkeydown = top.doKeyPress;
focus();
</script>
</body>
</html>