<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@ include file="inc/utils.jsp" %>
<%@ include file="inc/scrollString.jsp" %>
<epg:PageController name="vod_portal.jsp"/>
<%
    String page_url = ""; //处理封套返回路径
    String epg_info = request.getParameter("epg_info");
    if(null == epg_info || "".equals(epg_info) || "null".equals(epg_info) || "undefined".equals(epg_info)){
        epg_info = (String) session.getAttribute("epg_info_as");
    }
    if(null != epg_info && !"".equals(epg_info) && epg_info.length() > 20){
        session.setAttribute("epg_info_as",epg_info);
        page_url = epg_info.substring(epg_info.indexOf("<page_url>")+10,epg_info.indexOf("</page_url>"));
    }
    String columnName=request.getParameter("columnname");
    String columncode = request.getParameter("columncode"); //查的栏目ID
    String columncode1 = request.getParameter("chirldcolumncode"); //查的栏目ID
    String columncode3pb = columncode1;
	String isSonPage = request.getParameter("isSonPage"); 
	String is4K = request.getParameter("is4K"); 
	String isVodPortal = request.getParameter("isVodPortal"); 
	
	if(is4K==null){
        is4K="";
    }
    if(columncode1==null){
        columncode1="";
    }

    if(columnName!=null){
        columnName=java.net.URLDecoder.decode(columnName,"UTF-8");
    }else{
        columnName="";
    }
    String lastfocus = request.getParameter("lastfocus");
    if(lastfocus==null||"null".equals(lastfocus)){
        lastfocus="1-1-0-1-0";
    } else{
        columncode1="";
    }
    String[] positions=lastfocus.split("-");
	if(null != positions && positions.length < 5){
		String[] temp1 = new String[5];
		for(int i=0; i<5;i++){
			if(i < positions.length){
				temp1[i] = positions[i];
			}else{
				temp1[i] = "0";
			}
		}
		positions = temp1;
	}
	
	String reload_flag_as = (String) session.getAttribute("reload_flag_as");
	System.out.println("=========reload_flag_as=======" + reload_flag_as);
	if(null == reload_flag_as || "".equals(reload_flag_as)){
		session.setAttribute("reload_flag_as","1");
	}else{
		session.setAttribute("reload_flag_as",null);
	}
%>
<script type="text/javascript">
if('<%=reload_flag_as %>' == '1') {
	//window.location.reLoad();
}
</script>

<html>
<head>
    <title>vod_portal</title>
    <meta name="page-view-size" content="1280*720"/>
    <meta http-equiv="content-Type" content="text/html; charset=utf-8">
    <script type="text/javascript" src="js/dom.js"></script>
    <script type="text/javascript" src="js/contentloader.js"></script>
    <script type="text/javascript" src="js/toggleClass.js"></script>
    <style>
        .rootColumnName{
            position:absolute;
            left: 41px;
            top: 21px;
            width:527px;
            height: 50px;
            color: #ffffff;
            font-size: 30px;
            /*font-weight: bolder;*/
            line-height: 50px;
        }
        .vodPortalSplit{
            position: absolute;
            left:251px;
            top:100px;
            width: 2px;
            height: 581px;
            background: url(images/vod/vod_split.png) no-repeat;
        }
        .columnUpArrow{
            position: absolute;
            left:120px;
            top:100px;
            width: 26px;
            height: 12px;
            background: url(images/vod/vod_column_arrow_up.png) no-repeat;
        }
        .columnDownArrow{
            position: absolute;
            left:120px;
            top:656px;
            width: 26px;
            height: 13px;
            background: url(images/vod/vod_column_arrow_down.png) no-repeat;
        }
        .columnArea{
            position: absolute;
            left: 0px;
            top:127px;
            width: 251px;
            height: 512px;
        }
        .columnName{
            position: absolute;
            left:0px;
            width: 251px;
            height: 63px;
            color: #b9b6b7;
            font-size: 26px;
            /*font-weight: bolder;*/
            line-height: 63px;
            text-align: center;
        }
        #column_name0{
            top:0px;
        }
        #column_name1{
            top:64px;
        }
        #column_name2{
            top:128px;
        }
        #column_name3{
            top:192px;
        }
        #column_name4{
            top:256px;
        }
        #column_name5{
            top:320px;
        }
        #column_name6{
            top:384px;
        }
        #column_name7{
            top:448px;
        }
        .columnNameFocus{
            color:#ffffff;
            background-color: #5880FF;
        }
        .columnNameStay{
            color:#ffffff;
            /*background-color: #adafb1;*/
            /*background-color: #3D344D;*/
            background-image: url("images/vod/leftListBg.png") ;
        }
        .vod_scrollbar{
            position: absolute;
            left:1218px;
            top:150px;
            width: 6px;
            height: 500px;
            /*background-color: #2E1E1A;*/
            background: url(images/vod/scrollBarBg.png) repeat-y;
            /*y轴最大265px*/
            /*background-position: 0px 265px;*/
        }
        .scrollbar{
            position: absolute;
            left: 0px;
            width: 6px;
			top:0px;
            /*background-color: #3D344D;*/
            /*background: url(images/vod/scrollBarFocus.png) repeat-y;*/
        }
        .vodSearch{
            position: absolute;
            left: 1100px;
            top:70px;
            width: 137px;
            height: 61px;
            color: #ffffff;
            font-size: 24px;
            /*font-weight: bolder;*/
            background: url(images/vod/vod_search_normal.png) no-repeat;
        }
        #vodSearchFocus{
            position: absolute;
            left: 1060px;
            top:52px;
            width: 165px;
            height: 65px;
            visibility: hidden;
        }
        #vodNum{
            position: absolute;
            left: 305px;
            top:69px;
            width: 400px;
            height: 26px;
            font-size: 24px;
            line-height: 26px;
            color: #ffffff;
        }
        .vodPosterArea{
            position: absolute;
            left: 252px;
            top: 125px;
            width: 965px;
            height: 560px;
        }
        .programpanel{
            position: absolute;
            width: 145px;
            height: 237px;
        }
        .programpanel-top0{
            top:20px;
        }
        .programpanel-top1{
            top:299px;
        }
        .programpanel-left0{
            left: 56px;
        }
        .programpanel-left1{
            left: 238px;
        }
        .programpanel-left2{
            left: 420px;
        }
        .programpanel-left3{
            left: 602px;
        }
        .programpanel-left4{
            left: 784px;
        }
		.programpanel0{
            position: absolute;
            width: 210px;
            height: 145px;
        }
		.programname0{
            position: absolute;bottom: -40px; width: 210px;height: 40px;color: #b9b6b7; font-size: 22px;line-height: 40px;text-align: center;
        }
		
        .programpanel0-top0{
            top:-10px;
        }
        .programpanel0-top1{
            top:180px;
        }
        .programpanel0-top2{
            top:370px;
        }
        .programpanel0-left0{
            left: 31px;
        }
        .programpanel0-left1{
            left: 266px;
        }
        .programpanel0-left2{
            left: 501px;
        }
        .programpanel0-left3{
            left: 736px;
        }
        .vodposter0{
            position: absolute;
            top: 0px;
            left: 0px;
            width: 210px;
            height: 145px;
        }
        .programname{
            position: absolute;
            bottom: 0px;
            width: 145px;
            height: 40px;
            color: #b9b6b7;
            font-size: 24px;
            line-height: 40px;
            text-align: center;
        }
        .vodposter{
            position: absolute;
            top: 0px;
            left: 0px;
            width: 145px;
            height: 197px;
        }
        .programpanelFocus{
            transform:scale(1.1);
            -webkit-transform: scale(1.1);
        }
        .programpanel0Focus{
            transform:scale(1.1);
            -webkit-transform: scale(1.1);
        }
    </style>
