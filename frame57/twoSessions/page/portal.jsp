<%@ include file = "config/param.jsp"%>
<%@ include file = "config/code.jsp"%>
<epg:PageController name="portal.jsp"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
<title>首页</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<style>

.rolling_main{
	position:absolute;
	left:235px; 
	top:80px; 
	width:359px; 
	height:370px;
}
.rolling_main_focus{
	z-index:10;
}
.rolling_main_focus_IE{
	left:231px;
	top:76px;
	border:#00F solid 4px;
}
.rolling_main_focus>img{
	position:relative;
	z-index:10;
	width:400px;
	height:414px;
	top:-22px;
	left:-21px;
}
.rolling_main_focus .rolling_focus{
	background:url(images/portal_a3_focus.png);
}
.main_middle,.main_middle_focus,.main_middle_img_focus,.main_right{
	position:absolute;
}
.main_left{left:235px; top:459px;}
.main_left_focus{
	width:410px;
	height:210px;
	z-index:10;
}
.main_left_focus_IE{
	left:231px;
	top:455px;
	border:#00F solid 4px;
}
.main_left_focus div{
	background-image:url(images/mainmiddle_focus_bg.png);
}
.main_left_focus img{
	width:396px;
	height:200px;
	position:relative;
	top:-8px;
	left:-20px;
}
.main_middle{left:604px;top:270px;}
.main_middle_focus{
	width:410px;
	height:210px;
	left:583px;/*-31*/
	z-index:10;
}
.main_middle_focus_IE{
	left:600px;
	top:266px;
	width:358px;
	border:#00F solid 4px;
}
.main_middle_focus div{
	background-image:url(images/mainmiddle_focus_bg.png);
}
.main_middle_focus img{
	width:396px;
	height:200px;
	position:relative;
	top:-18px;
	left:2px;
}
.main_middle_img_focus{
	 width:91%;
	 height:84%;
	 left:19px;
	 top:22px;
}
.main_right{left:972px;}
.main_right_focus{
	left:962px
}
.main_right_focus_IE{
	left:968px;
	top:266px;
	border:#00F solid 4px;
}
.main_right_focus img{
	position:relative;
	top:-12px;
	left:-5px;
	width:272px;
	height:204px;
	z-index:10;
}
.main_right_focus div{
	background:url(images/portal_a6_focus.png) no-repeat;
}
</style>
</head>

<body  bgcolor="transparent" onUnload="exit_page();">
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
        <div id="nav_4" class="_nav">
        	<img id="icon_4" src="images/navIcon_5.png">
        	<span id="navText_4" >专题</span>
        </div>
	</div>
    <!--A3 - rolling_main-->
    <div id="rolling_main_0" class="rolling_main">
        <img id="rolling_main_img_0" src="" width="358" height="370">
        <div class="rolling_focus" style="position:absolute; width:418px; height:431px; left:-37px; top:-38px;z-index:10;"></div>
        <div style="position:absolute; width:160px; height:20px; left: 148px; top: 325px; line-height:20px;z-index:11;">
            <img id="pic_changer_0" src="images/mian_pic_changer.png" width="11px" height="11px;" style="left:0px;"/>&nbsp&nbsp
            <img id="pic_changer_1" src="images/mian_pic_changer.png" width="11px" height="11px;" style="left:24px;"/>&nbsp&nbsp
            <img id="pic_changer_2" src="images/mian_pic_changer.png" width="11px" height="11px;" style="left:48px;"/>
        </div>
    </div>
    <!--A4 - main_left-->
<div id="main_left_0" class="main_left" style="position:absolute; left:235px; top:459px; width:359px; height:180px;">
        <div style="position:absolute;width:430px;height:230px;left:-36px;top:-25px;"></div>
        <img id="main_left_img_0" src="" width="358" height="180"/>
    </div>
    <!--A5 - main_middle-->
  <div id="main_middle_0" class="main_middle" style="top:80px;">
