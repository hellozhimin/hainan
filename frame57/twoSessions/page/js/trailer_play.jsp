<%@ include file="../inc/utils.jsp" %>

<html>
<head>
    <title>vas small play</title>
</head>
<body bgcolor="transparent" onUnload="destoryMP()">
<script  type="text/javascript">
   
    var mediamp = new MediaPlayer();
	
	var mediaStr;
	
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

   

    function destoryMP()
    {
        mediamp.leaveChannel();
        mediamp.stop();
    }
    
	function initMediaStr(playUrl)
	{
		mediaStr = '[{mediaUrl:"'+ playUrl +'",';
		mediaStr += 'mediaCode: "1111",';
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
	
	function initMediaPlay_vod(_left,_top,_width,_height){
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
    	mediamp.setSingleMedia(mediaStr);
		mediamp.setAllowTrickmodeFlag(0);
		mediamp.setNativeUIFlag(0);
		mediamp.setAudioTrackUIFlag(0);
		mediamp.setMuteUIFlag(0); 
		mediamp.setAudioVolumeUIFlag(0);
		mediamp.setVideoDisplayArea(_left,_top,_width,_height);
		mediamp.setVideoDisplayMode(0);
		mediamp.refreshVideoDisplay();
	}
	
	function play(_left,_top,_width,_height,_playUrl){	
		initMediaStr(_playUrl);
		initMediaPlay_vod(_left,_top,_width,_height);
		mediamp.playFromStart();
	}
	
</script>
</body>
</html>
