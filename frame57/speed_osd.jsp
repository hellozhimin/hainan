<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%--<%@ include file="inc/words.jsp" %>--%>
<%@page isELIgnored="false" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@ page import="com.zte.iptv.epg.util.STBKeysNew" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<epg:PageController name="back.jsp"/>
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
    String definition = String.valueOf(request.getParameter("definition"));
    if (definition.equals("") || definition.equals("null")) {
        definition = "1";
    }
    String isok=request.getParameter("isok");
    String columnid = request.getParameter("columnid");
    String programid = request.getParameter("programid");
    String programName = "";
    String mediaservice = "1";
    String ishls = (String) session.getAttribute("isHls");
    ishls="1";
    if ("1".equals((String) session.getAttribute("isHls"))) {
        mediaservice = "2";
    }
    String sql = " columncode = '" + columnid + "' and programcode = '" + programid + "' and mediaservice = " + mediaservice;

//    String definitionImg = "images/icon_info_SD.png";
//    String replacehlsurl = (String) session.getAttribute("replacehlsurl");
//    if (replacehlsurl.equals("1")) {
//        ishls = "1";
//    }
    String seriesnum="";
    String programtype="";
    String description="";
    String actor="";
    String director="";
%>
<ex:params var="params">
    <ex:param name="programcodeavailable" value="<%=programid%>"/>
</ex:params>
<ex:search tablename="user_vod_detail" fields="*" inputparams="${params}"  condition="<%=sql%>"
           var="programInfo">
    <%
        List vodInfo = (ArrayList) pageContext.getAttribute("programInfo");
        //System.out.println("========vodInfo========"+vodInfo);
        if (vodInfo.size() > 0) {
            Map map = (Map) vodInfo.get(0);
            programName = String.valueOf(map.get("programname"));
            seriesnum = String.valueOf(map.get("seriesnum"));
            programtype = String.valueOf(map.get("programtype"));
          	description =String.valueOf(map.get("description"));
            actor = String.valueOf(map.get("actor"));
            director = String.valueOf(map.get("director"));

        }
    %>
</ex:search>
<html>
<head>
    <title>TVOD Flipbar</title>
    <meta name="page-view-size" content="1280*720"/>
</head>
<body bgcolor="transparent"  style="overflow: hidden;">
<%--下方进度条背景图片--%>
<div style="left:582px; top:217px;width:143px;height:142px; position:absolute;">
    <img src="images/btn_trans.gif" id="showimg">
</div>
<div style="left:582px; top:217px;width:143px;height:142px; position:absolute;line-height: 142px;font-size: 35px;color: #fff;"
     align="center" id="speedDiv">

</div>
<div style="left:30px; top:10px;width:1000px;height:130px; position:absolute;line-height: 100px;font-size: 35px;color: #fff;" >
    <%=programName%>
</div>
<div style="left:0px; top:468px;width:1172px;height:234px; position:absolute;">
    <img src="images/tvod/mini_bg.png" border="0" width="1280" height="234" alt=""/>

    <div id="name" class=""
         style="left:46px; top:130px; position:absolute; width: 401px; height: 100px;font-size:30px;color:#fff;"
         >
        <%=programName%>
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
  <div style="left:362px; top:94px;width:25px;height:25px; position:absolute;visibility: hidden;">
        <img src="images/tvod/xu.png"/>
    </div>
    <div style="left:480px; top:90px; width:770px; height:50px; position:absolute; color: #fff; font-size: 23px; overflow:hidden; text-overflow: ellipsis; word-wrap:break-word;"
         class="" id="director_actor">
    </div>
    <div style="left:480px; top:125px;width:760px;height:95px; position:absolute;color: #58595C;font-size: 20px;overflow:hidden;text-overflow: ellipsis;word-wrap:break-word;" id="description">
        
    </div>
    <div id="procesTimeLogo" style="position:absolute;width:29px;height:25px;left:208px;top:51px;visibility: hidden;">
        <img src="images/btn_trans.gif" alt="" width="29" height="25"></div>
    <div id="currenttime"
         style="position:absolute; width:10px; height:10px; left:208px; top:35px;color:#15a8f7;visibility: hidden;"></div>