</head>
<body bgcolor="transparent" onLoad="initPage();">
<!-- 背景 -->
<div style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px;">
    <img src="images/bg.png">
</div>
<!-- 根栏目名称 -->
<div class="rootColumnName" id="rootColumnName1"></div>
<!-- 分割线 -->
<div class="vodPortalSplit"></div>
<!-- 向上的箭头 -->
<div id="upArrow" class="columnUpArrow"></div>

<!-- 侧边栏 -->
<div class="columnArea">
    <div id="column_name0" class="columnName" style="width: 251px;"></div>
    <div id="column_name1" class="columnName" style="width: 251px;"></div>
    <div id="column_name2" class="columnName" style="width: 251px;"></div>
    <div id="column_name3" class="columnName" style="width: 251px;"></div>
    <div id="column_name4" class="columnName" style="width: 251px;"></div>
    <div id="column_name5" class="columnName" style="width: 251px;"></div>
    <div id="column_name6" class="columnName" style="width: 251px;"></div>
    <div id="column_name7" class="columnName" style="width: 251px;"></div>
</div>
<!-- 向下的箭头 -->
<div id="downArrow" class="columnDownArrow"></div>
<!-- 搜索 -->
<div class="vodSearch"></div>
<div id="vodSearchFocus">
    <img src="images/vod/vod_column_focus1.png" width="165" height="65">
</div>
<!-- <div id="test" style="position:absolute; width:1000px; height:200px; color:#FF0000; font-size:26px; left:110px; top:50px; z-index:9999"></div> -->
<!-- VOD 总数区域 -->
<div id="vodNum"></div>
<!-- VOD海报区域 -->
<div id="vodPosterArea0" class="vodPosterArea" style=" visibility:;">
	 <div id="programpanel0_0" class="programpanel0 programpanel0-top0 programpanel0-left0">
        <div id="posterchage0_0" class="vodposter0">
            <img id="vodposter0_0" src="images/vod/btn_trans.gif" width="210" height="145" />
        </div>
        <div id="programname0_0" class="programname0"></div>
     </div>
	 <div id="programpanel0_1" class="programpanel0 programpanel0-top0 programpanel0-left1">
        <div id="posterchage0_1" class="vodposter0">
            <img id="vodposter0_1" src="images/vod/btn_trans.gif" width="210" height="145" />
        </div>
        <div id="programname0_1" class="programname0"></div>
  	</div>
	 <div id="programpanel0_2" class="programpanel0 programpanel0-top0 programpanel0-left2">
        <div id="posterchage0_2" class="vodposter0">
            <img id="vodposter0_2" src="images/vod/btn_trans.gif" width="210" height="145" />
        </div>
        <div id="programname0_2" class="programname0"></div>
  	</div>
	 <div id="programpanel0_3" class="programpanel0 programpanel0-top0 programpanel0-left3">
        <div id="posterchage0_3" class="vodposter0">
            <img id="vodposter0_3" src="images/vod/btn_trans.gif" width="210" height="145" />
        </div>
        <div id="programname0_3" class="programname0"></div>
  	</div>
	 <div id="programpanel0_4" class="programpanel0 programpanel0-top1 programpanel0-left0">
        <div id="posterchage0_4" class="vodposter0">
            <img id="vodposter0_4" src="images/vod/btn_trans.gif" width="210" height="145" />
        </div>
        <div id="programname0_4" class="programname0"></div>
     </div>
	 <div id="programpanel0_5" class="programpanel0 programpanel0-top1 programpanel0-left1">
        <div id="posterchage0_5" class="vodposter0">
            <img id="vodposter0_5" src="images/vod/btn_trans.gif" width="210" height="145" />
        </div>
        <div id="programname0_5" class="programname0"></div>
     </div>
	 <div id="programpanel0_6" class="programpanel0 programpanel0-top1 programpanel0-left2">
        <div id="posterchage0_6" class="vodposter0">
            <img id="vodposter0_6" src="images/vod/btn_trans.gif" width="210" height="145" />
        </div>
        <div id="programname0_6" class="programname0"></div>
     </div>
	 <div id="programpanel0_7" class="programpanel0 programpanel0-top1 programpanel0-left3">
        <div id="posterchage0_7" class="vodposter0">
            <img id="vodposter0_7" src="images/vod/btn_trans.gif" width="210" height="145" />
        </div>
        <div id="programname0_7" class="programname0"></div>
     </div>
	 <div id="programpanel0_8" class="programpanel0 programpanel0-top2 programpanel0-left0">
        <div id="posterchage0_8" class="vodposter0">
            <img id="vodposter0_8" src="images/vod/btn_trans.gif" width="210" height="145" />
        </div>
        <div id="programname0_8" class="programname0"></div>
     </div>
	 <div id="programpanel0_9" class="programpanel0 programpanel0-top2 programpanel0-left1">
        <div id="posterchage0_9" class="vodposter0">
            <img id="vodposter0_9" src="images/vod/btn_trans.gif" width="210" height="145" />
        </div>
        <div id="programname0_9" class="programname0"></div>
     </div>
	 <div id="programpanel0_10" class="programpanel0 programpanel0-top2 programpanel0-left2">
        <div id="posterchage0_10" class="vodposter0">
            <img id="vodposter0_10" src="images/vod/btn_trans.gif" width="210" height="145" />
        </div>
        <div id="programname0_10" class="programname0"></div>
     </div>
	 <div id="programpanel0_11" class="programpanel0 programpanel0-top2 programpanel0-left3">
        <div id="posterchage0_11" class="vodposter0">
            <img id="vodposter0_11" src="images/vod/btn_trans.gif" width="210" height="145" />
        </div>
        <div id="programname0_11" class="programname0"></div>
     </div>
    <!-- VOD焦点框 -->
    <div id="vodFocus0" style="position:absolute;top:-17px;left:0px;visibility: hidden;">
        <img src="images/vod/vod_focus0.png" width="270" height="199">    </div>
