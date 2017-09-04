<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="inc/utils.jsp" %>
<%--<%@ page import="java.net.*" %>--%>
<%
    String leftStr = request.getParameter("left");
    String topStr = request.getParameter("top");
    String widthStr = request.getParameter("width");
    String heightStr = request.getParameter("height");
    String playurl = request.getParameter("playurl");
    playurl=java.net.URLDecoder.decode(playurl,"utf-8");
//    String mediacode = request.getParameter("mediacode");
//    String mixno = "";
//    String channelno = getConfigurationByName(request, "channelno", null, "UTF-8");
//    System.out.println("===========huwenxi=============="+playurl);
%>
<html>
<head>
    <title>vas small play</title>
</head>
<body bgcolor="transparent" onunload="destoryMP()">
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
    //    currentChannel=8;
    var mediamp = new MediaPlayer();
    var  mediaStr="" ;
//    var playUrl="rtsp://10.47.215.107:1556/vod/00000050280001105407.mpg?userid=m3&stbip=10.47.224.112&clienttype=1&mediaid=0000000030010000012887&ifcharge=1&time=20151125062607+00&life=172800&usersessionid=29&vcdnid=001&boid=001&srcboid=001&columnid=0J000102&backupagent=10.47.215.107:1556&ctype=1&playtype=0&Drm=0&EpgId=epg_nj_003&programid=00000050280001105407&contname=&fathercont=&bp=0&authid=&tscnt=0&tstm=0&tsflow=0&ifpricereqsnd=1&stbid=CA1003990070308000004C16F139F7BA&nodelevel=3&terminalflag=1&bitrate=0&usercharge=C88FBB6FC46332930854C847246B58CB&breakpoint=0&bp=0";
      var playUrl="<%=playurl%>";
//    alert("========playUrl======="+playUrl);
    //    function initMediaPlay(){
    //        var instanceId = mediamp.getNativePlayerInstanceID();
    //        var playListFlag = 0;
    //        var videoDisplayMode = 1;
    //        var height = 0;
    //        var width = 0;
    //        var left = 0;
    //        var top = 0;
    //        var muteFlag = 0;
    //        var subtitleFlag = 0;
    //        var videoAlpha = 0;
    //        var cycleFlag = 0;
    //        var randomFlag = 0;
    //        var autoDelFlag = 0;
    //        var useNativeUIFlag = 1;
    //        mediamp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
    //    }
    function initMediaStr(playUrl,playTime)
    {
        mediaStr = '[{mediaUrl:"'+ playUrl +'",';
        mediaStr += 'mediaCode: "jsoncode1",';
        mediaStr += 'mediaType:2,';
        mediaStr += 'audioType:1,';
        mediaStr += 'videoType:1,';
        mediaStr += 'streamType:1,';
        mediaStr += 'drmType:1,';
        mediaStr += 'fingerPrint:0,';
        mediaStr += 'copyProtection:1,';
        mediaStr += 'allowTrickmode:1,';
        mediaStr += 'startTime:0,';
        mediaStr += 'endTime:20000,';
        mediaStr += 'entryID:"jsonentry1"}]';
    }
    function initMediaPlay(l,t,w,h)
    {
        var instanceId = mediamp.getNativePlayerInstanceID();
        var playListFlag = 0;
        var videoDisplayMode = 1,useNativeUIFlag = 1;
        var height = h,width = w,left = l,top = t;
        var muteFlag = 0;
        var subtitleFlag = 0;
        var videoAlpha = 0;
        var cycleFlag = 0;
        var randomFlag = 0;
        var autoDelFlag = 0;
        mediamp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
        mediamp.setSingleMedia(mediaStr);
        mediamp.setAllowTrickmodeFlag(0);
        mediamp.setNativeUIFlag(0);
        mediamp.setAudioTrackUIFlag(1);
        mediamp.setMuteUIFlag(1);
        mediamp.setAudioVolumeUIFlag(1);
        mediamp.setVideoDisplayArea(left,top,width,height);
        mediamp.setVideoDisplayMode(0);
        mediamp.setCycleFlag(1);
        mediamp.refreshVideoDisplay();
    }
    function play(){

        <%--mediamp.setVideoDisplayArea(<%=leftStr%>,<%=topStr%>,<%=widthStr%>,<%=heightStr%>);--%>
        <%--mediamp.setVideoDisplayMode(0);--%>
//        mediamp.refreshVideoDisplay();

//        initMediaPlay(left,top,width,height);
//        mediamp.joinChannel(currentChannel);
        mediamp.playFromStart();
//        mediamp.playByTime(1,3770,1);
    }

    function init_trailer() {
        initMediaStr(playUrl);
        initMediaPlay(<%=leftStr%>,<%=topStr%>,<%=widthStr%>,<%=heightStr%>);
//        mediamp.setAllowTrickmodeFlag(0);
//        mediamp.setNativeUIFlag(0);
//        mediamp.setMuteUIFlag(0);
        play();
    }

    function destoryMP()
    {
        mediamp.leaveChannel();
        mediamp.stop();
    }
    init_trailer();
</script>
</body>
</html>
