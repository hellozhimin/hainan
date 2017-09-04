<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<epg:PageController name="zhuanti_list1.jsp"/>
<%
    String index=request.getParameter("type");
    String lastfocus = String.valueOf(request.getParameter("lastfocus"));
    //System.out.println("6407000229:lastfocus:"+lastfocus);  vodPage+"-"+vodIndex+"-"+columnPage+"-"+columnIndex;
    if (lastfocus.equals("null") || lastfocus.equals("")) {
        lastfocus = "1-0";
    }
    String[] lastList=lastfocus.split("-");
%>
<html>
<head>
    <meta name="page-view-size" content="1280*720">
    <title>vod</title>
    <style>
        .font_ellipsis {
            /*overflow: hidden;*/
            /*white-space: nowrap;*/
            /*text-overflow: ellipsis;*/
        }
        .right_div div {
            -webkit-transform: scale(1.1, 1.1);
            -moz-transform: scale(1.1, 1.1);
            -transform: scale(1.1, 1.1);
        }

        .imgStyle0 {
            -webkit-transform: scale(1.1, 1.1);
            -moz-transform: scale(1.1, 1.1);
            -transform: scale(1.1, 1.1);
        }
        div{
            -webkit-transition-duration: 300ms;
        }
.myfocusStyle0{position: absolute; left:18px; top:29px; width: 261px; height: 168px;}
.myfocusStyle1{position: absolute; left:18px; top:194px; width: 261px; height: 168px;}
.myfocusStyle2{position: absolute; left:18px; top:367px; width: 261px; height: 168px;}
.myfocusStyle3{position: absolute; left:18px; top:542px; width: 261px; height: 168px;}
    </style>
    <script type="text/javascript" src="js/contentloader.js"></script>
    <script type="text/javascript" src="js/dom.js"></script>
    <%--<script type="text/javascript" src="data/zhuanti_list1.js"></script>--%>
    <%@include file="inc/scrollString.jsp" %>
</head>
<body  style="width: 1280px;height: 720px;overflow: hidden;" bgcolor="transparent">
 <div style="position: absolute; left: 0px; top:0px; width: 1280px; height: 720px;">
       <img src="images/btn_trans.gif" id="bgpic">
 </div>
<div style="position: absolute; left: 915px; top:0px; width: 300px; height: 720px;" id="my">
        <div style="position: absolute; left:40px; top:50px; width: 218px; height: 128px;" id="mydiv0">
          
            <img src="images/btn_trans.gif" id="myimg0" width="218" height="128">
            <font id="myName_0"
                  style="position:absolute; width: 209px; height: 30px; font-size:20px; left: 3px; top: 80px; line-height:30px;color: #fff;" class="font_ellipsis"></font>
            <font id="mySeName_0"
                  style="position:absolute; width: 209px; height: 20px; font-size:17px; left: 3px; top: 102px; line-height:20px;color: #606060;" class="font_ellipsis"></font>
        </div>
        <div style="position: absolute; left:40px; top:215px; width: 218px; height: 128px;" id="mydiv1">
            
            <img src="images/btn_trans.gif" id="myimg1" width="218" height="128">
            <font id="myName_1"
                  style="position:absolute; width: 209px; height: 30px; font-size:20px; left: 3px; top: 80px; line-height:30px;color: #fff;" class="font_ellipsis"></font>
            <font id="mySeName_1"
                  style="position:absolute; width: 209px; height: 20px; font-size:17px; left: 3px; top: 102px; line-height:20px;color: #606060;" class="font_ellipsis"></font>

        </div>
        <div style="position: absolute; left:40px; top:388px; width: 218px; height: 128px;" id="mydiv2">
           
            <img src="images/btn_trans.gif" id="myimg2" width="218" height="128">
            <font id="myName_2"
                  style="position:absolute; width: 209px; height: 30px; font-size:20px; left: 3px; top: 80px; line-height:30px;color: #fff;" class="font_ellipsis"></font>
            <font id="mySeName_2"
                  style="position:absolute; width: 209px; height: 20px; font-size:17px; left:3px; top: 102px; line-height:20px;color: #606060;" class="font_ellipsis"></font>

        </div>
