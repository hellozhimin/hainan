<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--<%@include file="inc/words.jsp"%>--%>
<%

    String bp=request.getParameter("bp");
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
<html>
<head>
    <meta name="page-view-size" content="1280*720">
    <style type="text/css">

    </style>
</head>
<%--<body bgcolor="transparent" onload="pageInit()" style="background: url(images/channel/playbg.png);">--%>
<body bgcolor="transparent">
<div style="position: absolute;left: 343px;top:170px;width: 594px;height: 379px;">
    <img src="images/tvod/dialog_bg.png">
    <div  style="left:0; top:100;width:594;height:100px; position:absolute;font-size: 38px;color: #fff;" align="center">
        是否从上次记录播放？
    </div>
    <%--<div style="position: absolute;top:328px;left: 391px;" id="focusimg">--%>
    <%--<img src="images/channel/btufoucs.png">--%>
    <%--</div>--%>
    <div style="position: absolute;top:250px;left: 116px;width: 151px;height: 64px;">
        <img src="images/channel/15.png" width="151" height="64" id="focusimg0">
    </div>
    <div style="position: absolute;top:250px;left: 327px;width: 151px;height: 64px;">
        <img src="images/channel/14.png" width="151" height="64" id="focusimg1">
    </div>
    <div style="position: absolute;top:250px;left: 116px;width: 151px;height: 64px;line-height: 64px;color: #fff;font-size: 30px;" align="center">
             是
    </div>
    <div style="position: absolute;top:250px;left: 327px;width: 151px;height: 64px;line-height: 64px;color: #fff;font-size: 30px;" align="center">
        从头播放
    </div>
</div>
<script language="javascript">
    var index=0;

    function donothing() {
        return false;
    }
    function pageBack(){
//        setTimeout(function(){top.jsHideOSD();},500);
        document.location="speed_osd.jsp?<%=request.getQueryString()%>&time="+new Date() ;
    }
    function dook(){
//        document.location="back.jsp";
        if(index==0){
//            top.doStop();
//            document.location="back.jsp";
            top.jsDoSeekTargetTime(1, "<%=bp%>");
              document.location="speed_osd.jsp?<%=request.getQueryString()%>&time="+new Date() ;
        }else if(index==1){
//            pageBack();
            document.location="speed_osd.jsp?<%=request.getQueryString()%>&time="+new Date() ;
        }
    }
    function doLeft(){
        if(index>0){
            document.getElementById("focusimg"+index).src="images/channel/14.png";
            index--;
            document.getElementById("focusimg"+index).src="images/channel/15.png";
        }

    }
    function doRight(){
        if(index<1){
            document.getElementById("focusimg"+index).src="images/channel/14.png";
            index++;
            document.getElementById("focusimg"+index).src="images/channel/15.png";
        }

    }
    function doMenu(){
        // top.mainWin.document.location = "portal.jsp";
         top.doStop();
         top.mainWin.document.location =  '<%=page_url%>' ;
    }
    function dokeypress(evt){
        var keyCode = parseInt(evt.which);
        if (keyCode == 0x0008) {
            pageBack();
        } else if (keyCode == 0x0025) { //onKeyLeft
            doLeft();

        } else if (keyCode == 0x0027) { //onKeyRight
            doRight();

        } else if (keyCode == 0x0026) {//onKeyUp
            //doUP();
        } else if (keyCode == 0x0028) { //onKeyDown
            //doDown();

        } else if (keyCode == 0x000D) {  //OK
            dook();
        } else {
            top.doKeyPress(evt);
            return true;
        }
        return false;
    }
    <%--top.jsSetupKeyFunction("top.mainWin.dook", <%=STBKeysNew.onKeyOK%>);--%>
    <%--top.jsSetupKeyFunction("top.mainWin.pageBack", <%=STBKeysNew.remoteBack%>);--%>
    top.jsSetupKeyFunction("top.mainWin.doMenu", <%=STBKeysNew.remoteMenu%>);
    document.onkeydown = dokeypress;
    window.focus();
    var showtime=setTimeout("pageBack();",10000);
</script>
</body>
<%@include file="inc/lastfocus.jsp" %>
</html>
