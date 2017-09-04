<%@ include file = "config/param.jsp"%>
<%@ include file = "config/code.jsp"%>
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
	height:370px;"
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
.main_left{left:604px;top:270px;}
.main_left_focus{
	width:410px;
	height:210px;
	z-index:10;
}
.main_left_focus div{
	background-image:url(images/mainmiddle_focus_bg.png);
}
.main_left_focus img{
	width:400px;
	height:200px;
	position:relative;
	top:-5px;
	left:-21px;
}
.main_middle{left:604px;top:270px;}
.main_middle_focus{
	width:410px;
	height:210px;
	left:578px;/*-31*/
	z-index:10;
}
.main_middle_focus div{
	background-image:url(images/mainmiddle_focus_bg.png);
}
.main_middle_focus img{
	width:400px;
	height:200px;
	position:relative;
	top:-15px;
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
.main_right_focus img{
	position:relative;
	top:-10px;
	left:-5px;
	width:271px;
	height:200px;
	z-index:10;
}
.main_right_focus div{
	background:url(images/portal_a6_focus.png);
}
</style>
</head>

<body  bgcolor="transparent" onUnload="exit_page();">
<div style="position:absolute; top:0px; left:0px; width:1280px; height:720px; ">
	<img src="images/bg.png" />
    <img id="logo" src="images/logo.png" style="left:66px; top:18px;">
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
        	<span id="navText_2">点播</span>
        </div>
		<div id="nav_3" class="_nav">
        	<img id="icon_3" src="images/navIcon_3.png" >
        	<span id="navText_3" >专题</span>
        </div>
		<div id="nav_4" class="_nav">
        	<img id="icon_4" src="images/navIcon_4.png">
        	<span id="navText_4" >互动1</span>
        </div>
<!--<div id="nav_5" class="_nav">
        	<img id="icon_5" src="images/navIcon_5.png">
        	<span id="navText_5">互动</span>
        </div>-->
    </div>
    <!--A3 - rolling_main-->
    <div id="rolling_main_0" class="rolling_main">
        <img id="rolling_main_img_0" src="images/rolling_main_0.png" width="358" height="370">
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
        <img id="main_left_img_0" src="images/main_left.png" width="358" height="180"/>
    </div>
    <!--A5 - main_middle-->
  <div id="main_middle_0" class="main_middle" style="top:80px;">
<div style="position:absolute;width:430px;height:230px;left:-15px;top:-34px;"></div>
        <img id="main_middle_img_0" src="images/main_middle_0.png" width="358" height="180">
    </div>
<div id="main_middle_1" class="main_middle" style="top:270px;">
    	<div style="position:absolute;width:430px;height:230px;left:-15px;top:-34px;"></div>
        <img id="main_middle_img_1" src="images/main_middle_1.png" width="358" height="180"> 	
    </div>
    <div id="main_middle_2" class="main_middle" style="top:460px;">
   	  <div style="position:absolute;width:430px;height:230px;left:-15px;top:-34px;"></div>
        <img id="main_middle_img_2" src="images/main_middle_2.png" width="358" height="180">
    </div>
    <!--A6 - main_right-->
    <div id="main_right_0" class="main_right" style="top:80px;">
		<div style="position:absolute; width:308px; height:244px; left:-23px; top:-30px; z-index:10;"></div>        
        <img id="main_right_img_0" src="images/main_right_0.png" width="241" height="180">
    </div>
<div id="main_right_1" class="main_right" style="top:270px;">
		<div style="position:absolute; width:308px; height:244px; left:-23px; top:-30px; z-index:10;"></div> 
        <img src="images/main_right_1.png" width="241" height="180"> 	
    </div>
    <div id="main_right_2" class="main_right" style="top:460px;">
    	<div style="position:absolute; width:308px; height:244px; left:-23px; top:-30px; z-index:10;"></div> 
        <img src="images/main_right_2.png" width="241" height="180">
    </div>
    <!--bulletin-->
    <div>
    	<img src="images/bulletin_icon.png" style="position:absolute; left:250px; bottom:5px; width:48px; height:40px;"/>
    	<!--<marquee class="bulletin_text">意大利主帅孔蒂公布了最新一期的国家队名单，中场大师皮尔洛无缘本次集训。意大利</marquee>-->
	</div>
</div>
</body>
</html>
