<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.zte.iptv.epg.util.*" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<epg:PageController name="channel_tvod_list.jsp"/>
<%
//    String mixno = request.getParameter("mixno");
//    String columncode = request.getParameter("columncode");
    String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
    HashMap param = PortalUtils.getParams(path, "UTF-8");
    String parentcode = String.valueOf(param.get("channelRootColumnId"));
    String channelcolumncode = String.valueOf(param.get("column0"));
    String lastfocus = String.valueOf(request.getParameter("lastfocus"));
    //System.out.println("6407000229:lastfocus:"+lastfocus);
    String lastindex="0";
    if (lastfocus.equals("null") || lastfocus.equals("")) {
        lastfocus = "2-1-0-0-1-0";
        lastindex="1";
    }
    String[] lastList=lastfocus.split("-");
%>
<html>
<head>
    <title>channel_all_ok</title>
    <meta name="page-view-size" content="1280*720"/>
    <meta http-equiv="content-Type" content="text/html; charset=utf-8">
    <script type="text/javascript" src="js/contentloader.js"></script>
    <script type="text/javascript" src="js/dom.js"></script>
    <style>
        .font_ellipsis {
          /*  overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;*/
        }
    </style>
</head>
<body bgcolor="transparent"  style="overflow: hidden;" onLoad="init();">
<div style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px;">
    <img src="images/bg.png">
</div>
<div style="position: absolute;left: 46px;top:27px;">
    <img src="images/logo/logo.png">
</div>
<!--栏目div-->
<%--<div style="position: absolute;left: 0px;top:20px;width: 200px;height: 700px;">--%>
    <%--<div style="position: absolute;left: 0px;top:0px;width: 111px;height: 68px;visibility: hidden;" id="columnblur">--%>
        <%--<img src="images/channel/blur0.png">--%>
    <%--</div>--%>
    <%--<div style="position: absolute;left: 0px;top:-13px;width: 111px;height: 68px;visibility: hidden;" id="columnfocus">--%>
        <%--<img src="images/channel/f0.png">--%>
    <%--</div>--%>
    <%--<%--%>
        <%--for (int i = 0; i < 10; i++) {--%>
    <%--%>--%>
    <%--<div style="position: absolute;left: 0px;top:<%=i*68%>px;width: 200px;height: 68px;line-height: 68px;color: #fff;font-size: 30px;"--%>
         <%--align="center" id="columnname<%=i%>" class="font_ellipsis">--%>
        <%--&lt;%&ndash;全部频道<%=i%>&ndash;%&gt;--%>
    <%--</div>--%>
    <%--<%--%>
        <%--if (i > 0) {--%>
    <%--%>--%>
    <%--<div style="position: absolute;;left: 0px;top:<%=i*68%>px;width: 200px;">--%>
        <%--<img src="images/channel/heng.png">--%>
    <%--</div>--%>
    <%--<%--%>
            <%--}--%>
        <%--}--%>
    <%--%>--%>

<%--</div>--%>
<%--<div style="position: absolute;left: 200px;top:23px;width: 2px;height: 674px;">--%>
    <%--<img src="images/channel/line.png">--%>
<%--</div>--%>
<!--频道div-->
<div style="position: absolute;left: 55px;top:102px;width: 309px;height: 700px;">
    <div style="position: absolute;left: -5px;top:-5px;width: 111px;height: 85px;visibility: hidden;" id="channelblur">
        <img src="images/tvod/channelblur.png">
    </div>
    <div style="position: absolute;left: -32px;top:-15px;width: 111px;height: 85px;visibility: hidden;"
         id="channelfocus">
        <img src="images/tvod/channelfocus.png">
    </div>
    <%
        for (int i = 0; i < 9; i++) {
    %>
    <div style="position: absolute;left: 0px;top:<%=i*64%>px;width: 309px;height: 58px;line-height: 58px;color: #fff;font-size: 30px;"
         id="channelname<%=i%>" class="font_ellipsis">
        <%--安徽频道<%=i%>--%>
    </div>

    <%
        }
    %>

</div>
<div style="position: absolute;left: 381px;top:95px;width: 2px;height: 674px;">
    <img src="images/tvod/line.png">