</div>
<div class="vodPosterArea" id="vodPosterArea" style="visibility:hidden;">
    <div id="programpanel_0" class="programpanel programpanel-top0 programpanel-left0">
        <div id="posterchage_0" class="vodposter">
            <img id="vodposter_0" src="images/vod/btn_trans.gif" width="145" height="197" />
        </div>
        <div id="programname_0" style=" position: absolute;bottom: 0px; width: 145px;height: 40px;color: #b9b6b7; font-size: 22px;line-height: 40px;text-align: center;"class=""></div>
    </div>
    <div id="programpanel_1" class="programpanel programpanel-top0 programpanel-left1">
        <div id="posterchage_1" class="vodposter">
            <img id="vodposter_1" src="images/vod/btn_trans.gif" width="145" height="197" />
        </div>
        <div id="programname_1" style=" position: absolute;bottom: 0px; width: 145px;height: 40px;color: #b9b6b7; font-size: 22px;line-height: 40px;text-align: center;"class=""></div>
    </div>
    <div id="programpanel_2" class="programpanel programpanel-top0 programpanel-left2">
        <div id="posterchage_2" class="vodposter">
            <img id="vodposter_2" src="images/vod/btn_trans.gif" width="145" height="197" />
        </div>
        <div id="programname_2" style=" position: absolute;bottom: 0px; width: 145px;height: 40px;color: #b9b6b7; font-size: 22px;line-height: 40px;text-align: center;"class=""></div>
    </div>
    <div id="programpanel_3" class="programpanel programpanel-top0 programpanel-left3">
        <div id="posterchage_3" class="vodposter">
            <img id="vodposter_3" src="images/vod/btn_trans.gif" width="145" height="197" />
        </div>
        <div id="programname_3" style=" position: absolute;bottom: 0px; width: 145px;height: 40px;color: #b9b6b7; font-size: 22px;line-height: 40px;text-align: center;"class=""></div>
    </div>
    <div id="programpanel_4" class="programpanel programpanel-top0 programpanel-left4">
        <div id="posterchage_4" class="vodposter">
            <img id="vodposter_4" src="images/vod/btn_trans.gif" width="145" height="197" />
        </div>
        <div id="programname_4" style=" position: absolute;bottom: 0px; width: 145px;height: 40px;color: #b9b6b7; font-size: 22px;line-height: 40px;text-align: center;"class=""></div>
    </div>
    <div id="programpanel_5" class="programpanel programpanel-top1 programpanel-left0">
        <div id="posterchage_5" class="vodposter">
            <img id="vodposter_5" src="images/vod/btn_trans.gif" width="145" height="197" />
        </div>
        <div id="programname_5" style=" position: absolute;bottom: 0px; width: 145px;height: 40px;color: #b9b6b7; font-size: 22px;line-height: 40px;text-align: center;"class=""></div>
    </div>
    <div id="programpanel_6" class="programpanel programpanel-top1 programpanel-left1">
        <div id="posterchage_6" class="vodposter">
            <img id="vodposter_6" src="images/vod/btn_trans.gif" width="145" height="197" />
        </div>
        <div id="programname_6" style=" position: absolute;bottom: 0px; width: 145px;height: 40px;color: #b9b6b7; font-size: 22px;line-height: 40px;text-align: center;"class=""></div>
    </div>
    <div id="programpanel_7" class="programpanel programpanel-top1 programpanel-left2">
        <div id="posterchage_7" class="vodposter">
            <img id="vodposter_7" src="" width="145" height="197" />
        </div>
        <div id="programname_7" style=" position: absolute;bottom: 0px; width: 145px;height: 40px;color: #b9b6b7; font-size: 22px;line-height: 40px;text-align: center;"class=""></div>
    </div>
    <div id="programpanel_8" class="programpanel programpanel-top1 programpanel-left3">
        <div id="posterchage_8" class="vodposter">
            <img id="vodposter_8" src="images/vod/btn_trans.gif" width="145" height="197" />
        </div>
        <div id="programname_8" style=" position: absolute;bottom: 0px; width: 145px;height: 40px;color: #b9b6b7; font-size: 22px;line-height: 40px;text-align: center;"class=""></div>
    </div>
    <div id="programpanel_9" class="programpanel programpanel-top1 programpanel-left4">
        <div id="posterchage_9" class="vodposter">
            <img id="vodposter_9" src="images/vod/btn_trans.gif" width="145" height="197" />
        </div>
        <div id="programname_9" style=" position: absolute;bottom: 0px; width: 145px;height: 40px;color: #b9b6b7; font-size: 22px;line-height: 40px;text-align: center;"class=""></div>
    </div>
    <!-- VOD焦点框 -->
    <div id="vodFocus" style="position:absolute;top:-6px;left:35px;visibility: hidden;">
        <img src="images/vod/vod_focus.png" width="190" height="245px">
    </div>
    
