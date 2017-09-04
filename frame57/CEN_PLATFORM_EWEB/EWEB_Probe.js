/**
 * Created by zhimin on 2017/9/4.
 * probe for IPTV
 * 使用时需要先引入国双提供的探针js文件
 */
/* 定义全局对象EWEB
*  */
var EWEB = {
    // 版本
    version:'1.0',
    // 是否进行探针数据采集,true进行探针数据采集，false不进行探针数据采集
    isProbe: true,
    // 数据采集id,由国双提供
    pid : "210100",
    // 数据采集服务器地址
    configUrl : "http://172.24.18.38/210100.json",
    // 数据采集备用服务器地址
    configBakUr: "",
    //用户id
    device_carNum : "<%=userId1111%>"||"",
    //mac;
    device_mac  : "<%=userInfo1111.getStbMac()%>"||"",
    //stbtype
    device_stbTybe : Authentication.CTCGetConfig("STBType")||""
};
/* 定义自执行函数
*  把全局对象EWEB传入*/
(function(EWEB){
    //数据采集开关
    var _isProbe = EWEB.isProbe;
    if(!_isProbe){
        return;
    }
    /*探针内部需要的参数 */
    var _pid = EWEB.pid;
    var _configUrl = EWEB.configUrl;
    var _configBakUrl = EWEB.configBakUr;
    var _deviceCarNum = "";
    var _deviceMac = "";
    var _deviceStbTybe = "";
    if(EWEB.device_carNum){
        _deviceCarNum = EWEB.device_carNum;
        setCookie('deviceCarNum',_deviceCarNum);
    }else{
        _deviceCarNum = getCookie('deviceCarNum');
    }
    if(EWEB.device_mac){
        _deviceMac = EWEB.device_mac;
        setCookie('deviceMac',_deviceMac);
    }else{
        _deviceMac = getCookie('deviceMac');
    }
    if(EWEB.device_stbTybe){
        _deviceStbTybe = EWEB.device_stbTybe;
        setCookie('deviceStbType',_deviceStbTybe);
    }else{
        _deviceStbTybe = getCookie('deviceStbType');
    }
    /*
    * function setboxStartup
    * 实例化探针*/
    function setboxStartup(){
        /*实例化探针参数对象
        * deviceInfo对象和toastLogger对象是国双探针文档里提供*/
        var deviceInfo = new DeviceInfo();
        var toastLogger = new ToastLogger(false);
        deviceInfo.caCardNum = _deviceCarNum;
        deviceInfo.mac = _deviceMac;
        deviceInfo.stbId = _deviceStbTybe;
        deviceInfo.zoneNum = "0898";
        deviceInfo.stbType = "高清1280";
        //实例化探针对象
        var gs_tracker = CNTVTracker.getInstance(_pid, deviceInfo, _configUrl, _configBakUrl,'',toastLogger);
        return gs_tracker;
    }
    /* 探针buttonInfo对象实例化
     * clickPageNum: 点击页码
     * clickPositionNum: 点击位置
     * */
    function buttonIn(clickPageNum,clickPositionNum){
        var clickPageNum = clickPageNum || 0;
        var clickPositionNum = clickPositionNum || 0;
        var buttonInfo = new ButtonInfo();
        buttonInfo.clickPageNum = clickPageNum;
        buttonInfo.clickPositionNum = clickPositionNum;
        return buttonInfo;
    }
    /*  epgEnter事件参数epgInfo
     *  ispl 是否为播放 1为播放，0为未播放（不传时默认是0:未播放）
     *  返回epgInfo对象*/
    function epgInfo(ispl){
        var ispl= ispl||0;
        var epgInfo = new EpgInfo();
        epgInfo.title = document.title;
        epgInfo.pageUrl = window.location.href;
        return epgInfo;
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
    /*打开播放页面时需要的playInfo对象
     * columnId：栏目id
     * programId：节目id
     * programName: 节目名称*/
    function playInfo(columnId,programId,programName){
        var playInfo = new PlayInfo();
        playInfo.columndId = columnId;
        playInfo.programId = programId;
        playInfo.programName = programName;
        return playInfo;
    }
    /*播放事件时需要的videoInfo对象
     * columnId: 栏目id
     * programType: 节目类型(电视剧等)
     * programId：节目id
     * programName:节目名称
     * videoDuration：节目时长(单位是秒)
     * 函数返回videoInfo对象*/
    function videoInfo(columnId,programType,programId,programName,videoDuration){
        var videoInfo = new VideoInfo();
        videoInfo.columnId = columnId;
        videoInfo.programType = programType;
        videoInfo.programId = programId;
        videoInfo.programName = programName;
        videoInfo.videoId = programId;
        videoInfo.videoDuration = videoDuration;
        return videoInfo;
    }
    /*
    * function apppendProbeChannel
    * 拼接栏目层级,通过cookie获取之前的栏目层级并进行拼接,之后设置cookie返回
    * channel:当前栏目
    * 返回最新的栏目层级*/
    EWEB.appendProbeChannel = function(channel){
        //获取当前栏目层级
        var cur_channels = getCookie('channels');
        //进行拼接
        cur_channels += "/" + channel;
        //设置相应cookie
        setCookie('channels',cur_channels);
        //返回拼接后的栏目层级
        return cur_channels;
    }
    /*function changeChannel
    * 截取当前栏目层级后进行拼接
    * channel:必填,当前的栏目
    * 返回最新的栏目层级*/
    EWEB.changeChannel = function(channel){
        //获取当前栏目层级
        var cur_channels = getCookie('channels');
        //对当前栏目层级进行处理,获取到最后一个"/"之前的栏目层级
        var sub_channels = cur_channels.substring(0,cur_channels.lastIndexOf("/")+1);
        //进行栏目拼接
        cur_channels =  sub_channels + channel;
        //设置cookie
        setCookie("channels",cur_channels);
        //返回
        return cur_channels;
    }
    /*function backPreChannel
    * 返回上一级的栏目层级*/
    EWEB.backPreChannel = function(){
        //获取当前栏目层级
        var cur_channels = getCookie('channels');
        //对当前栏目层级进行处理,获取到最后一个"/"之前的栏目层级
        var sub_channels = cur_channels.substring(0,cur_channels.lastIndexOf("/"));
        //设置cookie
        setCookie("channels",sub_channels);
        //返回
        return sub_channels;
    }
    /*普通页面进行EpgEnter上报
    * isBack:必传，是否为返回页面
    * channels:必传，栏目层级
    * clickPageNum: 点击页码
    * clickPositionNum: 点击位置
    * */
    EWEB.openVodLoad = function(isBack,channels,clickPageNum,clickPositionNum){
        var gs_tracker = setboxStartup();
        var epgInfo = epgInfo();
        epgInfo.channels = channels;
        var buttonInfo = buttonInfo(clickPageNum,clickPositionNum);
        gs_tracker.epgEnter(isBack,epgInfo,buttonInfo);
    }

    /*打开播放页面调用此函数
    * channels:栏目层级
    * columnId:栏目id
    * programId:节目id
    * programName:节目名称
    * videoDuration：节目时长(单位是秒)
    * 函数返回vodPlayer对象*/
    EWEB.openVodPlayLoad = function(channels,columnId,programId,programName,programType,videoDuration){
        var gs_tracker = setboxStartup();
        var epgInfo = epgInfo(1);
        epgInfo.channels = channels;
        var buttonInfo = buttonInfo(clickPageNum,clickPositionNum);
        var playInfo = playInfo(columnId,programId,programName);
        var videoInfo = videoInfo(columnId,programType,programId,programName,videoDuration)
        gs_tracker.playEpgEnter(epgInfo,buttonInfo,playInfo);
        var vodPlayer = gs_tracker.openVodPlayer(videoInfo);
        vodPlayer.beginLoading(videoInfo);
        vodPlayer.endLoading(true);
        vodPlyaer.beginPlay();
        return vodPlayer;
    }
    /*function changePlay
    * 播放状态改变时调用
    * Player:播放器(vodPlayer,livePlayer,shiftPlayer,rePlayer)
    * status:PlayStatus.PLAYING,PlayStatus.PAUSED等*/
    EWEB.changePlay = function(Player,status){
        var Player = Player;
        Player.changeStatus(status);
    }
    /*function endPlay
    * 结束播放时调用
    * Player:播放器(vodPlayer,livePlayer,shiftPlayer,rePlayer)*/
    EWEB.endPlay = function(Player){
        var Player = Player;
        Player.endPlay();
    }
})(EWEB);