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
<div style="position: absolute;left: 524px;top:141px;width: 211px;height: 438px;">
    <img src="images/series/seriesbg.png" width="211" height="438">
</div>
<div style="position: absolute;left: 606px;top:151px;width: 47px;height: 47px;visibility: hidden;" id="up">
    <img src="images/series/25.png">
</div>
<div style="position: absolute;left: 606px;top:540px;width: 47px;height: 47px;visibility: hidden;" id="down">
    <img src="images/series/23.png">
</div>
<div style="position: absolute;left: 524px;top:215px;width: 211px;height: 438px;">
    <div style="position: absolute;left:10px;top:0px;width: 211px;height: 49px;visibility: hidden;" id="seriesblur">
        <img src="images/series/seriesblur.png" width="190" height="49">
    </div>
    <div style="position: absolute;left:10px;top:0px;width: 211px;height: 49px;visibility: hidden;" id="seriesfocus">
        <img src="images/series/seriesfocus.png" width="190" height="49">
    </div>
    <%
        for (int i = 0; i < 6; i++) {
    %>
    <div style="position: absolute;left: 0px;top:<%=i*49%>px;width: 211px;height: 49px;font-size:27px;color:#b9b6b7;line-height:49px;"
         align="center" id="showindex<%=i%>">
        第<%=i + 1%>集
    </div>
    <%
        }
    %>
</div>

<script language="javascript">
    var index = 0;
    var playindex = parseInt(top.jsGetControl("series_Index"),10);
    var playpage = 0;
    var page = 1;
    var seriesLeng = 0;
    var totalPage = 0;
    var seriesArr = new Array();
    function showObj() {
        var start = 0;
        var end = 0;
        if (totalPage == page) {
            start = (page - 1) * 6;
            end = seriesLeng;
        } else {
            start = (page - 1) * 6;
            end = page * 6;
        }
//        console.log(start+"=============="+end);
        var index1=-1;
        for (var i = 0; i < 6; i++) {
            if (i < (end - start)) {
                dom("showindex" + i).innerHTML = "第" + (start + i + 1) + "集";
                if(playindex==(start + i + 1)){
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
        dom("seriesfocus").style.visibility = "visible";
        dom("seriesfocus").style.top = 49 * index + "px";
    }
    function getSeriesData() {
        var requestUrl = "action/get_series_single_data.jsp?columncode=<%=columnid%>&programid=<%=seriesprogramcode%>";
        new net.ContentLoader(requestUrl, function () {
            var resultsdata = eval("(" + this.req.responseText + ")");
            seriesArr = resultsdata.seriesData;
//            totalcount = resultsdata.totalcount;
            //pagecount = parseInt(resultsdata.pagecount, 10);
            seriesLeng = seriesArr.length;
//            seriesLeng=40;
//            if (seriesLeng > 6) {
//                dom("up").style.visibility = "visible";
//                dom("down").style.visibility = "visible";
//            }
            totalPage = Math.ceil(seriesLeng / 6);
            page = Math.ceil((playindex - 1) / 6);
            if ((playindex-1) % 6 == 0) {
                page++;
            }
            index = (playindex - 1)%6;
//            alert("====index===="+index);
            showObj();
            movefocus(0);
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
            index = 5;
            movefocus(1);
        }
    }
    function doDown() {
        if (index < 5) {
            if ((page - 1) * 6 + 1 + index > seriesLeng - 1) {
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
        document.location = "vod_play.jsp?programcode=" + seriesArr[(page - 1) * 6 + index].programid +
                "&columncode=<%=columnid%>&contentcode=" + seriesArr[(page - 1) * 6 + index].contentcode +
                "&definition=" + seriesArr[(page - 1) * 6 + index].definition+
                "&seriesprogramcode=<%=seriesprogramcode%>" +
                  "&seriesIndex="+((page - 1) * 6 + index+1 ) ;
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
        }
        if (keyCode == 0x0028) { //onKeyDown
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
    }  else {
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
</body>
<%@include file="inc/lastfocus.jsp" %>
</html>