<div style="position:absolute;width:430px;height:230px;left:-15px;top:-34px;"></div>
        <img id="main_middle_img_0" src="" width="358" height="180">
    </div>
<div id="main_middle_1" class="main_middle" style="top:270px;">
    	<div style="position:absolute;width:430px;height:230px;left:-15px;top:-34px;"></div>
        <img id="main_middle_img_1" src="" width="358" height="180"> 	
    </div>
    <div id="main_middle_2" class="main_middle" style="top:460px;">
   	  <div style="position:absolute;width:430px;height:230px;left:-15px;top:-34px;"></div>
        <img id="main_middle_img_2" src="" width="358" height="180">
    </div>
    <!--A6 - main_right-->
    <div id="main_right_0" class="main_right" style="top:80px;">
		<div style="position:absolute; width:308px; height:244px; left:-23px; top:-30px; z-index:10;"></div>        
        <img id="main_right_img_0" src="" width="241" height="180">
    </div>
<div id="main_right_1" class="main_right" style="top:270px;">
		<div style="position:absolute; width:308px; height:244px; left:-23px; top:-30px; z-index:10;"></div> 
        <img id="main_right_img_1" src="" width="241" height="180"> 	
    </div>
    <div id="main_right_2" class="main_right" style="top:460px;">
    	<div style="position:absolute; width:308px; height:244px; left:-23px; top:-30px; z-index:10;"></div> 
        <img id="main_right_img_2" src="" width="241" height="180">
    </div>
    <!--bulletin-->
    <div>
    	<img src="images/bulletin_icon.png" style="position:absolute; left:250px; bottom:5px; width:48px; height:40px;"/>
    	<marquee id="scroll_txt" class="bulletin_text" style="width:917px;"></marquee>
	</div>
</div>
<div id="_test" style="color:red; position:absolute; top:20px; left:162px;"></div>
</body>
</html>
<%
	String isFirstIn = request.getParameter("isFirstIn")==null?"0":"1";