<div style="position: absolute; left:40px; top:563px; width:218px; height: 128px;" id="mydiv3">

            <img src="images/btn_trans.gif" id="myimg3" width="218" height="128">
    <font id="myName_3"
          style="position:absolute; width: 209px; height: 30px; font-size:20px; left: 3px; top: 80px; line-height:30px;color: #fff;" class="font_ellipsis"></font>
    <font id="mySeName_3"
          style="position:absolute; width: 209px; height: 20px; font-size:17px; left: 3px; top: 102px; line-height:20px;color: #606060;" class="font_ellipsis"></font>

</div>

      <div class="myfocusStyle0" id="myfocus" style="background:url(images/zhuanti/list1/f0.png) no-repeat;">
          <!--<img src="images/zhuanti/list1/f0.png" id="myfocusimg">-->
      </div>

</div>
<div style="position: absolute;left: 85px;top:235px;width: 724px;height: 415px;">
    <iframe id="xx_0" style="left:0px;top:0px;width: 724px;height: 415px; position:absolute;"
            src="empty.jsp"></iframe>
</div>
<div style="position: absolute;left: 73px;top:224px;visibility: hidden;" id="playfocus">
    <img src="images/zhuanti/list1/f1.png">
</div>
<div style="position: absolute;left: 85px;top:665px;font-size: 28px;color: #7A7976;" id="playname">

</div>
<div id="test" style="position:absolute; width: 266px; height: 97px; left: 157px; top: 50px;"></div>
<script>
    var indexFocus = parseInt("<%=lastList[1]%>",10);              //当前下标
	var index=indexFocus;
    var programData = new Array();
    var totalPage=0;
    var page=parseInt("<%=lastList[0]%>",10);
    var areaFlag=1;
    function donothing() {
        return false;
    }
    function pageBack(){
//        top.jsHideOSD();
        document.location="back.jsp";
    }
    function dook(){
        if(indexFocus ==index){
			areaFlag=1;
            var leefocus=page+"-"+index;
            var url=programData[(page - 1) * 6 + index].linkURL;
//            //alert("====linkURL====" + programData[(page - 1) * 6 + index].linkURL);
            //document.location=programData[index].linkURL;
            if(url.indexOf("?")>-1){
                url=url+"&leefocus="+leefocus;
            }else{
                url=url+"?leefocus="+leefocus;
            }
            url=url+"&programcode="+programData[(page - 1) * 6 + index].programcode+"&vodtype=100";
            document.location=url;
//            document.location=programData[index].linkURL;
        } else{
			indexFocus=index;
            areaFlag=0;
            movefocus(1);
            getvodplayurl();
        }
    }
    function doRight(){
        
    }
    function showObj(){
        var start = 0;
        var end = 0;
        if (totalPage == page) {
            start = (page - 1) * 4;
            end = programData.length;
        } else {
            start = (page - 1) * 4;
            end = page * 4;
        }
//        console.log(start+"=============="+end);
        for (var i = 0; i < 4; i++) {
            if (i < (end - start)) {
                dom("myimg" + i).src = programData[start + i].images;
                stopScroll("myName_"+i,programData[start + i].name);
                dom("mySeName_"+i).innerHTML=programData[start + i].subname;
               } else {
                dom("myimg" + i).src = "images/btn_trans.gif";
                dom("mySeName_"+i).innerHTML="";
                dom("myName_"+i).innerHTML="";
            }
        }
    }
    function doUp(){
        if (index > 0) {
            movefocus(0);
            index--;
            movefocus(1);
        } else {
            if (page == 1) return;
            if (page > 1) {
                page--;
            }
            movefocus(0);
            showObj();
            index = 3;
            movefocus(1);
        }
    }
    function doDown(){
        if (index < 3) {
            if ((page - 1) * 4 + 1 + index > programData.length-1) {
//                index--;
                return;
            } else{
         		movefocus(0);
                index++;
         		movefocus(1);
            }

        } else {
            if (page < totalPage) {
         		movefocus(0);
                page++;
                showObj();
                index = 0;
         		movefocus(1);
            }

        }

    }
    function movefocus(id){
         if(id==0){
           		  	dom("mydiv"+index).style.webkitTransform="scale(1)";
				 setTimeout(function(){
          			  dom("myfocus").style.webkitTransform="scale(1)";

				},100);
             stopScroll("myName_"+index,programData[(page-1)*4+index].name);
         }else{
				 setTimeout(function(){
            	 	dom("myfocus").style.webkitTransform="scale(1.1)";
            	 	dom("mydiv"+index).style.webkitTransform="scale(1.1)";
                     starScroll("myName_"+index,programData[(page-1)*4+index].name,218);
				},100);
         }
		dom("myfocus").className="myfocusStyle"+index;
    }
    function init(){
        if(programData.length==0){

        } else{
            totalPage = Math.ceil(programData.length / 4);
            showObj();
			dom("myfocus").className="myfocusStyle"+index;
            movefocus(1);
            getvodplayurl();
        }

    }
    function getvodplayurl(){
         dom("playname").innerText="当前播放："+programData[(page-1)*4+index].name;
        var requestUrl = "action/get_vod_playUrL.jsp?programList=" +programData[(page-1)*4+index].programcode +"&vodListIndex="+index;
        new net.ContentLoader(requestUrl, function() {
            var data = eval("(" + this.req.responseText + ")");
            var dataLength=data.length;
            if(data[0].playUrl!=""){
                var playurl= data[0].playUrl;
                playurl=encodeURIComponent(encodeURIComponent(playurl));
               dom("xx_0").src = "small_player.jsp?left=85&top=235&width=724&height=415&playurl="+playurl;
            }

        });
    }
