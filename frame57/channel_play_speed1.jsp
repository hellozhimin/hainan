<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--<%@ include file="inc/words.jsp" %>--%>
<%
    String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
    HashMap param = PortalUtils.getParams(path, "UTF-8");
    UserInfo userInfo = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
    String fastType=request.getParameter("fast");
    String channelcode = request.getParameter("channelid");
    String isIppv = request.getParameter("isIppv");
    isIppv="0";
    String columncode = (String)param.get("column0");
    String endTime = request.getParameter("endTime");
    String mixno = request.getParameter("mixno");
    if(endTime ==null){
        endTime="";
    }
    java.text.SimpleDateFormat timesdf = new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
    java.text.SimpleDateFormat dateF = new java.text.SimpleDateFormat("yyyy.MM.dd");
    String now = timesdf.format(new Date());
    StringBuffer sqlcon = new StringBuffer();

    if (columncode != null && !"".equals(channelcode)) {
        sqlcon.append(" channelcode = '").append(channelcode).append("'");
    }
//    if (contentcode != null && !"".equals(contentcode)) {
//        sqlcon.append(" and prevuecode = '").append(contentcode).append("'");
//    }
    String currDate = request.getParameter("currdate");
    if (currDate == null || "".equals(currDate)) {
        currDate = dateF.format(new Date());
    }
    String currDateBegin = currDate+" 00:00:00";
    String currDateEnd = currDate+" 23:59:59";
    sqlcon.append(" and begintime >'").append(currDateBegin).append("'");
    sqlcon.append(" and begintime <'").append(currDateEnd).append("'");
    String currprevuename = "暂无节目";
    String nextprevuename = "暂无节目";
    String time111 = "";
    String time222 = "";
    String begintime = "";
    String endtime = "";
//    String mixno = "";
    String channelname = "";
    String pdescription = "";
    int index = 0;
    long currtime = new Date().getTime();
    SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd HH:mm:SS");
%>
<ex:search tablename="user_channelprevue" fields="*" order="begintime asc"
           condition="<%=sqlcon.toString()%>" var="channelprevuelist">
    <%
        List channelprevuelist = (List) pageContext.getAttribute("channelprevuelist");
        if (channelprevuelist != null && channelprevuelist.size() > 0) {
            for (int i = 0; i < channelprevuelist.size(); i++) {
                Map tvodMap = (Map) channelprevuelist.get(i);
                String prevuename = String.valueOf(tvodMap.get("prevuename"));
                begintime = String.valueOf(tvodMap.get("begintime"));
                endtime = String.valueOf(tvodMap.get("endtime"));
                long begintime1 = format.parse(begintime).getTime();
                long endtime1 = format.parse(endtime).getTime();
                if (begintime1 <= currtime && currtime <= endtime1) {
                    currprevuename = prevuename;
                    time111 = begintime.substring(11, 16) + "-" + endtime.substring(11, 16);
                    index = i;
                }
                if (index != 0) {
                    nextprevuename = prevuename;
                    time222 = begintime.substring(11, 16) + "-" + endtime.substring(11, 16);
                }
            }

        }

    %>
</ex:search>
<%
//    String channelsql = "channelcode = '" + channelcode + "' and columncode='" + columncode + "'";
    String channelsql = "channelcode = '" + channelcode + "'";
//    System.out.println("======channelsql======"+channelsql);
%>
<ex:search tablename="user_channel" fields="*" condition="<%=channelsql%>" var="channellist">
    <%
        List channellist = (List) pageContext.getAttribute("channellist");