</div>
<!-- 滚动条 -->
<div class="vod_scrollbar" id="vod_scrollbar1">
  <div id="vodScrollBar" class="scrollbar">
      <img src="images/vod/scrollBarFocus.png" style="width: 6px;height: 1px;" id="vodScrollBar1">
  </div>
</div>
<%@include file="inc/lastfocus.jsp" %>
</body>
<script type="text/javascript">
var stbType = Authentication.CTCGetConfig("STBType");
stbType = stbType.toUpperCase();
var areaIndex=parseInt("<%=positions[0]%>",10);  // 焦点区域索引 0表示栏目区域  1表示vod海报区域  2表示搜索按钮
var columnData = [];// 当前页码下的子栏目数据
var columnPage=parseInt("<%=positions[1]%>",10);// 栏目的当前页码
var columnTotalPage=1;// 栏目的总页码
var columnTotalCount=0;// 子栏目的总数
var columnIndex=parseInt("<%=positions[2]%>",10);// 栏目的索引
var columnNumCurPage=8;// 子栏目当前页码含有的栏目数
var programData = [];//当前页码下的VOD数据
var columnProgramData = [];//当前页码下的栏目VOD数据
var programPage=parseInt("<%=positions[3]%>",10); //  VOD的当前页码
var programIndex=parseInt("<%=positions[4]%>",10);  // 当前VOD的索引
var programNumCurPage=10;//VOD当前页码含有的VOD数
var programTotalPage=1;// VOD的总页码
var programTotalCount=0;//  VOD的总数
var columncode1="<%=columncode1%>";
var columncode3pb="<%=columncode3pb%>";//3级栏目，解决EC2016V1和HG650盒子卡死的问题
var keyFlag = false;  //按键保护
var isBack=true;//判断是否刚进入该页面
var isSonPage = "<%=isSonPage%>";
var vcolumncode="<%=columncode%>";
if(vcolumncode.length>4){
	vcolumncode=vcolumncode.substring(0,4);
}
//dom("test").innerText="columncode3pb:"+columncode3pb+"--vcolumncode:"+vcolumncode+"--stbType:"+stbType;
//节目横版展示不包括(爱看高清,电影,电视剧,体育和少儿)
var showFlag= (vcolumncode != '0B04'&& vcolumncode != '0B05'  && vcolumncode != '0B06' && vcolumncode != '0B0A' && vcolumncode != '0B0G');

function dokeyPress(evt) {
    if (keyFlag)return false;
    var keyCode = parseInt(evt.which ? evt.which : evt.keyCode);
    if (keyCode == <%=STBKeysNew.remoteBack%>) {
        doBack();
    } else if (keyCode == <%=STBKeysNew.remoteMenu%>) {
        // Authentication.CTCSetConfig("KeyValue", "0x110");
        // document.location = "portal.jsp";
         document.location = '<%=page_url%>' ; 
    } else if (keyCode == <%=STBKeysNew.onKeyUp%>) {
        doUp();
    } else if (keyCode == <%=STBKeysNew.onKeyDown%>) {
        doDown();
    } else if (keyCode == <%=STBKeysNew.onKeyLeft%>) {
        doLeft();
    } else if (keyCode == <%=STBKeysNew.onKeyRight%>) {
        doRight();
    } else if (keyCode == <%=STBKeysNew.onKeyOK%>) {
        doOK();
    } else if (keyCode == <%=STBKeysNew.remotePlayNext%>) {
        doPageDown();
    } else if (keyCode == <%=STBKeysNew.remotePlayLast%>) {
        doPageUp();
    } else if (keyCode == <%=STBKeysNew.remoteChannelPlus%>) {
        return;
    } else if (keyCode == <%=STBKeysNew.remoteChannelMinus%>) {
        return;
    } else if (keyCode == 1108) {
		window.location.href = 'portal_key.jsp?Action=1';
	} else if (keyCode == 1110) {
		window.location.href = 'portal_key.jsp?Action=2';
	} else if (keyCode == 1109) {
		window.location.href = 'portal_key.jsp?Action=3';
	} else if (keyCode == 1112) {
		window.location.href = 'portal_key.jsp?Action=4';
	} else {
        top.doKeyPress(evt);
        return true;
    }
    return false;
}
//
//清空子栏目名称
function clearColumn(){
    for(var i=0;i<8;i++){
        dom("column_name"+i).innerText="";
    }
}
//展示子栏目名称
function  showColumn(){
    clearColumn();
     for(var i=0;i<columnData.length;i++){
         // dom("column_name"+i).innerText="冰总hellohello" + columnData[i].columnname;
        stopScroll("column_name" +i,columnData[i].columnname);
        if(columncode1!=""){
//             alert("======xxx======="+columnData[i].index)
            if(columnData[i].index=="1"){
                columnIndex=i;
            }

         }
     }
    columncode1="";
    
	if(columnData[columnIndex].subexist == '1'){
		dom("vodPosterArea0").style.visibility = 'visible';
		dom("vodPosterArea").style.visibility = 'hidden';
		getProgramColumnData();
	}else if(showFlag == true){
		dom("vodPosterArea0").style.visibility = 'visible';
		dom("vodPosterArea").style.visibility = 'hidden';
		getProgramDataOth();
	}else{
		dom("vodPosterArea0").style.visibility = 'hidden';
		dom("vodPosterArea").style.visibility = 'visible';
		getProgramData();
	}
}
//横版显示节目
function getProgramDataOth() {
    keyFlag = true;
    var requestUrl = "action/get_vodprogram_data.jsp?columnid=" + columnData[columnIndex].columncode +
            "&curpage=" + programPage + "&numperpage=12";
    new net.ContentLoader(requestUrl, function () {
        var datatext = this.req.responseText;
        var data = eval("(" + datatext + ")");
        keyFlag = false;
        programData = data.vodData;
        programTotalPage = data.pagenums;
        programNumCurPage = programData.length;
        programTotalCount=data.totalCount;
        // 显示VOD总数
        dom("vodNum").innerHTML=columnData[columnIndex].columnname+"|共"+"<font color='#cc7d1d'>"+programTotalCount+"</font>"+"部影片";
        if(programTotalCount==0){
            doLeft();
        } else{
            // 设置滚动条滚动
            if(programTotalPage>1){
				showScrollBar();
            } else{
                dom("vodScrollBar").style.visibility="hidden";
                dom("vod_scrollbar1").style.visibility="hidden";
            }
            // 展示VOD数据
            showPorgramOth();
            getFocus();
        }
    });
}

