;(function(){
	/* 探针实例化 */
	function probe(){
		
		//国双提供
		var pid = "210100";
		//服务器地址
		var configUrl = "http://172.24.18.40/210100.json";
		var configBakUrl = "";
		//获取用户id
		var device_carNum = "<%=userId1111%>"||getCookie('userId',"<%=userId1111%>");
		//获取mac;
		var device_mac = "<%=userInfo1111.getStbMac()%>"||getCookie('device_mac');
		//获取stbtype
		var device_stbTybe = Authentication.CTCGetConfig("STBType")||getCookie('stbType');
		//实例化探针参数对象
		var deviceInfo = new DeviceInfo();
		deviceInfo.caCardNum = device_carNum;
		deviceInfo.mac = device_mac;
		deviceInfo.stbId = device_stbTybe;
		deviceInfo.zoneNum = "0898";
		deviceInfo.stbType = "高清1280";
		var toastLogger = new ToastLogger(false);
		// 实例化对象
		var gs_tracker = CNTVTracker.getInstance(pid, deviceInfo, configUrl, configBakUrl,'',toastLogger);
		return gs_tracker;
	}
	/* epgEnter事件参数epgInfo
	*  channels 栏目层级(选传)
	*  ispl 是否为播放 1为播放，0为未播放
	*  当前页面的栏目*/
	function epgInfo(channel,ispl,subChannel){
		// 读取栏目层级
		var channels = channel||Util.getCookie('channel_name');
		if(arguments.length>2){
			channels += "/" + subChannel;
		}
		var epgInfo = new EpgInfo();
		epgInfo.title = document.title;
		epgInfo.pageUrl = window.location.href;
		epgInfo.channels = channels;
		setCookie('channel_name',channels);
		return epgInfo;
	}
	/* epgEnter事件参数buttonInfo*/
	function buttonInfo(clickPageNum,clickPositionNum){
		var clickPageNum = clickPageNum || 0;
		var clickPositionNum = clickPositionNum || 0;
		var buttonInfo = new ButtonInfo();
		buttonInfo.clickPageNum = clickPageNum;
		buttonInfo.clickPositionNum = clickPositionNum;
		return buttonInfo;
	}

	//保存cookie
	function setCookie(name,value){
	    var days = 7; //cookie默认保存七天
	    var expires = new Date(); //建立日期变量
	    expires.setTime(expires.getTime() + days * 30 * 24 * 60 * 60 * 1000);
	    var str = name + "=" + value + ";expires=" + expires.toGMTString() + ";path=/";
	    document.cookie = str;
	}
	//获取cookie
	function getCookie(name){
		var arr = null;
		if(document.cookie!=null && document.cookie.length>0)
		    arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
		if (arr != null)
		    return unescape(arr[2]);
		return null;
	}
	//删除cookie
	function deleteCookie(name){
	    var date = new Date();
	    date.setTime(date.getTime()-10000);
	    document.cookie = name+"=v; expire=" + date.toGMTString() + ";path=/";
	}
	var gs_tracker = probe();
	window.gs_tracker = gs_tracker;
	window.epgInfo = epgInfo;
	window.buttonInfo = buttonInfo;
})()
