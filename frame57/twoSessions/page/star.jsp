<%@ include file = "config/param.jsp"%>
<%
	String category_id = request.getParameter("category_id");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
<title>大明星</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<style>
.star_box{
	position:absolute;
	width:154px;
	height:273px;
}
.star_choose{
	position:absolute;
	left:0px;
}
.star_img{
	position:absolute;
	left:0px;
	top:0px;
}
.star_choose>.star_img{
	width:154px;
	height:212px;
}
.star_choose_focus{
	position:absolute;
	left:-8px;
	top:-8px;
	width:164px;
	height:222px;
	border:4px solid #e7fc00;
	border-radius:3px;
}
.star_choose_focus>.star_img{
	width:164px;
	height:222px;
}
.star_font24{
	width:100%;
	position:absolute;
	bottom:15px;
	text-align:center;
	font-family:"微软雅黑";
	font-size:24px;
	line-height:26px;
	color:#fff;
}
</style>
</head>

<body  bgcolor="transparent">
<div style="position:absolute; top:0px; left:0px; width:1280px; height:720px; ">
	<img src="images/bg_l_1.png" />
    <!--C2-->
    <div class="topsign">大明星</div>
    <!--C2_a2-->
    <div style="position:absolute; left:98px; top:114px; width:1116px; height:527px;">
    	<!--star_boxs-->
    	<div class="star_box" style="left:0px; top:0px;" id="nav0_0">
        	<div class="star_choose" id="area0_0">
	            <img id="area0_img_0" width="154px;" height="212px;" src="" class="star_img">
            </div>
            <span class="star_font24" id="area0_txt_0"></span>
        </div>
    	<div class="star_box" style="left:230px; top:0px;" id="nav0_1">
        	<div class="star_choose" id="area0_1">
 	           <img id="area0_img_1" width="154px;" height="212px;" src="" class="star_img">           
            </div>
            <span class="star_font24" id="area0_txt_1"></span>
        </div>
    	<div class="star_box" style="left:460px; top:0px;" id="nav0_2">
        	<div class="star_choose" id="area0_2">
 	           <img id="area0_img_2" width="154px;" height="212px;" src="" class="star_img">           
            </div>
            <span class="star_font24" id="area0_txt_2"></span>
        </div>
    	<div class="star_box" style="left:690px; top:0px;" id="nav0_3">
        	<div class="star_choose" id="area0_3">
 	           <img id="area0_img_3" width="154px;" height="212px;" src="" class="star_img">           
            </div>
            <span class="star_font24" id="area0_txt_3"></span>
        </div>
    	<div class="star_box" style="left:920px; top:0px;" id="nav0_4">
        	<div class="star_choose" id="area0_4">
 	           <img id="area0_img_4" width="154px;" height="212px;" src="" class="star_img">           
            </div>
            <span class="star_font24" id="area0_txt_4"></span>
        </div>
    	<div class="star_box" style="left:0px; top:271px;" id="nav0_5">
        	<div class="star_choose" id="area0_5">
 	           <img id="area0_img_5" width="154px;" height="212px;" src="" class="star_img">           
            </div>
            <span class="star_font24" id="area0_txt_5"></span>
        </div>
    	<div class="star_box" style="left:230px; top:271px;" id="nav0_6">
        	<div class="star_choose" id="area0_6">
 	           <img id="area0_img_6" width="154px;" height="212px;" src="" class="star_img">           
            </div>
            <span class="star_font24" id="area0_txt_6"></span>
        </div>
    	<div class="star_box" style="left:460px; top:271px;" id="nav0_7">
        	<div class="star_choose" id="area0_7">
 	           <img id="area0_img_7" width="154px;" height="212px;" src="" class="star_img">           
            </div>
            <span class="star_font24" id="area0_txt_7"></span>
        </div>
    	<div class="star_box" style="left:690px; top:271px;" id="nav0_8">
        	<div class="star_choose" id="area0_8">
 	           <img id="area0_img_8" width="154px;" height="212px;" src="" class="star_img">           
            </div>
            <span class="star_font24" id="area0_txt_8"></span>
        </div>
    	<div class="star_box" style="left:920px; top:271px;" id="nav0_9">
        	<div class="star_choose" id="area0_9">
 	           <img id="area0_img_9" width="154px;" height="212px;" src="" class="star_img">           
            </div>
            <span class="star_font24" id="area0_txt_9"></span>
        </div>
        <!--slider-->
        <div style="position:absolute; right:0px; top:0px; width:8px; height:100%; background-color:#16273d; opacity:0.8; border-radius:4px;">
        	<div id="scoller" style="position:absolute; left:1px; ; top:368px; width:75%; height:30%; background-color:#708391; border-radius:4px;visibility:hidden;"></div>
        </div>
    </div>    
</div>
</body>
</html>
<script type="text/javascript" src="js/focus_logic.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<script type="text/javascript">
	var area0;
	var category_list = new Array();
	var cookie_cat_id = "star_category_id";
	var cookie_focus = "star";
	var _focusArr = get_focus(cookie_focus);
	
	window.onload = function(){
		loadElement();
		setTimeout("window.focus()",1);
	}
	function loadElement(){
		area0 = focus_logic.loadElements(2,5,"area0_","star_choose_focus","star_choose",[-1,-1,-1,-1]);
		setAreaAttr();
		loadData();
		focus_logic.page.setCurrentFocus(_focusArr[0],_focusArr[1]);
	}
	function setAreaAttr(){
		//----------------------------------------------area0
		area0.pageNumber = _focusArr[2];
		area0.okEvent = function(){
			set_focus(cookie_focus);
			var _offset = (area0.pageNumber-1)*area0.domsMaxLength;
			window.location.href = "star_content.jsp?category_id="+category_list[area0.curDomIndex+_offset].category_id+"&cat_pic_path="+escape(category_list[area0.curDomIndex+_offset].category_picPath_0);
		}
		area0.pageTurnEvent = function(){
			bindData();
		}
		//----------------------------------------------page
		focus_logic.page.backEvent = function(){
			delCookie(cookie_focus);
			delCookie(cookie_cat_id);
			window.location.href = "vod.jsp";
		}
	}
	function loadData(){
		focus_logic.getDataByAjax("<%=data_path%>?Action=vod_categories&category_id="+load_category_id()+"&len_px=100&posterflag=2",load_category_list);
	}
	
	function load_category_list(result){
		category_list = eval('('+result+')');
		area0.setDataCount(category_list.length,"nav0_");
		if(category_list.length>10){
			$("scoller").style.visibility="visible";	
		}else{
			$("scoller").style.visibility="hidden";		
		}
	
		area0.setAttrForDomsTxt(category_list,"category_name","cut_category_name",1,"area0_txt_");
		bindData();
	}
	
	function bindData(){
		var _offset = (area0.pageNumber-1)*area0.domsMaxLength;
		for(var i=0;i<area0.domsCount;i++){
			if(category_list[i].category_picPath != ""){
				$("area0_img_"+i).src = category_list[i+_offset].category_picPath;
			}
		}
		var tmpPage_1 = area0.pageNumber==1?0:(area0.pageNumber-1);
		var tmpPage_2 = area0.pageTotal==1?1:(area0.pageTotal-1);
		$("scoller").style.top = parseInt((tmpPage_1/tmpPage_2)*368)+"px";
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
</script>