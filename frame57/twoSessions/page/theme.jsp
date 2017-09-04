<%@ include file = "config/param.jsp"%>
<%@ include file = "config/code.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
<title>专题</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<style>
.theme_box{
	position:absolute;
	width:311px;
	height:256px;
}

.theme_choose{
	position:absolute;
	left:0px;
}
.theme_img{
	position:absolute;
	left:0px;
	top:0px;
}
.theme_choose>.theme_img{
	width:311px;
	height:180px;
}
.theme_choose_focus{
	position:absolute;
	left:-8px;
	top:-8px;
	width:321px;
	height:190px;
	border:4px solid #e7fc00;
	border-radius:3px;
}
.theme_choose_focus>.theme_img{
	width:321px;
	height:190px;
}

.theme_E2Text_24{
	width:100%;
	position:absolute;
	bottom:30px;
	text-align:center;
	font-family:"微软雅黑";
	font-size:24px;
	line-height:26px;
	color:#fff;
}
</style>
</head>

<body bgcolor="transparent" onUnload="exit_page();">
<div style="position:absolute; top:0px; left:0px; width:1280px; height:720px; ">
	<img src="images/bg.png" />    
    <!--nav-->
      <div class="menu">
		<div id="nav_0" class="_nav">
        	<img id="icon_0" src="images/navIcon_0.png" >
            <span id="navText_0" >推荐</span>
        </div>
        <div id="nav_1" class="_nav">
        	<img id="icon_1" src="images/navIcon_1.png">
        	<span id="navText_1" >直播</span>
		</div>
        <div id="nav_2" class="_nav">
        	<img id="icon_2" src="images/navIcon_2.png" >
       	    <span id="navText_2" >点播</span>
        </div>
		<div id="nav_3" class="_nav">
        	<img id="icon_3" src="images/navIcon_4.png">
        	<span id="navText_3" >各省</span>
        </div>
        <div id="nav_4" class="_nav" >
        	<img id="icon_4" src="images/navIcon_5.png">
        	<span id="navText_4" >专题</span>
        </div>
	</div>
    <!--theme-->
    <!--E2 - theme_boxs-->
    <div style="position:absolute; left:235px; top:85px; width:976px; height:494px;">
    <div id="content_focus" style="left:-14px; top:-18px; position:absolute; width:339px; height:212px; background:url(images/theme_focus.png) no-repeat;visibility:hidden;"></div>
    	<!--theme_boxs-->
    	<div id="nav0_0" class="theme_box" style="left:0px; top:0px;">
        	<div class="theme_choose" id="area1_0">
         	   <img id="area1_img_0" src="" width="311" height="180" class="theme_img">
            </div>
            <span id="area1_txt_0" class="theme_E2Text_24"></span>
        </div>
    	<div id="nav0_1" class="theme_box" style="left:322px; top:0px;">
        	<div class="theme_choose" id="area1_1">
            	<img id="area1_img_1" src="" width="311" height="180" class="theme_img">
            </div>
            <span id="area1_txt_1" class="theme_E2Text_24"></span>
        </div>
    	<div  id="nav0_2" class="theme_box" style="left:644px; top:0px;">
        	<div class="theme_choose" id="area1_2">
          	  <img id="area1_img_2" src="" width="311" height="180" class="theme_img">
            </div>
            <span id="area1_txt_2" class="theme_E2Text_24"></span>
        </div>
    	<div  id="nav0_3" class="theme_box" style="left:0px; top:256px;">
        	<div class="theme_choose" id="area1_3">
           		 <img  id="area1_img_3" src="" width="311" height="180" class="theme_img">
            </div>
            <span id="area1_txt_3" class="theme_E2Text_24"></span>
        </div>
    	<div id="nav0_4" class="theme_box" style="left:322px; top:256px;">
        	<div class="theme_choose" id="area1_4">
          		  <img  id="area1_img_4" src="" width="311" height="180" class="theme_img">
            </div>
            <span id="area1_txt_4" class="theme_E2Text_24"></span>
        </div>
    	<div id="nav0_5" class="theme_box" style="left:644px; top:256px;">
       		 <div class="theme_choose" id="area1_5">
          		  <img   id="area1_img_5" src="" width="311" height="180" class="theme_img">
            </div>
            <span id="area1_txt_5" class="theme_E2Text_24"></span>
        </div>
        
        <!--slider-->
    <div style="position:absolute; right:0px; top:0px; width:8px; height:100%; background-color:#16273d; opacity:0.8; border-radius:4px;">
    <div id="scoller" style="position:absolute; left:1px; ; top:0px; width:75%; height:30%; background-color:#708391; border-radius:4px; visibility:hidden;"></div>
        </div>
    </div>  
    
    <div>
    	<img src="images/bulletin_icon.png" style="position:absolute; left:250px; bottom:5px; width:48px; height:40px;"/>
    	<marquee id="scroll_txt" class="bulletin_text" style="width:917px;"></marquee>
	</div>
      
