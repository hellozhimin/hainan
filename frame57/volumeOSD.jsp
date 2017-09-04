<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.zte.iptv.epg.util.*" %>
<%--<%@ include file="inc/words.jsp" %>--%>
<html>
<head>
    <title>portal</title>
<meta name="page-view-size" content="1280*720"/>
<meta http-equiv="content-Type" content="text/html; charset=utf-8">
</head>
<body bgcolor = "transparent" onload = "pageInit()" style="overflow: hidden;">
<div style="left:0px; top:0px;width:1280px;height:720px; position:absolute;visibility: visible;" id="bigdig">
    <div style="left:1170px; top:215px;width:720px;height:120px; position:absolute" id="volumeBack">
        <img src="images/volume/volume-bg.png" width="69" height="259"/>
    </div>

    <div style="left:1187px; top:42;width:46;height:50; position:absolute;visibility: hidden;" id="showvolumeimg">
        <img src="images/volume/mute.png">
    </div>

    <div style="left:380px; top:547px;width:100px;height:120px; position:absolute;font-size: 24px;color: #fff;line-height: 120px">
        <%--<%=W_VOLUME%>--%>
    </div>

    <div style="left:1197px; top:276;width:16;height:160; position:absolute;background-color:#393E49;">

    </div>
    <div style="left:1197px; top:436;width:16;height:0; position:absolute;background-color:#48AAFD;visibility: hidden;" id="volumediv">

    </div>
    <div style="left:1170px; top:225;width:69;height:40; position:absolute;color: #fff;font-weight: bold;font-size: 38px;" align="center">
          +
    </div>
    <div style="left:1172px; top:435;width:69;height:40; position:absolute;color: #fff;font-weight: bold;font-size: 38px;" align="center">
        -
    </div>
    <%--<div style="left:900px; top:550px;width:100px;height:120px; position:absolute;font-size: 24px;color: #fff;line-height: 120px" id="showvolume">--%>
        <%----%>
    <%--</div>--%>
</div>

<%--<div style="left:320px; top:491;width:45;height:37; position:absolute;visibility: hidden;" id="jingyin">--%>
    <%--<img src="images/volume/vodVolume_Start.png">--%>
<%--</div>--%>
<%--<div style="left:320px; top:591;width:45;height:37; position:absolute;visibility: hidden;" id="showvolumeimg">--%>
    <%--<img src="images/volume/vodVolume_Stop.png">--%>
    <%--&lt;%&ndash;<img src="images/volume/volume-bg.png" width="720" height="120" src="" />&ndash;%&gt;--%>
<%--</div>--%>
</body>	
<script language="javascript">    
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
   
var volumeDivs = new Array();
var volume = 0;
var volumeBarCount = 0;
var timeer=null;
function pageDisableWithTimer()
{
	  top.jsClearKeyFunction();
		top.jsHideOSD();
}

function pageVolumeOnKeyPressed()
{
	  pageDisableWithTimer();
}
function vitur()
{
	top.virtualEvent();
}
   
   
function pageVolumePlus()
{
   pageRight();
}

function pageVolumeMinus()
{
   pageLeft();
}

function pageLeft()
{
     top.resetOSDInfoTimer();
   	 if(volume>0){
            document.getElementById("showvolumeimg").style.visibility="hidden";
   	 	 volume = volume - 5;
   	 	 volumeBarCount = parseInt(volume/5);
   	 	 top.mp.setVolume(volume);
            top.jsDebug(volumeBarCount*21+"==========volumeBarCount=========="+volumeBarCount);
//            document.getElementById("volumeimg").style.width=volumeBarCount*20+"px";
            document.getElementById("volumediv").style.height=volumeBarCount*8+"px";
            document.getElementById("volumediv").style.top=436-volumeBarCount*8+"px";
//            document.getElementById("showvolume").innerText=volumeBarCount;
//   	 	 volumeDivs[volumeBarCount].style.visibility = 'hidden';
//   	 	 volumeDivs[20].innerHTML = top.FONTHEAD + volumeBarCount + top.FONTTAIL;
   	 }
   	 var vol = parseInt(top.mp.getVolume());
   	 if(vol == 0)
   	 {
            document.getElementById("volumediv").style.visibility="hidden";
//            document.getElementById("showvolume").innerText=0;
//		   top.doSetMuteState(1);
//		   top.jsHideOSD();
//		   top.showMuteOSD();
   	 }
}
   
