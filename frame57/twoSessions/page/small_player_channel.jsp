<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="inc/utils.jsp" %>
<%
    String leftStr = request.getParameter("left");
    String topStr = request.getParameter("top");
    String widthStr = request.getParameter("width");
    String heightStr = request.getParameter("height");
    String channelno = request.getParameter("mixno");
//    String mediacode = request.getParameter("mediacode");
//    String mixno = "";
//    String channelno = getConfigurationByName(request, "channelno", null, "UTF-8");
//    System.out.println("===========huwenxi=============="+channelno);
%>
<html>
<head>
    <title>vas small play</title>
</head>
<body bgcolor="transparent" onUnload="destoryMP()">
<script  type="text/javascript">
    //    alert("=========11111===========");
    <%--top.mp.leaveChannel();--%>
    <%--top.mp.setVideoDisplayArea(<%=0%>, <%=0%>, <%=370%>, <%=222%>);--%>
    <%--top.mp.setVideoDisplayMode(0);--%>
    <%--top.mp.refreshVideoDisplay();--%>
    <%--top.mp.setNativeUIFlag(1);--%>
    <%--//    top.smallVodPlayFlag = true;--%>
    <%--top.mp.joinChannel("<%=5%>");--%>
    <%--var currentChannel = top.channelInfo.currentChannel;--%>
    <%--if (currentChannel == -1) {--%>
        <%--currentChannel = <%=channelno%>;--%>
    <%--}--%>
      var currentChannel ="<%=channelno%>";
    //    currentChannel=8;
    var mediamp = new MediaPlayer();
    function initMediaPlay(){
        var instanceId = mediamp.getNativePlayerInstanceID();
        var playListFlag = 0;
        var videoDisplayMode = 1;
        var height = 0;
        var width = 0;
        var left = 0;
        var top = 0;
        var muteFlag = 0;
        var subtitleFlag = 0;
        var videoAlpha = 0;
        var cycleFlag = 0;
        var randomFlag = 0;
        var autoDelFlag = 0;
        var useNativeUIFlag = 1;
        mediamp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
    }

    function play(){
        mediamp.setVideoDisplayArea(<%=leftStr%>,<%=topStr%>,<%=widthStr%>,<%=heightStr%>);
        mediamp.setVideoDisplayMode(0);
        mediamp.refreshVideoDisplay();
        mediamp.joinChannel(currentChannel);
    }

    function init_trailer() {
        initMediaPlay();
        mediamp.setAllowTrickmodeFlag(0);
        mediamp.setNativeUIFlag(0);
        mediamp.setMuteUIFlag(0);
        play();
    }

    function destoryMP()
    {
        mediamp.leaveChannel();
        mediamp.stop();
    }
    init_trailer();
   // alert("=======00========");

</script>
</body>
</html>
