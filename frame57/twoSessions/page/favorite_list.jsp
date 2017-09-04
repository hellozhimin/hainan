<%@ include file = "config/param.jsp"%>
<%@ include file = "config/code.jsp"%>
<%
	String category_id = request.getParameter("category_id");
	String backUrl = request.getParameter("backUrl");	
	String category_name = request.getParameter("category_name")==null?"":request.getParameter("category_name");
	category_name = new String(category_name.getBytes("ISO-8859-1"),"utf-8");
	category_name = java.net.URLDecoder.decode(category_name,"utf-8");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
<title>点播二级页面</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<style>
body{
	font-family:"微软雅黑";
}
.news_choose,.news_list,.news_list_focus,.news_list_focusout{
	position:absolute;
}
.news_choose{
	left:0px;
	width:362px;
	height:75px;
	}
.news_list{
	left:0px;
	top:0px;
	width:362px;
	height:26px;
	font-size:24px;
	line-height:26px;
	color:#00F;
}
.news_list_focus{
	left:-35px;
	top:-20px;
	width:462px;/*462*/
	height:73px;
	font-size:26px;
	line-height:75px;
	color:#FFF;
	text-shadow:1px 1px 3px #000;
	text-align:center;
	background-image:url(images/news_list_focus_bg.png);
}
.news_list_focusout{
	left:-25px;
	top:-15px;
	width:461px;
	height:59px;
	font-size:26px;
	line-height:60px;
	color:#FFF;
	text-align:center;
	text-shadow:1px 1px 3px #000;
	background-image:url(images/news_list_focusout_bg.png);
}
</style>
</head>

<body  bgcolor="transparent" onUnload="exitPage();">
<div style="position:absolute; top:0px; left:0px; width:1280px; height:720px; ">
	<img src="images/news_bg.png" />
    <!--C3-->
    <div id="cat_title" class="topsign" style="width:900px;"></div>
    <!--C3_a1-->
    <div style="position:absolute; left:87px; top:106px; width:362px; height:564px;">
    	<!--list_up&down-->
        <img src="images/page_up.png" style="position:absolute; top:-10px; left:147px;">
        <img src="images/page_down.png" style="position:absolute; bottom:-10px; left:147px;">
    	<!--news_list-->
        <div class="news_choose" style="top:26px;">
    		<div class="news_list" id="area0_0"></div>
        </div>
        <div class="news_choose" style="top:86px;">
    		<div class="news_list" id="area0_1"></div>
        </div>
        <div class="news_choose" style="top:146px;">
    		<div class="news_list" id="area0_2"></div>
        </div>
        <div class="news_choose" style="top:206px;">
    		<div class="news_list" id="area0_3"></div>
        </div>
		<div class="news_choose" style="top:266px;">
			<div class="news_list" id="area0_4"></div>
        </div>
        <div class="news_choose" style="top:326px;">
            <div class="news_list" id="area0_5"></div>
        </div>
        <div class="news_choose" style="top:386px;">
            <div class="news_list" id="area0_6"> </div>
        </div>
        <div class="news_choose" style="top:446px;">
            <div class="news_list" id="area0_7"></div>
        </div>
        <div class="news_choose" style="top:506px;">
            <div class="news_list" id="area0_8"></div>
        </div>
    </div>
    <!--C3-a2-->
    <div style="position:absolute; top:174px; left:538px; border-width:3px; border-style:solid; border-color:rgba(11,94,125,0.9); width:666px; height:373px;"></div>
    <div id="bottom_title" class="news_list" style="position:absolute; top:566px; left:538px; width:672px; height:26px; text-align:center;">暂无节目</div>