//    init();
    function getZhuantiDate(){
//        //alert("===============");
        var requestUrl = "action/get_zhuanti.jsp?index=<%=index%>";
        new net.ContentLoader(requestUrl, function () {
            var data = eval("(" + this.req.responseText + ")");
            programData=data;
//            //alert("=====navigationJSON===="+navigationJSON);
            init();
        });
    }
    function getZhuantiBgpic(){
//        alert("===============");
        var requestUrl = "action/get_zhuantipic.jsp?index=1";
        new net.ContentLoader(requestUrl, function () {
            var data = eval("(" + this.req.responseText + ")");
//            alert("=============da----"+data.images);
            dom("bgpic").src=data.images;
        });
    }
    getZhuantiBgpic();
    getZhuantiDate();
    function doMenu(){
        top.mainWin.document.location = "portal.jsp";
    }
    function dokeypress(evt){
        var keyCode = parseInt(evt.which);
        if (keyCode == 0x0008) {
            pageBack();
        } else if (keyCode == 0x0025) { //onKeyLeft
//            doLeft();

        } else if (keyCode == 0x0027) { //onKeyRight
            doRight();

        } else if (keyCode == 0x0026) {//onKeyUp
            doUp();
        }
        if (keyCode == 0x0028) { //onKeyDown
            doDown();

        } else if (keyCode == 0x000D) {  //OK
            dook();
        }else if (keyCode == 768) {
            var dummyKeyCode = Utility.getEvent();
            var  eventType="";
            if(dummyKeyCode.length>0){
                var values=eval('('+dummyKeyCode+')');
                eventType= values["type"]||values["Type"];
            }
//            //alert("======eventType========="+eventType);
            if(eventType=="EVENT_MEDIA_END"){
//                //alert("=======bixxxxx=====");
                if (index < 3) {
                    if ((page - 1) * 4 + 1 + index > programData.length-1) {
                        index--;
                        movefocus(0);
                        index=0;
                        page=1;
                        showObj();
                        movefocus(1);
                        getvodplayurl();
                        return;
                    } else{
                        movefocus(0);
                        index++;
                    }
                    movefocus(1);
                    getvodplayurl();
                } else {
                    if (page < totalPage) {
                        page++;
                        showObj();
                        index = 0;
                        movefocus(1);
                    }else if(page == totalPage){
                        page=1;
                        showObj();
                        index = 0;
                        movefocus(1);
                    }
                    getvodplayurl();
                }

            }
        } else {
            top.doKeyPress(evt);
            return true;
        }
        return false;
    }
    <%--top.jsSetupKeyFunction("top.mainWin.dook", <%=STBKeysNew.onKeyOK%>);--%>
    <%--top.jsSetupKeyFunction("top.mainWin.pageBack", <%=STBKeysNew.remoteBack%>);--%>
    <%--top.jsSetupKeyFunction("top.mainWin.doMenu", <%=STBKeysNew.remoteMenu%>);--%>
    document.onkeydown = dokeypress;
    window.focus();
</script>
<%@include file="inc/lastfocus.jsp" %>

</body>
</html>
