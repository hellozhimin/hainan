<%@ page import="com.zte.iptv.epg.util.*" %>
<%@ page import="java.util.*" %>
<%@page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ include file="utils.jsp" %>
<%
    UserInfo userInfo = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
	String reqFrame = getHTTPFrameCode(request.getRequestURI());
	String requestURL = request.getRequestURL().toString();
	String appUrl = requestURL.substring(0, requestURL.indexOf("frame"));
	String frameUrl = appUrl + reqFrame; //http:  ...... framexx
    String channelcolumnid = String.valueOf(getConfigurationByName(request,"column0",null,"UTF-8"));
    String lockedLimitTime = String.valueOf(getConfigurationByName(request,"OrderLockTime",null,"UTF-8"));
    String isHls = String.valueOf(getConfigurationByName(request,"isHls","0","UTF-8"));
    String mosaicPageSwitch = String.valueOf(getConfigurationByName(request,"mosaicPageSwitch","0","UTF-8"));
    String mosaicVideoArea = String.valueOf(getConfigurationByName(request,"mosaicVideoArea","0,0,1280,720","UTF-8"));
    String hlschannelPlayMode = String.valueOf(getConfigurationByName(request,"hlschannelPlayMode","0","UTF-8"));
    String isLocalplay = String.valueOf(getConfigurationByName(request,"isLocalplay","0","UTF-8"));
    String vodADpretime = String.valueOf(getConfigurationByName(request,"vodADpretime","0","UTF-8"));
    session.setAttribute("isHls",isHls);
    String mediaservice = (!"1".equals(isHls))?"1":"2";
    userInfo.setMediaservices(Integer.parseInt(mediaservice));
    /**
     * ippv 离散鉴权相关
     */
    String channelBGAuthInterval = String.valueOf(getConfigurationByName(request, "channelBGAuthInterval", "5", "UTF-8"));
    int interval = 5;
    try {
        interval = Integer.parseInt(channelBGAuthInterval);
    } catch (Exception ex) {
        ex.printStackTrace();
    }
    String filterLockChannels = String.valueOf(getConfigurationByName(request,"filterLockChannel","0","UTF-8"));
