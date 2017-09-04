<%@ include file = "config/param.jsp"%>
<%@ include file = "config/code.jsp"%>
<%
	String category_id = request.getParameter("category_id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
<title>奖牌榜</title>
<link rel="stylesheet" href="css/public.css">
<style type="text/css">
.container{
	background:url(images/bg_l_1.png);
	width:1280px;
	height:720px;
	top:0px;
	left:0px;
	color:#FFF;
}
.content_bg{
	position:absolute;
	background:url(images/scorer_content_bg.png);
	width:1064px;
	height:556px;
	left: 114px;
	top: 110px;
}
.content_bg span{
	position:absolute;
	top:10px;
	font-size:28px;
}
.content{
	position:absolute;
	width:1064px;
	height:498px;
	left:114px;
	top:168px;
	font-size:28px;
}
.content .item{
	position:absolute;
	width:1155px;
	height:50px;
	line-height:50px;
}
.content .item .scorer_num{
	position:absolute;
	top:9px;
	left:49px;
	text-align:center;
	width: 50px;
}
.content .item_focus .scorer_num{
	position:absolute;
	top:9px;
	left:30px;
	text-align:center;
	width: 50px;
}
.content .item>span{
	position:absolute;
	left: 103px;
	width:423px;
	text-align:center;
	top: -1px;
}
.content .item_focus>span{
	color:#fcff00;
}
</style>
</head>

<body bgcolor="transparent">

<div class="container">

	<div style=" font-size: 34px;font-weight: bold;position: absolute;top: 39px;left: 79px;" >奖牌榜</div>
    
    <div style="left:1052px;top:14px;position:absolute;height:78px;width: 176px;"></div>
    
    <img id="area0_0" width="1065px;" height="557px;" style="position:absolute;left:114px;top:110px;" src="images/nav_0.png" />
    
</div>
</body>
</html>
<script type="text/javascript" src="js/focus_logic.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<script type="text/javascript">
	var area0;
	var category_list = new Array();
	var cookie_cat_id = "scorer_category_id";
	
	window.onload = function(){
		loadElement();
		setTimeout("window.focus()",1);
	}
	function loadElement(){
		area0 = focus_logic.loadElements(1,1,"area0_","item item_focus","item",[-1,-1,-1,-1]);
		setAreaAttr();
		loadData();
		focus_logic.page.setCurrentFocus(0,0);		
	}
	function setAreaAttr(){
		//----------------------------------------------area0
		area0.objFocus = ["scorer_focus",[0,-26],[0,-18],0];
		
		//----------------------------------------------page
		focus_logic.page.backEvent = function(){
			delCookie(cookie_cat_id);
			window.location.href = "vod.jsp";
		}
	}
	
	function loadData(){
		focus_logic.getDataByAjax("<%=data_path%>?Action=vod_categories&category_id=<%=vod_pic_code%>&posterflag=2&length=10",load_category_list);
	}
	
	function load_category_list(result){
		category_list = eval('('+result+')');
		area0.setDataCount(1);
		bindData();
	}
	
	function bindData(){
		for(var i=0;i<category_list.length;i++){
			var tmp_category_id = category_list[i].category_id;
			if(tmp_category_id=="<%=vod_scorer_code%>"){
				$("area0_0").src = category_list[i].category_picPath;
			}
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
</script>