// 横版显示节目
function showPorgramOth(){
    clearColumnProgram();
    for (var i = 0; i < programNumCurPage; i++) {
    	//解决EC2016V1盒子卡死的问题，替换成默认图  modify by cny 2017/8/9
	   	 if(vcolumncode=="0B0Z" && columncode3pb.length>6 && (stbType.indexOf('EC2106V1') != -1 || stbType.indexOf('HG650') != -1)){
			 dom("vodposter0_" + i).src =  "images/vod/column3_defaultPoster.png";
	   	 }else{
	   		 dom("vodposter0_" + i).src =  programData[i].normalposter;
	   	 }
         dom("programname0_" + i).innerText = programData[i].programName == undefined ? "" : programData[i].programName;
         stopScroll("programname0_" +i,programData[i].programName == undefined ? "" : programData[i].programName);
    }
    if(isBack){
        isBack=false;
        // 因为无论从其他页面返回还是第一次进入该页面，焦点只可能在搜索按钮区域和VOD海报区域
        if(areaIndex===1){
            //当焦点区域在VOD海报区域的时候，子栏目区域需要显示驻留效果
            hideColumnFocusDiv();
            getProgramFocus();
        }else if(areaIndex===2){
            // 当焦点在搜索按钮上的时候
            showSearchFocus();
        }
    }
}
// 子栏目上下箭头显示
function showColumnArrow(){
    var upArrow=dom("upArrow"),downArrow=dom("downArrow");
    if(columnPage>1){
        upArrow.style.visibility="visible";
    }else{
        upArrow.style.visibility="hidden";
    }
    if(columnPage<columnTotalPage){
        downArrow.style.visibility="visible";
    }else{
        downArrow.style.visibility="hidden";
    }

}
//子栏目失去焦点
function loseColumnFocus(){
    var ele=dom("column_name"+columnIndex);
    removeClass(ele,"columnNameFocus");
    stopScroll("column_name" + columnIndex, columnData[columnIndex].columnname);
}
/*
 获取子栏目数据
 */
 var tempcolumnData=[];
function getColumnData() {
    var requestUrl = "action/get_column.jsp?columnid=<%=columncode%>&destpage="+columnPage+"&columnid1="+columncode1;
    <%--var requestUrl = "action/channel_column.jsp?columnid=<%=columncode%>&destpage=1";--%>
    new net.ContentLoader(requestUrl, function () {
        // 获取栏目数据
        var columndata = eval("(" + this.req.responseText + ")");
        columnData=columndata.param;
		tempcolumnData=columnData;
        columnTotalCount=parseInt(columndata.totalcount,10);
        columnTotalPage=Math.ceil(columnTotalCount/8);
        columnNumCurPage=columnData.length;
        columnPage= columndata.destpageno;
        //展示箭头
        showColumnArrow();
        //展示子栏目
        showColumn();
    });
}

