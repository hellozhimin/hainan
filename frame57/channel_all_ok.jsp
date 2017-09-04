<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.zte.iptv.epg.util.*" %>
<%@ page import="java.util.*" %>
<%!
    public String getPath(String uri) {
        String path = "";
        int begin = 0;
        int end = uri.lastIndexOf('/');
        if (end > 0) {
            path = uri.substring(begin, end + 1) + path;
        }
        return path;
    }
%>
<%
    String mixno = request.getParameter("mixno");
  //  mixno = "196";
    String columncode = request.getParameter("columncode");
    
    String numToPlay = request.getParameter("numToPlay");
    
    //columncode = "070D";
    String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
    HashMap param = PortalUtils.getParams(path, "UTF-8");
    String parentcode = String.valueOf(param.get("channelRootColumnId"));
    String path1 = getPath(request.getRequestURI());
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
            /*overflow: hidden;*/
            /*white-space: nowrap;*/
            /*text-overflow: ellipsis;*/
        }
    </style>
</head>
<body bgcolor="transparent" background="images/channel/chanMiniList_bg.png" width="1280px" height="720px" style="overflow: hidden;" onLoad="init();">

<!--
<div id="test" style="position:absolute; width:1000px; height:500px; left:20px; color:#FF0000; font-size:18px; z-index:999;"></div>
-->

<!--栏目div-->
<div style="position: absolute;left: 0px;top:30px;width: 200px;height: 700px;">
    <div style="position: absolute;left: 10px;top:0px;width: 111px;height: 68px;visibility: hidden;" id="columnblur">
        <img src="images/channel/blur0.png">
    </div>
    <div style="position: absolute;left: 0px;top:-13px;width: 111px;height: 68px;visibility: hidden;" id="columnfocus">
        <img src="images/channel/f0.png" >
    </div>
    <%
        for (int i = 0; i < 10; i++) {
    %>
    <div style="position: absolute;left: 15px;top:<%=i*68%>px;width: 170px;height: 68px;line-height: 68px;color: #fff;font-size: 30px;"
         align="center" id="columnname<%=i%>" class="font_ellipsis">
        <%--全部频道<%=i%>--%>
    </div>
    <%
        if (i > 0) {
    %>
    <div style="position: absolute;left: 0px;top:<%=i*68%>px;width: 200px;visibility: hidden;" id="channelline<%=i%>">
        <img src="images/channel/heng.png">
    </div>
    <%
            }
        }
    %>

</div>
<%--<div style="position: absolute;left: 240px;top:23px;width: 2px;height: 674px;">--%>
    <%--<img src="images/channel/line.png">--%>
<%--</div>--%>
<!--频道div-->
<div style="position: absolute;left: 202px;top:30px;width: 219px;height: 700px;">
    <div style="position: absolute;left: 0px;top:0px;width: 111px;height: 68px;visibility: visible;" id="channelblur">
        <img src="images/channel/blur2.png">
    </div>
    <div style="position: absolute;left: -12px;top:-14px;width: 111px;height: 68px;visibility: hidden;z-index: 99;"
         id="channelfocus">
        <img src="images/channel/f2.png" width="242" height="96">
    </div>
    <%
        for (int i = 0; i < 10; i++) {
    %>
    <div style="position: absolute;left: 10px;top:<%=i*68%>px;width: 200px;height: 68px;line-height: 68px;color: #fff;font-size: 23px;"
         id="channelname<%=i%>" class="font_ellipsis" >
        <%--安徽频道<%=i%>--%>
    </div>

    <%
        }
    %>

</div>
<%--<div style="position: absolute;left: 463px;top:23px;width: 2px;height: 674px;">--%>
    <%--<img src="images/channel/line.png">--%>