</div>
<div id="_test" style="color:red; position:absolute; top:53px; left:247px;"></div>
</body>
</html>
<script type="text/javascript" src="js/focus_logic.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<%@ include file = "js/trailer_play.jsp"%>
<script type="text/javascript">
	var area0;
	var content_list = new Array();
	var cookie_cat_id = "news_category_id";
	var cookie_focus = "news";
	var cookie_vod_list_code = "vod_list_code";
	var cookie_code = "<%=category_id%>";
	var _focusArr = get_focus(cookie_focus);

	if("<%=category_id%>" != "null"){
		setCookie(cookie_vod_list_code,cookie_code);
	}
	
	// 设置title
	if("" != "<%=category_name%>"){
		setCookie("favorite_list_title","<%=category_name%>");
	}
	
	var select_focus = _focusArr[1];
	var select_page = _focusArr[2];
	window.onload = function(){
		loadElement();
		setTimeout("window.focus()",1);
	}
	function loadElement(){
		load_category_title();
		area0 = focus_logic.loadElements(9,1,"area0_","news_list_focus","news_list",[-1,-1,-1,-1]);
		setAreaAttr();
		loadData();
		focus_logic.page.setCurrentFocus(_focusArr[0],_focusArr[1]);
	}
	function setAreaAttr(){
		//----------------------------------------------area0
		area0.setMarqueeWidth(430);
		area0.curDomIndex = _focusArr[1];
		area0.pageNumber = _focusArr[2];
		set_select_focus(area0.curDomIndex);
		area0.okEvent = function(isAuto){
			if(select_focus==area0.curDomIndex && select_page==area0.pageNumber && isAuto==undefined){
				set_focus(cookie_focus);
				if(content_list.length>0){
					var _offset = (area0.pageNumber-1)*area0.domsMaxLength;
					window.location.href = "goto_play.jsp?action=out&returnUrl=favorite_list.jsp&vodId="+content_list[area0.curDomIndex+_offset].vodId+"&columncode="+load_category_id();
				}
				return;
			}
			get_play_info();
			set_select_focus(area0.curDomIndex);
		}
		area0.pageTurnEvent = function(){
			set_select_focus();
		}
		//----------------------------------------------page
		focus_logic.page.backEvent = function(){
			delCookie(cookie_focus);
			delCookie(cookie_cat_id);
			delCookie("favorite_list_title");
			if("<%=backUrl%>" == "null"){
				delCookie(cookie_vod_list_code);
				window.location.href = "favorite.jsp";
			}else{
				window.location.href = unescape("<%=backUrl%>");
			}
		}
	}
	function loadData(){
		focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId="+load_category_id()+"&len_px=220",load_content_list);
	}
	function load_content_list(result){
		content_list = eval('('+result+')');
		area0.setDataCount(content_list.length);
		area0.setAttrForDomsTxt(content_list,"vodName","cut_vodName",1);
		if(content_list != ""){
			get_play_info();
		}
	}
	function load_category_title(){
		
		if("<%=category_id%>" != "null"){
			var vod_code = "<%=category_id%>";
		}else{
			var vod_code = getCookie(cookie_vod_list_code);
		}
		
		// 能拿到中文标题时，不做处理
		var _vod_list_title = getCookie("favorite_list_title");
		if("" != _vod_list_title){
			$("cat_title").innerHTML = _vod_list_title;
			return;
		}
		
		if(vod_code=="<%=vod_star_code%>"){
			$("cat_title").innerHTML = "两会时间";
		}else if(vod_code=="<%=vod_news_code%>"){
			$("cat_title").innerHTML = "见证履职";
		}else if(vod_code=="<%=vod_ColumnEssence_code%>"){
			$("cat_title").innerHTML = "央视名栏";
		}else if(vod_code=="<%=vod_scorer_code%>"){
			$("cat_title").innerHTML = "会期花絮";
		}else if(vod_code=="<%=vod_honour_code%>"){
			$("cat_title").innerHTML = "每日热点";
		}else if(vod_code=="<%=vod_opening_closing_ceremony_code%>"){
			$("cat_title").innerHTML = "记者会直击";
		}else if(vod_code=="<%=vod_overmatch_code%>"){
			$("cat_title").innerHTML = "V观两会";
		}
		
	}
	
	function get_play_info(){
		var _offset = (area0.pageNumber-1)*area0.domsMaxLength;
		focus_logic.getDataByAjax("<%=data_path%>?Action=get_play_info&global_code="+content_list[area0.curDomIndex+_offset].vodId,play_vod);
		if(content_list[area0.curDomIndex+_offset].vodName.length>27){
			$("bottom_title").innerHTML = "<marquee>"+content_list[area0.curDomIndex+_offset].vodName+"</marquee>";
		}else{
			$("bottom_title").innerHTML = content_list[area0.curDomIndex+_offset].vodName;
		}
	}
	
	function play_vod(result){
		var mediaUrl = eval('('+result+')');
		destoryMP();
		var playUrl = mediaUrl[0].mediaUrl;
		play(542,176,666,378,playUrl);
	}
	
	function play_next(){
		/*area0.move(2);
		area0.okEvent("Auto");*/
		//将自动播放的方式改为顺序播放，之前是播放当前焦点的下一个
		
		area0.doms[select_focus].element.className = "news_list";
		area0.doms[select_focus].blurClassName = "news_list";
		var _offset = (select_page-1)*area0.domsMaxLength;
		area0.doms[select_focus].element.innerHTML = content_list[select_focus+_offset].cut_vodName;
		select_focus = select_focus+1;
		var tmp_select_count = area0.pageTotal==select_page?((area0.dataCount-1)%(area0.domsMaxLength)+1):area0.domsMaxLength;
		if(select_focus>=9 || (select_page==area0.pageTotal && select_focus>=tmp_select_count)){
			select_focus = 0;
			select_page = (select_page+1)>area0.pageTotal?1:(select_page+1);
		}
		if(select_page==area0.pageNumber){
			area0.doms[select_focus].element.className = "news_list_focusout";
			area0.doms[select_focus].blurClassName = "news_list_focusout";
		}
		
		_offset = (select_page-1)*area0.domsMaxLength;
		$("trailer").src = "../common/hwzxplayer_trailer.html?programSeriesId="+content_list[select_focus+_offset].vodId+"&seriesId="+content_list[select_focus+_offset].vodId+"&contentType=2&playType=vod&Left=542&Top=183&Width=666&Height=373"
		if(content_list[select_focus+_offset].vodName.length>27){
			$("bottom_title").innerHTML = "<marquee>"+content_list[select_focus+_offset].vodName+"</marquee>";
		}else{
			$("bottom_title").innerHTML = content_list[select_focus+_offset].vodName;
		}
	}
	
	function set_select_focus(_curDomIndex){
		area0.doms[select_focus].element.className = "news_list";
		area0.doms[select_focus].blurClassName = "news_list";
		if(_curDomIndex != undefined){
			select_focus = _curDomIndex;
			select_page=area0.pageNumber;
		}
		if(select_page==area0.pageNumber){
			if(select_focus==area0.curDomIndex && focus_logic.page.curAreaIndex==0){
				area0.doms[select_focus].element.className = "news_list_focus";
			}else{
				area0.doms[select_focus].element.className = "news_list_focusout";
			}
			area0.doms[select_focus].blurClassName = "news_list_focusout";
		}
	}
	
	function load_category_id(){
		var category_id;
		if("<%=category_id%>" == "null"){
			category_id = getCookie(cookie_cat_id);
		}else{
			category_id = "<%=category_id%>";
			setCookie(cookie_cat_id,category_id);
		}
		return category_id;
	}
	
	function exitPage(){
		destoryMP();
	}
	
	function goUtility(){
    	eval("eventJson = " + Utility.getEvent());
    	var typeStr = eventJson.type;
		this.eventJsonType=eventJson.type;
    	switch(typeStr){
			case 'EVENT_FIRST_I_FRAME'://b700 V2U
    		case "EVENT_MEDIA_BEGINING"://b700 V2A
			
    			break;
            case "EVENT_MEDIA_ERROR":
            	
            	break;
            case "EVENT_MEDIA_END":
				play_next();
                break;
            default :
                return 1;
        }
        return 1;
    }
</script>
<script type="text/javascript">
	var commonPage = new Object();
	commonPage.mp = mediamp;
</script>
<%@ include file = "volume_control.htm"%>