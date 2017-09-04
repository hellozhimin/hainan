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
<%

    String definition = String.valueOf(request.getParameter("definition"));
    if (definition.equals("") || definition.equals("null")) {
        definition = "1";
    }
    String columnid = request.getParameter("columnid");
    String programid = request.getParameter("programid");
    String programName = "";
    String mediaservice = "1";
    String ishls = (String) session.getAttribute("isHls");
    if ("1".equals((String) session.getAttribute("isHls"))) {
        mediaservice = "2";
    }
    String sql = " columncode = '" + columnid + "' and programcode = '" + programid + "' and mediaservice = " + mediaservice;

%>
<ex:params var="params">
    <ex:param name="programcodeavailable" value="<%=programid%>"/>
</ex:params>
<ex:search tablename="user_vod_detail" fields="*" inputparams="${params}" order="createtime desc" condition="<%=sql%>"
           var="programInfo">
    <%
        List vodInfo = (ArrayList) pageContext.getAttribute("programInfo");
//        System.out.println("========vodInfo========"+vodInfo);
        if (vodInfo.size() > 0) {
            Map map = (Map) vodInfo.get(0);
            programName = String.valueOf(map.get("programname"));
        }

    %>
</ex:search>
<html>
<head>
    <title>TVOD Flipbar</title>
    <meta name="page-view-size" content="1280*720"/>
</head>
<body bgcolor="transparent" onload="pageInit();" style="overflow: hidden;">
<%@ include file="inc/scrollString.jsp" %>
<%--下方进度条背景图片--%>
<div style="left:582px; top:217px;width:143px;height:142px; position:absolute;">
    <img src="images/btn_trans.gif" id="showimg">
</div>
<div style="left:582px; top:217px;width:143px;height:142px; position:absolute;line-height: 142px;font-size: 35px;color: #fff;"
     align="center" id="speedDiv">

</div>
<div style="left:30px; top:10px;width:1000px;height:100px; position:absolute;line-height: 100px;font-size: 35px;color: #fff;" >
    <%=programName%>
</div>
<div style="left:0px; top:568px;width:1172px;height:234px; position:absolute;">
    <img src="images/tvod/seek_bg.png" border="0" width="1280" height="133" alt=""/>

    <div id="name" class=""
         style="left:46px; top:120px; position:absolute; width: 311px; height: 100px;font-size:30px;color:#fff;visibility: hidden;"
         align="center">
        <%--<%=programName%>--%>
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

    <div id="procesTimeLogo" style="position:absolute;width:29px;height:25px;left:208px;top:51px;visibility: hidden;">
        <img src="images/btn_trans.gif" alt="" width="29" height="25"></div>
    <div id="currenttime"
         style="position:absolute; width:10px; height:10px; left:208px; top:35px;color:#15a8f7;visibility: hidden;"></div>
</div>
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
var tempLength=0;
function pageResume() {
	top.doStop();
    if (top.isPlay()) {
        top.pageResume();
        top.mainWin.document.location = "portal.jsp?onlymenu=1";
        top.showOSD(2, 0, 0);
    }
}
top.jsSetupKeyFunction("top.mainWin.pageResume", <%=STBKeysNew.remoteMenu%>);

function pagePlayPause() {
    top.jsDoResume();
    top.jsHideOSD();
}

//在这个页面按OK和按暂停效果是一样的都是重新播放。
function pageOnKeyOK() {
    pagePlayPause();
}

