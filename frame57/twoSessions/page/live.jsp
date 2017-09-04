<%@ include file = "config/param.jsp"%>
<%@ include file = "config/code.jsp"%>
<%
	java.text.SimpleDateFormat formatter2 = new java.text.SimpleDateFormat("yyyyMMddHHmm");
	java.util.Date currDate2 = new java.util.Date();
	String strDate1 = formatter2.format(currDate2);
%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="page-view-size" content="1280*720">
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/public.css" />
    <style>
        body {
            background:url("images/live_bg.png") no-repeat;
        }
		/*-------------------------------------------------------*/
body,
.container {
    width:1280px;
    height: 720px;
    position: absolute;
    font-size:24px;
	color:#ffffff;
	left:0px;
	top:0px;
}
.logo{
     width:50px;
     height:50px;
     left:30px;
     top:10px;
     position:absolute;
}
/*左侧部分*/
.left_container{
    width:175px;
    height:500px;
    position: absolute;
    top:150px;
    left:20px;
    /*border:1px solid red;*/
}
/*所有的循环div的属性相同，修改时只需循环它的top即可，所以class属性的a0不应该改变*/
.a0{
    position: absolute;
    width:185px;
    height:70px;
    line-height:70px;
    left:-10px;
    /*border:1px solid red;*/
}
.a0:hover{
    position:absolute;
    background-image:url("images/nav_focus_bg.png");
    background-repeat: no-repeat;
}
.a0>img{
    position: absolute;
    left:20px;
    top:15px;
    vertical-align:middle;
}
.text{
    position: absolute;
    left:80px;
    color:#fff;
}

/*中间区域*/
.content,.foot{
    width:980px;
   /* border:1px solid red;*/
    left:200px;
    position: absolute;
}
.content{
    position: absolute;
    height:437px;
    top:80px;
	left:235px;
}
.foot{
    position: absolute;
    height:115px;
    bottom:75px;
    left:235px;
}

.content_right{
    position: absolute;
    width: 384px;
    height:437px;
    right:1px;
    background-color:#0E2A46;
    opacity: 0.8;
}
.program_list{
    position: absolute;
    left:10px;
    height:35px;
    width:362px;
    top:8px;
    line-height:35px;
    padding-left:10px;
}
.program_text{
    font-size:28px;
    color: #ffffff;
}
.confirm{
    left:40px;
    font-size: 12px;
    color: #ffffff;
    float:right;
}
.repertoire_list{
    position: absolute;
    left:10px;
    top:130px;
    width: 355px;
    height:40px;
    line-height: 40px;
    padding-left: 10px;
}
.reprrtoire_focus div{
    background:url(images/bg_index.png) no-repeat;
}
.reprrtoire{
    border: 1px solid #ffffff;
    border-radius: 10px;
    background-image: url("images/radius.jpg");
    color:#FAFD02;
    padding-left:10px;
}
.foot_menu{
    position: absolute;
    width:188px;
    height:115px;
}

    </style>
</head>
<body bgcolor="transparent" onUnload="exit_page();">

