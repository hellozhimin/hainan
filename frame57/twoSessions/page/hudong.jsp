<%@ include file = "config/param.jsp"%>
<%@ include file = "config/code.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
<title>点播</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<style>

</style>
</head>

<body bgcolor="transparent" onUnload="exit_page();" >
<div style="position:absolute; top:0px; left:0px; width:1280px; height:720px; ">
	<img src="images/hudong_bg.jpg" />
   <!-- <img id="logo" src="images/logo.png" style="left:66px; top:18px;">-->
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
        	<span id="navText_3" >专题</span>
        </div>
        <div id="nav_4" class="_nav" >
        	<img id="icon_4" src="images/navIcon_5.png">
        	<span id="navText_4" >互动</span>
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
	var area0;
	var menu_urls = ["portal.jsp","live.jsp","vod.jsp","theme.jsp",""];
	var _t;
	window.onload = function(){
		loadElement();
		loadScrollTxt();
		setTimeout("window.focus()",1);
	}
	function loadElement(){
		area0 = focus_logic.loadElements(5,1,"nav_","_nav _nav_focus","_nav",[-1,-1,-1,-1]);
		setAreaAttr();
		focus_logic.page.setCurrentFocus(0,4);
	}
	function setAreaAttr(){
		//----------------------------------------------area0
	area0.curDomIndex = 4;
	area0.doms[4].blurClassName = "_nav _nav_select";
		area0.okEvent = function(){
			window.location.href = menu_urls[area0.curDomIndex];
		}
		//--------------------------------------------------page
		focus_logic.page.backEvent = function(){
			window.location.href = "../index.jsp?backFlag=1";
		}
	}
	function menu_change(){
		if(menu_urls[area0.curDomIndex] != ""){
			window.location.href = menu_urls[area0.curDomIndex];
		}
	}
	
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