//快进
function pageFastForword() {
    type = "FF";
    if ("<%=(String) session.getAttribute("isHls")%>" == "1") {
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
    if ("<%=(String) session.getAttribute("isHls")%>" == "1") {
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
    if (type != "pause") {
        pageRefreshBarState();
    }
    setTimeout("setRefreshBarTimer()", 1000);
}

//控制当前播放时间的进度展示
function pageRefreshBarState() {
    var state = top.getStatus();
    if (flag == 3 && state == "Normal Play") {
        top.hideOSD();
        return;
    }
    else {
        flag += 1;
    }
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

function pageInit() {
    <%--if ("<%=isnpvr%>" == "1") {--%>
        <%--document.getElementById("endTimeDiv").style.left = "1100px";--%>
        <%--document.getElementById("procesTimeLogo").style.visibility = "visible";--%>
        <%--document.getElementById("currenttime").style.visibility = "visible";--%>
    <%--}--%>
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
            top.mainWin.document.all.stateImg.src = "images/tvod/flip_bar_forward.png";
        } else {
            pageFastForword();
        }
    } else if (type == "RR") {
        top.mainWin.document.all.stateImg.src = "images/tvod/trans_rewind.png";
        if ("<%=(String) session.getAttribute("isHls")%>" != "1") {
            top.mainWin.document.all.speedDiv.innerHTML = "2X";
            top.mainWin.document.all.stateImg.src = "images/tvod/flip_bar_backward.png";
            document.getElementById("showimg").src = "images/tvod/showsu.png";
        } else {
            pageFastRewind();
        }
    } else if (type == "pause") {
        if (top.OSDInfo.state != 2) {
            top.OSDInfo.state = 2;
        }
        top.mainWin.document.all.stateImg.src = "images/tvod/flip_bar_pause.png";
        top.mainWin.document.all.speedDiv.innerHTML = "";
        document.getElementById("showimg").src = "images/tvod/puse.png";

        pageRefreshBarState();
    }
    if ("<%=(String) session.getAttribute("isHls")%>" != "1") {
        setRefreshBarTimer();
    }
    pageVODSpeedInitStartAndEnd();
}
function loadProgramInfo() {
    <%--if ("<%=isnpvr%>" == "1") {--%>
        <%--document.getElementById("endTimeDiv").style.left = "1100px";--%>
        <%--document.getElementById("procesTimeLogo").style.visibility = "visible";--%>
        <%--document.getElementById("currenttime").style.visibility = "visible";--%>
        <%--pageVODSpeedInitStartAndEnd();--%>
    <%--} else {--%>
        var tempEndTime = top.jsDoGetVODTimeInfo();
        top.mainWin.document.all.currentTimeDiv.innerHTML = top.FONTHEAD + "00:00:00" + top.FONTTAIL;
        top.mainWin.document.all.endTimeDiv.innerHTML = top.FONTHEAD + convertSecondTime(tempEndTime) + top.FONTTAIL;
  //  }
}
<%-- is HLS --%>
function fastr() {
    if (timeseek) {
        clearTimeout(timeseek);
        timeseek = null;
    }
    if (refreshBarTimer) {
        clearTimeout(refreshBarTimer);
        refreshBarTimer = null;
    }
    allfastf--;
    top.mainWin.document.all.stateImg.src = "images/flip_bar_backward.png";
    hlsRefreshBarLength(getHlsCurTime());
    timeseek = setTimeout("newFastRewind()", 1000);
}
function fastf() {
    if (timeseek) {
        clearTimeout(timeseek);
        timeseek = null;
    }
    if (refreshBarTimer) {
        clearTimeout(refreshBarTimer);
        refreshBarTimer = null;
    }
    allfastf++;
    top.mainWin.document.all.stateImg.src = "images/flip_bar_forward.png";
    hlsRefreshBarLength(getHlsCurTime());
    timeseek = setTimeout("newFastForword()", 1000);
}
function getHlsCurTime() {
    var currentTime = top.mp.getCurrentPlayTime();
    currentTime = parseInt(currentTime);
    var endTime = top.getMediaDuration();
    endTime = parseInt(endTime);
    var curr = currentTime + allfastf * 10;
    curr = (curr > endTime) ? endTime : curr;
    curr = (curr < 0) ? 0 : curr;
    return curr;
}
function newFastRewind() {
    var curr = getHlsCurTime();
    top.jsDoSeekTargetTime(1, curr);
    allfastf = 0;
    setTimeout("top.hideOSD();", 500);
}
function newFastForword() {
    var curr = getHlsCurTime();
    top.jsDoSeekTargetTime(1, curr);
    allfastf = 0;
    setTimeout("top.hideOSD();", 500);
}
function hlsRefreshBarLength(curr) {
    var tempCurrentTime = curr;
    var tempEndTime = top.jsDoGetVODTimeInfo();
    tempLength = (tempCurrentTime * 858) / tempEndTime;
    tempLength = parseInt(tempLength);
    if (tempLength == 0) {
        top.mainWin.document.all.speedBarDiv.style.width = 1;
        top.mainWin.document.all.speedBarDiv1.style.left =228;
    } else if (tempLength >= 858) {
        top.mainWin.document.all.speedBarDiv.style.width = 858;
        top.mainWin.document.all.speedBarDiv1.style.left = 858+228;
    } else {
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
document.onkeypress = top.doKeyPress;
focus();
</script>
</body>
</html>