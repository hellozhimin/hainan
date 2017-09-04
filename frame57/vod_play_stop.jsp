<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zte.iptv.epg.utils.Utils" %>
<%@ page import="com.zte.iptv.epg.util.*" %>
<%@ page import="java.util.*" %>
<%@page import="com.zte.iptv.volcano.epg.account.User"%>
<%@page import="com.zte.iptv.volcano.data.QueryResult"%>
<%@page import="com.zte.iptv.volcano.epg.constants.NameConstants"%>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<epg:PageController/>
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
    public String getPorgramnameVodInfo(User user, String telcode)
    {
        QueryResult qr = user.query(NameConstants.VIEWNAME_USER_VOD, "",
                "contentcode='" + telcode + "'", "", 1, 1, null);
        String porgramname = "";
        if (null != qr)
        {
            List vodlist = qr.getResultList();
//            System.out.println("=======wwww====");
            if (null != vodlist && vodlist.size() > 0)
            {
                Map vod = (Map)vodlist.get(0);
                if (vod != null)
                {
                    porgramname = (String)vod.get("programname");
//                    contentcode = (String)vod.get("contentcode");
                }
            }
        }
        return porgramname;

    }
%>
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
    User user = User.getCurrentUser();
    String columncode = request.getParameter("columnid");
    String contentcode = request.getParameter("contentcode");
    String programname=getPorgramnameVodInfo(user,contentcode);
    String currTime = request.getParameter("currTime");
    String seriesprogramcode = request.getParameter("seriesprogramcode");
    String vodtype = request.getParameter("vodtype");
//    System.out.println("======vodtype====="+vodtype);
    String fromBookMark = String.valueOf(request.getParameter("fromBookMark"));
    String path = getPath(request.getRequestURI());
    String mediaservice = "32";
    mediaservice = String.valueOf(request.getParameter("mediaservices"));
%>
<html>
<head>
    <title>osd</title>
    <meta name="page-view-size" content="1280*720">
</head>
<!--VOD播放过程中按遥控器返回键，弹出的【是否退出？确认取消保存书签】对话框-->
<body bgcolor="transparent" onLoad="pageInit()">
<div style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px;">

    <div style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px;display: none;" id="serdiv">
        <img src="images/channel/allbg.png">
        <div style="left:0; top:236;width:1280;height:100px; position:absolute;font-size: 35px;color: #fff;" align="center">
            是否退出当前节目？
        </div>
        <div style="position: absolute;top:328px;left: 391px;width: 151px;height: 64px;">
            <img src="images/channel/15.png" width="151" height="64" id="focusimg0">
        </div>
        <div style="position: absolute;top:328px;left: 561px;width: 151px;height: 64px;">
            <img src="images/channel/14.png" width="151" height="64" id="focusimg1">
        </div>
        <div style="position: absolute;top:328px;left: 730px;width: 151px;height: 64px;">
            <img src="images/channel/14.png" width="151" height="64" id="focusimg2">
        </div>
        <div style="position: absolute;top:328px;left: 391px;width: 151px;height: 64px;line-height: 64px;color: #fff;font-size: 30px;"
             align="center">
            下一集
        </div>
        <div style="position: absolute;top:328px;left: 561px;width: 151px;height: 64px;line-height: 64px;color: #fff;font-size: 30px;"
             align="center">
            确定
        </div>
        <div style="position: absolute;top:328px;left: 730px;width: 151px;height: 64px;line-height: 64px;color: #fff;font-size: 30px;"
             align="center">
            取消
        </div>
    </div>
    <div style="position: absolute;left: 343px;top:170px;width: 594px;height: 379px;display: none;" id="voddiv">
        <img src="images/tvod/dialog_bg.png">
        <div  style="left:0; top:100;width:594;height:100px; position:absolute;font-size: 38px;color: #fff;" align="center">
            是否退出当前节目？
        </div>
        <div style="position: absolute;top:250px;left: 116px;width: 151px;height: 64px;">
            <img src="images/channel/15.png" width="151" height="64" id="focusimg10">
        </div>
        <div style="position: absolute;top:250px;left: 327px;width: 151px;height: 64px;">
            <img src="images/channel/14.png" width="151" height="64" id="focusimg11">
        </div>
        <div style="position: absolute;top:250px;left: 116px;width: 151px;height: 64px;line-height: 64px;color: #fff;font-size: 30px;" align="center">
            确定
        </div>
        <div style="position: absolute;top:250px;left: 327px;width: 151px;height: 64px;line-height: 64px;color: #fff;font-size: 30px;" align="center">
            取消
        </div>
    </div>
</div>
<script type="text/javascript" src="js/contentloader.js"></script>
<script language="javascript">
//    top.jsClearVideoKeyFunction();
    // pageDoVODMark();
    var index = 0;
    var totalcount=0;