</div>
<!--回看div-->
<div style="position: absolute;left: 597px;top:95px;width: 219px;height: 700px;">
    <div style="position: absolute;left: -40px;top:-5px;width: 111px;height: 68px;visibility: hidden;" id="tvodblur">
        <img src="images/tvod/tvodblur.png">
    </div>
    <div style="position: absolute;left: -50px;top:-18px;width: 111px;height: 68px;visibility: hidden;"
         id="tvodfocus">
        <img src="images/tvod/tvodfocus.png">
    </div>
    <%
        for (int i = 0; i < 10; i++) {
    %>
    <div style="position: absolute;left: 0px;top:<%=i*58%>px;width: 358px;height: 54px;font-size: 25px;color: #fff;">
        <div style="position: absolute;left: 0px;top:0px;height: 54px;width: 370px;line-height: 54px;" id="tvodname<%=i%>"
             class="font_ellipsis">
            <%--晕了个时间倒垃圾了经费等<%=i%>--%>
        </div>
        <div style="position: absolute;left: 380px;top:0px;height: 54px;line-height: 54px;width: 150px;" id="tvodtime<%=i%>">
            <%--8:20-9:20--%>
        </div>
        <%--<div style="position: absolute;left: 200px;top:15px;height: 30px;visibility: hidden;" id="tvodstaut<%=i%>">--%>
            <%--回看--%>
        <%--</div>--%>
    </div>

    <%
        }
    %>

</div>
<div style="position: absolute;left: 555px;top:95px;width: 2px;height: 674px;">
    <img src="images/tvod/line.png">
</div>
<!--时间div-->
<div style="position: absolute;left: 384px;top:95px;width: 219px;height: 700px;">
    <div style="position: absolute;left: 0px;top:3px;width: 111px;height: 68px;visibility: visible;" id="timeblur">
        <img src="images/tvod/timeblur.png">
    </div>
    <div style="position: absolute;left: -14px;top:-7px;width: 111px;height: 68px;visibility: hidden;"
         id="timefocus">
        <img src="images/tvod/timefocus.png">
    </div>
    <%
        String[] time = {"前天", "昨天", "今天"};
        for (int i = 0; i < 3; i++) {
    %>
    <div style="position: absolute;left: 0px;top:<%=i*98%>px;width: 174px;height: 68px;color: #fff;font-size: 27px;" align="center">
        <div style="position: absolute;left: 0px;top:5px;height: 30px;width: 174px;" id="time<%=i%>">
            <%--19日--%>
        </div>
        <div style="position: absolute;left: 0px;top:35px;height: 30px;width: 174px;">
            <%=time[i]%>
        </div>
    </div>

    <%
        }
    %>