</div>
<div id="isPrompt" style="position: absolute; width: 301px; height: 38px; left: 945px; top: 64px; font-size: 26px; color: #FFF; text-align: right;">连续剧请按向上键选集</div>
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
var isok="<%=isok%>";
var showtime=0;
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
    } else{
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
        if (speed < 0 || speed == 64) {
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
        if (speed > 0 || speed == -64) {
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

//展示开始和结束的时间
function pageVODSpeedInitStartAndEnd() {
    var duration = top.jsDoGetVODTimeInfo();
    var VODTimeInfo = parseInt(duration);
    var endTimeStr = convertSecondTime(VODTimeInfo);
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
    showtimebar=setTimeout("setRefreshBarTimer()", 1000);
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
function donothing(){

}

function pageInit() {
    <%--stopScroll("director" ,"<%=director%>");--%>
    <%--stopScroll("actor" ,"<%=actor%>");--%>
    var director="<%=director%>";
    var actor="<%=actor%>";
    var description="<%=description%>";
    document.getElementById("director_actor").innerHTML="导演："+director+"   主演："+actor;
    document.getElementById("description").innerHTML="简介："+description;
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
            top.mainWin.document.all.speedDiv.innerHTML = "2X";
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
//            alert("======huwenx----"+convertSecondTime(isoktime));
        }  else{
            var tempEndTime = top.jsDoGetVODTimeInfo();
            showtime=parseInt(tempEndTime/20);
            top.mainWin.document.all.stateImg.src = "images/tvod/flip_bar_pause.png";
            top.mainWin.document.all.speedDiv.innerHTML = "";
            document.getElementById("showimg").src = "images/tvod/puse.png";
        }
        pageRefreshBarState();
    } else if(type=="normal") {
        top.mainWin.document.all.stateImg.src = "images/tvod/flip_bar_pause.png";
        top.mainWin.document.all.speedDiv.innerHTML = "";
        isok=1;
        if(isok==1){
            showtime=30 ;
            isoktime= top.mp.getCurrentPlayTime();
            hlsRefreshBarLength(isoktime);
        }
        showtimebar= setTimeout("setRefreshBarTimer();",1000);
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

var isfirst=0 ;
<%-- is HLS --%>
function fastr() {
    if(showtimebar!=null){
        clearTimeout(showtimebar);
//        isoktime=top.mp.getCurrentPlayTime();
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
    }  else{
        if(tempLength ==858){
            isfirst=0;
            allfastf--;
        }
    }
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

    } else{
        if(tempLength ==0){
            isfirst=0;
            allfastf++;
        }
    }
    hlsRefreshBarLength(getHlsCurTime());
    if(isok==1){
        timeseek = setTimeout("newFastForword()", 1000);
    }
}
function getHlsCurTime() {
    var currentTime = top.mp.getCurrentPlayTime();
    if(isok==1){
        currentTime=isoktime;
    }
    currentTime = parseInt(currentTime);
    var endTime = top.getMediaDuration();
    endTime = parseInt(endTime);
    var curr = currentTime + allfastf * showtime;
    if(isok==0){
        curr = (curr > (endTime-10)) ? endTime-10 : curr;
    }  else{
        curr = (curr > endTime) ? endTime : curr;
    }

    curr = (curr < 0) ? 0 : curr;
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
    showtimebar=setTimeout("setRefreshBarTimer()", 2000);
    hiddenTime= setTimeout(function(){
        top.jsHideOSD();
    },10000) ;
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
    showtimebar=setTimeout("setRefreshBarTimer()", 2000);
    hiddenTime= setTimeout(function(){
        top.jsHideOSD();
    },10000) ;
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
        top.mainWin.document.all.speedBarDiv1.style.left =228;
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

//document.onkeydown = dokeypress;
pageInit();
document.onkeydown = top.doKeyPress;
focus();
</script>
</body>
</html>