<%--</div>--%>
<!--回看div-->
<div style="position: absolute;left: 424px;top:30px;width: 219px;height: 700px;">
    <div style="position: absolute;left: 0px;top:0px;width: 111px;height: 68px;visibility: hidden;" id="tvodblur">
        <img src="images/channel/blur3.png">
    </div>
    <div style="position: absolute;left: -12px;top:-18px;width: 111px;height: 68px;visibility: hidden;"
         id="tvodfocus">
        <img src="images/channel/f3.png" width="380" height="113">
    </div>
    <%
        for (int i = 0; i < 8; i++) {
    %>
    <div style="position: absolute;left: 0px;top:<%=i*78%>px;width: 358px;height: 68px;font-size: 25px;color: #fff;">
        <div style="position: absolute;left: 20px;top:13px;height: 30px;width: 276px;" id="tvodname<%=i%>"
             class="font_ellipsis">
            <%--晕了个时间倒垃圾了经费等<%=i%>--%>
        </div>
        <div style="position: absolute;left: 20px;top:48px;height: 30px;font-size: 22px;" id="tvodtime<%=i%>">
            <%--8:20-9:20--%>
        </div>
        <div style="position: absolute;left: 300px;top:15px;height: 30px;visibility: hidden;" id="tvodstaut<%=i%>">
            回看
        </div>
    </div>

    <%
        }
    %>

</div>
<%--<div style="position: absolute;left: 823px;top:23px;width: 2px;height: 674px;">--%>
    <%--<img src="images/channel/line.png">--%>
<%--</div>--%>
<!--时间div-->
<div style="position: absolute;left: 785px;top:50px;width: 219px;height: 700px;">
    <div style="position: absolute;left: 0px;top:0px;width: 111px;height: 68px;visibility: visible;" id="timeblur">
        <img src="images/channel/blur1.png">
    </div>
    <div style="position: absolute;left: -14px;top:-15px;width: 111px;height: 68px;visibility: hidden;"
         id="timefocus">
        <img src="images/channel/f1.png">
    </div>
    <%
        String[] time = {"前天", "昨天", "今天"};
        for (int i = 0; i < 3; i++) {
    %>
    <div style="position: absolute;left: 0px;top:<%=i*98%>px;width: 358px;height: 68px;color: #fff;font-size: 27px;">
        <div style="position: absolute;left: 23px;top:5px;height: 30px;width: 100px;" id="time<%=i%>">
            <%--19日--%>
        </div>
        <div style="position: absolute;left: 23px;top:35px;height: 30px;width: 100px;">
            <%=time[i]%>
        </div>
    </div>

    <%
        }
    %>