%>
<script type="text/javascript" src="js/focus_logic.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<script type="text/javascript">
	var area0,area1,area2,area3,area4;
	var menu_urls = ["","live.jsp","vod.jsp","favorite.jsp","theme.jsp"];
	var _count = 2;
	var _t;
	var roll_pic_count = 3;
	
	var big_pic_data = new Array();
	var middle_pic_data = new Array();
	var small_pic_data = new Array();

	var cookie_focus = "portal";
	var _focusArr = get_focus(cookie_focus);
	if("<%=isFirstIn%>"==1){
		_focusArr = [0,0,1];
	}
	clear_cookies();
	
	window.onload = function(){
		loadElement();
		loadData();
		rolling_pic();
		loadScrollTxt();
		setTimeout("window.focus()",1);
	}
	function loadElement(){
		area0 = focus_logic.loadElements(5,1,"nav_","_nav _nav_focus","_nav",[-1,-1,-1,1]);
		if(navigator.userAgent.indexOf("MSIE 6.0") == -1){
			area1 = focus_logic.loadElements(1,1,"rolling_main_","rolling_main rolling_main_focus","rolling_main",[-1,0,2,3]);
			area2 = focus_logic.loadElements(1,1,"main_left_","main_left main_left_focus","main_left",[1,0,-1,3]);
			area3 = focus_logic.loadElements(3,1,"main_middle_","main_middle main_middle_focus","main_middle",[-1,1,-1,4]);
			area4 = focus_logic.loadElements(3,1,"main_right_","main_right main_right_focus","main_right",[-1,3,-1,-1]);
		}else{
			area1 = focus_logic.loadElements(1,1,"rolling_main_","rolling_main rolling_main_focus_IE","rolling_main",[-1,0,2,3]);
			area2 = focus_logic.loadElements(1,1,"main_left_","main_left main_left_focus_IE","main_left",[1,0,-1,3]);
			area3 = focus_logic.loadElements(3,1,"main_middle_","main_middle main_middle_focus_IE","main_middle",[-1,1,-1,4]);
			area3.focusEvent = function(){
				for(var i=0;i<3;i++){
					area3.doms[i].element.style.top = 80+i*190+"px";
				}
				area3.doms[area3.curDomIndex].element.style.top = 76+area3.curDomIndex*190+"px";
			}
			area3.areaOutEvent = function(){
				for(var i=0;i<3;i++){
					area3.doms[i].element.style.top = 80+i*190+"px";
				}
			}
			area4 = focus_logic.loadElements(3,1,"main_right_","main_right main_right_focus_IE","main_right",[-1,3,-1,-1]);
			area4.focusEvent = function(){
				for(var i=0;i<3;i++){
					area4.doms[i].element.style.top = 80+i*190+"px";
				}
				area4.doms[area4.curDomIndex].element.style.top = 76+area4.curDomIndex*190+"px";
			}
			area4.areaOutEvent = function(){
				for(var i=0;i<3;i++){
					area4.doms[i].element.style.top = 80+i*190+"px";
				}
			}
		}
		setAreaAttr();
		focus_logic.page.setCurrentFocus(_focusArr[0],_focusArr[1]);
	}
	function setAreaAttr(){
		//----------------------------------------------area0
		area0.curDomIndex = 0;
		area0.doms[0].blurClassName = "_nav _nav_select";
		area0.okEvent = function(){
			window.location.href = menu_urls[area0.curDomIndex];
		}
		//----------------------------------------------area1
		area1.okEvent = function(){
			set_focus(cookie_focus);
			window.location.href = "goto_play.jsp?action=out&returnUrl=portal.jsp&vodId="+big_pic_data[_count].vodId+"&columncode=<%=portal_big_pic_code%>";
		}
		//----------------------------------------------area2
		area2.doms[0].moveRule = [-1,-1,-1,[3,2]];
		area2.okEvent = function(){
			set_focus(cookie_focus);
			window.location.href = "goto_play.jsp?action=out&returnUrl=portal.jsp&vodId="+middle_pic_0_data[0].vodId+"&columncode=<%=portal_middle_pic_0_code%>";
		}
		//----------------------------------------------area3
		area3.doms[1].moveRule = [-1,-1,-1,[4,1]];
		area3.doms[2].moveRule = [-1,[2,0],-1,[4,2]];
		area3.doms[0].okEvent = function(){
			set_focus(cookie_focus);
			window.location.href = "goto_play.jsp?action=out&returnUrl=portal.jsp&vodId="+middle_pic_1_data[0].vodId+"&columncode=<%=portal_middle_pic_1_code%>";
		}
		area3.doms[1].okEvent = function(){
			set_focus(cookie_focus);
			window.location.href = "goto_play.jsp?action=out&returnUrl=portal.jsp&vodId="+middle_pic_2_data[0].vodId+"&columncode=<%=portal_middle_pic_2_code%>";
		}
		area3.doms[2].okEvent = function(){
			set_focus(cookie_focus);
			window.location.href = "goto_play.jsp?action=out&returnUrl=portal.jsp&vodId="+middle_pic_3_data[0].vodId+"&columncode=<%=portal_middle_pic_3_code%>";
		}
		//----------------------------------------------area4
		area4.doms[1].moveRule = [-1,[3,1],-1,-1];
		area4.doms[2].moveRule = [-1,[3,2],-1,-1];
		area4.doms[0].okEvent = function(){
			set_focus(cookie_focus);
			window.location.href = "goto_play.jsp?action=out&returnUrl=portal.jsp&vodId="+small_pic_0_data[0].vodId+"&columncode=<%=portal_small_pic_0_code%>";
		}
		area4.doms[1].okEvent = function(){
			set_focus(cookie_focus);
			window.location.href = "goto_play.jsp?action=out&returnUrl=portal.jsp&vodId="+small_pic_1_data[0].vodId+"&columncode=<%=portal_small_pic_1_code%>";
		}
		area4.doms[2].okEvent = function(){
			set_focus(cookie_focus);
			window.location.href = "goto_play.jsp?action=out&returnUrl=portal.jsp&vodId="+small_pic_2_data[0].vodId+"&columncode=<%=portal_small_pic_2_code%>";
		}
		//--------------------------------------------------page
		focus_logic.page.backEvent = function(){
			window.location.href = "../index.jsp?backFlag=1";
		}
	}
	function rolling_pic(){
		$("pic_changer_"+_count).style.width = "11px";
		$("pic_changer_"+_count).style.height = "11px";
		_count++;
		_count = _count%roll_pic_count;
		$("pic_changer_"+_count).style.width = "15px";
		$("pic_changer_"+_count).style.height = "15px";
		$("rolling_main_img_0").src = big_pic_data[_count].vod_picPath;
		setTimeout(rolling_pic,5000);
	}
	function menu_change(){
		if(menu_urls[area0.curDomIndex] != ""){
			window.location.href = menu_urls[area0.curDomIndex];
		}
	}
	function exit_page(){}
	
	function loadData(){
		focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId=<%=portal_big_pic_code%>&length=1",load_big_pic);
		focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId=<%=portal_middle_pic_0_code%>&length=1",load_middle_pic_0);
		focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId=<%=portal_middle_pic_1_code%>&length=1",load_middle_pic_1);
		focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId=<%=portal_middle_pic_2_code%>&length=1",load_middle_pic_2);
		focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId=<%=portal_middle_pic_3_code%>&length=1",load_middle_pic_3);
		focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId=<%=portal_small_pic_0_code%>&length=1",load_small_pic_0);
		focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId=<%=portal_small_pic_1_code%>&length=1",load_small_pic_1);
		focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId=<%=portal_small_pic_2_code%>&length=1",load_small_pic_2);
	}
	
	function load_big_pic(result){
		big_pic_data = eval('('+result+')');
		roll_pic_count = big_pic_data.length;
		for(var i=2;i>=big_pic_data.length;i--){
			$("pic_changer_"+i).style.visibility = "hidden";
		}
		if(roll_pic_count==1){
			$("pic_changer_0").style.visibility = "hidden";
		}
	}

	function load_middle_pic_0(result){
		middle_pic_0_data = eval('('+result+')');
		$("main_left_img_0").src = middle_pic_0_data[0].vod_picPath;
	}
	
	function load_middle_pic_1(result){
		middle_pic_1_data = eval('('+result+')');
		$("main_middle_img_0").src = middle_pic_1_data[0].vod_picPath;	
	}
	
	function load_middle_pic_2(result){
		middle_pic_2_data = eval('('+result+')');
		$("main_middle_img_1").src = middle_pic_2_data[0].vod_picPath;
	}
	
	function load_middle_pic_3(result){
		middle_pic_3_data = eval('('+result+')');
		$("main_middle_img_2").src = middle_pic_3_data[0].vod_picPath;
	}
	
	function load_small_pic_0(result){
		small_pic_0_data = eval('('+result+')');
		$("main_right_img_0").src = small_pic_0_data[0].vod_picPath;
	}
	
	function load_small_pic_1(result){
		small_pic_1_data = eval('('+result+')');
		$("main_right_img_1").src = small_pic_1_data[0].vod_picPath;
	}
	
	function load_small_pic_2(result){
		small_pic_2_data = eval('('+result+')');
		$("main_right_img_2").src = small_pic_2_data[0].vod_picPath;
	}
	
	function clear_cookies(){
		var cookie_names = ["portal","live","vod","favorite","favorite_content","vod","theme","theme_list","interaction","star","star_content","honour","ColumnEssence","overmatch","overmatch_content","news","opening_closing_ceremony","scorer","vod_list_code","favorite_list_title"];
		for(var i=0;i<cookie_names.length;i++){
			delCookie(cookie_names[i]);
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