<div style="position:absolute; top:0px; left:0px; width:1280px; height:720px;">
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
 
    <div class="content">
         <div id="content_left_0" style="position: absolute;width:582px;height:437px;left:0px;top:0px;">
         	 <div id="channel_vedio_focus" style="background:url(images/channel_vedio_focus.png); width:632px; height:506px; position:absolute; left: -24px; top: -41px;visibility:hidden;"></div>
		</div>
         <div class="content_right">
             <div class="program_list">
                 <span class="program_text">节目表</span>
                 <span class="confirm">两次确认健进入播放</span>
                     <img style="display:block" src="images/main.jpg"/>
             </div>
              <!--节目清单select:		repertoire_list reprrtoire
              	focus:   repertoire_list reprrtoire_focus
              -->
             <div id="program_menu_0" class="repertoire_list" style="top:65px;">
             		  <div style="position:absolute; width:382px; height:52px; left: -6px; top: -3px;"></div>
                      <span style="position:absolute;font-size:18px;left:5px;" id="program_menu_time_0"></span>
                      <span style="position:absolute;font-size:18px;left:60px;" id="program_menu_txt_0"></span>
			 </div>
             <div id="program_menu_1" class="repertoire_list" style="top:105px;">
             	<div style="position:absolute; width:382px; height:52px; left: -6px; top: -3px;"></div>
                 	<span style="position:absolute;font-size:18px;left:5px;" id="program_menu_time_1"></span>
                      <span style="position:absolute;font-size:18px;left:60px;" id="program_menu_txt_1"></span>
             </div>
             <div id="program_menu_2" class="repertoire_list" style="top:145px;">
             	<div style="position:absolute; width:382px; height:52px; left: -6px; top: -3px;"></div>
                 	<span style="position:absolute;font-size:18px;left:5px;" id="program_menu_time_2"></span>
                      <span style="position:absolute;font-size:18px;left:60px;" id="program_menu_txt_2"></span>
             </div>
             <div id="program_menu_3" class="repertoire_list" style="top:185px;" >
             	<div style="position:absolute; width:382px; height:52px; left: -6px; top: -3px;"></div>
                 	<span style="position:absolute;font-size:18px;left:5px;" id="program_menu_time_3"></span>
                      <span style="position:absolute;font-size:18px;left:60px;" id="program_menu_txt_3"></span>
             </div>
             <div id="program_menu_4" class="repertoire_list" style="top:225px;">
             	<div style="position:absolute; width:382px; height:52px; left: -6px; top: -3px;"></div>
                 <span style="position:absolute;font-size:18px;left:5px;" id="program_menu_time_4"></span>
                 <span style="position:absolute;font-size:18px;left:60px;" id="program_menu_txt_4"></span>
             </div>
             <div id="program_menu_5" class="repertoire_list" style="top:265px;" >
             	<div style="position:absolute; width:382px; height:52px; left: -6px; top: -3px;"></div>
                 <span style="position:absolute;font-size:18px;left:5px;" id="program_menu_time_5"></span>
                 <span style="position:absolute;font-size:18px;left:60px;" id="program_menu_txt_5"></span>
             </div>
             <div id="program_menu_6" class="repertoire_list" style="top:305px;">
             	<div style="position:absolute; width:382px; height:52px; left: -6px; top: -3px;"></div>
                 <span style="position:absolute;font-size:18px;left:5px;" id="program_menu_time_6"></span>
                 <span style="position:absolute;font-size:18px;left:60px;" id="program_menu_txt_6"></span>
             </div>
             <div id="program_menu_7" class="repertoire_list" style="top:345px;">
             	<div style="position:absolute; width:382px; height:52px; left: -6px; top: -3px;"></div>
                 <span style="position:absolute;font-size:18px;left:5px;" id="program_menu_time_7"></span>
                 <span style="position:absolute;font-size:18px;left:60px;" id="program_menu_txt_7"></span>
             </div>
             <div id="program_menu_8" class="repertoire_list" style="top:385px;">
             	<div style="position:absolute; width:382px; height:52px; left: -6px; top: -3px;"></div>
                 <span style="position:absolute;font-size:18px;left:5px;" id="program_menu_time_8"></span>
                 <span style="position:absolute;font-size:18px;left:60px;" id="program_menu_txt_8"></span>
             </div>
         </div>
    </div>
    <!--底部视频信息图片-->
    <div class="foot">
        <div id="channel_foot_focus" style="background:url(images/channel_foot_focus.png) no-repeat; position:absolute; width:213px; height:142px; left: -11px; top: -14px;visibility:hidden;"></div>
          <div id="top_menu_0" class="foot_menu" style="left:0px;top:0px;">
            <img id="top_menu_img_0" src="images/channel_00.jpg" style="top:0px;left:0px;position:absolute;"/>
          </div>
  <div id="top_menu_1" class="foot_menu" style="left:198px;top:0px;">
            <img id="top_menu_img_1" src="images/channel_01.jpg" style="top:0px;left:0px;position:absolute;"/>
</div>
        <div id="top_menu_2" class="foot_menu" style="left:396px;top:0px;">
            <img id="top_menu_img_2" src="images/channel_02.jpg" style="top:0px;left:0px;position:absolute;"/>
        </div>
        <div id="top_menu_3" class="foot_menu" style="left:594px;top:0px;">
            <img id="top_menu_img_3" src="images/channel_03.jpg" style="top:0px;left:0px;position:absolute;"/>
        </div>
        <div id="top_menu_4" class="foot_menu" style="left:792px;top:0px;">
            <img id="top_menu_img_4" src="images/channel_04.jpg" style="top:0px;left:0px;position:absolute;"/>
      </div>
    </div>
     <div>
    	<img src="images/bulletin_icon.png" style="position:absolute; left:250px; bottom:5px; width:48px; height:40px;"/>
    	<marquee id="scroll_txt" class="bulletin_text" style="width:917px;"></marquee>
	</div>