//子栏目获取焦点
function getColumnFocus(){
    var ele=dom("column_name"+columnIndex);
    addClass(ele,"columnNameFocus");
    starScroll("column_name" + columnIndex, columnData[columnIndex].columnname, 151);
    programPage=1;
	programIndex = 0;
	//dom("test").innerHTML+=columnData[columnIndex].columnname;
	//dom("test").innerHTML+="-------"+columnData[columnIndex].subexist;
	if(columnData[columnIndex].subexist == '1'){
		dom("vodPosterArea0").style.visibility = 'visible';
		dom("vodPosterArea").style.visibility = 'hidden';
		getProgramColumnData();
	}else if(showFlag == true){
		dom("vodPosterArea0").style.visibility = 'visible';
		dom("vodPosterArea").style.visibility = 'hidden';
		getProgramDataOth();
	}else{
		dom("vodPosterArea0").style.visibility = 'hidden';
		dom("vodPosterArea").style.visibility = 'visible';
    	getProgramData();
	}
}
function doRight() {
   if(areaIndex===0){
       // 子栏目的焦点框消失,显示驻留样式
       hideColumnFocusDiv();
        //子栏目区域
       areaIndex=1;
       getProgramFocus();
   }else if(areaIndex===1){
         //VOD海报区域
        if(programPage<programTotalPage){
			if(columnData[columnIndex].subexist == '1' || showFlag == true){
				if(programIndex<11){
					loseProgramFocus();
					programIndex++;
					getProgramFocus();
				}
			}else{
				if(programIndex<9){
					loseProgramFocus();
					programIndex++;
					getProgramFocus();
				}
			}
        }else{
            if(programIndex<programNumCurPage-1){
                loseProgramFocus();
                programIndex++;
                getProgramFocus();
            }
        }
   }
}
function doLeft() {
   if(areaIndex===1){
   		var programIndexTemp = 5;
		if(showFlag == true){
			programIndexTemp = 4;
		}else if(columnData[columnIndex].subexist == '1'){
			programIndexTemp = 4;
		}
		//alert(programIndexTemp +'----'+programIndex+'-----'+showFlag);
      // VOD海报区域
       if(programIndex==0||programIndex==programIndexTemp || (showFlag == true && programIndex==8) || (columnData[columnIndex].subexist == '1' && (programIndex==8 || programIndex==4))){
            loseProgramFocus();
            areaIndex=0;
            hideVODFocus();
            showColumnFocusDiv();
       }else{
           if(programIndex>0){
               loseProgramFocus();
               programIndex--;
               getProgramFocus();
           }
       }

   }
}
function doDown() {
    if(areaIndex==0){
       // 子栏目区域
        if(columnPage<columnTotalPage){
             if(columnIndex<7){
                  loseColumnFocus();
                  columnIndex++;
                  getColumnFocus();
             }else{
                 loseColumnFocus();
                 columnPage++;
                 columnIndex=0;
                 getColumnData();
                 getColumnFocus();
             }
        }else{
            // 子栏目最后一页
            if(columnIndex<columnNumCurPage-1){
                loseColumnFocus();
                columnIndex++;
                getColumnFocus();
            }
        }
    }else if(areaIndex==1){
			var pIndexTemp = 5;
			var programIndexTemp = 5;
			if(columnData[columnIndex].subexist == '1' || showFlag == true){
				programIndexTemp = 4;
				pIndexTemp = 8;
			}
        // VOD海报区域
       if(programPage<programTotalPage){
            if(programIndex<pIndexTemp){
                loseProgramFocus();
                programIndex+=programIndexTemp;
                getProgramFocus();
            }else{
                loseProgramFocus();
                programPage++;
                programIndex=0;
               	//getProgramData();
                //getProgramFocus();
				if(columnData[columnIndex].subexist == '1'){
					getProgramColumnData();
				}else if(showFlag == true){
					getProgramDataOth();
				}else{
					getProgramData();
				}
            }
       }else{
           //VOD海报最后一页
          if(programIndex<pIndexTemp){
              if(programIndex+programIndexTemp<programNumCurPage){
                  loseProgramFocus();
                  programIndex+=programIndexTemp;
                  getProgramFocus();
              }
          }
       }
    }else if(areaIndex==2){
        //  搜索按钮
        areaIndex=1;
        hideSearchFocus();
        showVODFocus();
        getProgramFocus();
    }
}
//  搜索按钮失去焦点
function hideSearchFocus(){
      dom("vodSearchFocus").style.visibility="hidden";
}
// 搜索按钮获取焦点
function showSearchFocus(){
    dom("vodSearchFocus").style.visibility="visible";
}
// 隐藏VOD焦点框
function  hideVODFocus(){
	if(columnData[columnIndex].subexist == '1' || showFlag == true){
   		dom("vodFocus0").style.visibility="hidden";
	}else{
   		dom("vodFocus").style.visibility="hidden";
	}
}
// 显示VOD焦点框
function  showVODFocus(){
	if(columnData[columnIndex].subexist == '1' || showFlag == true){
   		dom("vodFocus0").style.visibility="visible";
	}else{
   		dom("vodFocus").style.visibility="visible";
	}
}
//隐藏子栏目的焦点框
function hideColumnFocusDiv(){
    var ele=dom("column_name"+columnIndex);
    //先将焦点样式移除
    removeClass(ele,"columnNameFocus");
    //隐藏子栏目焦点框，需要显示子栏目驻留效果，添加驻留样式
    addClass(ele,"columnNameStay");
}
// 显示子栏目的焦点框
function showColumnFocusDiv(){
     var ele=dom("column_name"+columnIndex);
    // 显示子栏目焦点框，需要先移除，子栏目驻留样式
    removeClass(ele,"columnNameStay");
    // 然后使用焦点样式
    addClass(ele,"columnNameFocus");
}
function doUp() {
    if(areaIndex===0){
           // 子栏目区域
          if(columnIndex>0){
               loseColumnFocus();
               columnIndex--;
               getColumnFocus();
          }else{
              if(columnPage>1){
                    loseColumnFocus();
                    columnPage--;
                    columnIndex=7;
                    getColumnData();
              }
          }
    }else if(areaIndex===1){
		var programIndexTemp = 4;
		if(columnData[columnIndex].subexist == '1' || showFlag == true){
			programIndexTemp = 3;
		}
        // VOD海报区域
         if(programIndex>programIndexTemp){
                loseProgramFocus();
                programIndex-=programIndexTemp+1;
                getProgramFocus();
         }else{
             // 判断是否第一页
             if(programPage>1){
                 // 非第一页
                 loseProgramFocus();
                 programIndex=0;
                 programPage--;
				 if(columnData[columnIndex].subexist == '1'){
                 	getProgramColumnData();
				 }else if(showFlag == true){
					getProgramDataOth();
				 }else{
                 	getProgramData();
				 }
             }else{
                 // 第一页，焦点需要切换到搜索上
                 loseProgramFocus();
                 areaIndex=2;
                 hideVODFocus();
                 showSearchFocus();
             }
         }
    }
}
function doPageUp() {
    if(areaIndex===0){
        // 子栏目区域
        if(columnPage>1){
            loseColumnFocus();
            columnIndex=0;
            columnPage--;
            getColumnData();
        }
    }else if(areaIndex===1){
        // VOD海报区域
        if(programPage>1){
            loseProgramFocus();
            programPage--;
            programIndex=0;
			if(columnData[columnIndex].subexist == '1'){
            	getProgramColumnData();
			}else if(showFlag == true){
					getProgramDataOth();
			}else{
            	getProgramData();
			}
        }
    }
}
function doPageDown() {
      if(areaIndex===0){
          // 子栏目区域
          if(columnPage<columnTotalPage){
              loseColumnFocus();
              columnIndex=0;
              columnPage++;
              getColumnData();
              getColumnFocus();
          }
      }else if(areaIndex===1){
          // VOD海报区域
           if(programPage<programTotalPage){
                 loseProgramFocus();
                 programPage++;
                 programIndex=0;
				if(columnData[columnIndex].subexist == '1'){
					getProgramColumnData();
				}else if(showFlag == true){
					getProgramDataOth();
				}else{
					getProgramData();
				}
           }
      }
}
//重置封套模板
function restFTEPGModel(kc) {
	/*
	var requestUrl = "action/resetEPGModel.jsp?group_path=&kc="+kc;
	new net.ContentLoader(requestUrl, function () {
	});
	*/
}
function doOK() {
    var leefocus = areaIndex +"-"+ columnPage +"-"+ columnIndex +"-"+ programPage +"-"+ programIndex
	restFTEPGModel("|portal|0|" + leefocus+"|"+areaIndex);
    if(areaIndex===1){
		if(columnData[columnIndex].subexist == '1'){
			//if(isSonPage == '1'){
				//dom('test').innerHTML=columnData[columnIndex].columncode+'-----'+columnData[columnIndex].columnname+'-----'+programData[programIndex].columncode;
				var jumpUrl = "vod_portal_cgy.jsp?columncode=" +columnData[columnIndex].columncode +"&columnname=" 
					+columnData[columnIndex].columnname+'&chirldcolumncode='+programData[programIndex].columncode+"&is4K=<%=is4K%>&isVodPortal=1&leefocus=" + leefocus;
				restFTEPGModel("|portal|1|" + jumpUrl);
				document.location = jumpUrl;
			/*}else{
				document.location = "vod_new_list.jsp?columncode=" + columnData[columnIndex].columncode +
					"&chirldcolumncode=" + programData[programIndex].columncode +
					"&leefocus=" + leefocus+"&is4K=";
			}*/
		}else{
			restFTEPGModel("|portal|2|" + programData[programIndex].programType);
			restFTEPGModel("|portal|3|" + programData[programIndex].columnId);
			restFTEPGModel("|portal|4|" + programData[programIndex].programId);
			restFTEPGModel("|portal|5|" + programData[programIndex].mediaservices);
			if (programData[programIndex].programType == 1) {
				document.location = "vod_detail.jsp?columncode=" + programData[programIndex].columnId +
						"&programid=" + programData[programIndex].programId +
						"&mediaservices=" + programData[programIndex].mediaservices +
						"&leefocus=" + leefocus+"&is4K=<%=is4K%>";
			} else {
				document.location = "vod_series_head.jsp?columncode=" + programData[programIndex].columnId +
						"&programid=" + programData[programIndex].programId +
						"&mediaservices=" + programData[programIndex].mediaservices +
						"&leefocus=" + leefocus+"&is4K=<%=is4K%>";
			}
		}
    }else if(areaIndex===2){
       // 跳转到Search页面
        document.location="search.jsp?leefocus="+leefocus;
    }
}
function getProgramColumnData(){
	var requestUrl = "action/get_column.jsp?columnid="+columnData[columnIndex].columncode+"&destpage="+programPage+"&destpage="+programPage + "&numperpage=12";
    new net.ContentLoader(requestUrl, function () {
        // 获取栏目数据
        var columndata = eval("(" + this.req.responseText + ")");
        programData = columndata.param;
        programTotalCount = columndata.totalcount;
        programTotalPage = Math.ceil(programTotalCount/12);
        programNumCurPage = programData.length;
        // 显示VOD总数
        dom("vodNum").innerHTML=columnData[columnIndex].columnname+"|共"+"<font color='#cc7d1d'>"+programTotalCount+"</font>"+"个栏目";
		if(programTotalCount==0){
            doLeft();
        } else{
            // 设置滚动条滚动
            if(programTotalPage>1){
				showScrollBar();
            } else{
                dom("vodScrollBar").style.visibility="hidden";
                dom("vod_scrollbar1").style.visibility="hidden";
            }
            // 展示VOD数据
            showColumnPorgram();
            getFocus();
        }
		/*
		*/
    });
}
// 清除VOD数据
function clearColumnProgram(){
    for(var i = 0; i < 12; i++){
        dom("vodposter0_" + i).src = "images/vod/btn_trans.gif";
        dom("programname0_" + i).innerText = "";
        //将VOD海报位置恢复至默认状态
        resetProgramPoster(i);
    }
}
function showColumnPorgram(){
    clearColumnProgram();
    for (var i = 0; i < programNumCurPage; i++) {
		    //解决EC2016V1盒子卡死的问题，替换成默认图  modify by cny 2017/8/9
		   	 if(vcolumncode=="0B0Z" && columncode3pb.length>6 && (stbType.indexOf('EC2106V1') != -1 || stbType.indexOf('HG650') != -1)){
				 dom("vodposter0_" + i).src =  "images/vod/column3_defaultPoster.png";
		   	 }else{
		   		 dom("vodposter0_" + i).src = programData[i].imgUrl;
		   	 }
            dom("programname0_" + i).innerText = programData[i].columnname;
			//dom("test").innerHTML = dom("test").innerHTML + "<br />i:" + i + "   columnname:" + programData[i].columnname;
//             alert("======11111======")
           stopScroll("programname0_" +i,programData[i].columnname);
    }
    if(isBack){
        isBack=false;
        // 因为无论从其他页面返回还是第一次进入该页面，焦点只可能在搜索按钮区域和VOD海报区域
        if(areaIndex===1){
            //当焦点区域在VOD海报区域的时候，子栏目区域需要显示驻留效果
            hideColumnFocusDiv();
            getProgramFocus();
        }else if(areaIndex===2){
            // 当焦点在搜索按钮上的时候
            showSearchFocus();
        }
    }
}
// 获取VOD数据
function getProgramData() {
    keyFlag = true;
    var requestUrl = "action/get_vodprogram_data.jsp?columnid=" + columnData[columnIndex].columncode +
            "&curpage=" + programPage + "&numperpage=10";
    new net.ContentLoader(requestUrl, function () {
        var datatext = this.req.responseText;
        var data = eval("(" + datatext + ")");
        keyFlag = false;
        programData = data.vodData;
        programTotalPage = data.pagenums;
        programNumCurPage = programData.length;
        programTotalCount=data.totalCount;
        // 显示VOD总数
        dom("vodNum").innerHTML=columnData[columnIndex].columnname+"|共"+"<font color='#cc7d1d'>"+programTotalCount+"</font>"+"部影片";
        if(programTotalCount==0){
            doLeft();
        } else{
            // 设置滚动条滚动
            if(programTotalPage>1){
				showScrollBar();
            } else{
                dom("vodScrollBar").style.visibility="hidden";
                dom("vod_scrollbar1").style.visibility="hidden";
            }
            // 展示VOD数据
            showPorgram();
            getFocus();
        }
    });
}
//设置焦点
function getFocus(){
    if(areaIndex===0){
        showColumnFocusDiv();
        hideVODFocus();
    }else if(areaIndex===1){
        //当焦点区域在VOD海报区域的时候，子栏目区域需要显示驻留效果
        hideColumnFocusDiv();
        getProgramFocus();
    }else if(areaIndex===2){
        // 当焦点在搜索按钮上的时候
        showSearchFocus();
        hideVODFocus();
        hideColumnFocusDiv();
    }
}
// 清除VOD数据
function clearProgram(){
    for(var i = 0; i < 10; i++){
        dom("vodposter_" + i).src = "images/vod/btn_trans.gif";
        dom("programname_" + i).innerText = "";
        //将VOD海报位置恢复至默认状态
        resetProgramPoster(i);
    }
}
// 展示VOD数据
function showPorgram(){
    clearProgram();
    for (var i = 0; i < programNumCurPage; i++) {
	    	//解决EC2016V1盒子卡死的问题，替换成默认图  modify by cny 2017/8/9
		   	 if(vcolumncode=="0B0Z" && columncode3pb.length>6 && (stbType.indexOf('EC2106V1') != -1 || stbType.indexOf('HG650') != -1)){
				 dom("vodposter_" + i).src =  "images/vod/column3_defaultPoster.png";
		   	 }else{
	            dom("vodposter_" + i).src = programData[i].normalposter;
		   	 }
//            dom("programname_" + i).innerText = programData[i].programName;
//             alert("======11111======")
            stopScroll("programname_" +i,programData[i].programName == undefined ? "" : programData[i].programName);
    }
    if(isBack){
        isBack=false;
        // 因为无论从其他页面返回还是第一次进入该页面，焦点只可能在搜索按钮区域和VOD海报区域
        if(areaIndex===1){
            //当焦点区域在VOD海报区域的时候，子栏目区域需要显示驻留效果
            hideColumnFocusDiv();
            getProgramFocus();
        }else if(areaIndex===2){
            // 当焦点在搜索按钮上的时候
            showSearchFocus();
        }
    }
}
// VOD海报获取焦点
function getProgramFocus(){
    // 将海报放大
	if(columnData[columnIndex].subexist == '1'){
		var ele=dom("programpanel0_"+programIndex);
		addClass(ele,"programpanel0Focus"); 
		starScroll("programname0_" + programIndex, programData[programIndex].columnname, 350);  
		//移动外边框焦点图
		moveProgramFocusDiv();
	}else if(showFlag == true){
		var ele=dom("programpanel0_"+programIndex);
		addClass(ele,"programpanel0Focus"); 
		starScroll("programname0_" + programIndex, programData[programIndex].programName, 350);  
		//移动外边框焦点图
		moveProgramFocusDiv();
	}else{
		var ele=dom("programpanel_"+programIndex);
		addClass(ele,"programpanelFocus");
		starScroll("programname_" + programIndex, programData[programIndex].programName, 300);
		//移动外边框焦点图
		moveProgramFocusDiv();
	}
}
// VOD海报失去焦点
function loseProgramFocus(){
	if(columnData[columnIndex].subexist == '1' || showFlag == true){
		dom("vodFocus0").style.visibility="hidden";
	}else{
		dom("vodFocus").style.visibility="hidden";
	}
	resetProgramPoster(programIndex);
}
// 移动VOD海报焦点框
function moveProgramFocusDiv(){
	if(columnData[columnIndex].subexist == '1' || showFlag == true){
		var top="-37px";
		var left=235*(programIndex%4);
		if(programIndex>3 && programIndex<8){
			top="152px";
		}else if(programIndex>7 && programIndex<12){
			top="341px";
		}
		dom("vodFocus0").style.top=top;
		dom("vodFocus0").style.left=left+"px";
		dom("vodFocus0").style.visibility="visible";
	}else{
		var top="-6px";
		var left=35+182*(programIndex%5);
		if(programIndex>4){
			top="273px";
		}
		dom("vodFocus").style.top=top;
		dom("vodFocus").style.left=left+"px";
		dom("vodFocus").style.visibility="visible";
	}
}
//设置滚动条滚动
function showScrollBar(){
    dom("vodScrollBar").style.visibility="visible";
    dom("vod_scrollbar1").style.visibility="visible";
    // 设置滚动条的大小
    var scrollBarSize=Math.ceil(500/programTotalPage);
    var scrollBarHeight=scrollBarSize>500?500:scrollBarSize;
    dom("vodScrollBar1").style.height=scrollBarHeight;
    // 设置滚动条滚动的位置
    // 设置滚动条能够滚动的区域大小
    var scrollBottomSize=500-scrollBarHeight;
    var scrollY=Math.ceil((programPage/programTotalPage)*scrollBottomSize);
    var y=scrollY>scrollBottomSize?scrollBottomSize:scrollY;
    if(programTotalPage===1||programPage===1){
        y=0;
    }
    dom("vodScrollBar").style.top=y+"px";
}
/*
 *  海报还原为默认大小
 */