//        System.out.println("=========1111111=============="+channellist);
        if (channellist != null && channellist.size() > 0) {
            Map tvodMap = (Map) channellist.get(0);
            mixno = String.valueOf(tvodMap.get("mixno"));
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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="page-view-size" content="1280*720">
    <title></title>
    <script type="text/javascript" src="js/stb_keys_new.js"></script>
    <script type="text/javascript" src="js/contentloader.js"></script>
    <script type="text/javascript" src="js/public_func.js"></script>
    <style type="text/css">
        .font_ellipsis {
           /* overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;*/
        }
    </style>


</head>
<body bgcolor="transparent"  onload="pageInit();" onunload="pagePlayPause();" style="overflow: hidden;">
<div style="left:582px; top:217px;width:143px;height:142px; position:absolute;">
    <img src="images/btn_trans.gif" id="showimg">
</div>
<div style="left:582px; top:217px;width:143px;height:142px; position:absolute;line-height: 142px;font-size: 35px;color: #fff;"
     align="center" id="fastinfo2">

</div>
<div style="left:0px; top:568px;width:1172px;height:234px; position:absolute;">
    <%--<img src="images/vod/bg_vodinfobar.png" border="0" width="1280" height="187" alt=""/>--%>
        <img src="images/tvod/seek_bg.png" border="0" width="1280" height="133" alt=""/>
    <div id="currproname"  style="color:#B9DB63;left:140px; top:0px; position:absolute; width:900px; height:28px;font-size:28px;"  ></div>

        <div id="name" class="font_ellipsis"
             style="left:35px; top:129px; position:absolute; width: 411px; height: 50px;font-size:38px;color:#fff;visibility: hidden;"
             align="right">
            <%=mixno%>  <%=channelname%>
        </div>

    <div id="starttime" style="left:126px; top:17px;width:88px;height:62px;position:absolute;font-size:28px;color:#fff;line-height: 62px;" ></div>
    <div id="endtime" style="left:1126px;top:17px;width:88px;height:62px;position:absolute;font-size:28px;color:#fff;line-height: 62px;"></div>

    <div style="left:46px; top:17px;width:25px;height:25px; position:absolute">
        <img id="fastinfo1" border="0" src="images/btn_trans.gif"/>
    </div>
    <%--<div id="fastinfo2" align="left" style="left:170px; top:60px;width:42px;height:22; position:absolute;font-size:25px;color:#02A9FA" ></div>--%>

    <div style="left:250px; top:42px; position:absolute; width: 858px;height: 10px;background-color:#3F434B;" >
        <%--<img src="images/bg_grey.png" alt="" width="930" height="10">--%>
    </div>
        <%--<div style="left:462px; top:103px;width:25px;height:25px; position:absolute">--%>
            <%--<img src="images/tvod/xu.png"/>--%>
        <%--</div>--%>
        <div style="left:510px; top:109px;width:750px;height:50px; position:absolute;color: #fff;font-size: 30px;visibility: hidden;"
             class="font_ellipsis">
             当前播放：
            <span style="position:absolute;left:140px;width: 350px;" class="font_ellipsis"><%=currprevuename%></span>
            <span style="position:absolute;left:500px;width: 200px;"><%=time111%></span>
        </div>
        <div style="left:510px; top:162px;width:750px;height:50px; position:absolute;color: #fff;font-size: 30px;visibility: hidden;"
             class="font_ellipsis">
             稍后播放： <span style="position:absolute;left:140px;width: 350px;" class="font_ellipsis"> <%=nextprevuename%></span>
            <span style="position:absolute;left:500px;width: 200px;"><%=time222%></span>
        </div>
    <div id="procesTimeLogo" style="position:absolute;width:25px;height:20px;left:208px;top:51px;visibility: hidden;">
        <img src="images/btn_trans.gif" alt="" width="25" height="20"></div>
    <div id="speedBarDiv"  style="position:absolute; width:0px; height:10px; left:250px; top:42px;background-color:#00B7F9">
    </div>
        <div id="speedBarDiv1"
             style="position:absolute; width:48px; height:47px; left:228px; top:24px;">
            <img  src="images/seek.png" >
        </div>
    <div id="ts_show" style="position:absolute;width:100px;height:22px;top:10px;left:175;font-size:28px;color:#fff;text-align:center">
        <div id="ts_timeinfo" style="width:100px;height:22px;font-size:28px;color:#fff;text-align:center;visibility: hidden;"></div>
    </div>
</div>
<%@ include file="inc/lastfocus.jsp"%>
<script type="text/javascript">

var type="<%=fastType%>";
var isIppv =parseInt("<%=isIppv%>");
var endTime="<%=endTime%>";
var speed = 1 ;
var data ;
var prevuenameData ;
var probegintime;
var proendtime;
var processbarTimerId = -1;
var tempchanid="<%=channelcode%>";
top.jsDebug("-----------channel_paly_speed-----------------channelcode"+tempchanid);

var MonitorTimerId = null;
var currpronameTimerId = null;
var begintimetemp="";
var endtimetemp="";
var prevuename="";
var refreshTimerId=null;
function showCurrpronameTimer()
{
    <%--var currentPlayTime = formatDate(top.TSTVCurrentTime);--%>
    <%--if (currentPlayTime == -1)--%>
    <%--{--%>
        <%--return false;--%>
    <%--}--%>
    <%--var url = "action/channel_program_data.jsp?columncode=<%=columncode%>&channelcode=<%=channelcode%>&starttime="+currentPlayTime;--%>
    <%--new net.ContentLoader(url, function() {--%>
        <%--prevuenameData = eval("(" + this.req.responseText + ")");--%>
        <%--if(prevuenameData)--%>
        <%--{--%>
            <%--if(prevuenameData.items[0]!=undefined)--%>
            <%--{--%>
                <%--prevuename = prevuenameData.items[0].prevuename;--%>
                <%--document.getElementById("currproname").innerText = formatText(prevuename,30);--%>
            <%--}--%>
        <%--}--%>
    <%--});--%>
    <%--currpronameTimerId = top.mainWin.setTimeout("showCurrpronameTimer()", 5000);--%>
}

function clearCurrpronameTimer()
{
    if(currpronameTimerId != null)
    {
        top.mainWin.clearTimeout(currpronameTimerId);
        currpronameTimerId = null;
    }
}
function setMonitorTimer()
{
    MonitorTimerId = null;
    var state = top.getStatus();
    if(state == "Normal Play") {
        top.hideOSD();
    }
}
function clearMonitorTimer()
{
    if(MonitorTimerId != null) {
        top.mainWin.clearTimeout(MonitorTimerId);
        MonitorTimerId = null;
    }
}

function pagePlayPause()
{
    clearProcessBarTimer();
    clearMonitorTimer();
    clearCurrpronameTimer();
    top.pageResume();
    top.hideOSD();
    return false;
}

function pageFastForword()
{

    if(type == "pause")
    {
        top.mainWin.clearTimeout(refreshTimerId);
        refreshTimerId = top.mainWin.setTimeout("showProcessBarTimer()", 1000);
    }
    type = "FF";
    speed = top.getStbPlaySpeed();
    top.jsDebug("pageFastForword:speed:[Before Modify]"+speed);
    //对机顶盒进行兼容处理：部分盒子视频播放过程中暂停状态的返回码为0而非-1，导致兼容问题
    if(speed == 0){
        speed = -1;
    }
    top.jsDebug("pageFastForword:speed:[After  Modify]"+speed);
    if (speed < 0 || speed == 32)
    {
        speed = 2;
    } else
    {
        speed = speed * 2;
    }
    top.jsDebug("------------------------speed:"+speed);

    document.getElementById("fastinfo2").innerText=speed+"X";
    document.getElementById("fastinfo1").src="images/tvod/flip_bar_forward.png";
    document.getElementById("showimg").src = "images/tvod/showsu.png";
    top.doFastForward(speed);

}

function pageFastRewind()
{

    if(type == "pause")
    {
        top.mainWin.clearTimeout(refreshTimerId);
        refreshTimerId = top.mainWin.setTimeout("showProcessBarTimer()", 1000);
    }
    type = "RR";
    speed = top.getStbPlaySpeed();
    top.jsDebug("pageFastRewind:speed:[Before Modify]"+speed);
    //对机顶盒进行兼容处理：部分盒子视频播放过程中暂停状态的返回码为0而非-1，导致兼容问题
    if(speed == 0){
        speed = -1;
    }
    top.jsDebug("pageFastRewind:speed:[After  Modify]"+speed);
    if (speed > 0 || speed == -32) {
        speed = -2;
    } else {
        speed = speed * 2;
    }
    var nowspeed = -speed;
    document.getElementById("fastinfo1").src="images/tvod/flip_bar_backward.png";
    document.getElementById("fastinfo2").innerText=nowspeed+"X";
    document.getElementById("showimg").src = "images/tvod/showsu.png";
    top.doFastRewind(speed);
}

//显示进度条 延时
function showProcessBarTimer()
{
    var currTime = parseInt(top.jsGetCurrentPlayTime());
    if (currTime == -1)
    {
        return false;
    }
    showProcess();
    if(type == "pause") {
        refreshTimerId = top.mainWin.setTimeout("showProcessBarTimer()", 60000);
    } else {
        refreshTimerId = top.mainWin.setTimeout("showProcessBarTimer()", 1000);
    }
}
//清空进度条延时
function clearProcessBarTimer()
{
    if(refreshTimerId != null)
    {
        top.mainWin.clearTimeout(refreshTimerId);
        refreshTimerId = null;
    }
}
//显示进度
function showProcess()
{
    if(top.currState == 2 || top.currState == 4)
    {
        top.getTSTVTime();
        var PlaySpeed = top.getStbPlaySpeed();
        top.jsDebug("showProcess:PlaySpeed:"+PlaySpeed);
        var TSTVPlayTime = top.TSTVCurrentTime.getTime()+PlaySpeed*1000;
        var TSBeginTime = top.TSTVBeginTime.getTime();
        var TSEndTime = top.TSTVEndTime.getTime();

        if(isIppv ==1&&probegintime != undefined &&probegintime != undefined){//ippv
            TSBeginTime = probegintime.getTime();
            TSEndTime = proendtime.getTime();
        }else{
            //update
            top.jsDebug("=====TSBeginTime==="+TSBeginTime+"====TSEndTime==="+TSEndTime);
            var startTimeStr = formatDate(top.TSTVBeginTime);
            var endTimeStr = formatDate(top.TSTVEndTime);
            top.jsDebug("=====startTimeStr==="+startTimeStr+"====endTimeStr==="+endTimeStr);
            getTVtimeShow(startTimeStr,endTimeStr)
        }

        if(type == "pause")
        {
            TSTVPlayTime = top.TSTVCurrentTime.getTime();
        }
        else if (TSTVPlayTime > TSEndTime && type == "FF")
        {
            top.jsDebug("=====goto end====");
            clearMonitorTimer();
            clearProcessBarTimer();
            clearCurrpronameTimer();
            if(isIppv ==1){//ippv
                top.jsSetControl("gotoEnd",1);
                type ="normal";
                top.jsDebug("=====resume play==200==");
                top.jsDoResume();
                setTimeout("gotoEnd();",400);
            }else{
                top.doGoToEnd();
                top.jsHideOSD();
            }
            return false;
        }
        else if (TSTVPlayTime < TSBeginTime && type == "RR")
        {
            top.jsDebug("=====goto start====");
            clearMonitorTimer();
            clearProcessBarTimer();
            clearCurrpronameTimer();
            if(isIppv ==1){//ippv
                pageDoStart();
            }else{
                top.doGoToStart();
            }
            top.jsHideOSD();
            return false;
        }

        top.jsDebug("===TSTVPlayTime===="+TSTVPlayTime+"======TSBeginTime==="+TSBeginTime+"=====TSEndTime==="+TSEndTime);
        var beginToCurrTime =  TSTVPlayTime - TSBeginTime;
        var beginToEndTime =   TSEndTime-TSBeginTime;
        top.jsDebug("===TSTVPlayTime===="+TSTVPlayTime+"======beginToCurrTime==="+beginToCurrTime+"=====beginToEndTime==="+beginToEndTime);
        var processBarLenght = 858;
        var currentProcessLength = parseInt(processBarLenght * beginToCurrTime / beginToEndTime);
        top.jsDebug("=======currentProcessLength===="+currentProcessLength);
        if (currentProcessLength < 1)
        {
            currentProcessLength = 1;
        }
        else if (currentProcessLength >= processBarLenght)
        {
            currentProcessLength =processBarLenght;
        }
        top.mainWin.document.all.speedBarDiv.style.width =currentProcessLength;
        top.mainWin.document.all.speedBarDiv1.style.left =currentProcessLength+228;
        document.getElementById("speedBarDiv").style.visibility = "visible";

        document.getElementById("ts_show").style.left=(currentProcessLength+175);
        document.getElementById("procesTimeLogo").style.left=(currentProcessLength+208);
        getTVCurrtenttimeShow(formatDate(top.TSTVCurrentTime))

        if(TSTVPlayTime<TSBeginTime||TSTVPlayTime>=TSEndTime)
        {
            top.jsDebug("---------------------into load--------");
            top.mainWin.clearTimeout(refreshTimerId);
        }

    }
}

function gotoEnd(){
    if(top.getStatus()=="Trickmode"){
        top.jsDebug("====the status is ==="+top.getStatus()+" and continue wait===")
        setTimeout("gotoEnd();",200);
    }else{
        top.jsDebug("===goto pause,and junmp====");
        top.doPause();
        top.jsSetControl("gotoEnd",0);
        top.mainWin.document.location = "channel_play_ippvend.jsp?mixno=<%=mixno%>&channelid=<%=channelcode%>&isIppv="+isIppv+"&endTime="+endTime;
        top.showOSD(2, 0, 0);
    }

}

function changeTimeStyle(time, flag) {
    var newTime = "";
    var forend = "";
    var hour = parseInt(time.substring(0, 2),10);
    if (flag) {
        if (hour >= 12) {
            if (hour == 24) {
                forend = "AM";
            } else {
                forend = "PM";
            }
            hour = hour - 12;
            if(hour == 0){
                return "12" + time.substring(2, 5) + forend;
            }
//                hour = hour < 10 ? "0" + "" + hour : hour;
            return hour + time.substring(2, 5) + forend;
        } else {
            if (hour == 12) {
                forend = "PM";
            } else {
                forend = "AM";
            }
            if (hour == 0) {
                return "12" + time.substring(2, 5) + forend;
            }
            return hour + time.substring(2, 5) + forend;
        }
    } else {
        return time;

    }
}

function pageVODSpeedInitStartAndEnd()
{
    var startTimeStr = begintimetemp;
    var endTimeStr = endtimetemp;
    if(isIppv==0)//no ippv
    {
        top.getTSTVTime();

        var TSBeginTime = top.TSTVBeginTime;
        var TSEndTime = top.TSTVEndTime;
        top.jsDebug("=====TSBeginTime==="+TSBeginTime+"====TSEndTime==="+TSEndTime);
        startTimeStr = formatDate(TSBeginTime);
        endTimeStr = formatDate(TSEndTime);
        top.jsDebug("=====startTimeStr==="+startTimeStr+"====endTimeStr==="+endTimeStr);
    }
    getTVtimeShow(startTimeStr,endTimeStr)
    document.getElementById("currproname").innerText = formatText(prevuename,30);
    showProcessBarTimer();
    refreshTimerId = top.mainWin.setTimeout("showProcessBarTimer()", 1000);
    MonitorTimerId = top.mainWin.setTimeout("setMonitorTimer()", 5000);
//    currpronameTimerId= top.mainWin.setTimeout("showCurrpronameTimer()", 5000);
}


function getTVtimeShow(startTimeStr,endTimeStr){

    var startHour = startTimeStr.substring(11,13);
    var startMin= startTimeStr.substring(14,16);
    var starttime =changeTimeStyle(startHour + ':' + startMin, false);

    var endHour = endTimeStr.substring(11,13);
    var endMin= endTimeStr.substring(14,16);
    var endtime =changeTimeStyle(endHour + ':' + endMin, false);
    document.getElementById("starttime").innerText =starttime;
    document.getElementById("endtime").innerText =endtime;
}

function getTVCurrtenttimeShow(timeStr){

    var startHour = timeStr.substring(11,13);
    var startMin= timeStr.substring(14,16);
    var starttime =changeTimeStyle(startHour + ':' + startMin, false);
    var TSEndTime = top.TSTVEndTime.getTime();
    var currtime=top.TSTVCurrentTime.getTime();
//     if(TSEndTime==currtime||(TSEndTime-10*1000)<currtime){
        document.getElementById("starttime").innerHTML =starttime;

}


function pageInit()
{
    if (type == "FF"){

        document.getElementById("fastinfo1").src="images/tvod/flip_bar_forward.png";
        document.getElementById("fastinfo2").innerText="2X";
        document.getElementById("showimg").src = "images/tvod/showsu.png";
//        top.jsDebug();
    } else if(type == "RR") {

        document.getElementById("fastinfo1").src="images/tvod/flip_bar_backward.png";
        document.getElementById("fastinfo2").innerText="2X";
        document.getElementById("showimg").src = "images/tvod/showsu.png";
    } else if(type == "pause") {

        document.getElementById("fastinfo1").src ="images/tvod/flip_bar_pause.png";
        document.getElementById("fastinfo2").innerText="";
        document.getElementById("showimg").src = "images/tvod/puse.png";

    }
    loadProgramInfo();
    //showProcess();
    //pageVODSpeedInitStartAndEnd();

}

function loadProgramInfo()
{
    var currtime = formatDate(top.TSTVCurrentTime);
    //ippv,将结束时间作为查节目数据的开始时间
    <%--if(isIppv ==1&&endTime!=""){--%>
        <%--var crruntProendtime = returnTime(endTime.substring(0,4),endTime.substring(5,7),endTime.substring(8,10),--%>
                <%--endTime.substring(11,13),endTime.substring(14,16),endTime.substring(17,19));--%>
        <%--/*if(top.TSTVCurrentTime.getTime()>crruntProendtime.getTime()){--%>
         <%--currtime = endTime;--%>
         <%--}*/--%>
        <%--currtime = endTime;--%>
        <%--top.jsDebug("=====top.TSTVCurrentTime=="+top.TSTVCurrentTime.getTime()+"=====crruntProendtime====="+crruntProendtime.getTime()+"===currtime===="+currtime);--%>
    <%--}--%>
    <%--var url = "action/channel_program_data.jsp?columncode=<%=columncode%>&channelcode=<%=channelcode%>&starttime="+currtime;--%>

    <%--new net.ContentLoader(url, function() {--%>
        <%--data = eval("(" + this.req.responseText + ")");--%>
        <%--if(data)--%>
        <%--{--%>
            <%--top.jsDebug("====goto ====1====");--%>
            <%--if(data.items[0]!=undefined)--%>
            <%--{--%>
                <%--begintimetemp =  data.items[0].begintime;--%>
                <%--endtimetemp =  data.items[0].endtime;--%>
                <%--//test--%>
                <%--//begintimetemp ="2013.11.25 11:00:00";--%>
                <%--//endtimetemp="2013.11.25 20:00:00";--%>
                <%--prevuename = data.items[0].prevuename;--%>
                <%--top.jsDebug("====goto ====2====");--%>
                <%--probegintime = returnTime(begintimetemp.substring(0,4),begintimetemp.substring(5,7),begintimetemp.substring(8,10),--%>
                        <%--begintimetemp.substring(11,13),begintimetemp.substring(14,16),begintimetemp.substring(17,19));--%>
                <%--proendtime = returnTime(endtimetemp.substring(0,4),endtimetemp.substring(5,7),endtimetemp.substring(8,10),--%>
                        <%--endtimetemp.substring(11,13),endtimetemp.substring(14,16),endtimetemp.substring(17,19));--%>

                <%--//test--%>

            <%--}--%>
            <%--else--%>
            <%--{--%>
                <%--probegintime = undefined;--%>
                <%--proendtime = undefined;--%>
            <%--}--%>
            <%--top.jsDebug("===probegintime=="+probegintime+"===proendtime==="+proendtime);--%>

            <%--//test--%>

            <%--/* probegintime = returnTime(begintimetemp.substring(0,4),begintimetemp.substring(5,7),begintimetemp.substring(8,10),--%>
             <%--begintimetemp.substring(11,13),begintimetemp.substring(14,16),begintimetemp.substring(17,19));--%>
             <%--proendtime = returnTime(endtimetemp.substring(0,4),endtimetemp.substring(5,7),endtimetemp.substring(8,10),--%>
             <%--endtimetemp.substring(11,13),endtimetemp.substring(14,16),endtimetemp.substring(17,19));*/--%>
            <%--pageVODSpeedInitStartAndEnd();--%>
        <%--}--%>

    <%--});--%>
    pageVODSpeedInitStartAndEnd();
}
function pageResume()
{
    if(top.isPlay() == true){
        top.pageResume();
        top.mainWin.document.location="portal.jsp?onlymenu=1";//onlymenu没用
        top.showOSD(2, 0, 0);
        return false;
    }
}
function goback()
{
    clearProcessBarTimer();
    clearMonitorTimer();
    clearCurrpronameTimer();
    top.pageResume();
    top.hideOSD();
    return false;
}
function pagePlayStop()
{
    top.remotePlayNext();
}
function pageDoStart(){
    if(begintimetemp ==""||begintimetemp==undefined){
        pagePlayPause();
    }else{
        var startHour = begintimetemp.substring(11,13);
        var startMin= begintimetemp.substring(14,16);
        var startSecond= begintimetemp.substring(17,20);
        pageDoVodSeek(startHour,startMin,startSecond);
    }

}
function pageDoVodSeek(hours,minutes,seconds)
{

    var hoursInt = fomateTimestrToInt(hours);
    var minutesInt =  fomateTimestrToInt(minutes);
    var secondsInt = fomateTimestrToInt(seconds);

    var inputTime =  hoursInt * 3600 + minutesInt * 60+secondsInt;
    top.jsDebug("====hoursInt==="+hoursInt+"===minutesInt==="+minutesInt+"===secondsInt==="+secondsInt+"===inputTime==="+inputTime);
    top.mp.playByTime(1, inputTime, 1);
}

function fomateTimestrToInt(timeStr){
    var hoursInt =0;
    if (timeStr.length == 2)
    {
        var tem = timeStr.substring(0, 1);
        if (tem == "0")
        {
            hoursInt = parseInt(timeStr.substring(1, 2));
        }
        else
        {
            hoursInt = parseInt(timeStr);
        }
    }
    else if (timeStr.length == 1)
    {
        hoursInt = parseInt(timeStr);
    }

    else if (timeStr.length == 0)
    {
        hoursInt = 0;
    }
    return hoursInt;
}

top.jsSetVideoKeyFunction("top.extrWin.pagePlayStop", <%=STBKeysNew.remoteStop%>);

document.onkeypress = dokeypress;
function dokeypress(evt)
{
    var keyCode = parseInt(evt.which);
    switch(keyCode)
    {
        case STBKeysNew.remoteStop:
            pagePlayStop();
            break;
        // 快进键监听及调用处理函数
        // 让四向键的向右键与快进键具有相同的快进功能
        case STBKeysNew.remoteFastForword:
        case STBKeysNew.onKeyRight:
            pageFastForword();
            break;
        // 快退键监听及调用处理函数
        // 让四向键的向左键与快退键具有相同的快退功能
        case STBKeysNew.remoteFastRewind:
        case STBKeysNew.onKeyLeft:
            pageFastRewind();
            break;
        case STBKeysNew.rmotePlayPause:
            pagePlayPause();
            break;
        case STBKeysNew.onKeyOK:
            pagePlayPause();
            break;
        case STBKeysNew.remoteBack:
            goback();
            break;
        default:
            top.doKeyPress(evt);
    }
    return false;
}
</script>
</body>
</html>