</div>
<div id="_test" style="color:red; position:absolute; top:20px; left:162px;"></div>
</body>
</html>
<script type="text/javascript" src="js/focus_logic.js"></script>
<%@ include file = "js/trailer_play.jsp"%>
<script type="text/javascript" src="js/utils.js"></script>
<script type="text/javascript">

	top.mp.stop();
	top.mp.leaveChannel();

	var area0,area1,area2,area3;
	var menu_urls = ["portal.jsp","","vod.jsp","favorite.jsp","theme.jsp"];
	var _t;
	var channel_list = new Array();
	var channel_content_list = new Array();
	var cur_ChannelID;
	var cur_ChannelIndex;
	var cur_ChannelName;
	var cur_CODE;
	var area2_select_index = 4;
	var area2_select_page = 1;
	var area3_select_index = 0;
	var cur_live_index = area2_select_index;
	
	var cookie_focus = "live";
	var _focusArr = get_focus_ex1(cookie_focus,[0,1,1,0,0,1]);
	delCookie(cookie_focus);
	
	window.onload = function(){
		loadElement();
		init_media();
		loadScrollTxt();
		setTimeout("window.focus()",1);
	}
	function loadElement(){
		area0 = focus_logic.loadElements(5,1,"nav_","_nav _nav_focus","_nav",[-1,-1,-1,1]);
		area1 = focus_logic.loadElements(1,1,"content_left_","","",[-1,0,3,2]);
		area2 = focus_logic.loadElements(9,1,"program_menu_","repertoire_list reprrtoire_focus","repertoire_list",[-1,1,3,-1]);
		area3 = focus_logic.loadElements(1,5,"top_menu_","","",[1,0,-1,-1]);
		setAreaAttr();
		loadData();
		focus_logic.page.setCurrentFocus(_focusArr[0],_focusArr[1]);		
	}
	function setAreaAttr(){
		//----------------------------------------------area0
		area0.curDomIndex = 1;
		area0.doms[1].blurClassName = "_nav _nav_select";
		area0.okEvent = function(){
			window.location.href = menu_urls[area0.curDomIndex];
		}
		//----------------------------------------------area1
		area1.objFocus = ["channel_vedio_focus",[0,-24],[0,-41],0];
		area1.doms[0].moveRule = [-1,[0,1],-1,-1];
		area1.okEvent = function(){
			area2.pageNumber = area2_select_page;
			var _offset = (area2.pageNumber-1)*area2.domsMaxLength;
			if((area2_select_index+_offset)==parseInt(channel_content_list[0].cur_channel_content_index)){
				set_focus_ex_live(cookie_focus);
				window.location.href = "goto_channel.jsp?action=out&returnUrl=live.jsp&CHANNELNUM="+cur_ChannelIndex+"&CHANNELID="+cur_ChannelID;
			}else{
				set_focus_ex_trailer(cookie_focus);	
				window.location.href = "goto_tvod.jsp?action=out&returnUrl=live.jsp&PROGID="+channel_content_list[0].tvodList[_offset+area2_select_index].proID+"&CHANNELID="+cur_ChannelID+"&CHANNELNUM="+cur_ChannelIndex+"&CHANNELNAME="+cur_ChannelName+"&channel_code="+cur_CODE;
			}
		}
		//----------------------------------------------area2
		area2.doms[8].moveRule = [-1,-1,[3,3],-1];
		area2.okEvent = function(isAuto){
			var _offset = (area2.pageNumber-1)*area2.domsMaxLength;
			if((area2.curDomIndex+_offset)<parseInt(channel_content_list[0].cur_channel_content_index)){
				if(channel_content_list[0].tvodList[area2.curDomIndex+_offset].play_status!=1) return;
				if((area2.pageNumber == area2_select_page && area2_select_index==area2.curDomIndex) && isAuto==undefined){
					set_focus_ex_live(cookie_focus);
					var _offset = (area2.pageNumber-1)*area2.domsMaxLength;
					window.location.href = "goto_tvod.jsp?action=out&returnUrl=live.jsp&PROGID="+channel_content_list[0].tvodList[_offset+area2.curDomIndex].proID+"&CHANNELID="+cur_ChannelID+"&CHANNELNUM="+cur_ChannelIndex+"&CHANNELNAME="+cur_ChannelName+"&channel_code="+cur_CODE;
					return;
				}
				get_tvod_info();
				set_area2_select_index(area2.curDomIndex);
			}else if((area2.curDomIndex+_offset) == parseInt(channel_content_list[0].cur_channel_content_index)){
				if(area2_select_index==area2.curDomIndex && isAuto==undefined){
					set_focus_ex_live(cookie_focus);
					window.location.href = "goto_channel.jsp?action=out&returnUrl=live.jsp&CHANNELNUM="+cur_ChannelIndex+"&CHANNELID="+cur_ChannelID;
					return;
				}
				trailer_play(parseInt(channel_list[area3_select_index].ChannelIndex));
				set_area2_select_index(area2.curDomIndex);
			}
		}
		area2.pageTurnEvent = function(){
			set_area2_select_index();
			bindData();	
		}
		//----------------------------------------------area3
		area3.objFocus = ["channel_foot_focus",[0,-11],[0,-14],0];
		area3.doms[0].moveRule = [-1,[0,1],-1,-1];
		area3.doms[3].moveRule = [[2,8],-1,-1,-1];
		area3.doms[4].moveRule = [[2,8],-1,-1,-1];
		area3.curDomIndex = _focusArr[4];
		area3.okEvent = function(){
			if(channel_list.length>0){
				if(area3_select_index == area3.curDomIndex){
					set_focus_ex_live(cookie_focus);
					window.location.href = "goto_channel.jsp?action=out&returnUrl=live.jsp&CHANNELNUM="+cur_ChannelIndex+"&CHANNELID="+cur_ChannelID;
				}else{
					trailer_play(parseInt(channel_list[area3.curDomIndex].ChannelIndex));
					focus_logic.getDataByAjax("<%=data_path%>?Action=tvod_one_channel_list&channelId="+channel_list[area3.curDomIndex].ChannelID+"&date=<%=strDate1%>&len_px=250",load_channel_content);
				}
			}
		}
		//------------------------------------------------page
		focus_logic.page.setAreaMembership(3,2);
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
	function exit_page(){
		destoryMP();
	}
	function trailer_play(channelIndex){
		//海南zte电信
		var _channelIndex = channelIndex;
		if(_channelIndex == 13){
			_channelIndex = 913;
		}else if(_channelIndex == 901){
			_channelIndex = 985;
		}else if(_channelIndex == 2){
			_channelIndex = 902;
		}else if(_channelIndex == 4){
			_channelIndex = 904;
		}else if(_channelIndex == 7){
			_channelIndex = 907;
		}
		
		mediamp.leaveChannel();
		mediamp.stop();
        
        initMediaPlay();
        mediamp.setAllowTrickmodeFlag(0);
        mediamp.setNativeUIFlag(0);
        mediamp.setMuteUIFlag(0);
        mediamp.setVideoDisplayArea(237,84,592,438);
        mediamp.setVideoDisplayMode(0);
        mediamp.refreshVideoDisplay();
        mediamp.joinChannel(_channelIndex);
		
	}
	
	function loadData(){
		var result = '['+
						'{"ChannelID":"ch00000000000000001220","ChannelIndex":"13","ChannelName":"CCTV-13","channel_picPath":"../../","isSubscribe":"1","IsTvod":"1","CODE":""},'+
						'{"ChannelID":"ch00000000000000001227","ChannelIndex":"901","ChannelName":"CCTV-1 HD","channel_picPath":"../../","isSubscribe":"1","IsTvod":"1","CODE":""},'+
						'{"ChannelID":"ch00000000000000001213","ChannelIndex":"2","ChannelName":"CCTV-2","channel_picPath":"../../","isSubscribe":"1","IsTvod":"1","CODE":""},'+
						'{"ChannelID":"ch00000000000000001211","ChannelIndex":"4","ChannelName":"CCTV-4","channel_picPath":"../../","isSubscribe":"1","IsTvod":"1","CODE":""},'+
						'{"ChannelID":"ch00000000000000001212","ChannelIndex":"7","ChannelName":"CCTV-7","channel_picPath":"../../","isSubscribe":"1","IsTvod":"1","CODE":""}'+
						']';
		load_channel(result);
	}
	
	function load_channel(result){
		channel_list = eval('('+result+')');
		if(channel_list.length>0){
			focus_logic.getDataByAjax("<%=data_path%>?Action=tvod_one_channel_list&channelId="+channel_list[area3.curDomIndex].ChannelID+"&date=<%=strDate1%>&len_px=250",load_channel_content,1);
		}
	}
	
	function load_channel_content(result,param){
		channel_content_list = eval('('+result+')');
		cur_ChannelID = channel_list[area3.curDomIndex].ChannelID;
		cur_ChannelIndex = channel_list[area3.curDomIndex].ChannelIndex;
		cur_ChannelName = channel_list[area3.curDomIndex].ChannelName;
		cur_CODE = channel_list[area3.curDomIndex].CODE;
		area3_select_index = area3.curDomIndex;
		var _cur_channel_content_index = parseInt(channel_content_list[0].cur_channel_content_index);
		cur_live_index = _cur_channel_content_index%9;
		if(param==1 && (_focusArr[6]==1 || _focusArr[6]=="1" || (_focusArr[0]==2 && (area2.curDomIndex+(_focusArr[2]-1)*area2.domsMaxLength)<parseInt(channel_content_list[0].cur_channel_content_index)))){
			area2.pageNumber = _focusArr[2];
			set_area2_select_index(_focusArr[1]);	
		}else{
			area2.pageNumber = Math.ceil((_cur_channel_content_index+1)/9);
			set_area2_select_index(cur_live_index);	
		}
		
		
		if(channel_content_list[0].tvodList.length==0){
			$("program_menu_txt_0").innerHTML = "暂无节目单";
			$("program_menu_time_0").innerHTML = "";
			for(var j=1;j<9;j++){
				$("program_menu_txt_"+j).innerHTML = "";
				$("program_menu_time_"+j).innerHTML = "";
			}
			area2.domsCount = 0;
			area3.doms[3].moveRule = [-1,-1,-1,-1];
			area3.doms[4].moveRule = [-1,-1,-1,-1];
			set_area2_select_index(parseInt(channel_content_list[0].cur_channel_content_index));
			return;
		}else{
			area3.doms[3].moveRule = [[2,8],-1,-1,-1];
			area3.doms[4].moveRule = [[2,8],-1,-1,-1];
		}
		
		
		area2.setDataCount(channel_content_list[0].tvodList.length);
		area2.setAttrForDomsTxt(channel_content_list[0].tvodList,"name","cut_name",1,"program_menu_txt_");
		
		bindData();
	}
	
	function bindData(){
		
		var _offset = (area2.pageNumber-1)*area2.domsMaxLength;
		for(var i=0;i<area2.domsMaxLength;i++){
			if((i+_offset)<channel_content_list[0].tvodList.length || area2.pageNumber<area2.pageTotal){
				$("program_menu_time_"+i).innerHTML = channel_content_list[0].tvodList[i+_offset].time.substring(0,5)+"&nbsp;&nbsp;";//11:11:11
				if((i+_offset)>channel_content_list[0].cur_channel_content_index || (channel_content_list[0].tvodList[i+_offset].play_status!=1 && (i+_offset)!=channel_content_list[0].cur_channel_content_index)){
					$("program_menu_txt_"+i).style.color = "#666";
				}else{
					$("program_menu_txt_"+i).style.color = "#FFF";
				}
			}else{
				$("program_menu_time_"+i).innerHTML = "";
				$("program_menu_txt_"+i).innerHTML = "";
			}
		}
	}
	
	function get_tvod_info(){
		var _offset = (area2.pageNumber-1)*area2.domsMaxLength;
		focus_logic.getDataByAjax("<%=data_path%>?Action=get_tvod_info&schedule_proId="+channel_content_list[0].tvodList[_offset+area2.curDomIndex].proID+"&channel_id="+cur_ChannelID,play_tvod);
	}
	
	function play_tvod(result){
		var mediaUrl = eval('('+result+')');
		destoryMP();
		var playUrl = mediaUrl[0].mediaUrl;
		play(237,84,592,438,playUrl);
	}
	
	function play_next(){
		area2.move(2);
		area2.okEvent("auto");
	}
	
	function init_media(){
		if(_focusArr[6]==1 || _focusArr[6]=="1"){
			get_tvod_info();
			focus_logic.page.setCurrentFocus(1,0);
		}else if(focus_logic.page.curAreaIndex==2 && (area2.curDomIndex+(_focusArr[2]-1)*area2.domsMaxLength)<parseInt(channel_content_list[0].cur_channel_content_index)){
			get_tvod_info();
			set_area2_select_index(area2.curDomIndex);
		}else{
			trailer_play(parseInt(channel_list[area3.curDomIndex].ChannelIndex));
		}
	}
	
	function set_area2_select_index(_curDomIndex){
		area2.doms[area2_select_index].element.className = "repertoire_list";
		area2.doms[area2_select_index].blurClassName = "repertoire_list";
		if(_curDomIndex != undefined){
			area2_select_index = _curDomIndex;
			area2_select_page = area2.pageNumber;
		}
		
		if(area2_select_page==area2.pageNumber){
			if(area2_select_index==area2.curDomIndex && focus_logic.page.curAreaIndex==2){
				area2.doms[area2_select_index].element.className = "repertoire_list reprrtoire_focus";
			}else{
				if(channel_content_list[0].tvodList.length>0){
					area2.doms[area2_select_index].element.className = "repertoire_list reprrtoire";
				}else{
					area2.doms[area2_select_index].element.className = "repertoire_list";
				}
			}
			area2.doms[area2_select_index].blurClassName = "repertoire_list reprrtoire";
		}
	}
	
	function set_focus_ex_live(name){
		var _pageObj = focus_logic.page;
		var _AreaObj = _pageObj.areas[_pageObj.curAreaIndex];
		var _parent_focus_str;
		if(_AreaObj.parentAreaIndex == undefined){
			_parent_focus_str = "&"+0+"&"+area3_select_index+"&"+1;
		}else{
			_parent_focus_str = "&"+_AreaObj.parentAreaIndex+"&"+area3_select_index+"&"+_pageObj.areas[_AreaObj.parentAreaIndex].pageNumber;
		}
		setCookie(name,_pageObj.curAreaIndex+"&"+_AreaObj.curDomIndex+"&"+_AreaObj.pageNumber+_parent_focus_str);
	}
	
	function set_focus_ex_trailer(name){
		focus_logic.page.setCurrentFocus(2,area2_select_index);
		var _pageObj = focus_logic.page;
		var _AreaObj = _pageObj.areas[_pageObj.curAreaIndex];
		var _parent_focus_str;
		if(_AreaObj.parentAreaIndex == undefined){
			_parent_focus_str = "&"+0+"&"+area3_select_index+"&"+1;
		}else{
			_parent_focus_str = "&"+_AreaObj.parentAreaIndex+"&"+area3_select_index+"&"+_pageObj.areas[_AreaObj.parentAreaIndex].pageNumber+"&"+1;
		}
		setCookie(name,_pageObj.curAreaIndex+"&"+_AreaObj.curDomIndex+"&"+_AreaObj.pageNumber+_parent_focus_str);
	}
	
	function get_focus_ex1(name,default_focus){
		var _focusStr = getCookie(name);
		if(_focusStr != null){
			var _focusArr = _focusStr.split("&");
			var focusArr = new Array();
			focusArr.push(parseInt(_focusArr[0]));
			focusArr.push(parseInt(_focusArr[1]))
			focusArr.push(parseInt(_focusArr[2]))
			focusArr.push(parseInt(_focusArr[3]))
			focusArr.push(parseInt(_focusArr[4]))
			focusArr.push(parseInt(_focusArr[5]))
			focusArr.push(parseInt(_focusArr[6]))
			
			return focusArr;
		}else{
			if(default_focus==undefined){
				return [0,0,1,0,0,1];
			}else{
				return default_focus;
			}
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
<script type="text/javascript">
	var commonPage = new Object();
	commonPage.mp = mediamp;
</script>
<%@ include file = "volume_control.htm"%>