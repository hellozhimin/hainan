<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.zte.iptv.epg.util.STBKeysNew" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.epg.util.PortalUtils" %>
<%@ page import="java.util.HashMap" %>
<%!
    public String getFrameCode(String uri)
    {
        String result = "";
        int begin = uri.indexOf("frame");
        int end = uri.lastIndexOf("/");
        if (begin > 0) {
            result = uri.substring(begin, end);
        }
        return result;
    }
%>
<%--<epg:PageController name="refreshOSD.jsp"/>--%>
<html>
<head>
    <meta name="page-view-size" content="1280*720">
</head>
<body bgcolor="transparent" onload="pageInit()">

<div style="z-index: 199; font-size:80px;font-weight:bold;line-height:81px;left:1080px;top:40px; width:138px; height:81px; position:absolute;color:#00FF00;"
     id="channelNumber" align="center">

</div>
    <div style="left:220px; top:591;width:45;height:37; position:absolute;visibility: visible;" id="showvolume">
        <img src="images/volume/mute.png">
    </div>
<%
    String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
    HashMap param = PortalUtils.getParams(path, "UTF-8");
    String columncode = String.valueOf(param.get("column0"));
    String mixno=request.getParameter("channelNumber");
    String frameid = getFrameCode(request.getRequestURI());
%>

<script language="javascript">
    if (top.OSDInfo.state != 0) {
        top.OSDInfo.state = 0;
    }
    var FONTHEAD = "<font color='00FF00'>";
    var FONTTAIL = "</font>";
    var ch = "<%=request.getParameter("channelNumber")%>";
    top.jsDebug("============================channelNumber:"+ch);
    var muteState = top.doGetMuteState();
//    alert("======muteState========="+muteState);
    if(muteState==1){
        document.getElementById("showvolume").style.visibility="visible";
    } else{
       document.getElementById("showvolume").style.visibility="hidden";
    }
    function showChannelNumber(channelNum)
    {
        var temChannelNum = parseInt(channelNum);
        if (channelNum != "null" && channelNum != undefined) {
            top.mainWin.document.all.channelNumber.style.visibility = "visible";
            top.mainWin.document.all.channelNumber.innerHTML = FONTHEAD + channelNum + FONTTAIL;
        }
    }
    showChannelNumber(ch);

    function clearChannelNumber()
    {
        top.jsDebug(" clearChannelNumber ");
        top.mainWin.document.all.channelNumber.innerHTML = "";
        top.mainWin.document.all.channelNumber.style.visibility = "hidden";
    }

    function pageInit()
    {
        top.enablekey();
    }

    function checkOrderChannel(curChannel, orderChannelList) {
        if (curChannel || curChannel == 0) {
            for (var i = 0; i < orderChannelList.length; i++) {
                if (curChannel == orderChannelList[i]) {
                    return true;
                }
            }
        }
        return false;
    }

    function onKeyOK() {
        var curMixnoinnerHTML = top.mainWin.document.getElementById("channelNumber").innerHTML;
        var curChannel_last = top.channelInfo.currentChannel;
        var curMixnoinner = parseInt(curMixnoinnerHTML);
        if (!isNaN(curMixnoinner) && curMixnoinner != curChannel_last) {//立即播放
            top.jsDebug("SSSSSSSSSSSSSSSSSSSSSSStop.showChannelId=" + top.showChannelId);
            if (top.showChannelId != null) {
                top.clearTimeout(top.showChannelId);
                var intChannel = parseInt(top.temChannel, 10);
                top.jsDebug("SSSSSSSSSSSSSSSSSSSSSSS1111111intChannel=" + intChannel);
                top.jsRedirectChannel(intChannel);
            }
            return;
        } else if (curMixnoinner == curChannel_last) {//相同频道EPG会刷新下
            top.clearTimeout(top.showChannelId);
            top.temChannel = "";
        }
        //        }
        var channelid= top.jsGetChannelCode(mixno);
        top.jsDebug("---------------------columncode:<%=columncode%>---------mixno:<%=mixno%>------channelid:"+channelid);
        top.mainWin.document.location = "channel_play_option.jsp?columnid=<%=columncode%>&mixno="+curChannel_last+"&channelid="+channelid;
        top.showOSD(2, 0, 0);
    }
    function remoteChannelMinus() {
        top.remoteChannelMinus();
    }

    function remoteChannelPlus() {
        top.remoteChannelPlus();
    }

    function remoteBack() {
        var lastChannelNum = top.channelInfo.lastChannel;
        if (lastChannelNum == null || !(lastChannelNum || lastChannelNum === 0) || undefined == lastChannelNum || lastChannelNum < 0) {
        } else {
            top.jsHideOSD();
            top.jsRedirectChannel(lastChannelNum);
        }
    }

       function dokeypress(evt){
           var keyCode = parseInt(evt.which ? evt.which : evt.keyCode);
           if (keyCode >= 48&&keyCode <=57) {
                clearTimeout(timeer);
               top.doKeyPress(evt);
           }  else {
               top.doKeyPress(evt);
           }
           timeer=setTimeout("clearChannelNumber()",5000);
       }
    timeer=setTimeout("clearChannelNumber()",5000);
    document.onkeypress = dokeypress;
    focus();
</script>
</body>

</html>

