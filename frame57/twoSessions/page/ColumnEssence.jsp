﻿<%@ include file = "config/param.jsp"%>
<%
	String category_id = request.getParameter("category_id");
	String backUrl = request.getParameter("backUrl");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
<title>酷栏目</title>
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
	line-height:74px;
	color:#FFF;
	text-shadow:1px 1px 3px #000;
	text-align:center;
	background-image:url(images/news_list_focus_bg.png);
}
.news_list_focusout{
	left:-16px;
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
	<div class="topsign">酷栏目</div>
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
	
	var cookie_cat_id = "ColumnEssence_category_id";
	var cookie_focus = "ColumnEssence";
	var _focusArr = get_focus_ex(cookie_focus);
	
	var area0_select_index = _focusArr[4];
	var area0_select_page = _focusArr[5];
	var area1_select_index = _focusArr[1];
	var area1_select_page = _focusArr[2];
	
	var category_list = new Array();
	var content_list = new Array();

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
		set_area0_select_index(area0.curDomIndex);
		area0.setMarqueeWidth(180);
		area0.areaOutEvent = function(){
			if(area0.pageNumber == area0_select_page){
				area0.curDomIndex = area0_select_index;
			}
		}
		area0.pageTurnEvent = function(){
			set_area0_select_index();
		}
		area0.okEvent = function(type){
			area1.pageNumber = 1;
			var _offset = (area0.pageNumber-1)*area0.domsMaxLength;
			focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId="+category_list[_offset+area0.curDomIndex].category_id+"&len_px=150",load_content_list);
			set_area0_select_index(area0.curDomIndex);
		};
		//----------------------------------------------area1
		area1.curDomIndex = _focusArr[1];
		area1.pageNumber = _focusArr[2];
		area1.setMarqueeWidth(430);
		area1.okEvent = function(isAuto){
			if(area1_select_index==area1.curDomIndex && area1_select_page==area1.pageNumber && isAuto==undefined){
				area0.pageNumber = area0_select_page;
				area0.curDomIndex = area0_select_index;
				set_focus_ex(cookie_focus);
				var _offset = (area1.pageNumber-1)*area1.domsMaxLength;
				window.location.href = "goto_play.jsp?action=out&returnUrl=ColumnEssence.jsp&vodId="+content_list[area1.curDomIndex+_offset].vodId+"&columncode="+load_category_id();
				return;
			}
			get_play_info();
			set_area1_select_index(area1.curDomIndex);
		}
		area1.pageTurnEvent = function(){
			set_area1_select_index();
		}
		//----------------------------------------------page
		focus_logic.page.backEvent = function(){
			delCookie(cookie_focus);
			delCookie(cookie_cat_id);
			if("<%=backUrl%>" == "null"){
				window.location.href = "vod.jsp";
			}else{
				window.location.href = unescape("<%=backUrl%>");
			}
		}
		focus_logic.page.setAreaMembership(0,1);
	};
	
	function set_area0_select_index(_curDomIndex){
		area0.doms[area0_select_index].element.className = "horizontalNav";
		area0.doms[area0_select_index].blurClassName = "horizontalNav";
		if(_curDomIndex != undefined){
			area0_select_index = _curDomIndex;
			area0_select_page=area0.pageNumber;
		}
		if(area0_select_page==area0.pageNumber){
			if(area0_select_index==area0.curDomIndex && focus_logic.page.curAreaIndex==0){
				area0.doms[area0_select_index].element.className = "horizontalNav_focus";
			}else{
				area0.doms[area0_select_index].element.className = "horizontalNav_focusout";
			}
			area0.doms[area0_select_index].blurClassName = "horizontalNav_focusout";
		}
	}
	
	function set_area1_select_index(_curDomIndex){
		area1.doms[area1_select_index].element.className = "news_list";
		area1.doms[area1_select_index].blurClassName = "news_list";
		if(_curDomIndex != undefined){
			area1_select_index = _curDomIndex;
			area1_select_page=area1.pageNumber;
		}
		if(area1_select_page==area1.pageNumber){
			if(area1_select_index==area1.curDomIndex && focus_logic.page.curAreaIndex==1){
				area1.doms[area1_select_index].element.className = "news_list_focus";
			}else{
				area1.doms[area1_select_index].element.className = "news_list_focusout";
			}
			area1.doms[area1_select_index].blurClassName = "news_list_focusout";
		}
	}
	
	function loadData(){
		focus_logic.getDataByAjax("<%=data_path%>?Action=vod_categories&category_id="+load_category_id()+"&len_px=80",load_category_list);
	}
	
	function load_category_list(result){
		category_list = eval('('+result+')');
		area0.setDataCount(category_list.length);
		area0.setAttrForDomsTxt(category_list,"category_name","cut_category_name",1);
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
			set_area1_select_index(area1.curDomIndex);
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
		
		area1.doms[area1_select_index].element.className = "news_list";
		area1.doms[area1_select_index].blurClassName = "news_list";
		var _offset = (area1_select_page-1)*area1.domsMaxLength;
		area1.doms[area1_select_index].element.innerHTML = content_list[area1_select_index+_offset].cut_vodName;
		area1_select_index = area1_select_index+1;
		var tmp_select_count = area1.pageTotal==area1_select_page?((area1.dataCount-1)%(area1.domsMaxLength)+1):area1.domsMaxLength;
		if(area1_select_index>=9 || (area1_select_page==area1.pageTotal && area1_select_index>=tmp_select_count)){
			area1_select_index = 0;
			area1_select_page = (area1_select_page+1)>area1.pageTotal?1:(area1_select_page+1);
		}
		if(area1_select_page==area1.pageNumber){
			area1.doms[area1_select_index].element.className = "news_list_focusout";
			area1.doms[area1_select_index].blurClassName = "news_list_focusout";
		}
		
		_offset = (area1_select_page-1)*area1.domsMaxLength;
		$("trailer").src = "../common/hwzxplayer_trailer.html?programSeriesId="+content_list[area1_select_index+_offset].vodId+"&seriesId="+content_list[area1_select_index+_offset].vodId+"&contentType=2&playType=vod&Left=542&Top=206&Width=666&Height=373";
		if(content_list[area1_select_index+_offset].vodName.length>27){
			$("bottom_title").innerHTML = "<marquee>"+content_list[area1_select_index+_offset].vodName+"</marquee>";
		}else{
			$("bottom_title").innerHTML = content_list[area1_select_index+_offset].vodName;
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