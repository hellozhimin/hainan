<%@ include file = "config/param.jsp"%>
<%@ include file = "config/code.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
<title>点播</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<style>
	.left_top_0{
		position:absolute; 
		left:235px; 
		top:80px; 
		width:232px; 
		height:421px;
	}
	.left_top_0 .item{}
	.left_top_0 .item_focus img{
		position:relative;
		z-index:10;
		width:262px;
		height:474px;
		left:-15px;
		top:-27px;
	}
	.left_top_0 .item_focus_IE{
		position:relative;
		left:-4px;
		top:-4px;
		width:232px;
		border:#00F solid 4px;
	}
	.left_top_0 .item_focus div{
	 	background:url(images/vod_top_0.png) no-repeat;
	}
	.left_top_1{
		position:absolute; 
		left:477px; 
		top:80px; 
		width:491px; 
		height:276px;
	}
	.left_top_1 .item{}
	.left_top_1 .item_focus img{
		position:relative;
		z-index:10;
		width:531px;
		height:307px;
		left:-20px;
		top:-16px;
	}
	.left_top_1 .item_focus_IE{
		position:relative;
		left:-4px;
		top:-4px;
		width:491px;
		border:#00F solid 4px;
	}
	.left_top_1 .item_focus div{
		background:url(images/vod_top_1.png) no-repeat;
	}
	.left_top_2{
		position:absolute; 
		left:978px; 
		top:80px;
	}
	.left_top_2 .item{}
	.left_top_2 .item_focus img{
		position:relative;
		z-index:10;
		width:261px;
		height:307px;
		left:-15px;
		top:-17px;
	}
	.left_top_2 .item_focus_IE{
		position:relative;
		left:-4px;
		top:-4px;
		width:231px;
		border:#00F solid 4px;
	}

	.left_top_2 .item_focus div{
		background:url(images/vod_top_2.png) no-repeat
	}
	.left_bottom_0{
		position:absolute; 
		left:235px; 
		top:511px;
	}
	.left_bottom_0 .item{}
	.left_bottom_0 .item_focus img{
		position:relative;
		z-index:10;
		width:262px;
		height:145px;
		left:-15px;
		top:-8px;
	}
	.left_bottom_0 .item_focus_IE{
		position:relative;
		left:-4px;
		top:-4px;
		width:231px;
		border:#00F solid 4px;
	}
	.left_bottom_0 .item_focus div{
		background:url(images/vod_bottom_0.png) no-repeat;
	}
	.left_bottom{
		position:absolute; 
		left:477px; 
		top:366px;
	}
	.left_bottom .item{}
	.left_bottom .item_focus img{
		position:relative;
		z-index:10;
		width:261px;
		height:307px;
		left:-15px;
		top:-17px;
	}
	.left_bottom .item_focus_IE{
		position:relative;
		left:-4px;
		top:-4px;
		width:240px;
		border:#00F solid 4px;
	}
	.left_bottom .item_focus div{
		background:url(images/vod_top_2.png) no-repeat
	}
	
</style>
</head>