function pageRight()
{
    top.resetOSDInfoTimer();
   	 if(volume<100)
   	 {
            document.getElementById("showvolumeimg").style.visibility="hidden";
            document.getElementById("volumediv").style.visibility="visible";
   	 	 volume = volume + 5;
   	 	 volumeBarCount = parseInt(volume/5);
   	 	 top.mp.setVolume(volume);
		   var tem = volumeBarCount ;
            top.jsDebug(tem*8+"==========tem=========="+tem);
//            document.getElementById("volumediv").style.width=tem*8+"px";
            document.getElementById("volumediv").style.height=tem*8+"px";
            document.getElementById("volumediv").style.top=436-tem*8+"px";
//            document.getElementById("showvolume").innerText=volumeBarCount;
//		   volumeDivs[tem].style.visibility = 'visible';
//		   volumeDivs[20].innerHTML = top.FONTHEAD + volumeBarCount + top.FONTTAIL;
   	 }
   	 var vol = parseInt(top.mp.getVolume());
   	 if(vol == 0)
   	 {
         document.getElementById("volumediv").style.visibility="hidden";
//            document.getElementById("showvolume").innerText=0;
//		   top.doSetMuteState(1);
//		   top.jsHideOSD();
//		   top.showMuteOSD();
   	 }
}

function pageMute()
{
//	top.jsHideOSD();
	var muteState = top.doGetMuteState();
	var vol = parseInt(top.mp.getVolume());
	if(muteState == 0)
	{
		   top.doSetMuteState(1);		
//		   top.showMuteOSD();
        document.getElementById("showvolumeimg").style.visibility="visible";
	}  else{
        top.doSetMuteState(0);
        document.getElementById("showvolumeimg").style.visibility="hidden";
    }
//	else if(vol != 0)
//	{
//		   top.doSetMuteState(0);
////		   top.showVolumeOSD();
//  }
//    top.jsHideOSD();
}
function  doBack(){
    top.jsHideOSD();
}
function dokeyPress(evt) {
    clearTimeout(timeer);
    var keyCode = parseInt(evt.which ? evt.which : evt.keyCode);
    if (keyCode == <%=STBKeysNew.remoteBack%>) {
        doBack();
    } else if (keyCode == <%=STBKeysNew.remoteMenu%>) {
       document.location = '<%=page_url%>' ; 
        // Authentication.CTCSetConfig("KeyValue", "0x110");
        // doBack();
    } else if (keyCode == <%=STBKeysNew.remoteVolumePlus%>) {
        pageRight();
    } else if (keyCode == <%=STBKeysNew.remoteVolumeMinus%>) {
        pageLeft();
    } else if (keyCode == <%=STBKeysNew.onKeyDown%>) {
        pageLeft();
    } else if (keyCode == <%=STBKeysNew.onKeyUp%>) {
        pageRight();
    } else if (keyCode == <%=STBKeysNew.remoteVolumeMute%>) {
        pageMute();
    } else {
        top.doKeyPress(evt);
    }
    timeer=setTimeout("doBack()",3000);
}
function pageInit(){

    volume = top.mp.getVolume();
    var muteState = top.doGetMuteState();
    top.jsDebug("=======volume======="+volume);
    top.jsDebug("=======muteState======="+muteState);
    if(muteState==0 && "<%=request.getParameter("type")%>"=="mute"){
        pageMute();
    }  else{
        top.jsDebug("=========111111111111====muteState======");
        top.doSetMuteState(0);

    }
    if(volume>0){
        document.getElementById("volumediv").style.visibility="visible";
        volumeBarCount = parseInt(volume/5);
//        top.mp.setVolume(volume);
        var tem = volumeBarCount ;
        top.jsDebug(tem*21+"==========tem=========="+tem);
        document.getElementById("volumediv").style.height=tem*8+"px";
        document.getElementById("volumediv").style.top=436-tem*8+"px";
    }
//    document.getElementById("showvolume").innerText= parseInt(volume/5);
    timeer=setTimeout("doBack()",3000);
    document.onkeydown = dokeyPress;

}
focus();
</script>
<%@include file="inc/lastfocus.jsp" %>
</html>