</div>
<%@include file="inc/time.jsp" %>
<%@include file="inc/lastfocus.jsp" %>
</body>
<script type="text/javascript">
//var columnData=new Array();
document.getElementById("Date").style.color="#90a5c5";
document.getElementById("Date").style.fontSize="25px";
var channelcolumncode = "<%=channelcolumncode%>";
var areaFlag = 0;
var channelObj = null;  //导航栏对象
var tvodObj = null;  //导航栏对象
var timeObj = null;  //导航栏对象
var lastindex="<%=lastindex%>";
var lastindex1="<%=lastindex%>";
var lastindex2="<%=lastindex%>";
function initPageObj() {
    //columnObj = new returnColumnObj();
    channelObj = new returnChannelObj();
    tvodObj = new returnTvodObj();
    timeObj = new returnTimeObj();

}
function resetChannel(channelArray){
    var returnArray1=[],returnArray2=[],returnArray3=[],returnArray4=[],returnArray5=[],returnArray6=[],returnArray7=[];
    for(var i=0;i < channelArray.length;i++){
        if(channelArray[i].channelname.indexOf("CCTV") != -1 && channelArray[i].channelname.indexOf("高清") != -1){
            returnArray1.push(channelArray[i]);
        }else if(channelArray[i].channelname.indexOf("CCTV") != -1){
            returnArray2.push(channelArray[i]);
        }else if(channelArray[i].channelname.indexOf("重庆卫视高清") != -1){
            returnArray3.push(channelArray[i]);
        }else if(channelArray[i].channelname.indexOf("高清") != -1){
            returnArray4.push(channelArray[i]);
        }else if(channelArray[i].channelname.indexOf("卫视") != -1 && channelArray[i].channelname.indexOf("高清") == -1 ||channelArray[i].channelname.indexOf("金鹰卡通") != -1 || channelArray[i].channelname.indexOf("卡酷动画") != -1){
            returnArray5.push(channelArray[i]);
        }else if(channelArray[i].channelname.indexOf("CQTV") != -1){
            returnArray6.push(channelArray[i]);
        }else{
            returnArray7.push(channelArray[i]);
        }
    }
    return returnArray1.concat(returnArray2,returnArray3,returnArray4,returnArray5,returnArray6,returnArray7);
}
function initShowPage() {
    timeObj.getTimeDate();
    channelObj.getChannelDate();
}
function returnChannelObj() {
    this.channelData = new Array();
    this.channelIndex = 0;
    this.lastchannelIndex=-1;
    this.page = 1;
    this.totalPage = 0;
    this.timer = null;
    this.left = function () {
//        areaFlag = 0;
//        this.posterblur();
//        columnObj.posterfocus(0);
    }
    this.right = function () {
        //if (tvodObj.tvodData.length == 0) {
            areaFlag = 1;
            this.posterblur();
            timeObj.posterfocus(0);
//        } else {
//            areaFlag = 2;
//            this.posterblur();
//            tvodObj.posterfocus(0);
//        }

    }
    this.up = function () {
        if (this.channelIndex > 0) {
            this.channelIndex--;
            this.posterfocus(1);
        } else {
            if (this.page == 1) return;
            if (this.page > 1) {
                this.page--;
            }
            this.showObj();
            this.channelIndex = 8;
            this.posterfocus(0);
        }
    }
    this.down = function () {
        if (this.channelIndex < 8) {
            this.channelIndex++;
            if ((this.page - 1) * 9 + 1 + this.channelIndex > this.channelData.length) {
                this.channelIndex--;
                return;
            }
            this.posterfocus(1);
        } else {
            if (this.page < this.totalPage) {
                this.page++;
            }
            this.showObj();
            this.channelIndex = 0;
            this.posterfocus(0);
        }
    }
    this.ok=function(){
        var palymixno=this.channelData[(this.page-1)*9+this.channelIndex].mixno;
        top.jsRedirectChannel(palymixno);
    }
    this.posterfocus = function (flag) {
        if (this.timer != null) {
            clearTimeout(this.timer);
        }
        dom("channelfocus").style.visibility = "visible";
        dom("channelblur").style.visibility = "hidden";
        if (flag == 0) {
            dom("channelfocus").style.webkitTransitionDuration = 0;
        } else {
            dom("channelfocus").style.webkitTransitionDuration = 200;
        }
        dom("channelfocus").style.top = -15 + this.channelIndex * 64 + "px";
        setTimeout(function () {
            if(channelObj.lastchannelIndex==((channelObj.page-1)*9+channelObj.channelIndex)){
                return;
            }
            channelObj.lastchannelIndex=(channelObj.page-1)*9+channelObj.channelIndex;
            timeObj.timeIndex=2;
            timeObj.posterblur();
            tvodObj.getChannelDate();
        }, 500);
    }
    this.posterblur = function () {
        dom("channelfocus").style.visibility = "hidden";
        dom("channelblur").style.visibility = "visible";
        dom("channelblur").style.top = -5+this.channelIndex * 64 + "px";
    }
    this.showmixno=function(num){
         if(num<10){
             num="00"+num;
         }else if(num<100){
             num="0"+num;
         }
        return num;
    }
    this.showObj = function () {
        var start = 0;
        var end = 0;
        if (this.totalPage == this.page) {
            start = (this.page - 1) * 9;
            end = this.channelData.length;
        } else {
            start = (this.page - 1) * 9;
            end = this.page * 9;
        }
        for (var i = 0; i < 9; i++) {
            if (i < (end - start)) {
                dom("channelname" + i).innerText =this.showmixno(this.channelData[start + i].mixno)+" "+this.channelData[start + i].channelname;
            } else {
                dom("channelname" + i).innerText = "";
            }
        }
    }
    this.getChannelDate = function () {
        var requestUrl = "action/channel_data.jsp?columnid=<%=channelcolumncode%>&searchtype=1";
        new net.ContentLoader(requestUrl, function () {
//                var datatext = this.req.responseText;
            channelObj.channelData = new Array();
            var data = eval("(" + this.req.responseText + ")");
            channelObj.channelData = data.channels;//resetChannel(data.channels);
            if (channelObj.channelData.length > 0) {
                channelObj.totalPage = Math.ceil(channelObj.channelData.length / 9);
                if(channelObj.totalPage==0){
                    channelObj.totalPage++;
                }
                if(lastindex=="1"){

                } else{
                    lastindex="1";
                    channelObj.page=parseInt("<%=lastList[1]%>",10);
                    channelObj.channelIndex=parseInt("<%=lastList[2]%>",10);
                }
                channelObj.showObj();
                if(areaFlag==0){
                    channelObj.posterfocus(0);
                } else{
                    channelObj.posterblur();
                    if(lastindex2=="1"){
                        timeObj.timeIndex=2;
                    } else{
                        lastindex2="0";
                        timeObj.timeIndex="<%=lastList[0]%>";
                        timeObj.lasttimeIndex=timeObj.timeIndex;
                    }
                    timeObj.posterblur();
                    tvodObj.getChannelDate();
                   channelObj.lastchannelIndex=(channelObj.page-1)*9+channelObj.channelIndex;
                }
                //channelObj.lastchannelIndex=channelObj.channelIndex;
            } else {
                for (var i = 0; i < 9; i++) {
                    dom("channelname" + i).innerText = "";
                }
                dom("channelfocus").style.visibility = "hidden";
                dom("channelblur").style.visibility = "hidden";
                areaFlag = 0;
//                columnObj.posterfocus(0);
            }

        });
    }
}

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
        str= "<marquee >" + str + "</marquee>";
    }
    document.getElementById(id).innerHTML = str;
}
function returnTvodObj() {
    this.tvodData = new Array();
    this.tvodIndex = 0;
    this.page = 1;
    this.totalPage = 0;
    this.timer = null;
    this.left = function () {
        areaFlag = 1;
        this.posterblur();
        timeObj.posterfocus(0);
    }
    this.right = function () {

    }
    this.up = function () {
		this.posterblur();
        if (this.tvodIndex > 0) {
            if (this.tvodData[(this.page - 1) * 10 + this.tvodIndex].status != 1&&this.tvodData[(this.page - 1) * 10 + this.tvodIndex].data == 0) {
                dom("tvodtime" + this.tvodIndex).style.color="#999";
                dom("tvodname" + this.tvodIndex).style.color="#999";
            }
            stopstr("tvodname" +this.tvodIndex,this.tvodData[(this.page - 1) * 10 + this.tvodIndex].prevuename,12);
            this.tvodIndex--;
            this.posterfocus(1);
        } else {
            if (this.page == 1) return;
            if (this.tvodData[(this.page - 1) * 10 + this.tvodIndex].status != 1&&this.tvodData[(this.page - 1) * 10 + this.tvodIndex].data == 0) {
                dom("tvodtime" + this.tvodIndex).style.color="#999";
                dom("tvodname" + this.tvodIndex).style.color="#999";
            }
            stopstr("tvodname" +this.tvodIndex,this.tvodData[(this.page - 1) * 10 + this.tvodIndex].prevuename,12);
            if (this.page > 1) {
                this.page--;
            }
            this.showObj();
            this.tvodIndex = 9;
            this.posterfocus(0);
        }
    }
    this.down = function () {
		this.posterblur();
        if (this.tvodIndex < 9) {
          //  (this.page - 1) * 8 + 1 + this.tvodIndex > this.tvodData.length-1
            if ((this.page - 1) * 10 + 1 + this.tvodIndex > this.tvodData.length-1) {
               // this.tvodIndex--;
                return;
            } else{
                if (this.tvodData[(this.page - 1) * 10 + this.tvodIndex].status != 1&&this.tvodData[(this.page - 1) * 10 + this.tvodIndex].data == 0) {
                    dom("tvodtime" + this.tvodIndex).style.color="#999"  ;
                    dom("tvodname" + this.tvodIndex).style.color="#999"  ;
                }
                stopstr("tvodname" +this.tvodIndex,this.tvodData[(this.page - 1) * 10 + this.tvodIndex].prevuename,12);
                this.tvodIndex++;
            }
            this.posterfocus(1);
        } else {
            if (this.page < this.totalPage) {
                this.page++;
                if (this.tvodData[(this.page - 1) * 10 + this.tvodIndex].status != 1&&this.tvodData[(this.page - 1) * 10 + this.tvodIndex].data == 0) {
                    dom("tvodtime" + this.tvodIndex).style.color="#999"  ;
                    dom("tvodname" + this.tvodIndex).style.color="#999"  ;
                }
                stopstr("tvodname" +this.tvodIndex,this.tvodData[(this.page - 1) * 10 + this.tvodIndex].prevuename,12);
                this.showObj();
                this.tvodIndex = 0;
                this.posterfocus(0);
            }

        }
    }
    this.posterfocus = function (flag) {
        if (this.timer != null) {
            clearTimeout(this.timer);
        }
        dom("tvodfocus").style.visibility = "visible";
        dom("tvodblur").style.visibility = "hidden";
        if (flag == 0) {
            dom("tvodfocus").style.webkitTransitionDuration = 0;
        } else {
            dom("tvodfocus").style.webkitTransitionDuration = 200;
        }
        dom("tvodfocus").style.top = -18 + this.tvodIndex * 58 + "px";
        starstr("tvodname" + this.tvodIndex,this.tvodData[(this.page - 1) * 10 + this.tvodIndex].prevuename,12);
        if (this.tvodData[(this.page - 1) * 10 + this.tvodIndex].status != 1&&this.tvodData[(this.page - 1) * 10 + this.tvodIndex].data == 0) {
//            dom("tvodname" + this.tvodIndex).innerHTML = "<font color=' #333'>" + this.tvodData[(this.page - 1) * 10 + this.tvodIndex].prevuename + "</font>";
//            dom("tvodtime" + this.tvodIndex).innerHTML = "<font color=' #333'>" +this.showTime(this.tvodData[(this.page - 1) * 10 + this.tvodIndex].begintime) + "-" + this.showTime(this.tvodData[(this.page - 1) * 10 + this.tvodIndex].endtime) + "</font>";
            dom("tvodtime" + this.tvodIndex).style.color="#333" ;
            dom("tvodname" + this.tvodIndex).style.color="#333" ;
        }

    }
    this.posterblur = function () {
        stopstr("tvodname" +this.tvodIndex,this.tvodData[(this.page - 1) * 10 + this.tvodIndex].prevuename,12);
        dom("tvodfocus").style.visibility = "hidden";
        dom("tvodblur").style.visibility = "hidden";
        dom("tvodblur").style.top = -5+this.tvodIndex * 58+ "px";
        if (this.tvodData[(this.page - 1) * 10 + this.tvodIndex].status != 1&&this.tvodData[(this.page - 1) * 10 + this.tvodIndex].data == 0) {
//            dom("tvodname" + this.tvodIndex).innerHTML = "<font color=' #999'>" + this.tvodData[(this.page - 1) * 10 + this.tvodIndex].prevuename + "</font>";
//            dom("tvodtime" + this.tvodIndex).innerHTML = "<font color=' #999'>" +this.showTime(this.tvodData[(this.page - 1) * 10 + this.tvodIndex].begintime) + "-" + this.showTime(this.tvodData[(this.page - 1) * 10 + this.tvodIndex].endtime) + "</font>";
            dom("tvodtime" + this.tvodIndex).style.color="#999"  ;
            dom("tvodname" + this.tvodIndex).style.color="#999"  ;
        }

    }
    this.ok=function(){
//        alert("===========================")
       if(this.tvodData[(this.page - 1) * 10 + this.tvodIndex].status==1){
            document.location="tvodplay.jsp?prevuecode="+this.tvodData[(this.page - 1) * 10 + this.tvodIndex].prevuecode+"&channelcode="+this.tvodData[(this.page - 1) * 10 + this.tvodIndex].channelcode+
                    "&leefocus="+timeObj.timeIndex+"-"+channelObj.page+"-"+channelObj.channelIndex+"-"+this.tvodIndex+"-"+this.page+"-"+areaFlag;

       }else if(this.tvodData[(this.page - 1) * 10 + this.tvodIndex].data==1){
           var palymixno=channelObj.channelData[(channelObj.page-1)*9+channelObj.channelIndex].mixno;
//           alert("=============palymixno================="+palymixno)
           top.jsRedirectChannel(palymixno);
       }
    }
    this.showObj = function () {
        var start = 0;
        var end = 0;
        if (this.totalPage == this.page) {
            start = (this.page - 1) * 10;
            end = this.tvodData.length;
        } else {
            start = (this.page - 1) * 10;
            end = this.page * 10;
        }
//        console.log(start+"=============="+end);
        for (var i = 0; i < 10; i++) {
            if (i < (end - start)) {
                if (this.tvodData[start + i].status == 1) {

//                    dom("tvodname" + i).innerHTML = "<font color=' #fff'>"+this.tvodData[start + i].prevuename+"</font>";
//                    dom("tvodtime" + i).innerHTML = this.showTime(this.tvodData[start + i].begintime) + "-" + this.showTime(this.tvodData[start + i].endtime);
//                    dom("tvodname" + i).innerHTML = this.tvodData[start + i].prevuename;
                    stopstr("tvodname" + i,this.tvodData[start + i].prevuename,12);
                    dom("tvodtime" + i).innerHTML = this.showTime(this.tvodData[start + i].begintime) + "-" + this.showTime(this.tvodData[start + i].endtime);
                    dom("tvodtime" +i).style.color="#fff"  ;
                    dom("tvodname" +i).style.color="#fff"  ;
                } else {
//                    dom("tvodname" + i).innerHTML = "<font color=' #999'>" + this.tvodData[start + i].prevuename + "</font>";
//                    dom("tvodtime" + i).innerHTML = "<font color=' #999'>" +this.showTime(this.tvodData[start + i].begintime) + "-" + this.showTime(this.tvodData[start + i].endtime) + "</font>";
//                    dom("tvodname" + i).innerHTML =  this.tvodData[start + i].prevuename;
                    stopstr("tvodname" + i,this.tvodData[start + i].prevuename,12);
                    dom("tvodtime" + i).innerHTML = this.showTime(this.tvodData[start + i].begintime) + "-" + this.showTime(this.tvodData[start + i].endtime) ;
                    dom("tvodtime" +i).style.color="#999"  ;
                    dom("tvodname" +i).style.color="#999"  ;
                }
                if(this.tvodData[start + i].data == 1){
//                    dom("tvodname" + i).innerHTML = "<font color=' #00EE00'>"+this.tvodData[start + i].prevuename+"</font>";
//                    dom("tvodtime" + i).innerHTML = "<font color=' #00EE00'>"+this.showTime(this.tvodData[start + i].begintime) + "-" + this.showTime(this.tvodData[start + i].endtime)+"</font>";
//                    dom("tvodname" + i).innerHTML =this.tvodData[start + i].prevuename;
                    stopstr("tvodname" + i,this.tvodData[start + i].prevuename,12);
                    dom("tvodtime" + i).innerHTML = this.showTime(this.tvodData[start + i].begintime) + "-" + this.showTime(this.tvodData[start + i].endtime);
                    dom("tvodtime" +i).style.color="#00EE00"  ;
                    dom("tvodname" +i).style.color="#00EE00"  ;
                }
            } else {
                dom("tvodname" + i).innerHTML = "";
                dom("tvodtime" + i).innerText = "";
//                dom("tvodstaut" + i).style.visibility = "hidden";
            }
        }
    }
    this.showTime = function (time) {
        var returntime = time.substring(11, 16);
        return returntime;
    }
    this.getChannelDate = function () {
        var requestUrl = "action/getchannelprogram.jsp?channelcode=" + channelObj.channelData[(channelObj.page - 1) * 9 + channelObj.channelIndex].channelcode + "&currdate=" + timeObj.timeData[parseInt(timeObj.timeIndex,10)];
        new net.ContentLoader(requestUrl, function () {
//                var datatext = this.req.responseText;
            tvodObj.tvodData = new Array();
            var data = eval("(" + this.req.responseText + ")");
            tvodObj.tvodData = data.prevuelist;
            if (tvodObj.tvodData.length > 1) {
                tvodObj.totalPage = Math.ceil(tvodObj.tvodData.length / 10);
                if(lastindex1=="1"){
                    var index = 0;
                    for (var i = 0; i < tvodObj.tvodData.length; i++) {
                        if (tvodObj.tvodData[i].data == 1) {
                            index = i;
                        }
                    }
                    tvodObj.page = Math.ceil(index / 10);
                    if (index % 10 == 0) {
                        tvodObj.page++;
                    }
                    if (tvodObj.page == 0) {
                        tvodObj.page = 1;
                    }
                    tvodObj.tvodIndex = index - (tvodObj.page - 1) * 10;
                    tvodObj.showObj();
                    tvodObj.posterblur();
                } else{
                    lastindex1="1";
                    tvodObj.tvodIndex=parseInt("<%=lastList[3]%>",10);
                    tvodObj.page=parseInt("<%=lastList[4]%>",10);
                    tvodObj.showObj();
//                    dom("tvodfocus").style.top = -18 + this.tvodIndex * 54 + "px";
                    tvodObj.posterfocus(0);
                }

            } else {
                for (var i = 0; i < 10; i++) {
                    dom("tvodname" + i).innerHTML = "";
                    dom("tvodtime" + i).innerText = "";
//                    dom("tvodstaut" + i).style.visibility = "hidden";
                }
                dom("tvodfocus").style.visibility = "hidden";
                dom("tvodblur").style.visibility = "hidden";
            }

        });
    }
}
function returnTimeObj() {
    this.timeData = new Array();
    this.timeIndex = 2;
    this.lasttimeIndex=2;
    this.page = 1;
    this.totalPage = 0;
    this.timer = null;
    this.left = function () {
        //if (tvodObj.tvodData.length == 0) {
            areaFlag = 0;
            this.posterblur();
            channelObj.posterfocus(0);
//        } else {
//            areaFlag = 2;
//            this.posterblur();
//            tvodObj.posterfocus(0);
//        }
    }
    this.right = function () {
        if (tvodObj.tvodData.length == 0) {

        } else {
            areaFlag = 2;
            this.posterblur();
            tvodObj.posterfocus(0);
        }
    }
    this.up = function () {
        if (this.timeIndex > 0) {
            this.timeIndex--;
            this.posterfocus(1);
        }
    }
    this.down = function () {
        if (this.timeIndex < 2) {
            this.timeIndex++;
            this.posterfocus(1);
        }
    }
    this.posterfocus = function (flag) {
        if (this.timer != null) {
            clearTimeout(this.timer);
        }
        dom("timefocus").style.visibility = "visible";
        dom("timeblur").style.visibility = "hidden";
        if (flag == 0) {
            dom("timefocus").style.webkitTransitionDuration = 0;
        } else {
            dom("timefocus").style.webkitTransitionDuration = 200;
        }
        dom("timefocus").style.top = -7 + this.timeIndex * 98 + "px";
        setTimeout(function () {
            if(timeObj.lasttimeIndex==timeObj.timeIndex){
                return;
            }
            timeObj.lasttimeIndex=timeObj.timeIndex ;
            tvodObj.getChannelDate();
        }, 500);
    }
    this.posterblur = function () {
        dom("timefocus").style.visibility = "hidden";
        dom("timeblur").style.visibility = "visible";
        dom("timeblur").style.top = 3+this.timeIndex * 98 + "px";
    }
    this.showObj = function (daytime, id) {
        dom("time" + id).innerHTML = daytime + "日";
    }
    this.getTimeDate = function () {
        for (var i = 2; i >= 0; i--) {
            var date1 = new Date();
            var yesterday_milliseconds = date1.getTime() - 1000 * 60 * 60 * 24 * i;
            var yesterday = new Date();
            yesterday.setTime(yesterday_milliseconds);
            var strYear = yesterday.getFullYear();
            var strDay = yesterday.getDate();
            if(strDay<10){
                strDay="0"+strDay;
            }
            var strMonth = yesterday.getMonth() + 1;
            if(strMonth<10){
                strMonth="0"+strMonth;
            }
            // var daytime = yesterday.getDay();
            this.showObj(strDay, (2 - i));
            this.timeData.push(strYear + "." + strMonth + "." + strDay);
        }
        this.posterblur();
    }
}