<body bgcolor="transparent" onUnload="exit_page();" >
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
    <!--C2 - football_star-->
    <div class="left_top_0">
        <div id="area1_0" class="item">
			<div style="position:absolute; width:295px; height:523px; left:-31px; top:-63px; z-index:10;"></div>        
            <img id="img_0" width="232" height="421">
        </div>
    </div>
    <!--C3 - news-->
    <div class="left_top_1">
        <div id="area1_1" class="item">
			<div style="position:absolute; width:613px; height:354px; left:-55px; top:-42px; z-index:10; "></div>        
            <img id="img_1" width="491" height="276"/>
        </div>
    </div>
    <!--C4 - Column_essence-->
    <div class="left_top_2">
        <div id="area1_2" class="item">
			<div style="position:absolute; width:317px; height:350px; left:-31px; top:-42px; z-index:10;"></div>        
            <img id="img_2" width="231" height="276">
        </div>
    </div>
    <!--C5 - shooter_list-->
    <div class="left_bottom_0">
        <div id="area2_0" class="item">
        	<div style="position:absolute; width:297px; height:189px; left:-31px; top:-21px; z-index:10;"></div>
            <img id="img_3" width="232" height="129" >
       </div>
   </div>
   <div class="left_bottom">
    <!--C6 - group_match-->
        <div id="area2_1" class="item" style="position:absolute;">
			<div style="position:absolute; width:317px; height:350px; left:-31px; top:-42px; z-index:10;"></div>        
            <img id="img_4" width="240" height="273">
        </div>
        <!--C7 - shoot_out-->
        <div id="area2_2" class="item" style="position:absolute;left:251px;">
        	<div style="position:absolute; width:317px; height:350px; left:-31px; top:-42px; z-index:10;"></div>
            <img id="img_5" width="240" height="273" >
        </div>
        <!--C8 - all_overmatch-->
        <div id="area2_3" class="item" style="position:absolute;left:502px;">
        	<div style="position:absolute; width:317px; height:350px; left:-31px; top:-42px; z-index:10;"></div>
            <img id="img_6" width="231" height="273">
        </div>
    </div>
    <!--bulletin-->
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
	var area0,area1,area2;
	var menu_urls = ["portal.jsp","live.jsp","","favorite.jsp","theme.jsp"];
	var content_urls = ["vod_list.jsp","vod_list.jsp","vod_list.jsp","vod_list.jsp","vod_list.jsp","vod_list.jsp","vod_list.jsp"];
	var codes = ["<%=vod_star_code%>","<%=vod_news_code%>","<%=vod_ColumnEssence_code%>","<%=vod_scorer_code%>","<%=vod_honour_code%>","<%=vod_opening_closing_ceremony_code%>","<%=vod_overmatch_code%>"];
	var vod_pic_data = new Object();
	var _t;
	var cookie_focus = "vod";
	var _focusArr = get_focus(cookie_focus,[0,2,1]);
	delCookie(cookie_focus);
	window.onload = function(){
		loadElement();
		loadData();
		loadScrollTxt();
		setTimeout("window.focus()",1);
	}
	function loadElement(){
		area0 = focus_logic.loadElements(5,1,"nav_","_nav _nav_focus","_nav",[-1,-1,-1,1]);
		if(navigator.userAgent.indexOf("MSIE 6.0") == -1){
			area1 = focus_logic.loadElements(1,3,"area1_","item item_focus","item",[-1,0,2,-1]);
		    area2 = focus_logic.loadElements(1,4,"area2_","item item_focus","item",[1,0,-1,-1]);
		}else {
			area1 = focus_logic.loadElements(1,3,"area1_","item item_focus_IE","item",[-1,0,2,-1]);
		    area2 = focus_logic.loadElements(1,4,"area2_","item item_focus_IE","item",[1,0,-1,-1]);	
			area2.focusEvent = function(){
				for(var i=1;i<4;i++){
					area2.doms[i].element.style.left = (i-1)*251+"px";
				}
				if(area2.curDomIndex>0){
					if(area2.curDomIndex==3){
						area2.doms[area2.curDomIndex].element.style.width = "231px";
					}else{
						area2.doms[area2.curDomIndex].element.style.width = "240px";
					}
					area2.doms[area2.curDomIndex].element.style.left = -4+(area2.curDomIndex-1)*251+"px";
				}
			}
			area2.areaOutEvent = function(){
				for(var i=1;i<4;i++){
					area2.doms[i].element.style.left = (i-1)*251+"px";
				}
			}
		}
		
		setAreaAttr();
		focus_logic.page.setCurrentFocus(parseInt(_focusArr[0]),parseInt(_focusArr[1]));
	}
	function setAreaAttr(){
		//----------------------------------------------area0
		area0.curDomIndex = 2;
		area0.doms[2].blurClassName = "_nav _nav_select";
		area0.okEvent = function(){
			window.location.href = menu_urls[area0.curDomIndex];
		}
		//----------------------------------------------area1
		area1.doms[0].moveRule = [-1,[0,2],-1,-1];
		area1.doms[1].moveRule = [-1,-1,[2,1],-1];
		area1.doms[2].moveRule = [-1,-1,[2,3],-1];
		area1.okEvent = function(){
			set_focus(cookie_focus);
			window.location.href = content_urls[area1.curDomIndex]+"?category_id="+codes[area1.curDomIndex];
		}
		//----------------------------------------------area2
		area2.doms[0].moveRule = [-1,[0,2],-1,-1];
		area2.doms[1].moveRule = [[1,1],-1,-1,-1];
		area2.doms[2].moveRule = [[1,1],-1,-1,-1];
		area2.doms[3].moveRule = [[1,2],-1,-1,-1];
		area2.okEvent = function(){
			set_focus(cookie_focus);
			window.location.href = content_urls[area2.curDomIndex+3]+"?category_id="+codes[area2.curDomIndex+3];
		}
		//--------------------------------------------------page
		focus_logic.page.backEvent = function(){
			window.location.href = "../index.jsp?backFlag=1";
		}
	}
	function loadData(){
		focus_logic.getDataByAjax("<%=data_path%>?Action=vod_categories&category_id=<%=vod_pic_code%>&posterflag=0&length=10",load_vod_pic);
	}
	function load_vod_pic(result){
		vod_pic_data = eval('('+result+')');
		for(var i=0;i<vod_pic_data.length;i++){
			var tmp_category_id = vod_pic_data[i].category_id;
			if(tmp_category_id=="<%=vod_star_code%>"){
				$("img_0").src = vod_pic_data[i].category_picPath;
			}else if(tmp_category_id=="<%=vod_news_code%>"){
				$("img_1").src = vod_pic_data[i].category_picPath;
			}else if(tmp_category_id=="<%=vod_ColumnEssence_code%>"){
				$("img_2").src = vod_pic_data[i].category_picPath;
			}else if(tmp_category_id=="<%=vod_scorer_code%>"){
				$("img_3").src = vod_pic_data[i].category_picPath;
			}else if(tmp_category_id=="<%=vod_honour_code%>"){
				$("img_4").src = vod_pic_data[i].category_picPath;
			}else if(tmp_category_id=="<%=vod_opening_closing_ceremony_code%>"){
				$("img_5").src = vod_pic_data[i].category_picPath;
			}else if(tmp_category_id=="<%=vod_overmatch_code%>"){
				$("img_6").src = vod_pic_data[i].category_picPath;
			}
		}
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