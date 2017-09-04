<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<epg:PageController name="vod_new_list.jsp"/>
<%
    String columncode=request.getParameter("columncode");
    String columncode1 = request.getParameter("chirldcolumncode");
//    columncode="07";
    String columnname=request.getParameter("columnname");
    if(columnname!=null&&!columncode.equals("")){
        columnname=java.net.URLDecoder.decode(columnname,"utf-8");
    }else{
        columnname="";
    }
    String lastfocus = String.valueOf(request.getParameter("lastfocus"));
    //System.out.println("6407000229:lastfocus:"+lastfocus);  vodPage+"-"+vodIndex+"-"+columnPage+"-"+columnIndex;
    if (lastfocus.equals("null") || lastfocus.equals("")) {
        lastfocus = "1-0-1-0-0";
    }  else{
        columncode1="";
    }
    String[] lastList=lastfocus.split("-");
%>
<html>
<head>
    <meta name="page-view-size" content="1280*720">
    <title>vod</title>
    <script type="text/javascript" src="js/stb_keys_new.js"></script>
    <script type="text/javascript" src="js/contentloader.js"></script>
    <script type="text/javascript" src="js/dom.js"></script>
    <style>
	body{ color:#FFF;}
    </style>
</head>
<body background="images/bg.png" style="overflow: hidden;" onLoad="init();">
<%@include file="inc/scrollString.jsp" %>
<div style="position:absolute;left:55px; top:27px;font-size: 40px;color: #fff;" id="rootColumnName1">
    <%--<%=columnname%>--%>
</div>
<div style="position: absolute;left:88px;top:70px;width: 1128px;height: 68px;">
    <div style="position: absolute;left:0px;top:10px;width: 194px;height: 93px;visibility: hidden;" id="columnblur">
        <img src="images/tvProgram/upListBg.png">
    </div>
    <div style="position: absolute;left:-15px;top:-7px;width: 194px;height: 93px;visibility: hidden;" id="columnfocus">
        <img src="images/tvProgram/upListFocus.png">
    </div>
<%
        for (int i = 0; i < 6; i++) {
    %>
    <div style="position: absolute;left:<%=i*178+10%>px;top:0px;width: 148px;height: 68px;line-height:68px;font-size: 28px;color: #fff;"
          class="" id="column<%=i%>" align="center">
        <%--开门大吉我哎你啊啊啊--%>
    </div>
    <%
        }
    %>

</div>
<div style="position: absolute;left:42px;top:91px;visibility: hidden;" id="columnLeft">
      <img src="images/tvProgram/upPageLeft.png">
</div>
<div style="position: absolute;left:1187px;top:91px;visibility: hidden;" id="columnRight">
    <img src="images/tvProgram/upPageRight.png">
</div>

<div style="position: absolute;left:88px;top:169px;width: 558px;height: 600px;">
    <div style="position: absolute;left:-10px;top:0px;width: 194px;height: 93px;z-index:10;visibility: hidden;" id="vodblur1">
        <img src="images/tvProgram/leftListBg.png">
    </div>
    <div style="position: absolute;left:-10px;top:0px;width: 194px;height: 93px;z-index:12;visibility: hidden;" id="vodblur">
        <img src="images/tvProgram/leftListBg.png">
    </div>
    <div style="position: absolute;left:-27px;top:-20px;width: 194px;height: 93px;z-index:12;visibility: hidden;" id="vodfocus">
        <img src="images/tvProgram/leftListFocus.png">
    </div>
<%
          for(int i=0;i<8;i++){
      %>
      <div style="position: absolute;left:6px;top:<%=i*64%>px;width: 480px;height: 64px;z-index:12;line-height:64px;font-size: 25px;color: #fff;"
           class="" id="vod<%=i%>">
          <%--开门大吉我哎你啊啊啊了京东方撒了点积分领导--%>
      </div>
    <%
        }
    %>
</div>
<div style="position: absolute;left:42px;top:372px;visibility: hidden;" id="pageLeft">
    <img src="images/tvProgram/leftPageLeft.png">
</div>
<div style="position: absolute;left:638px;top:372px;visibility: hidden;" id="pageRight">
    <img src="images/tvProgram/leftPageRight.png">
</div>

<div style="position: absolute;left:679px;top:220px;width: 506px;height: 288px;border:solid 2px white;">
    <iframe id="xx_0" style="left:0px;top:0px;width: 506px;height: 288px; position:absolute;"
            src="empty.jsp"></iframe>
</div>
<div style="position: absolute; left:679px; top:520px; width: 506px; height: 136px; font-size: 28px; color: #fff;" align="center" id="name">

</div>

<div id="" style="color:#CCC; position:absolute; width: 569px; height: 26px; left: 674px; top: 661px; letter-spacing:2px;"><span id="page" style="font-size:35px;">     </span> &nbsp;&nbsp; &nbsp;请按"确认"键播放，再按一次"确认"键全屏播放</div>
</div>
<script>
    var areaFlag="<%=lastList[4]%>";
    var columnIndex=parseInt("<%=lastList[3]%>");
    var lastcolumnIndex=-1;
    var columnPage=parseInt("<%=lastList[2]%>");
    var columnTotalpage=0;
    var columnData=new Array();
          //vodPage+"-"+vodIndex+"-"+columnPage+"-"+columnIndex;
    var vodIndex=parseInt("<%=lastList[1]%>");
    var lastvodIndex=vodIndex;
    var vodPage="<%=lastList[0]%>";
    var vodTotalpage=0;
    var vodData=new Array();
    var columncode1="<%=columncode1%>" ;
    var playInedx=0;
    function stopstr(id,str,len){
        if(str==""){
            return "";
        }
        if(str.length>len){
            str=str.substring(0,len)+"...";
        }
        document.getElementById(id).innerHTML = str;
    }
    function starstr(id,str,len){
        if(str==""){
            return "";
        }
        if(str.length>len){
            str= "<marquee version='5'>" + str + "</marquee>";
        }
        document.getElementById(id).innerHTML = str;
    }
    function getColumn(){
        var requestUrl = "action/get_column.jsp?columnid=<%=columncode%>&numperpage=6&destpage="+columnPage+"&columnid1="+columncode1;
        new net.ContentLoader(requestUrl, function () {
//                var datatext = this.req.responseText;
            columnData=new Array();
            var data = eval("(" + this.req.responseText + ")");
            columnData = data.param;
            columnTotalpage=data.totalpages;
            columnPage=data.destpageno;
//            if(columnTotalpage>1){
//               dom("columnLeft").style.visibility="visible";
//               dom("columnRight").style.visibility="visible";
//            }
            if(columnPage==columnTotalpage&&columnPage>1){
                dom("columnLeft").style.visibility="visible";
               dom("columnRight").style.visibility="hidden";
            } else if(columnPage==columnTotalpage&&columnPage==1) {
                dom("columnLeft").style.visibility="hidden";
                dom("columnRight").style.visibility="hidden";
            } else if(columnPage==1){
                dom("columnLeft").style.visibility="hidden";
                dom("columnRight").style.visibility="visible";
            } else{
                dom("columnLeft").style.visibility="visible";
               dom("columnRight").style.visibility="visible";
            }
            for(var i=0;i<6;i++){
                if(i<columnData.length){
//                    dom("column"+i).innerHTML=columnData[i].columnname;
//                    stopScroll("column" +i,columnData[i].columnname);
                    stopstr("column" +i,columnData[i].columnname,4);
                    if(columncode1!=""){
                        if(columnData[i].index=="1"){
                            columnIndex=i;
                        }
                    }
                }else{
                    dom("column"+i).innerHTML="";
                }
            }
//            alert("=======vodIndex========"+vodIndex)
            columncode1="";
            if(areaFlag==0){
                moveColumnfocus(1);
            }else{
                dom("columnblur").style.left=columnIndex*178+"px";
                dom("columnfocus").style.left=-15+columnIndex*178+"px";
                dom("columnblur").style.webkitTransitionDuration = 0;
                dom("columnfocus").style.webkitTransitionDuration = 0;
                moveColumnblur();
//                alert("======lastcolumnIndex===="+lastcolumnIndex);
                lastcolumnIndex=(columnPage-1)*6+columnIndex;
//                alert("======lastcolumnIndex==111=="+lastcolumnIndex);
                getVod();
            }
        });
    }
    function moveColumnfocus(id){
        dom("columnblur").style.visibility="visible";
        dom("columnfocus").style.visibility="visible";
        dom("columnblur").style.left=parseInt(columnIndex,10)*178+"px";
        dom("columnfocus").style.left=-15+parseInt(columnIndex,10)*178+"px";
        dom("columnblur").style.webkitTransitionDuration = 300;
        dom("columnfocus").style.webkitTransitionDuration = 300;
        if(id==0){
//            stopScroll("column" + columnIndex,columnData[columnIndex].columnname);
            stopstr("column" + columnIndex,columnData[columnIndex].columnname,4);
        }else{
//            starScroll("column" + columnIndex,columnData[columnIndex].columnname,168);
            starstr("column" + columnIndex,columnData[columnIndex].columnname,4);
        }
        setTimeout(function(){
            if(lastcolumnIndex==(columnPage-1)*6+columnIndex) return;
            lastcolumnIndex=(columnPage-1)*6+columnIndex;
            //alert(lastcolumnIndex+"============"+columnIndex);
            vodPage=1;
            vodIndex=0;
            getVod();
        },500);
    }
    function moveColumnblur(){
        dom("columnblur").style.visibility="visible";
        dom("columnfocus").style.visibility="hidden";
//        stopScroll("column" + columnIndex,columnData[columnIndex].columnname);
        stopstr("column" + columnIndex,columnData[columnIndex].columnname,4);
    }
    function getVod(){
        var requestUrl = "action/get_vodprogram_data.jsp?columnid="+columnData[columnIndex].columncode+"&numperpage=8&curpage="+vodPage;
        new net.ContentLoader(requestUrl, function () {
//                var datatext = this.req.responseText;
            vodData=new Array();
            var data = eval("(" + this.req.responseText + ")");
            vodData = data.vodData;
            vodTotalpage=data.pagenums;
//            if(vodTotalpage>1){
//                dom("pageLeft").style.visibility="visible";
//                dom("pageRight").style.visibility="visible";
//            }
            if(vodPage==vodTotalpage&&vodPage>1){
                dom("pageLeft").style.visibility="visible";
                dom("pageRight").style.visibility="hidden";
            } else if(vodPage==vodTotalpage&&vodPage==1) {
                dom("pageLeft").style.visibility="hidden";
                dom("pageRight").style.visibility="hidden";
            } else if(vodPage==1){
                dom("pageLeft").style.visibility="hidden";
                dom("pageRight").style.visibility="visible";
            } else{
                dom("pageLeft").style.visibility="visible";
                dom("pageRight").style.visibility="visible";
            }
            //alert("======vodTotalpage====="+vodTotalpage);
            for(var i=0;i<8;i++){
                if(i<vodData.length){
//                    dom("vod"+i).innerHTML=vodData[i].programName;
//                    stopScroll("vod" +i,vodData[i].programName);
                    stopstr("vod" +i,vodData[i].programName,16);
//                    stopstr("vod" +i,"我多了几分了电视剧放大了当减肥鹿鼎记发了啥剪短发了辅导老师解放路少打飞机市领导房间爱丽丝的房间",20);
                }else{
                    dom("vod"+i).innerHTML="";
                }
            }
            if(vodData.length==0){
                dom("page").innerHTML="";
            } else{
                dom("page").innerHTML=vodPage+"/"+vodTotalpage;
               // if(playInedx==0){
                    playInedx=1;
                lastvodIndex=vodIndex;
                    getvodplayurl();
                    dom("vodblur1").style.visibility="visible";
//                dom("vodfocus").style.visibility="visible";
                    dom("vodblur1").style.top=parseInt(vodIndex,10)*64+"px";


            }
            if(areaFlag==1){
                moveVodfocus(1);
                dom("vodblur1").style.visibility="visible";
//                dom("vodfocus").style.visibility="visible";
                dom("vodblur1").style.top=parseInt(vodIndex,10)*64+"px";
            }
        });
    }
    function moveVodfocus(id){
        dom("vodblur").style.visibility="visible";
        dom("vodfocus").style.visibility="visible";
        dom("vodblur").style.top=parseInt(vodIndex,10)*64+"px";
        dom("vodfocus").style.top=-20+parseInt(vodIndex,10)*64+"px";
        if(id==0){
            //alert("======11=======");
//            stopScroll("vod" + vodIndex,vodData[vodIndex].programName);
            stopstr("vod" + vodIndex,vodData[vodIndex].programName,16);
        }else{
//            starScroll("vod" + vodIndex,vodData[vodIndex].programName,510);
            starstr("vod" + vodIndex,vodData[vodIndex].programName,16);
        }
        dom("vodblur").style.webkitTransitionDuration = 300;
        dom("vodfocus").style.webkitTransitionDuration = 300;

    }
    function moveVodblur(){
        dom("vodblur").style.visibility="hidden";
        dom("vodfocus").style.visibility="hidden";
//        stopScroll("vod" + vodIndex,vodData[vodIndex].programName);
        stopstr("vod" + vodIndex,vodData[vodIndex].programName,16);
    }
    function colsemp(){
        try{
            window.frames["xx_0"].destoryMP();
        }catch(e){
            //alert("==================");
        }

    }
    function getvodplayurl(){
        colsemp();
        var requestUrl = "action/get_vod_playUrL.jsp?programList=" +vodData[lastvodIndex].programId +"&vodListIndex=0";
        new net.ContentLoader(requestUrl, function() {
            var data = eval("(" + this.req.responseText + ")");
            var dataLength=data.length;
//            alert("=====dataLength======="+dataLength);
            if(data[0].playUrl!=""){
                var playurl= data[0].playUrl;
                playurl=encodeURIComponent(encodeURIComponent(playurl));
//                alert("======playurl======"+playurl);
//                dom("xx_0").src = "small_player.jsp?left=679&top=220&width=506&height=288&playurl="+playurl;
            }
            dom("xx_0").src = "small_player.jsp?left=679&top=220&width=506&height=288&playurl="+playurl;
            dom("name").innerHTML=vodData[lastvodIndex].programName;

        });
    }
    function doBack() {
        document.location = "back.jsp";
    }
    function doLeft(){
        if(areaFlag==0){
            if(columnIndex>0){
                moveColumnfocus(0);
                columnIndex--;
                moveColumnfocus(1);
            }else{
                if(columnPage>1){
                    moveColumnfocus(0);
                    columnPage--;
                    columnIndex=5;
                    getColumn();

                }
            }
        }else{
            if(vodPage>1){
                moveVodfocus(0);
                vodPage--;
                vodIndex=0;
                getVod();
//                moveVodfocus(1);
            }
        }
    }
    function doRight(){
        if(areaFlag==0){
            if(columnIndex<columnData.length-1){
                moveColumnfocus(0);
                columnIndex++;
                moveColumnfocus(1);
            }else{
                if(columnPage<columnTotalpage){
                    moveColumnfocus(0);
                    columnPage++;
                    columnIndex=0;
                    getColumn();

                }
            }
        }else{
            if(vodPage<vodTotalpage){
                moveVodfocus(0);
                vodPage++;
                vodIndex=0;
                getVod();
//                moveVodfocus(1);
            }
        }
    }
    function doUp(){
        if(areaFlag==0){

        }else{
            if(vodIndex>0){
                moveVodfocus(0);
                vodIndex--;
                moveVodfocus(1);
            }else{
               areaFlag=0;
               moveVodblur();
               moveColumnfocus(1);
            }
        }
    }
    function doDown(){
        if(areaFlag==0){
            if(vodData.length>0){
                areaFlag=1;
                moveColumnblur();
                moveVodfocus();
                dom("vodblur1").style.visibility="visible";
//                alert("========lastvodIndex========"+lastvodIndex);
                dom("vodblur1").style.top=parseInt(lastvodIndex,10)*64+"px";
            }
        }else{
           if(vodIndex<vodData.length-1){
               moveVodfocus(0);
               vodIndex++;
               moveVodfocus(1);
           }
        }
    }
//    var isfirst=0;
    function doOk(){

        if(areaFlag==1){
            //alert(lastvodIndex+"================"+vodIndex);
           if(lastvodIndex==vodIndex){
               var leefocus=vodPage+"-"+vodIndex+"-"+columnPage+"-"+columnIndex+"-"+areaFlag;
               var url="zhuanti_play.jsp";
               //alert("====linkURL====" + programData[(page - 1) * 6 + index].linkURL);
               //document.location=programData[index].linkURL;
               if(url.indexOf("?")>-1){
                   url=url+"&leefocus="+leefocus;
               }else{
                   url=url+"?leefocus="+leefocus;
               }
               url=url+"&programcode="+vodData[vodIndex].programId+"&vodtype=101";
               document.location=url;
//               document.location="zhuanti_play.jsp";
           } else{
               lastvodIndex=vodIndex;
               dom("vodblur1").style.visibility="visible";
               dom("vodblur1").style.top=parseInt(vodIndex,10)*64+"px";
               getvodplayurl();
           }
        }
    }
    function dokeyPress(evt) {
        //alert("---------");
        var keyCode = parseInt(evt.which);
        if (keyCode == 0x0008) {
            doBack();
        } else if (keyCode == 0x0025) { //onKeyLeft
            doLeft();
        } else if (keyCode == 0x0027) { //onKeyRight
            doRight();
        } else if (keyCode == 0x0026) {//onKeyUp
            doUp();
        } else if (keyCode == 0x0028) { //onKeyDown
            doDown();
        } else if (keyCode == 0x000D) {  //OK
             doOk();
        } else if (keyCode == 34) {
            //doPageDown();
            if (areaFlag == 0) {
                if (columnPage < columnTotalpage) {
                    moveColumnfocus(0);
                    columnPage++;
                    columnIndex = 0;
                    getColumn();
                }
            } else {
                if (vodPage < vodTotalpage) {
                    moveVodfocus(0);
                    vodPage++;
                    vodIndex = 0;
                    getVod();
//                moveVodfocus(1);
                }
            }
        } else if (keyCode == 33) {
            // doPageUp();
            if (areaFlag == 0) {
                if (columnPage > 1) {
                    moveColumnfocus(0);
                    columnPage--;
                    columnIndex = 0;
                    getColumn();

                }
            } else {
                if (vodPage > 1) {
                    moveVodfocus(0);
                    vodPage--;
                    vodIndex = 0;
                    getVod();
//                moveVodfocus(1);
                }
            }
        }else if (keyCode == 768) {
            var dummyKeyCode = Utility.getEvent();
            var  eventType="";
            if(dummyKeyCode.length>0){
                var values=eval('('+dummyKeyCode+')');
                eventType= values["type"]||values["Type"];
            }
            //alert("======eventType========="+eventType);
            if(eventType=="EVENT_MEDIA_END"){
                //alert("=======bixxxxx=====");
               if(lastvodIndex<vodData.length-1){
                   lastvodIndex++;
//                   moveVodfocus();
               }else{
                   if(vodPage<vodTotalpage){
                       vodPage++;
                       getVod();
                       vodIndex=0;
                       lastvodIndex=0;
//                       moveVodfocus();
                   }else{
                       vodPage=1;
                       getVod();
                       vodIndex=0;
                       lastvodIndex=0;
                   }
               }
//                lastvodIndex=vodIndex;
//                if(areaFlag==1){
//                    moveVodfocus();
//                }
                getvodplayurl();
                dom("vodblur1").style.visibility="visible";
                dom("vodblur1").style.top=parseInt(lastvodIndex,10)*64+"px";
            }
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
    document.onkeydown = dokeyPress;
//    window.focus();
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
   function init(){
       getColumn();
       getFarColumnData();
       if(areaFlag==1){
           moveColumnblur();
           moveVodfocus(1);
       }
   }
    
</script>
<%@include file="inc/lastfocus.jsp" %>

</body>
</html>
