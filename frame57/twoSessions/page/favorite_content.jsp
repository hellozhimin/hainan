<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file = "config/param.jsp"%>
<%@ page language="java" import="java.net.URL" %>
<%@ page language="java" import="java.net.HttpURLConnection" %>
<%@ page language="java" import="java.io.BufferedReader" %>
<%@ page language="java" import="java.io.InputStreamReader" %>
<%!

    String requestAction = "";
	String actionURL = "";
	int len_px=1280;
	
	public String getHttpClient(String tmpUrl) {
		StringBuilder result = new StringBuilder();
		try {
			URL url = new URL(tmpUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setUseCaches(false);
			connection.connect();
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
			String lines = "";
			while ((lines = reader.readLine()) != null) {
				result.append(lines);
			}
			reader.close();
			connection.disconnect();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
 %>
<%
	String category_id = request.getParameter("category_id");
	String category_name = request.getParameter("category_name")==null?"":request.getParameter("category_name");
	String _category_name = category_name;
	category_name = new String(category_name.getBytes("ISO-8859-1"),"utf-8");
	category_name = java.net.URLDecoder.decode(category_name,"utf-8");
	
	/*if(category_id != null){
		String url_1 = data_path+"?Action=vod_categories&category_id="+category_id+"&len_px=80";
		String result_1 = getHttpClient(url_1);
		System.out.println("----------------------------------ff-"+result_1);
		if("".equals(result_1) || result_1.indexOf("cut_category_name")<0){
			response.sendRedirect("favorite_list.jsp?category_id="+category_id+"&category_name="+java.net.URLEncoder.encode(category_name));
		}
	}*/
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
<title>比赛 类别详情</title>
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
	color:#FFF;
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
.horizontalNav_choose,.horizontalNav,.horizontalNav_focus,.horizontalNav_focusout{
	position:absolute;
	text-align:center;
}
.horizontalNav_choose{
	top:0px;
	width:190px;
	height:60px;
	line-height:60px;
	}
.horizontalNav{
	top:-5px;
	left:0px;
	width:100%;
	font-size:30px;
	color:#013e12;
}
.horizontalNav_focus{
	top:-13px;
	left:-22px;
	width:218px;
	height:76px;
	line-height:76px;
	font-size:30px;
	color:#FFF;
	background-image:url(images/horizontalNav_focus_bg.png);
}
.horizontalNav_focusout{
	top:-15px;
	left:-8px;
	width:194px;
	height:80px;
	line-height:80px;
	font-size:30px;
	color:#013e12;
	background-image:url(images/horizontalNav_focusout_bg.png);
}
</style>
</head>

<body bgcolor="transparent"  onUnload="exitPage();">
<div style="position:absolute; top:0px; left:0px; width:1280px; height:720px; ">
	<img src="images/ColumnEssence_bg.png" />
    <!--C3-->
    <div class="topsign" id="topSign"></div>
    <!--C3_a1-->
    <div style="position:absolute; left:55px; top:105px; width:1122px; height:60px;">
    	<div class="horizontalNav_choose" style="left:0px;">
    		<div class="horizontalNav" id="area0_0"></div>
        </div>
    	<div class="horizontalNav_choose" style="left:190px;">
    		<div class="horizontalNav" id="area0_1"></div>
        </div>
    	<div class="horizontalNav_choose" style="left:380px;">
    		<div class="horizontalNav" id="area0_2"></div>
        </div>
    	<div class="horizontalNav_choose" style="left:570px;">
    		<div class="horizontalNav" id="area0_3"></div>
        </div>
    	<div class="horizontalNav_choose" style="left:760px;">
    		<div class="horizontalNav" id="area0_4"></div>
        </div>
    	<div class="horizontalNav_choose" style="left:950px;">
    		<div class="horizontalNav" id="area0_5"></div>
        </div>
    </div>
    <img id="col_l" src="images/col_l.png" style="position:absolute; left: 14px; top: 117px;" width="16" height="25"/>
    <img id="col_r" src="images/col_r.png" style="position:absolute; left: 1225px; top: 117px;" width="16" height="25"/>
    <!--C3_a2-->
    <div style="position:absolute; left:87px; top:169px; width:362px; height:494px;">
    	<!--list_up&down-->
        <img src="images/page_up.png" style="position:absolute; top:-6px; left:166px;">
        <img src="images/page_down.png" style="position:absolute; bottom:-10px; left:166px;">
        <!--news_list-->
        <div class="news_choose" style="top:26px;">
    		<div class="news_list" id="area1_0"></div>
        </div>
        <div class="news_choose" style="top:80px;">
    		<div class="news_list" id="area1_1"></div>
        </div>
        <div class="news_choose" style="top:140px;">
    		<div class="news_list" id="area1_2"></div>
        </div>
        <div class="news_choose" style="top:200px;">
    		<div class="news_list" id="area1_3"></div>
        </div>
        <div class="news_choose" style="top:260px;">
			<div class="news_list" id="area1_4"></div>
        </div>
        <div class="news_choose" style="top:320px;">
            <div class="news_list" id="area1_5"></div>
        </div>
        <div class="news_choose" style="top:380px;">
            <div class="news_list" id="area1_6"> </div>
        </div>
        <div class="news_choose" style="top:440px;">
            <div class="news_list" id="area1_7"></div>
        </div>
    </div>
    <!--C3-a3-->
    <div style="position:absolute; top:198px; left:538px; border-width:3px; border-style:solid; border-color:rgba(11,94,125,0.9); width:666px; height:373px;"></div>
    <div id="bottom_title" class="news_list" style="position:absolute; top:590px; left:538px; width:672px; height:26px; text-align:center;">暂无节目</div>
</div>
</body>
</html>
<script type="text/javascript" src="js/focus_logic.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<%@ include file = "js/trailer_play.jsp"%>
<script type="text/javascript">
	var area0,area1;
	
	var cookie_cat_id = "favorite_content_category_id";
	var cookie_cat_name = "favorite_content_category_name";
	var cookie_focus = "favorite_content";
	var _focusArr = get_focus_ex(cookie_focus);
	
	var select_area1_focus = _focusArr[1];
	var select_area1_page = _focusArr[2];
	var select_area0_focus = _focusArr[4];
	var select_area0_page = _focusArr[5];
	var area0_cur = 0;

	
	var category_list = new Array();
	var content_list = new Array();
	
	var category_name;
	var _cookie_cat_name;
	
	window.onload = function(){
		loadElement();
		setTimeout("window.focus()",1);
	}
	function loadElement(){
		area0 = focus_logic.loadElements(1,6,"area0_","horizontalNav_focus","horizontalNav",[-1,-1,1,-1]);
		area1 = focus_logic.loadElements(8,1,"area1_","news_list_focus","news_list",[0,-1,-1,-1]);
		setAreaAttr();
		loadData();
		if(area0.pageTotal<=1){
			$("col_l").style.visibility = "hidden";
			$("col_r").style.visibility = "hidden";
		}
		focus_logic.page.setCurrentFocus(_focusArr[0],_focusArr[1]);
	}
	function setAreaAttr(){
		//----------------------------------------------area0
		area0.curDomIndex = _focusArr[4];
		area0.pageNumber = _focusArr[5];
		area0.setMarqueeWidth(180);
		area0.areaOutEvent = function(){
			if(area0.pageNumber != select_area0_page){
				area0.doms[area0.curDomIndex].blurClassName = "horizontalNav";
				area0_cur = area0.curDomIndex;
			}else{
				area0.doms[_focusArr[4]].element.className = "horizontalNav_focusout"; 
			}
		}
		area0.okEvent = function(type){
			_focusArr[4] = area0.curDomIndex;
			if(type!="cross" && type!="appoint"){
				area1.pageNumber = 1;
				focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId="+category_list[area0.curDomIndex].category_id+"&len_px=150",load_content_list);
			}
			if(select_area0_focus==area0.curDomIndex){
				return;
			}
			set_area0_select_focus(area0.curDomIndex);
		}
		area0.pageTurnEvent = function(){
			if(area0.pageNumber == select_area0_page){
				area0.doms[select_area0_focus].element.className = "horizontalNav_focusout";
			}
			set_area0_select_focus();
		}
		//----------------------------------------------area1
		area1.curDomIndex = _focusArr[1];
		area1.pageNumber = _focusArr[2];
		area1.setMarqueeWidth(430);
		area1.okEvent = function(isAuto){
			if(select_area1_focus==area1.curDomIndex && select_area1_page==area1.pageNumber && isAuto==undefined){
				area0.curDomIndex = select_area0_focus;
				area0.pageNumber = select_area0_page; 
				set_focus_ex(cookie_focus);
				var _offset = (area1.pageNumber-1)*area1.domsMaxLength;
				window.location.href = "goto_play.jsp?action=out&returnUrl=favorite_content.jsp&vodId="+content_list[area1.curDomIndex+_offset].vodId+"&columncode="+load_category_id();
				return;
			}
			get_play_info();
			set_area1_select_focus(area1.curDomIndex);
		}
		area1.areaOutEvent = function(){
			if(area0.pageNumber != select_area0_page){
				area0.curDomIndex = area0_cur;
				//area0.doms[area0.curDomIndex].blurClassName = "horizontalNav";
			}else{
				area0.curDomIndex = _focusArr[4];
			}
		}
		area1.pageTurnEvent = function(){
			if(area1.pageNumber == select_area1_page){
				area1.curDomIndex = select_area1_focus;
			}
			set_area1_select_focus();
		}
		//----------------------------------------------page
		focus_logic.page.backEvent = function(){
			delCookie(cookie_focus);
			delCookie(cookie_cat_id);
			delCookie(cookie_cat_name);
			window.location.href = "favorite.jsp";
		}
		focus_logic.page.setAreaMembership(0,1);
	}
	function set_area0_select_focus(_curDomIndex){
		area0.doms[select_area0_focus].element.className = "horizontalNav";
		area0.doms[select_area0_focus].blurClassName = "horizontalNav";
		if(_curDomIndex != undefined){
			select_area0_focus = _curDomIndex;
			select_area0_page = area0.pageNumber;
		}
		if(select_area0_page==area0.pageNumber){
			if(select_area0_focus==area0.curDomIndex && focus_logic.page.curAreaIndex==0){
				area0.doms[select_area0_focus].element.className = "horizontalNav_focus";
			}else{
				area0.doms[select_area0_focus].element.className = "horizontalNav_focusout";
			}
			area0.doms[select_area0_focus].blurClassName = "horizontalNav_focusout";
		}
	}
	function set_area1_select_focus(_curDomIndex){
		area1.doms[select_area1_focus].element.className = "news_list";
		area1.doms[select_area1_focus].blurClassName = "news_list";
		if(_curDomIndex != undefined){
			select_area1_focus = _curDomIndex;
			select_area1_page=area1.pageNumber;
		}
		if(select_area1_page==area1.pageNumber){
			if(select_area1_focus==area1.curDomIndex && focus_logic.page.curAreaIndex==1){
				area1.doms[select_area1_focus].element.className = "news_list_focus";
			}else{
				area1.doms[select_area1_focus].element.className = "news_list_focusout";
			}
			area1.doms[select_area1_focus].blurClassName = "news_list_focusout";
		}
	}
	
	function loadData(){
		focus_logic.getDataByAjax("<%=data_path%>?Action=vod_categories&category_id="+load_category_id()+"&len_px=80",load_category_list);
		_cookie_cat_name = getCookie(cookie_cat_name);
		if(_cookie_cat_name != null){
			document.getElementById("topSign").innerHTML = _cookie_cat_name;
		}else{
			category_name = "<%=category_name%>";
			document.getElementById("topSign").innerHTML = category_name;
			setCookie(cookie_cat_name,category_name);
		}
	}
	
	function load_category_list(result){
		category_list = eval('('+result+')');
		area0.setDataCount(category_list.length);
		area0.setAttrForDomsTxt(category_list,"category_name","cut_category_name",1);
		set_area0_select_focus(area0.curDomIndex);
		if(category_list.length>0){
			var _offset = (area0.pageNumber-1)*area0.domsMaxLength;
			focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId="+category_list[_offset+area0.curDomIndex].category_id+"&len_px=150",load_content_list);
		}
	}
	
	function load_content_list(result){
		content_list = eval('('+result+')');
		area1.setDataCount(content_list.length);
		area1.setAttrForDomsTxt(content_list,"vodName","cut_vodName",1);
		if(content_list != ""){
			get_play_info();
			set_area1_select_focus(area1.curDomIndex);
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
	function set_focus_favorite_ex0(name){
		var _pageObj = focus_logic.page;
		var _AreaObj = _pageObj.areas[_pageObj.curAreaIndex];
		var _parent_focus_str = "&"+_AreaObj.parentAreaIndex+"&"+_pageObj.areas[_AreaObj.parentAreaIndex].curDomIndex+"&"+_pageObj.areas[_AreaObj.parentAreaIndex].pageNumber;
		if(_AreaObj.parentAreaIndex == undefined){
			_parent_focus_str = "&"+0+"&"+0+"&"+1;
		}
		setCookie(name,_pageObj.curAreaIndex+"&"+_AreaObj.curDomIndex+"&"+_AreaObj.pageNumber+_parent_focus_str);
	}
	function exitPage(){
		destoryMP();
	}
	
	function get_play_info(){
		var _offset = (area1.pageNumber-1)*area1.domsMaxLength;
		focus_logic.getDataByAjax("<%=data_path%>?Action=get_play_info&global_code="+content_list[area1.curDomIndex+_offset].vodId,play_vod);
		if(content_list[area1.curDomIndex+_offset].vodName.length>27){
			$("bottom_title").innerHTML = "<marquee>"+content_list[area1.curDomIndex+_offset].vodName+"</marquee>";
		}else{
			$("bottom_title").innerHTML = content_list[area1.curDomIndex+_offset].vodName;
		}
	}
	
	function play_vod(result){
		var mediaUrl = eval('('+result+')');
		destoryMP();
		var playUrl = mediaUrl[0].mediaUrl;
		play(542,197,666,378,playUrl);
	}
	
	function play_next(){
		/*area0.move(2);
		area0.okEvent("Auto");*/
		//将自动播放的方式改为顺序播放，之前是播放当前焦点的下一个
		
		area1.doms[select_area1_focus].element.className = "news_list";
		area1.doms[select_area1_focus].blurClassName = "news_list";
		var _offset = (select_area1_page-1)*area1.domsMaxLength;
		area1.doms[select_area1_focus].element.innerHTML = content_list[select_area1_focus+_offset].cut_vodName;
		select_area1_focus = select_area1_focus+1;
		var tmp_select_count = area1.pageTotal==select_area1_page?((area1.dataCount-1)%(area1.domsMaxLength)+1):area1.domsMaxLength;
		if(select_area1_focus>=9 || (select_area1_page==area1.pageTotal && select_area1_focus>=tmp_select_count)){
			select_area1_focus = 0;
			select_area1_page = (select_area1_page+1)>area1.pageTotal?1:(select_area1_page+1);
		}
		if(select_area1_page==area1.pageNumber){
			area1.doms[select_area1_focus].element.className = "news_list_focusout";
			area1.doms[select_area1_focus].blurClassName = "news_list_focusout";
		}
		
		_offset = (select_area1_page-1)*area1.domsMaxLength;
		$("trailer").src = "../common/hwzxplayer_trailer.html?programSeriesId="+content_list[select_area1_focus+_offset].vodId+"&seriesId="+content_list[select_area1_focus+_offset].vodId+"&contentType=2&playType=vod&Left=542&Top=206&Width=666&Height=373"
		if(content_list[select_area1_focus+_offset].vodName.length>27){
			$("bottom_title").innerHTML = "<marquee>"+content_list[select_area1_focus+_offset].vodName+"</marquee>";
		}else{
			$("bottom_title").innerHTML = content_list[select_area1_focus+_offset].vodName;
		}
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