</div>
</body>
</html>
<script type="text/javascript" src="js/focus_logic.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<script type="text/javascript">
	var area0,area1;
	var menu_urls = ["portal.jsp","live.jsp","vod.jsp","favorite.jsp",""];
	var _t;
	var category_list = new Array();

	var cookie_focus = "theme";
	var _focusArr = get_focus(cookie_focus,[0,4,1]);
	delCookie(cookie_focus);
	window.onload = function(){
		loadElement();
		loadScrollTxt();
		setTimeout("window.focus()",1);
	}
	function loadElement(){
		area0 = focus_logic.loadElements(5,1,"nav_","_nav _nav_focus","_nav",[-1,-1,-1,1]);
		area1 = focus_logic.loadElements(2,3,"area1_","theme_choose_focus","theme_choose",[-1,0,-1,-1]);
		setAreaAttr();
		loadData();
		focus_logic.page.setCurrentFocus(_focusArr[0],_focusArr[1]);
	}
	function setAreaAttr(){
		//----------------------------------------------area0
		area0.curDomIndex = 4;
		area0.doms[4].blurClassName = "_nav _nav_select";
		area0.okEvent = function(){
			window.location.href = menu_urls[area0.curDomIndex];
		}
		//----------------------------------------------area1
		area1.doms[0].moveRule = [-1,[0,4],-1,-1];
		area1.doms[3].moveRule = [-1,[0,4],-1,-1];
		area1.pageNumber = _focusArr[2];
		area1.okEvent = function(){
			set_focus(cookie_focus);
			var _offset = (area1.pageNumber-1)*area1.domsMaxLength;
			//window.location.href = "theme_list.jsp?category_id="+category_list[area1.curDomIndex+_offset].category_id;
			window.location.href = "theme_list.jsp?category_id="+category_list[area1.curDomIndex+_offset].category_id+"&cat_pic_path="+escape(category_list[area1.curDomIndex+_offset].category_picPath_0);

		}
		area1.pageTurnEvent = function(){
			bindData();
		}
		//----------------------------------------------page
		focus_logic.page.backEvent = function(){
			window.location.href = "../index.jsp?backFlag=1";
		}
	}
	
	function loadData(){
		focus_logic.getDataByAjax("<%=data_path%>?Action=vod_categories&category_id=<%=theme_code%>&len_px=140&posterflag=1",load_category_list);
	}
	
	function load_category_list(result){
		category_list = eval('('+result+')');
		area1.setDataCount(category_list.length,"nav0_");
		
		if(category_list.length>6){
			$("scoller").style.visibility="visible";	
		}else{
			$("scoller").style.visibility="hidden";		
		}
	
		area1.setAttrForDomsTxt(category_list,"category_name","cut_category_name",1,"area1_txt_");
		bindData();
	}
	function bindData(){
		var _offset = (area1.pageNumber-1)*area1.domsMaxLength;
		for(var i=0;i<area1.domsCount;i++){
			if(category_list[i].category_picPath != ""){
				$("area1_img_"+i).src = category_list[i+_offset].category_picPath;
			}
		}
		var tmpPage_1 = area1.pageNumber==1?0:(area1.pageNumber-1);
		var tmpPage_2 = area1.pageTotal==1?1:(area1.pageTotal-1);
		$("scoller").style.top = parseInt((tmpPage_1/tmpPage_2)*346)+"px";
	}
	
	function menu_change(){
		if(menu_urls[area0.curDomIndex] != ""){
			window.location.href = menu_urls[area0.curDomIndex];
		}
	}
	function exit_page(){}
	function loadScrollTxt(){
		focus_logic.getDataByAjax("<%=data_path%>?Action=vod_categories&category_id=<%=scroll_txt_code%>&length=1",load_scroll_txt);
	}
	
	function load_scroll_txt(result){
		var scroll_obj = eval('('+result+')');
		if(scroll_obj.length>0){
			$("scroll_txt").innerHTML = scroll_obj[0].category_introduce;
		}
	}
</script>