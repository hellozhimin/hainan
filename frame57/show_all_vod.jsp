<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.zte.iptv.volcano.epg.account.User"%>
<%@page import="com.zte.iptv.volcano.data.QueryResult"%>
<%@page import="com.zte.iptv.volcano.epg.constants.NameConstants"%>
<%@ page import="java.util.*" %>
<%!
    public String getPorgramnameVodInfo(User user, String telcode)
    {
        QueryResult qr = user.query(NameConstants.VIEWNAME_USER_VOD, "",
                "programcode='" + telcode + "'", "", 1, 1, null);
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
    User user = User.getCurrentUser();
    String programid = request.getParameter("programid");
    String programname=getPorgramnameVodInfo(user,programid);
    String columnid = request.getParameter("columnid");
    String seriesprogramcode = request.getParameter("seriesprogramcode");
%>
<html>
<head>
    <title>show_all_series</title>
    <meta name="page-view-size" content="1280*720"/>
    <meta http-equiv="content-Type" content="text/html; charset=utf-8">
    <script type="text/javascript" src="js/dom.js"></script>
    <script type="text/javascript" src="js/contentloader.js"></script>

</head>
<body bgcolor="transparent">
<div style="left:30px; top:10px;width:1000px;height:100px; position:absolute;line-height: 100px;font-size: 35px;color: #fff;" >
    <%=programname%>
</div>
<div style="position: absolute;left: 398px;top:126px;width: 211px;height: 438px;">
    <img src="images/series/zongyibg.png" width="484" height="468">
</div>
<div style="position: absolute;left: 616px;top:151px;width: 47px;height: 47px;visibility: hidden;" id="up">
    <img src="images/series/25.png">
</div>
<div style="position: absolute;left: 616px;top:545px;width: 47px;height: 47px;visibility: hidden;" id="down">
    <img src="images/series/23.png">
</div>
<div style="position: absolute;left: 398px;top:195px;width: 211px;height: 438px;">
    <div style="position: absolute;left:37px;top:0px;width: 211px;height: 49px;visibility: hidden;" id="seriesblur">
        <img src="images/series/seriesblur.png" width="410" height="49">
    </div>
    <div style="position: absolute;left:37px;top:0px;width: 211px;height: 49px;visibility: hidden;" id="seriesfocus">
        <img src="images/series/seriesfocus.png" width="410" height="49">
    </div>
    <%
        for (int i = 0; i < 7; i++) {
    %>
    <div style="position: absolute;left: 37px;top:<%=i*49%>px;width: 410px;height: 49px;font-size:25px;color:#fff;line-height:49px;"
         align="center" id="showindex<%=i%>" class="font_ellipsis">
        <%--第<%=i + 1%>集--%>
    </div>
    <%
        }
    %>
</div>
<%@include file="inc/scrollString.jsp" %>
<script language="javascript">
    var index = 0;
    var playindex = 0;
    var playpage = 0;
    var page = 1;
    var seriesLeng = 0;
    var totalPage = 0;
    var seriesArr = new Array();
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
    function showObj() {
        var start = 0;
        var end = 0;
        if (totalPage == page) {
            start = (page - 1) * 7;
            end = seriesLeng;
        } else {
            start = (page - 1) * 7;
            end = page * 7;
        }
//        console.log(start+"=============="+end);
        var index1=-1;
        for (var i = 0; i < 7; i++) {
            if (i < (end - start)) {
//                dom("showindex" + i).innerHTML = seriesArr[(start + i)].programName;
//                stopScroll("showindex" +i,seriesArr[(start + i)].programName);
                stopstr("showindex" +i,seriesArr[(start + i)].programName,15);
//                stopstr("showindex" +i,"善良劫匪我饿经费了司法局哦呜金额非鹿鼎记佛为减肥多了几分我饿",15);
                if (seriesArr[(start + i)].index == 1) {
//                    firstindex = i;
                    index1=i;
                }
            } else {
                dom("showindex" + i).innerHTML = "";
            }
        }
        if(index1>-1){
            dom("seriesblur").style.visibility = "visible";
            dom("seriesblur").style.top = 49 * index1 + "px";
        } else{
            dom("seriesblur").style.visibility = "hidden";
            dom("seriesblur").style.top = 49 * index1 + "px";
        }
        if(page==totalPage&&page>1){
            dom("up").style.visibility="visible";
            dom("down").style.visibility="hidden";
        } else if(page==totalPage&&page==1) {
            dom("up").style.visibility="hidden";
            dom("down").style.visibility="hidden";
        } else if(page==1){
            dom("up").style.visibility="hidden";
            dom("down").style.visibility="visible";
        } else{
            dom("up").style.visibility="visible";
            dom("down").style.visibility="visible";
        }
    }
    function movefocus(id) {
        if(id==0){
//            stopScroll("showindex" + index,seriesArr[(page-1)*7+index].programName);
            stopstr("showindex" + index,seriesArr[(page-1)*7+index].programName,15);
        }else{
//            alert("============"+seriesArr[(page-1)*7+index].programName);
//            starScroll("showindex" + index,seriesArr[(page-1)*7+index].programName,410);
            starstr("showindex" + index,seriesArr[(page-1)*7+index].programName,15);
        }
        dom("seriesfocus").style.visibility = "visible";
        dom("seriesfocus").style.top = 49 * index + "px";
    }
    function getSeriesData() {
        var requestUrl = "action/get_vodprogram_data1.jsp?columnid=<%=columnid%>&programid=<%=programid%>";
        new net.ContentLoader(requestUrl, function () {
            var resultsdata = eval("(" + this.req.responseText + ")");
            seriesArr = resultsdata.vodData;
//            totalcount = resultsdata.totalcount;
            //pagecount = parseInt(resultsdata.pagecount, 10);
            seriesLeng = seriesArr.length;
//            seriesLeng=40;
//            if (seriesLeng > 7) {
//                dom("up").style.visibility = "visible";
//                dom("down").style.visibility = "visible";
//            }
            totalPage = Math.ceil(seriesLeng / 7);
            var firstindex=0;
            for(var i=0;i<seriesLeng;i++){
                if (seriesArr[i].index == 1) {
                    firstindex = i;
                }
            }
            page = Math.ceil((firstindex) / 7);
            if ((firstindex) % 7 == 0) {
                page++;
            }
            index = firstindex - (page - 1) * 7;
            showObj();
            movefocus(1);

        });

    }
    function doUp() {
        if (index > 0) {
            movefocus(0);
            index--;
            movefocus(1);
        } else {
            if (page == 1) return;
            if (page > 1) {
                page--;
            }
            showObj();
            index = 6;
            movefocus(1);
        }
    }
    function doDown() {
        if (index < 6) {
            if ((page - 1) * 7 + 1 + index > seriesLeng - 1) {
                index--;
                return;
            } else {
                movefocus(0);
                index++;
            }

//            console.log((page - 1) * 4 + 1 + index+"=============="+index);
            movefocus(1);
        } else {
            if (page < totalPage) {
                page++;
                showObj();
                index = 0;
                movefocus(1);
            }

        }
    }
    function doOk() {
        <%--document.location = "vod_play.jsp?programcode=" + seriesArr[(page - 1) * 7 + index].programid +--%>
                <%--"&columncode=<%=columnid%>&contentcode=" + seriesArr[(page - 1) * 7 + index].contentcode +--%>
                <%--"&definition=" + seriesArr[(page - 1) * 7 + index].definition+--%>
                <%--"&seriesprogramcode=<%=seriesprogramcode%>" ;--%>
       document.location="zhuanti_play.jsp?programcode="+seriesArr[(page - 1) * 7 + index].programId+"&vodtype=101";
    }
    function dokeyPress(evt) {
        var keyCode = parseInt(evt.which);
        if (keyCode == 0x0008) {
            setTimeout(function () {
                top.jsHideOSD();
            }, 200);

        } else if (keyCode == 0x0025) { //onKeyLeft
            //doLeft();

        } else if (keyCode == 0x0027) { //onKeyRight
            //doRight();
        } else if (keyCode == 0x0026) {//onKeyUp
            doUp();
        }else if (keyCode == 0x0028) { //onKeyDown
            doDown();
        } else if (keyCode == 0x000D) {  //OK
            doOk();
        }else if (keyCode == 34) {
//        doPageDown();
            if (page < totalPage) {
                page++;
                showObj();
                index = 0;
                movefocus(1);
            }
        } else if (keyCode == 33) {
//        doPageUp();
            if (page == 1) return;
            if (page > 1) {
                page--;
            }
            showObj();
            index = 0;
            movefocus(1);
        } else {
            top.doKeyPress(evt);
            return true;
        }
        return false;
    }
    document.onkeydown = dokeyPress;
    function init() {
        getSeriesData();
    }
    init();
</script>
<%@include file="inc/lastfocus.jsp" %>

</body>

</html>
