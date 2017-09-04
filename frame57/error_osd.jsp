<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<epg:PageController name="back.jsp"/>
<%--<%@include file="inc/words.jsp"%>--%>
<html>
<head>
    <style type="text/css">
        /*.detail_alert {*/
            /*background: url(images/bg_popup_regular.png);*/
            /*position: absolute;*/
            /*font-size: 24px;*/
            /*left: 767px;*/
            /*top: 80px;*/
            /*width: 510px;*/
            /*height: 279px;*/
            /*color: #FFF;*/
            /*font-weight: bold;*/
        /*}*/
    </style>
</head>
<body bgcolor="transparent" onload="pageInit()" style="background: url(images/channel/allbg.png);">
<div style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px;">
    <%--<div id="errorDiv"  style="left:30; top:81;width:453;height:100px; position:absolute;font-size: 24px;">--%>
    <%--</div>--%>
    <div id="errorDiv" style="left:0; top:236;width:1280;height:100px; position:absolute;font-size: 35px;color: #fff;" align="center">

    </div>
        <div style="position: absolute;top:328px;left: 564px;width: 151px;height: 64px;">
            <img src="images/channel/15.png" width="151" height="64" id="focusimg0">
        </div>
    <div id="backDiv"  style="left:564; top:328px;width:151;height:64px; position:absolute;font-size: 30px;color:#fff;line-height: 64px;" align="center">
    </div>
</div>
<script language="javascript">
    if (top.vodBackTimer){
        top.clearTimeout(top.vodBackTimer);
    }
    if(top.extrWin.showinfotime){
        top.extrWin.clearTimeout(top.extrWin.showinfotime);
    }
    if(top.extrWin.pauseTime){
        top.extrWin.clearTimeout(top.extrWin.pauseTime);
    }
    function pageInit(){
        top.mainWin.document.all.errorDiv.innerHTML =top.errorMsg.errorMessage + "(" + top.errorMsg.errorCode + ")";
        top.mainWin.document.all.backDiv.innerHTML="确定";
    }
    function donothing() {                                       
        return false;
    }
    function pageBack(){
        top.jsHideOSD();
        top.vodBackTimer = top.setTimeout("top.switchToStopOSDUrl(0)", 500);
        var lastChannelNum = top.getPrevChannel();
        if ("1604" == top.errorMsg.errorCode){
            lastChannelNum = top.channelInfo.currentChannel;
        }
        top.doStop();
    }

    function doMenu(){
        top.mainWin.document.location = "portal.jsp";
    }
    top.jsSetupKeyFunction("top.mainWin.pageBack", <%=STBKeysNew.onKeyOK%>);
    top.jsSetupKeyFunction("top.mainWin.pageBack", <%=STBKeysNew.remoteBack%>);
    top.jsSetupKeyFunction("top.mainWin.doMenu", <%=STBKeysNew.remoteMenu%>);
    document.onkeypress = top.doKeyPress;
    focus();
</script>
</body>
<%@include file="inc/lastfocus.jsp" %>
</html>
