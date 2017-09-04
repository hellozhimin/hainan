<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<epg:PageController name="sport.jsp"/>
<%
    String lastfocus = request.getParameter("lastfocus");
    if(lastfocus==null||"null".equals(lastfocus)){
	    lastfocus="0";
    }
%>
<html>
<head>
    <title>体育</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="page-view-size" content="1280*720">
    <style>
      	body {font-size: 24px; color: #FFFFFF; width: 1280px; height: 720px; background:url(images/vod/sport/sport_bg.png) no-repeat;}
        div {-webkit-transition-duration: 200ms;}
		.focus0 { position:absolute; width:284px; height:478px; background:url(images/vod/sport/sFocus.png) no-repeat; left: 63px; top: 94px; z-index:1;}
		.focus1 { position:absolute; width:284px; height:478px; background:url(images/vod/sport/sFocus.png) no-repeat; left: 360px; top: 94px; z-index:1;}
		.focus2 { position:absolute; width:284px; height:478px; background:url(images/vod/sport/sFocus.png) no-repeat; left: 658px; top: 94px; z-index:1;}
		.focus3 { position:absolute; width:321px; height:178px; background:url(images/vod/sport/hFocus.png) no-repeat; left: 934px; top: 94px; z-index:1;}
		.focus4 { position:absolute; width:321px; height:178px; background:url(images/vod/sport/hFocus.png) no-repeat; left: 934px; top: 245px; z-index:1;}
		.focus5 { position:absolute; width:321px; height:178px; background:url(images/vod/sport/hFocus.png) no-repeat; left: 934px; top: 394px; z-index:1;}
    </style>
</head>
<body onLoad="init()" onUnload="exitPage()" bgcolor="transparent">
<div style="position:absolute; top: 29px; left: 54px; width:143px; height:28px; font-size:32px;">体育专区</div>

<div id="focus" class=""></div>

<div id="posterDiv0" style="position:absolute; width:249px; height:443px; left: 80px; top: 112px;">
	<img src="images/vod/sport/poster_img_0.png"/>
	<div style="position:absolute; width:256px; height:160px; top:-26px; left:-38px; z-index:2;">
		<img src="images/vod/sport/poster_title_0.png" style="width:256px; height:160px;"/>	</div>
	<div style="position:absolute; width:249px; height:133px; left: 0px; top: 443px;"><img src="images/vod/sport/poster_img_0_dy.png"/></div>
</div>
<div id="posterDiv1" style="position:absolute; width:249px; height:443px; left: 377px; top: 112px;">
  <img src="images/vod/sport/poster_img_1.png"/>
  <div style="position:absolute; width:273px; height:75px; top:50px; left:-17px; z-index:2;">
		<img src="images/vod/sport/poster_title_1.png" style="width:268px; height:75px;"/>	</div>
<div style="position:absolute; width:249px; height:133px; left: 0px; top: 443px;"><img src="images/vod/sport/poster_img_1_dy.png"/></div>
</div>
<div id="posterDiv2" style="position:absolute; width:249px; height:443px; left: 675px; top: 112px;">
	<img src="images/vod/sport/poster_img_2.png"/>
  <div style="position:absolute; width:258px; height:117px; top:273px; left:-26px; z-index:2;">
		<img src="images/vod/sport/poster_title_2.png" style="width:258px; height:117px;"/>	</div>
	<div style="position:absolute; width:249px; height:133px; left: 0px; top: 443px;">
		<img src="images/vod/sport/poster_img_2_dy.png"/>
	  <div style="position:absolute; width:258px; height:75px; top:57px; left:-26px; z-index:2;">
			<img src="images/vod/sport/poster_title_2_dy.png" style="width:258px; height:75px;"/>	</div>
	</div>
</div>
<div id="posterDiv3" style="position:absolute; width:286px; height:143px; left: 951px; top: 112px;">
	<img src="images/vod/sport/poster_img_3.png"/>
</div>
<div id="posterDiv4" style="position:absolute; width:286px; height:143px; left: 951px; top: 262px;">
	<img src="images/vod/sport/poster_img_4.png"/>
</div>
<div id="posterDiv5" style="position:absolute; width:286px; height:143px; left: 951px; top: 412px;">
	<img src="images/vod/sport/poster_img_5.png"/>
	<div style="position:absolute; width:286px; height:133px; left: 0px; top: 141px;">
		<img src="images/vod/sport/poster_img_5_dy.png"/>
	</div>
</div>
<%@include file="inc/lastfocus.jsp" %>
</body>
<script>
var index = parseInt('<%=lastfocus %>',10);
var sportDataUrl = ['vod_portal.jsp?columncode=0B0A00','vod_portal.jsp?columncode=0B0A02',
					'vod_portal.jsp?columncode=0B0A05','vod_portal.jsp?columncode=0B0A03',
					'vod_portal.jsp?columncode=0B0A01','vod_portal.jsp?columncode=0B0A04'];

function init() {
   	setFocus();
}

function keyEnter() {
	document.location = sportDataUrl[index] + '&leefocus=' + index;
}
function keyDown() {
	freeFocus();
    if(index > 2 && index < 5) index++;
  	setFocus();
}
function keyLeft() {
	freeFocus();
    if(index > 2 && index <= 5) index = 2;
	else if(index > 0) index--;
  	setFocus();
}
function keyRight() {
	freeFocus();
    if(index == 2) index = 3;
	else if(index < 2) index++;
  	setFocus();
}
function keyUp() {
	freeFocus();
    if(index > 3) index--;
  	setFocus();
}
function setFocus() {
   $('focus').className = 'focus' + index;
   $('posterDiv' + index).style.webkitTransitionDuration = 300;
   $('posterDiv' + index).style.webkitTransform = 'scale(1.05)';
   $('focus').style.webkitTransform = 'scale(1.05)';
}
function freeFocus() {
   $('posterDiv' + index).style.webkitTransitionDuration = 300;
   $('posterDiv' + index).style.webkitTransform = 'scale(1)';
   $('focus').style.webkitTransform = 'scale(1)';
}
function $(id){
	return document.getElementById(id);
}
function keyBack() {
    document.location = "back.jsp";
}
function exitPage() {
}
function dokeyPress(evt) {
    //alert("---------");
    var keyCode = parseInt(evt.which);
    if (keyCode == 0x0008) {
        keyBack();
    } else if (keyCode == 0x0025) { //onKeyLeft
        keyLeft();
    } else if (keyCode == 0x0027) { //onKeyRight
        keyRight();

    } else if (keyCode == 0x0026) {//onKeyUp
        keyUp();
    } else if (keyCode == 0x0028) { //onKeyDown
        keyDown();
    } else if (keyCode == 0x000D) {  //OK
        keyEnter();
    } else if (keyCode == 1108) {
		window.location.href = 'portal_key.jsp?Action=1';
	} else if (keyCode == 1110) {
		window.location.href = 'portal_key.jsp?Action=2';
	} else if (keyCode == 1109) {
		window.location.href = 'portal_key.jsp?Action=3';
	} else if (keyCode == 1112) {
		window.location.href = 'portal_key.jsp?Action=4';
	} else {
        top.doKeyPress(evt);
        return true;
    }
    return false;
}
document.onkeydown = dokeyPress;
</script>
</html>