function resetProgramPoster(index){
	if(columnData[columnIndex].subexist == '1'){
		var ele=dom("programpanel0_"+index);
		removeClass(ele,"programpanel0Focus");
	//    alert("=========ssss=======")
		stopScroll("programname0_" + programIndex, programData[programIndex].columnname);
	}else if(showFlag == true){
		var ele=dom("programpanel0_"+index);
		removeClass(ele,"programpanel0Focus");
		stopScroll("programname0_" + programIndex, programData[programIndex].programName);
	}else{
		var ele=dom("programpanel_"+index);
		removeClass(ele,"programpanelFocus");
		stopScroll("programname_" + programIndex, programData[programIndex].programName);
	}
}
function doBack() {
        document.location = "back.jsp";
}
function getFarColumnData() {
    var requestUrl = "action/channel_column1.jsp?columnid=<%=columncode%>";
<%--var requestUrl = "action/channel_column.jsp?columnid=<%=columncode%>&destpage=1";--%>
    new net.ContentLoader(requestUrl, function () {
        // 获取栏目数据
		var datatext = this.req.responseText;
		var data = eval("(" + datatext + ")");
		dom("rootColumnName1").innerHTML=data.param[0].columnname;
    });
}
function initPage() {
	document.onkeypress = dokeyPress;
    getColumnData();
    getFarColumnData();
}

</script>
</html>