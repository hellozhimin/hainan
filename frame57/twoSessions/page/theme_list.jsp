<%@ include file = "config/param.jsp"%>
<%
	String category_id = request.getParameter("category_id");//
	String cat_pic_path = request.getParameter("cat_pic_path");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
<title>专题详情页</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<style>
.overmatch_content_choose,.overmatch_content_list,.overmatch_content_list_focus{
	position:absolute;
}
.overmatch_content_choose{
	left:0px;
	width:550px;
	height:100px;
	}
.overmatch_content_list{
	left:0px;
	top:0px;
	width:550px;
	height:26px;
	font-size:24px;
	line-height:26px;
	color:#00F;
}
.overmatch_content_list_focus{
	left:-40px;
	top:-35px;
	width:584px;
	height:100px;
	font-size:26px;
	line-height:100px;
	color:#FFF;
	text-shadow:1px 1px 3px #000;
	text-align:center;
	background-image:url(images/star_content_focus.png);
}
</style>
</head>

<body  bgcolor="transparent">
<div style="position:absolute; top:0px; left:0px; width:1280px; height:720px; ">
	<!--C2_a3-->
	<img id="bg" src="" width="1280px;" height="720px;" />
    <!--C2_a3_1-->
    <div style="position:absolute; left:56px; top:82px; width:550px; height:558px; letter-spacing:1px;">
    	<!--list_up&down-->
        <img src="images/page_up.png" style="position:absolute; top:-10px; left:224px;">
        <img src="images/page_down.png" style="position:absolute; bottom:-10px; left:224px;">
    	<!--news_list-->
        <div class="overmatch_content_choose" style="top:26px;">
    		<div id="overmatch_content_0" class="overmatch_content_list"></div>
        </div>
        <div class="overmatch_content_choose" style="top:84px;">
    		<div id="overmatch_content_1" class="overmatch_content_list"></div>
        </div>
        <div class="overmatch_content_choose" style="top:143px;">
    		<div id="overmatch_content_2" class="overmatch_content_list"></div>
        </div>
        <div class="overmatch_content_choose" style="top:206px;">
    		<div id="overmatch_content_3" class="overmatch_content_list"></div>
        </div>
        <div class="overmatch_content_choose" style="top:261px;">
			<div id="overmatch_content_4" class="overmatch_content_list"></div>
        </div>
        <div class="overmatch_content_choose" style="top:320px;">
    		<div id="overmatch_content_5" class="overmatch_content_list"></div>
        </div>
        <div class="overmatch_content_choose" style="top:379px;">
    		<div id="overmatch_content_6" class="overmatch_content_list"></div>
        </div>
        <div class="overmatch_content_choose" style="top:438px;">
    		<div id="overmatch_content_7" class="overmatch_content_list"></div>
        </div>
        <div class="overmatch_content_choose" style="top:496px;">
    		<div id="overmatch_content_8" class="overmatch_content_list"></div>
        </div>
    </div>

</div>
<div id="_test" style="position:absolute; left:100px; top:100px; color:#f00;"></div>
</body>
</html>
<script type="text/javascript" src="js/focus_logic.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<script type="text/javascript">
	var area0;
	var content_list = new Array();
	var cookie_cat_id = "theme_list_category_id";
	var cookie_cat_pic_path = "theme_list_pic_path";
	var cookie_focus = "theme_list";
	var _focusArr = get_focus(cookie_focus);
	
	window.onload = function(){
		loadElement();
		setTimeout("window.focus()",1);
	}
	function loadElement(){
		area0 = focus_logic.loadElements(9,1,"overmatch_content_","overmatch_content_list_focus","overmatch_content_list",[-1,-1,-1,-1]);
		setAreaAttr();
		loadData();
		load_bg();
		focus_logic.page.setCurrentFocus(_focusArr[0],_focusArr[1]);
	}
	function setAreaAttr(){
		//----------------------------------------------area0
		area0.setMarqueeWidth(540);
		area0.pageNumber = _focusArr[2];
		area0.okEvent = function(){
			set_focus(cookie_focus);
			if(content_list.length>0){
				var _offset = (area0.pageNumber-1)*area0.domsMaxLength;
				window.location.href = "goto_play.jsp?action=out&returnUrl=theme_list.jsp&vodId="+content_list[area0.curDomIndex+_offset].vodId+"&columncode="+load_category_id();
			}
		}
		//----------------------------------------------page
		focus_logic.page.backEvent = function(){
			delCookie(cookie_focus);
			delCookie(cookie_cat_id);
			delCookie(cookie_cat_pic_path);
			window.location.href = "theme.jsp";
		}
	}
	function loadData(){
		focus_logic.getDataByAjax("<%=data_path%>?Action=vodList&subCategoryId="+load_category_id()+"&len_px=300",load_content_list);
	}
	function load_content_list(result){
		content_list = eval('('+result+')');
		area0.setDataCount(content_list.length);
		area0.setAttrForDomsTxt(content_list,"vodName","cut_vodName",1);
	}
	
	function load_bg(){
		if(load_cat_pic_path()!=null && load_cat_pic_path()!="null" &&load_cat_pic_path()!="" && load_cat_pic_path()!="../../"){
			$("bg").src = load_cat_pic_path();
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
	
	function load_cat_pic_path(){
		var cat_pic_path;
		if("<%=cat_pic_path%>" == "null"){
			cat_pic_path = getCookie(cookie_cat_pic_path);
		}else{
			cat_pic_path = "<%=cat_pic_path%>";
			setCookie(cookie_cat_pic_path,cat_pic_path);
		}
		return unescape(cat_pic_path);
	}
</script>

