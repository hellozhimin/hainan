<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="com.zte.iptv.epg.util.STBKeysNew" %>
<% if (request.getParameter("lastfocus") != null) {%>
<script language="javascript" type="">
    if (document.links["<%=request.getParameter(EpgConstants.RETURNFOCUS)%>"] != null)
        document.links["<%=request.getParameter(EpgConstants.RETURNFOCUS)%>"].focus();
</script>
<%}%>


<div style="z-index: 199; font-size:80px;font-weight:bold;line-height:81px;left:1080px;top:40px; width:138px; height:81px; position:absolute;color:#00FF00"
     id="channelNumber" align="center">
</div>
<script language="javascript" type="">


    function showChannelNumber(channelNum)
    {
        if (channelNum != null && channelNum != undefined)
        {
            top.mainWin.document.all.channelNumber.innerHTML =  channelNum ;
        }
    }

    function clearChannelNumber()
    {
        top.mainWin.document.all.channelNumber.innerHTML = "";
    }
	top.jsEnableNumKey();

	function hideOsd()
	{
		top.hideOSD();
	}

	function playLastChannel_(){
		top.jsStopList();
		top.jsSetSingleOrPlaylistMode(0);	 
		play_();
	}

   function play_()
	{
		top.jsHideOSD();
		top.setDefaulchannelNo();
		var lastChannelNum = top.channelInfo.lastChannel;
		if (lastChannelNum == null || !(lastChannelNum || lastChannelNum === 0) || undefined == lastChannelNum || lastChannelNum < 0)
		{
			top.vodBackTimer = top.setTimeout("top.switchToStopOSDUrl(0)",1000);
		}else if(top.channelInfoArr[lastChannelNum] != undefined && top.channelInfoArr[lastChannelNum] != null){
			if(top.channelInfoArr[lastChannelNum].channelType == 3){
				top.vodBackTimer = top.setTimeout("top.switchToStopOSDUrl(0)",1000);
			}else{
                top.jsSetControl("isPlayChannelBeforeAD", 1);
				top.jsRedirectChannel(lastChannelNum);
			}
		}else{
            top.jsSetControl("isPlayChannelBeforeAD", 1);
			top.jsRedirectChannel(lastChannelNum);
		}
	}

    function do_nothing() {
        return false;
    }
    function remoteChannelMinus() {
        top.remoteChannelMinus();
    }
    function remoteChannelPlus() {
        top.remoteChannelPlus();
    }
//    int onKeyRed = 275;
//    int onKeyGreen = 276;
//    int onKeyYellow = 277;
//    int onKeyBlue = 278;
     function gored(){
         document.location="channel_play.jsp?mixno=9&columncode=0700&framechannel=0";
     }
    function gogreen(){
        document.location="channel_tvod_list.jsp";
    }

    function goyellow(){
        document.location="vod_portal.jsp?columncode=2508";
    }
    function goblue(){
//        document.location="channel_tvod_list.jsp";
    }
    top.jsSetupKeyFunction("top.mainWin.remoteChannelMinus", <%=STBKeysNew.remoteChannelMinus%>);
    top.jsSetupKeyFunction("top.mainWin.remoteChannelPlus", <%=STBKeysNew.remoteChannelPlus%>);
    top.jsSetupKeyFunction("top.mainWin.gored", <%=STBKeysNew.onKeyRed%>);
    top.jsSetupKeyFunction("top.mainWin.gogreen", <%=STBKeysNew.onKeyGreen%>);
    top.jsSetupKeyFunction("top.mainWin.goyellow", <%=STBKeysNew.onKeyYellow%>);
    top.jsSetupKeyFunction("top.mainWin.goblue", <%=STBKeysNew.onKeyBlue%>);
	if(iPanel){
    	iPanel.focusWidth = "4";
	}
    //Navigation.disableHighlight();
</script>