%>
<script language="javascript" type="">
	Authentication.CTCSetConfig("EPGEdition","osd");
    Authentication.CTCSetConfig ("framecode","<%=reqFrame%>");
	Utility.setBrowserWindowTransColor(0x00FF00FF);
    var str = navigator.userAgent;
    if(str.indexOf("Android") != -1 || str.indexOf("android") != -1){
        ztebw.setenv("{'show_pageloadingbar':'no'}");//设置加载圈隐藏
        ztebw.setenv("{'default_word_lib':'hanfeng'}"); //设置汉峰字库
    }
    else{
        top.writeConfig("show_pageloadingbar", "no");
    }
    if("<%=isLocalplay%>"=="1"){
        Authentication.CTCSetConfig("LocalplaySupplier","1");
    }  else{
        Authentication.CTCSetConfig("LocalplaySupplier","0");
    }
	//top.enableSTBLocalAudioUI();//开机频道音量条显示
	top.jsSetControl("STBLocalAudioUIFlag","1");//开机频道音量条显示
    top.jsSetControl("IppvAuthControlFlag","1");//ippv
    top.jsSetControl("ChannelAuthBGUrl", "<%=frameUrl%>/channelOrderAuth4Epg.jsp");
    top.jsSetControl("ChannelBGAuthInterval", parseInt("<%=interval%>"));//IPPV频道后台离散鉴权提前时间，即节目开始前XX分钟离散鉴权，默认5分钟(单位:分钟)
    //top.jsSetControl("UserModel","<%=reqFrame%>");  //-------xsw
    top.jsSetControl("UserID","<%=userInfo.getUserId()%>");    
	top.jsSetControl("lockvertifyjsp","<%=frameUrl%>/channel_lockverify.jsp");
	top.jsSetControl("ChannelAuthUrl","<%=frameUrl%>/channelOrderAuth.jsp");
	<%--top.jsSetControl("ChannelOrderUrl","<%=frameUrl%>/channelOrder.jsp");--%>
	<%--top.jsSetControl("ShowOrderListUrl","<%=frameUrl%>/channelOrderShowOrderList.jsp");--%>
	top.jsSetControl("errorTipOsdUrl","<%=frameUrl%>/error_osd.jsp");
	top.jsSetControl("errorOsdUrl","<%=frameUrl%>/error_osd.jsp");
	<%--top.jsSetControl("NoResourceOSD","<%=frameUrl%>/noresource_osd.jsp");--%>
	<%--top.jsSetControl("muteOsdUrl","<%=frameUrl%>/mute.jsp");--%>
	<%--top.jsSetControl("volumeOsdUrl","<%=frameUrl%>/volumeosd.jsp");--%>
	top.jsSetControl("frameBackUrl","<%=frameUrl%>/back.jsp");
    top.jsSetControl("channelListOsdUrl","<%=frameUrl%>/channel_all_ok_pre.jsp?columnid=<%=channelcolumnid%>&flag=true");
    top.jsSetControl("soundAndTitleUrl","<%=frameUrl%>/audiomuti.jsp");
    top.jsSetControl("refreshOsdUrl","<%=frameUrl%>/refreshOSD.jsp");
	top.jsSetControl("DLNA PUSH RESULT","<%=frameUrl%>/pushaction.jsp");
    top.jsSetControl("TVMS PUSH RESULT","<%=frameUrl%>/tvms_notice.jsp");
    top.jsSetControl("isHls","<%=isHls%>");
    top.jsDebug("6407000229:chan_addjsset.jsp:66:hlschannelPlayMode=<%=hlschannelPlayMode%>");
    if("1" == "<%=hlschannelPlayMode%>"){
    top.jsSetControl("channelHlsPlayUrl","<%=frameUrl%>/channel_play_hls.jsp");
    }
    top.jsSetControl("channelPlayTSTV","<%=frameUrl%>/channel_playtstv.jsp");
    top.jsSetControl("UserTeamId", "<%=userInfo.getUserSetId()%>");
    top.jsSetControl("langtype", "<%=userInfo.getUserlanguage()%>");
    top.jsSetControl("bocode", "<%=userInfo.getBoId()%>");
    top.jsSetControl("mediaservice", "<%=mediaservice%>");
    top.jsSetControl("vodadurl", "/mad_interface/VodServlet");
    top.jsSetControl("startadurl", "/mad_interface/EPGStartupServlet");
    top.jsSetControl("channeladurl", "/mad_interface/ChannelServlet");
    top.jsSetControl("npvrtvodadurl", "/mad_interface/RChannelServlet");
    top.jsSetControl("nvodadurl", "/mad_interface/EPGBannerVod");
    top.jsSetControl("epgbannerurl", "/mad_interface/EPGServlet");
    top.jsSetControl("adBeforeUrl","<%=frameUrl%>/vod_play.jsp");
    top.jsSetControl("adAfterUrl","<%=frameUrl%>/afteradplay.jsp");
    top.jsSetControl("NpvradBeforeUrl","<%=frameUrl%>/npvr_play.jsp");
    top.jsSetControl("NpvradAfterUrl","<%=frameUrl%>/afteradplay.jsp");
    top.jsSetControl("TvodadBeforeUrl","<%=frameUrl%>/channel_tvod_play.jsp");
    top.jsSetControl("TvodadAfterUrl","<%=frameUrl%>/afteradplay.jsp");
    if(parseInt("<%=vodADpretime%>",10) > 0){
        top.jsSetControl("ADTimeCounterPageURL","<%=frameUrl%>/displayAdTime.jsp");
    }
    if ("<%=mosaicPageSwitch%>" == "1") {
        top.jsSetControl("mosaicOsdUrl", "<%=frameUrl%>/channel_mosaic.jsp");
    }
    top.jsSetControl("mosaicVideoArea", "<%=mosaicVideoArea%>");
    top.jsSetControl("lockedLimitTime", "<%=lockedLimitTime%>");
    top.jsSetControl("filterLockChannel","<%=filterLockChannels%>");  /*童锁过滤开关*/
    top.jsSetControl("voiceSearchURL","<%=frameUrl%>/search_epg.jsp");  /*童锁过滤开关*/
</script>