</div>
<div style="position: absolute; width: 309px; height: 85px; left: 795px; top: 554px; color: #FFF; font-size: 30px;">按确定键呼出频道列表<br/>按返回键关闭频道列表</div>
<%@include file="inc/lastfocus.jsp" %>
<%@include file="inc/scrollString.jsp" %>
<div id="test" style="position:absolute; width:1000px;top:10px; height:500px; left:20px;  font-size:18px;"></div>
</body>
<script type="text/javascript">
//var columnData=new Array();
var mixno = "<%=mixno%>";
var columncode = "<%=columncode%>";
var areaFlag = 1;
var columnObj = null;  //推荐对象
var channelObj = null;  //导航栏对象
var tvodObj = null;  //导航栏对象
var timeObj = null;  //导航栏对象
function initPageObj() {
    columnObj = new returnColumnObj();
    channelObj = new returnChannelObj();
    tvodObj = new returnTvodObj();
    timeObj = new returnTimeObj();
	
}
function initShowPage() {
    columnObj.getChannelDate();
    timeObj.getTimeDate();
}
function returnColumnObj() {
    this.columnData = new Array();
    
    // this.columnIndex = (this.columnIndex != 0) ? this.columnIndex : 0;
    this.lastcolumnIndex=-1;
    this.page = 1;
    this.totalPage = 0;
    this.timer = null;
    this.left = function () {

    }
    this.right = function () {
        if (channelObj.channelData.length == 0) {
            return;
        }
        areaFlag = 1;
        this.posterblur();
        channelObj.posterfocus();
    }
    this.up = function () {
        if (this.columnIndex > 0) {
            this.posterblur();
            this.columnIndex--;
            this.posterfocus(1);
        } else {
            if (this.page == 1) return;
            this.posterblur();
            if (this.page > 1) {
                this.page--;
            }
            this.showObj();
            this.columnIndex = 9;
            this.posterfocus(0);
        }
    }
    this.down = function () {
        if (this.columnIndex < 9) {
            if ((this.page - 1) * 10 + 1 + this.columnIndex > this.columnData.length-1) {
//                this.columnIndex--;
                return;
            }else{
                this.posterblur();
                this.columnIndex++;
            }
            this.posterfocus(1);
        } else {
            if (this.page < this.totalPage) {
                this.posterblur();
                this.page++;
                this.showObj();
                this.columnIndex = 0;
                this.posterfocus(0);
            }

        }
    }
    this.posterfocus = function (flag) {
        if (this.timer != null) {
            clearTimeout(this.timer);
        }
        dom("columnfocus").style.visibility = "visible";
        dom("columnblur").style.visibility = "visible";
        if (flag == 0) {
            dom("columnfocus").style.webkitTransitionDuration = 0;
            dom("columnblur").style.webkitTransitionDuration = 0;
        } else {
            dom("columnfocus").style.webkitTransitionDuration = 300;
            dom("columnblur").style.webkitTransitionDuration = 300;
        }
        dom("columnfocus").style.top = -13 + this.columnIndex * 68 + "px";
        dom("columnblur").style.top =  this.columnIndex * 68 + "px";

        setTimeout(function () {
			//dom("test").innerHTML = dom("test").innerHTML + "<br/>---column----lastcolumnIndex:" + columnObj.lastcolumnIndex + "----columnIndex:" + columnObj.columnIndex;
            if(columnObj.lastcolumnIndex==columnObj.columnIndex){
                return;
            }
            columnObj.lastcolumnIndex=columnObj.columnIndex
            channelObj.lastchannelIndex=-1;
            channelObj.getChannelDate();
            channelObj.channelIndex = 0;
            dom("channelfocus").style.top = -14 + this.channelIndex * 68 + "px";
            channelObj.posterblur();
			timeObj.timeIndex=2;
            timeObj.posterblur();
			//dom("test").innerHTML = dom("test").innerHTML + "<br/>---column----tvodObj.getChannelDate-----";
            tvodObj.getChannelDate();
        }, 500);
        
        if(this.columnData.length==0) return;
        starScroll("columnname" + this.columnIndex,this.columnData[(this.page-1)*10+this.columnIndex].columnname,170);
    }
    this.posterblur = function () {
        dom("columnfocus").style.visibility = "hidden";
        dom("columnblur").style.visibility = "visible";
        dom("columnblur").style.top = this.columnIndex * 68 + "px";
		
        dom("columnfocus").style.top = -13 + this.columnIndex * 68 + "px";
        if(this.columnData.length==0) return;
//        console.log("=========(this.page-1)*10+this.columnIndex==="+(parseInt((this.page-1)*10,10)+parseInt(this.columnIndex,10)))
        stopScroll("columnname" + this.columnIndex,this.columnData[parseInt((this.page-1)*10,10)+parseInt(this.columnIndex,10)].columnname);
    }
    this.showObj = function () {
        var start = 0;
        var end = 0;

        if (parseInt(this.totalPage, 10) == parseInt(this.page, 10)) {
            start = (this.page - 1) * 10;
            end = this.columnData.length;
        } else {
            start = (this.page - 1) * 10;
            end = this.page * 10;
        }
        for (var i = 0; i < 10; i++) {
            if (i < (end - start)) {
//                dom("columnname" + i).innerText = this.columnData[start + i].columnname;
//                alert("=======huwenxi-----");
                stopScroll("columnname" + i,this.columnData[start + i].columnname);
            } else {
                dom("columnname" + i).innerText = "";
            }
        }
//        this.posterblur();
//        channelObj.getChannelDate();
    }
    this.getChannelDate = function () {
        var requestUrl = "action/channel_column.jsp?columnid=<%=parentcode%>";
        new net.ContentLoader(requestUrl, function () {
//                var datatext = this.req.responseText;

            var data = eval("(" + this.req.responseText + ")");
            
            var allchannelcolumncode = "";
			for(var i=0;i<data.param.length;i++){
				if(data.param[i].columnname != '直播'){
            		columnObj.columnData.push(data.param[i]);
				}
				
				if(data.param[i].columnname == '全部') {
					allchannelcolumncode = data.param[i].columncode;
				}
			}
            //columnObj.columnData = data.param;
            // columnObj.columnData.push({columnname:"全部频道", normalposter:"1", columncode:"0D00"});
            // columnObj.columnData.push({columnname:"本地频道", normalposter:"1", columncode:"0D01"});
            // columnObj.columnData.push({columnname:"直播频道", normalposter:"1", columncode:"0D02"});
           // columnObj.columnData.push({columnname:"央视频道", normalposter:"1", columncode:"35"});
           // columnObj.columnData.push({columnname:"高清频道", normalposter:"1", columncode:"39"});
            columnObj.columnData.push({columnname:"频道收藏", normalposter:"1", columncode:"xxx"});
            
            for (var i = 0; i < columnObj.columnData.length; i++) {
                dom("channelline"+(i+1)).style.visibility="visible";
            }
            
            var index = -1;
			if('<%=numToPlay%>' == "false") {
				for (var i = 0; i < columnObj.columnData.length; i++) {
	                // if (columnObj.columnData[i].columncode == top.channelInfo.columncode1111)
                    if (columnObj.columnData[i].columncode == "<%=columncode%>")
                     {
	                    index = i;
                        break;
	                }
	            }
			}
			
			if(index == -1) {
				for (var i = 0; i < columnObj.columnData.length; i++) {
	                if (columnObj.columnData[i].columncode == allchannelcolumncode) {
	                    index = i;
                        break;
	                }
	            }
			}
            
            columnObj.totalPage = Math.ceil(columnObj.columnData.length / 10);
            columnObj.page = Math.ceil(index / 10);
            if (index % 10 == 0) {
                columnObj.page++;
            }
            if (columnObj.page == 0) {
                columnObj.page = 1;
            }
            columnObj.columnIndex = index - ((columnObj.page - 1) * 10);
            columnObj.lastcolumnIndex=columnObj.columnIndex;
            
            columnObj.showObj();
            if(areaFlag!=0){
                channelObj.getChannelDate();
                columnObj.posterblur();
            }
        });
    }
}
function returnChannelObj() {
    this.channelData = new Array();
    this.channelIndex = 0;
    this.lastchannelIndex=-1;
    this.page = 1;
    this.totalPage = 0;
    this.timer = null;
    this.left = function () {
        areaFlag = 0;
        this.posterblur();
        columnObj.posterfocus(0);
    }
    this.right = function () {
        if (tvodObj.tvodData.length == 0) {
            areaFlag = 3;
            this.posterblur();
            timeObj.posterfocus(0);
        } else {
            areaFlag = 2;
            this.posterblur();
            tvodObj.posterfocus(0);
        }

    }
    this.up = function () {
        if (this.channelIndex > 0) {
            this.posterblur();
            this.channelIndex--;
            this.posterfocus(1);
        } else {
            if (this.page == 1) return;
            this.posterblur();
            if (this.page > 1) {
                this.page--;
            }
            this.showObj();
            this.channelIndex = 9;
            this.posterfocus(0);
        }
    }
    this.down = function () {
        if (this.channelIndex < 9) {
            if ((this.page - 1) * 10 + 1 + this.channelIndex > channelObj.channelData.length-1) {
//                this.channelIndex--;
                return;
            }else{
                this.posterblur();
                this.channelIndex++;
            }
            this.posterfocus(1);
        } else {
            if (this.page < this.totalPage) {
                this.posterblur();
                this.page++;
                this.showObj();
                this.channelIndex = 0;
                this.posterfocus(0);
            }

        }
    }
    this.ok=function(){
	var palymixno=channelObj.channelData[(channelObj.page-1)*10+channelObj.channelIndex].usermixno;
        var palymixno1=channelObj.channelData[(channelObj.page-1)*10+channelObj.channelIndex].mixno;
	top.mp.joinChannel(palymixno);
            top.channelInfo.currentChannel=palymixno1;
            
            top.jsSetControl("NUM_TO_PLAY", false);
            var url = "<%=path1%>control_transit_play.jsp?channelid="+channelObj.channelData[(channelObj.page-1)*10+channelObj.channelIndex].channelcode+
                    "&channelname="+channelObj.channelData[(channelObj.page-1)*10+channelObj.channelIndex].channelname+
                    "&columnid="+columnObj.columnData[(columnObj.page - 1) * 10 + columnObj.columnIndex].columncode+
                    "&mixno="+channelObj.channelData[(channelObj.page-1)*10+channelObj.channelIndex].mixno+"&preview=0&isIppv=0&startTime=undefined&endTime=undefined";
			//dom("test").innerHTML = dom("test").innerHTML + "<br/>---channel----ok-----url:" + url;
            top.extrWin.document.location = url;
        //},200);
        showtimer=setTimeout(function(){top.jsHideOSD();},5000);
//        top.jsRedirectChannel(palymixno);
    }
    this.posterfocus = function (flag) {
        if (this.timer != null) {
            clearTimeout(this.timer);
        }
        dom("channelfocus").style.visibility = "visible";
        dom("channelblur").style.visibility = "visible";
        if (flag == 0) {
            dom("channelfocus").style.webkitTransitionDuration = 0;
            dom("channelblur").style.webkitTransitionDuration = 0;
        } else {
            dom("channelfocus").style.webkitTransitionDuration = 300;
            dom("channelblur").style.webkitTransitionDuration = 300;
        }
        dom("channelfocus").style.top = -14 + this.channelIndex * 68 + "px";
        dom("channelblur").style.top = this.channelIndex * 68 + "px";
        if(areaFlag==0) return;
        setTimeout(function () {
//            if(channelObj.lastchannelIndex==channelObj.channelIndex){
			/**/
            if(channelObj.lastchannelIndex==((channelObj.page-1)*10+channelObj.channelIndex)){
                return;
            }
			
            channelObj.lastchannelIndex=(channelObj.page-1)*10+channelObj.channelIndex;
            timeObj.timeIndex=2;
			if(channelObj.channelData.length!=0){
            timeObj.posterblur();
            tvodObj.getChannelDate();
			}
        }, 200);
        if(channelObj.channelData.length==0) return;
        starScroll("channelname" + this.channelIndex,this.channelData[(this.page-1)*10+this.channelIndex].mixno+" "+this.channelData[(this.page-1)*10+this.channelIndex].channelname,200);
    }
    this.posterblur = function () {
        dom("channelfocus").style.visibility = "hidden";
        dom("channelblur").style.visibility = "visible";
        dom("channelfocus").style.webkitTransitionDuration = 0;
        dom("channelblur").style.webkitTransitionDuration = 0;
        dom("channelblur").style.top = this.channelIndex * 68 + "px";
        dom("channelfocus").style.top = -14+this.channelIndex * 68 + "px";
        if(channelObj.channelData.length==0) return;
        stopScroll("channelname" + this.channelIndex,this.channelData[(this.page-1)*10+this.channelIndex].mixno+" "+this.channelData[(this.page-1)*10+this.channelIndex].channelname);
    }
    this.showObj = function () {
        var start = 0;
        var end = 0;
        if (this.totalPage == this.page) {
            start = (this.page - 1) * 10;
            end = channelObj.channelData.length;
        } else {
            start = (this.page - 1) * 10;
            end = this.page * 10;
        }
        for (var i = 0; i < 10; i++) {
            if (i < (end - start)) {
//                dom("channelname" + i).innerText =this.channelData[start + i].mixno+" "+this.channelData[start + i].channelname;
                stopScroll("channelname" + i,this.channelData[start + i].mixno+" "+this.channelData[start + i].channelname);
            } else {
                dom("channelname" + i).innerText = "";
            }
        }
    }
    this.getChannelDate = function () {
		if(columnObj.columnIndex == undefined) columnObj.columnIndex = 0;
        var requestUrl = "action/channel_data.jsp?columnid=" + columnObj.columnData[(columnObj.page - 1) * 10 + columnObj.columnIndex].columncode;
         if(columnObj.columnData[(columnObj.page - 1) * 10 + columnObj.columnIndex].columncode=="xxx"){
             requestUrl="action/get_all_channel_favorite.jsp";
         }
        new net.ContentLoader(requestUrl, function () {
//                var datatext = this.req.responseText;
            channelObj.channelData =[];
            var data = eval("(" + this.req.responseText + ")");
            channelObj.channelData = data.channels;
            channelObj.totalPage = Math.ceil(channelObj.channelData.length / 10);
            if (channelObj.channelData.length > 0) {
                var index = 0;
				dom("channelblur").style.visibility = 'visible';
                for (var i = 0; i < channelObj.channelData.length; i++) {
                    if (channelObj.channelData[i].mixno == mixno) {
                        index = i;
                        mixno="";
                    }
                }
                channelObj.page = Math.ceil(index / 10);
                if (index % 10 == 0) {
                    channelObj.page++;
                }
                if (channelObj.page == 0) {
                    channelObj.page = 1;
                }
                channelObj.channelIndex = index % 10;//index - (channelObj.page - 1) * 10;
//                channelObj.lastchannelIndex=channelObj.channelIndex;
                channelObj.showObj();
                if(areaFlag==1){
                    channelObj.posterfocus(0);
                } else{
                    if(areaFlag==0) return;
                    channelObj.posterblur();
                    timeObj.timeIndex=2;
                    timeObj.posterblur();
                    tvodObj.getChannelDate();
                }
            } else {
                for (var i = 0; i < 10; i++) {
                    dom("channelname" + i).innerText = "";
                }
                dom("channelfocus").style.visibility = "hidden";
                dom("channelblur").style.visibility = "hidden";
                areaFlag = 0;
                columnObj.posterfocus(0);
                if(areaFlag==0) return;
                tvodObj.page=1;
                tvodObj.totalPage=1;
                tvodObj.tvodData = new Array();
                tvodObj.showObj();
                dom("tvodfocus").style.visibility = "hidden";
                dom("tvodblur").style.visibility = "hidden";
            }

        });
    }
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
        channelObj.posterfocus(0);
    }
    this.right = function () {
        areaFlag = 3;
        this.posterblur();
        timeObj.posterfocus(0);
    }
    this.up = function () {
        if (this.tvodIndex > 0) {
            this.stopScroll();
            this.tvodIndex--;
            this.posterfocus(1);
        } else {
            if (this.page == 1) return;
            this.stopScroll();
            if (this.page > 1) {
                this.page--;
            }
            this.showObj();
            this.tvodIndex = 7;
            this.posterfocus(0);
        }
    }
    this.down = function () {
        if (this.tvodIndex < 7) {

            if ((this.page - 1) * 8 + 1 + this.tvodIndex > this.tvodData.length-1) {
//                this.tvodIndex--;
                return;
            }else{
                this.stopScroll();
                this.tvodIndex++;
            }
            this.posterfocus(1);
        } else {
            if (this.page < this.totalPage) {
                this.stopScroll();
                this.page++;
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
        dom("tvodblur").style.visibility = "visible";
        if (flag == 0) {
            dom("tvodfocus").style.webkitTransitionDuration = 0;
            dom("tvodblur").style.webkitTransitionDuration = 0;
        } else {
            dom("tvodfocus").style.webkitTransitionDuration = 300;
            dom("tvodblur").style.webkitTransitionDuration = 300;
        }
        dom("tvodfocus").style.top = -18 + this.tvodIndex * 78 + "px";
        dom("tvodblur").style.top =  this.tvodIndex * 78 + "px";
        if(this.tvodData.length==0) return;
        starScroll("tvodname" + this.tvodIndex,this.tvodData[(this.page - 1) * 8 + this.tvodIndex].prevuename,276);
    }
    this.posterblur = function () {
        dom("tvodfocus").style.visibility = "hidden";
        dom("tvodblur").style.visibility = "hidden";
        dom("tvodblur").style.top = this.tvodIndex * 78 + "px";
        if(this.tvodData.length==0) return;
        this.stopScroll();
    }
    this.stopScroll=function(){
        if(this.tvodData[(this.page - 1) * 8 + this.tvodIndex].status==1) {
            document.getElementById("tvodname" + this.tvodIndex).innerHTML = subStringFunction(this.tvodData[(this.page - 1) * 8 + this.tvodIndex].prevuename,1,256);
        }else{
            document.getElementById("tvodname" + this.tvodIndex).innerHTML = "<font color=' #606060'>" + subStringFunction(this.tvodData[(this.page - 1) * 8 + this.tvodIndex].prevuename,1,256) + "</font>";
//            document.getElementById("prevuetime" +(leftprogramindex*7+programindex)).innerHTML = "<font color=' #606060'>" +  tvodArr[(destpage-1)*14+(leftprogramindex*7+programindex)].showtime + "</font>";
        }
        if(this.tvodData[(this.page - 1) * 8 + this.tvodIndex].data==1) {
            document.getElementById("tvodname" + this.tvodIndex).innerHTML = "<font color=' #F9D77D'>" + subStringFunction(this.tvodData[(this.page - 1) * 8 + this.tvodIndex].prevuename,1,256) + "</font>";
        }
    }
    this.ok=function(){
        if(this.tvodData[(this.page - 1) * 8 + this.tvodIndex].status==1){
            document.location="tvodplay.jsp?prevuecode="+this.tvodData[(this.page - 1) * 8 + this.tvodIndex].prevuecode+"&channelcode="+this.tvodData[(this.page - 1) * 8 + this.tvodIndex].channelcode+
              "&isfromchannel=1&mixno="+channelObj.channelData[(channelObj.page-1)*10+channelObj.channelIndex].mixno+"&columncode="+columnObj.columnData[(columnObj.page-1)*10+columnObj.columnIndex].columncode;

        }  else if(this.tvodData[(this.page - 1) * 8 + this.tvodIndex].data==1){
            var palymixno=channelObj.channelData[(channelObj.page-1)*10+channelObj.channelIndex].mixno;
            top.jsRedirectChannel(palymixno);
        }
    }
    this.showObj = function () {
        var start = 0;
        var end = 0;
        if (this.totalPage == this.page) {
            start = (this.page - 1) * 8;
            end = this.tvodData.length;
        } else {
            start = (this.page - 1) * 8;
            end = this.page * 8;
        }
        for (var i = 0; i < 8; i++) {
            if (i < (end - start)) {
            	var prevue_name = subStringFunction(this.tvodData[start + i].prevuename,1,256);
                if (this.tvodData[start + i].status == 1) {
                    dom("tvodname" + i).innerHTML = "<font color=' #fff'>"+prevue_name+"</font>";
                    dom("tvodtime" + i).innerHTML = "<font color=' #fff'>"+this.showTime(this.tvodData[start + i].begintime) + "-" + this.showTime(this.tvodData[start + i].endtime)+"</font>";
                    dom("tvodstaut" + i).style.visibility = "visible";
                } else {
//                    dom("tvodname" + i).innerHTML = this.tvodData[start + i].prevuename;
//                    dom("tvodtime" + i).innerHTML = this.showTime(this.tvodData[start + i].begintime) + "-" + this.showTime(this.tvodData[start + i].endtime);
                    dom("tvodname" + i).innerHTML = "<font color=' #606060'>" +prevue_name + "</font>";
                    dom("tvodtime" + i).innerHTML = "<font color=' #606060'>" + this.showTime(this.tvodData[start + i].begintime) + "-" + this.showTime(this.tvodData[start + i].endtime) + "</font>";
                    dom("tvodstaut" + i).style.visibility = "hidden";
                }
                if(this.tvodData[start + i].data == 1){
                    dom("tvodname" + i).innerHTML = "<font color=' #F9D77D'>"+prevue_name+"</font>";
                    dom("tvodtime" + i).innerHTML = "<font color=' #F9D77D'>"+this.showTime(this.tvodData[start + i].begintime) + "-" + this.showTime(this.tvodData[start + i].endtime)+"</font>";
                }
            } else {
                dom("tvodname" + i).innerHTML = "";
                dom("tvodtime" + i).innerText = "";
                dom("tvodstaut" + i).style.visibility = "hidden";
            }
        }
    }
    this.showTime = function (time) {
        var returntime = time.substring(11, 16);
        return returntime;
    }
    this.getChannelDate = function () {
        var requestUrl = "action/getchannelprogram.jsp?channelcode=" + channelObj.channelData[(channelObj.page - 1) * 10 + channelObj.channelIndex].channelcode + "&currdate=" + timeObj.timeData[timeObj.timeIndex];
        new net.ContentLoader(requestUrl, function () {
//                var datatext = this.req.responseText;
            tvodObj.tvodData = new Array();
            var data = eval("(" + this.req.responseText + ")");
            tvodObj.tvodData = data.prevuelist;
            if (tvodObj.tvodData.length > 1) {
                tvodObj.totalPage = Math.ceil(tvodObj.tvodData.length / 8);
                var index = 0;
                for (var i = 0; i < tvodObj.tvodData.length; i++) {
                    if (tvodObj.tvodData[i].data == 1) {
                        index = i;
                    }
                }
                tvodObj.page = Math.ceil(index / 8);
                if (index % 8 == 0) {
                    tvodObj.page++;
                }

                if (tvodObj.page == 0) {
                    tvodObj.page = 1;
                }
                tvodObj.tvodIndex = index - (tvodObj.page - 1) * 8;
                tvodObj.showObj();
                tvodObj.posterblur();
            } else {
                for (var i = 0; i < 8; i++) {
                    dom("tvodname" + i).innerHTML = "";
                    dom("tvodtime" + i).innerText = "";
                    dom("tvodstaut" + i).style.visibility = "hidden";
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
        if (tvodObj.tvodData.length == 0) {
            areaFlag = 1;
            this.posterblur();
            channelObj.posterfocus(0);
        } else {
            areaFlag = 2;
            this.posterblur();
            tvodObj.posterfocus(0);
        }
    }
    this.right = function () {

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
        dom("timeblur").style.visibility = "visible";
        if (flag == 0) {
            dom("timefocus").style.webkitTransitionDuration = 0;
            dom("timeblur").style.webkitTransitionDuration = 0;
        } else {
            dom("timefocus").style.webkitTransitionDuration = 300;
            dom("timeblur").style.webkitTransitionDuration = 300;
        }
        dom("timefocus").style.top = -15 + this.timeIndex * 98 + "px";
        dom("timeblur").style.top =  this.timeIndex * 98 + "px";
        setTimeout(function () {
            if(timeObj.lasttimeIndex==timeObj.timeIndex){
                return;
            }
            timeObj.lasttimeIndex=timeObj.timeIndex
            tvodObj.getChannelDate();
        }, 500);
    }
    this.posterblur = function () {
        dom("timefocus").style.visibility = "hidden";
        dom("timeblur").style.visibility = "visible";
        dom("timeblur").style.top = this.timeIndex * 98 + "px";
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
    if(showtimer!=null){
        clearTimeout(showtimer);
    }
    if (keyCode == 0x0008) {
        setTimeout(function(){top.jsHideOSD();},200);

    } else if (keyCode == <%=STBKeysNew.remoteMenu%>) {
		
			 top.doStop();
            top.currState = 0;
            // Authentication.CTCSetConfig("KeyValue", "0x110");
            // document.location = "portal.jsp";
               top.doKeyPress(evt);
    } else if (keyCode == 0x0025) { //onKeyLeft
        //doLeft();
        if (areaFlag == 0) {
            columnObj.left();
        } else if (areaFlag == 1) {
            channelObj.left();
        } else if (areaFlag == 2) {
            tvodObj.left();
        } else {
            timeObj.left();
        }

    } else if (keyCode == 0x0027) { //onKeyRight
        //doRight();
        if (areaFlag == 0) {
            columnObj.right();
        } else if (areaFlag == 1) {
            channelObj.right();
        } else if (areaFlag == 2) {
            tvodObj.right();
        } else {
            timeObj.right();
        }

    } else if (keyCode == 0x0026) {//onKeyUp
        //doUP();
        if (areaFlag == 0) {
            columnObj.up();
        } else if (areaFlag == 1) {
            channelObj.up();
        } else if (areaFlag == 2) {
            tvodObj.up();
        } else {
            timeObj.up();
        }
    }else if (keyCode == 0x0028) { //onKeyDown
        //doDown();
        if (areaFlag == 0) {
            columnObj.down();
        } else if (areaFlag == 1) {
            channelObj.down();
        } else if (areaFlag == 2) {
            tvodObj.down();
        } else {
            timeObj.down();
        }

    } else if (keyCode == 0x000D) {  //OK
        //doOk();
        if (areaFlag == 0) {
           // columnObj.ok();
        } else if (areaFlag == 1) {
            channelObj.ok();
        } else if (areaFlag == 2) {
            tvodObj.ok();
        } else {
           // timeObj.ok();
        }
    }else if (keyCode == 34) {
//        doPageDown();
        if (areaFlag == 1) {
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
        if (areaFlag == 1) {
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
    } else {
        top.doKeyPress(evt);
        return true;
    }
    showtimer=setTimeout(function(){top.jsHideOSD();},5000);
    return false;
}
function init() {
	document.onkeydown = dokeyPress;
    initPageObj();
    initShowPage();
    if (areaFlag == 0) {
        columnObj.posterfocus(0);
    } else if (areaFlag == 1) {
        channelObj.posterfocus(0);
    }
    //dom("test").innerHTML=dom("test").innerHTML + "<br/>---column----";
}

 var showtimer=setTimeout(function(){top.jsHideOSD();},5000);
</script>
</html>