function getSeriesData() {
    var requestUrl = "action/get_series_single_data.jsp?columncode=<%=columncode%>&programid=<%=seriesprogramcode%>";
    new net.ContentLoader(requestUrl, function () {
        var resultsdata = eval("(" + this.req.responseText + ")");
        seriesArr = resultsdata.seriesData;
        seriesLeng = seriesArr.length;
    });

}
     function pageInit(){
         if("<%=seriesprogramcode%>" != "" && "<%=seriesprogramcode%>" != "null"){
             document.getElementById("serdiv").style.display="block";
             totalcount=2;
             getSeriesData();
         } else{
             document.getElementById("voddiv").style.display="block";
             totalcount=1;
         }
     }
    function delayStop() {
        top.jsClearVideoKeyFunction();
        //二期从书签播放后返回需要播放频道
        <%--if ("<%=fromBookMark%>" == "true") {--%>
            <%--top.vodBackTimer = top.setTimeout("top.mainWin.document.location='<%=path%>back.jsp';top.showOSD(2, 0, 0);", 800);--%>
            <%--//playChannel();--%>
        <%--} else {--%>
            <%--top.vodBackTimer = top.setTimeout("top.mainWin.document.location='<%=path%>back.jsp';top.showOSD(2, 0, 0);", 500);--%>
            <%--top.jsHideOSD();--%>
        <%--}--%>
        setTimeout(function(){
            document.location="back.jsp";
        },800);

    }
    function pageDoVODMark() {
        var breakpoint = top.mp.getCurrentPlayTime();
        top.doStop();
        if("<%=vodtype%>"=="1"||"<%=vodtype%>"=="10"){
            saveMark(breakpoint);
            if ("<%=seriesprogramcode%>" != "" && "<%=seriesprogramcode%>" != "null") {
                saveMark1();
            }
        }
        delayStop();
        top.setBwAlpha(0);
		var currTime="<%=currTime%>";
		var endTime=Date.parse(new Date()) / 1000;
		var watchtime=endTime-parseInt(currTime);
    }
    function saveMark(breakpoint) {
        var requestUrl = "action/add_bookmark.jsp?breakpoint=" + breakpoint + "&columncode=<%=columncode%>&contentcode=<%=contentcode%>";
        new net.ContentLoader(requestUrl, function () {
            var data = eval("(" + this.req.responseText + ")");
        });
    }
    function saveMark1() {
        var series_Index = top.jsGetControl("series_Index");
        top.jsSetControl("series_Index", "");
        var requestUrl = "action/add_bookmark1.jsp?breakpoint=" + series_Index + "&columncode=<%=columncode%>&seriesprogramcode=<%=seriesprogramcode%>&mediaservices=<%=mediaservice%>";
        new net.ContentLoader(requestUrl, function () {
            var data = eval("(" + this.req.responseText + ")");
        });
    }

    function donothing() {
        return false;
    }
    function pageBack() {
        if(top.isPlay()){
            top.jsDoResume();
            setTimeout(function(){
                top.jsHideOSD();
            },500);
        }else{
            document.location="back.jsp";
        }

    }
    function dook() {
//        document.location="back.jsp";
        if("<%=seriesprogramcode%>" != "" && "<%=seriesprogramcode%>" != "null"){
            if (index == 0) {
                var Index = top.jsGetControl("series_Index");
                if (Index != "" && !isNaN(Index)) //记忆为空
                {
                    Index = parseInt(Index);
                }else{
                    Index = 1;
                }
                Index++;
                document.location = "vod_play.jsp?programcode=" + seriesArr[Index-1].programid +
                        "&columncode=<%=columncode%>&contentcode=" + seriesArr[Index-1].contentcode +
                        "&definition=" + seriesArr[Index-1].definition+
                        "&seriesprogramcode=<%=seriesprogramcode%>" +
                        "&seriesIndex="+(Index) ;
            } else if (index == 1) {
                pageDoVODMark();
            }else{
                pageBack();
            }
        }else{
            if (index == 0) {
                //document.location = "back.jsp";
                pageDoVODMark();
            } else if (index == 1) {
                pageBack();
            }
        }

    }
    function doLeft() {
        if("<%=seriesprogramcode%>" != "" && "<%=seriesprogramcode%>" != "null"){
            if (index > 0) {
                document.getElementById("focusimg" + index).src = "images/channel/14.png";
                index--;
                document.getElementById("focusimg" + index).src = "images/channel/15.png";
            }
        } else{
            if (index > 0) {
                document.getElementById("focusimg1" + index).src = "images/channel/14.png";
                index--;
                document.getElementById("focusimg1" + index).src = "images/channel/15.png";
            }
        }


    }
    function doRight() {
        if("<%=seriesprogramcode%>" != "" && "<%=seriesprogramcode%>" != "null"){
            if (index < totalcount) {
                document.getElementById("focusimg" + index).src = "images/channel/14.png";
                index++;
                document.getElementById("focusimg" + index).src = "images/channel/15.png";
            }
        } else{
            if (index < totalcount) {
                document.getElementById("focusimg1" + index).src = "images/channel/14.png";
                index++;
                document.getElementById("focusimg1" + index).src = "images/channel/15.png";
            }
        }


    }
    function doMenu() {
        // top.mainWin.document.location = "portal.jsp";
               top.mainWin.document.location = '<%=page_url%>' ;
    }
    function dokeypress(evt) {
//        alert("=============")
        var keyCode = parseInt(evt.which);
        if (keyCode == 8) {
            //alert("=====22=======");
            pageBack();
        } else if (keyCode == 0x0025) { //onKeyLeft
            doLeft();

        } else if (keyCode == 0x0027) { //onKeyRight
            doRight();

        } else if (keyCode == 0x0026) {//onKeyUp
            //doUP();
        }else if (keyCode == 0x0028) { //onKeyDown
            //doDown();

        } else if (keyCode == 0x000D) {  //OK
            dook();
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
<%@ include file="inc/lastfocus.jsp" %>
</html>