function dokeyPress(evt) {
    var keyCode = parseInt(evt.which);
    if (keyCode == 0x0008) {
        //doBack();
        document.location="back.jsp" ;
//            document.location="channel_all_ok.jsp?mixno=28&columncode=07";
    } else if (keyCode == <%=STBKeysNew.remoteMenu%>) {
        Authentication.CTCSetConfig("KeyValue", "0x110");
        document.location = "portal.jsp";
    } else if (keyCode == 0x0025) { //onKeyLeft
        //doLeft();
        if (areaFlag == 1) {
            timeObj.left();
        } else if (areaFlag == 0) {
            channelObj.left();
        } else if (areaFlag == 2) {
            tvodObj.left();
        }

    } else if (keyCode == 0x0027) { //onKeyRight
        //doRight();
        if (areaFlag == 1) {
            timeObj.right();
        } else if (areaFlag == 0) {
            channelObj.right();
        } else if (areaFlag == 2) {
            tvodObj.right();
        }

    } else if (keyCode == 0x0026) {//onKeyUp
        //doUP();
        if (areaFlag == 1) {
            timeObj.up();
        } else if (areaFlag == 0) {
            channelObj.up();
        } else if (areaFlag == 2) {
            tvodObj.up();
        }
    }else if (keyCode == 0x0028) { //onKeyDown
        //doDown();
        if (areaFlag == 1) {
            timeObj.down();
        } else if (areaFlag == 0) {
            channelObj.down();
        } else if (areaFlag == 2) {
            tvodObj.down();
        }

    } else if (keyCode == 0x000D) {  //OK
        //doOk();
        if (areaFlag == 0) {
           // columnObj.ok();
        } else if (areaFlag == 1) {
            //channelObj.ok();
        } else if (areaFlag == 2) {
            tvodObj.ok();
        } else {
           // timeObj.ok();
        }
    } else if (keyCode == 34) {
//        doPageDown();
         if (areaFlag == 0) {
             if (channelObj.page < channelObj.totalPage) {
                 channelObj.page++;
             }
             channelObj.showObj();
             channelObj.channelIndex = 0;
             channelObj.posterfocus(0);
        } else if (areaFlag == 2) {
//            tvodObj.down();
             if (tvodObj.page < tvodObj.totalPage) {
                 tvodObj.page++;
             }
             tvodObj.showObj();
             tvodObj.tvodIndex = 0;
             tvodObj.posterfocus(0);
        }
    } else if (keyCode == 33) {
//        doPageUp();
         if (areaFlag == 0) {
             if (channelObj.page == 1) return;
             if (channelObj.page > 1) {
                 channelObj.page--;
             }
             channelObj.showObj();
             channelObj.channelIndex = 0;
             channelObj.posterfocus(0);
        } else if (areaFlag == 2) {
//            tvodObj.up();
             if (tvodObj.page == 1) return;
             if (tvodObj.page > 1) {
                 tvodObj.page--;
             }
             tvodObj.showObj();
             tvodObj.tvodIndex = 0;
             tvodObj.posterfocus(0);
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
function init() {
document.onkeydown = dokeyPress;
    <%--timeObj.timeIndex=parseInt("<%=lastList[0]%>",10);--%>
    areaFlag=parseInt("<%=lastList[5]%>",10) ;
    initPageObj();
    initShowPage();
    timeObj.posterblur();
    if (areaFlag == 0) {
//        channelObj.posterfocus(0);
    } else if (areaFlag == 2) {
        channelObj.posterblur();
//        channelObj.posterfocus(0);
    }
}

</script>
</html>