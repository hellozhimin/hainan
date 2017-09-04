<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<epg:PageController name="zhuanti_all_list.jsp"/>
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
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .right_div div {
            -webkit-transform: scale(1.1, 1.1);
            -moz-transform: scale(1.1, 1.1);
            -transform: scale(1.1, 1.1);
            /*z-index: 99;*/
        }

        .right_div1 img {
            -webkit-transform: scale(1, 1);
            -moz-transform: scale(1, 1);
            -transform: scale(1, 1);
            /*z-index: 1;*/
        }

        .imgStyle0 {
            -webkit-transform: scale(1.1, 1.1);
            -moz-transform: scale(1.1, 1.1);
            -transform: scale(1.1, 1.1);
        }

        div {
            /*-webkit-transform:scale(1.2,1.2);*/
            transition: All 0.3s;
            /*z-index:99;*/
        }

    </style>
    <script type="text/javascript" src="js/contentloader.js"></script>
    <script type="text/javascript" src="js/dom.js"></script>
    <%--<script type="text/javascript" src="data/zhuanti_all_list.js"></script>--%>
</head>
<body background="images/bg.png" style="width: 1280px;height: 720px;overflow: hidden;">
<div style="position: absolute;left: 50px;top:43px;width: 1230px;height: 40px;font-size: 35px;color: #fff;"
     id="showinfo">

</div>
<div style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px;">
    <div style="position: absolute;left: 50px;top:97px;width: 1230px;height: 720px;" id="my">
        <%
            for (int i = 0; i < 6; i++) {      //-11,0
                int row = i / 3;
                int col = i % 3;
        %>
        <div style="position: absolute;left:<%=col*395%>px;top:<%=row*312%>px;width: 386px;height: 217px;"
             id="mydiv<%=i%>">
            <img src="images/zhuanti/alllist/1.png" id="myimg<%=i%>" width="100%" height="100%">
        </div>
        <div style="position: absolute;left:<%=col*395%>px;top:<%=row*312+227%>px;width: 386px;height: 40px;font-size: 30px;color: #fff;line-height: 50px;"
             class="font_ellipsis" align="center" id="name<%=i%>">
            <%--市领导可能公路局费德勒将--%>
        </div>
        <%
            }
        %>

        <div style="position: absolute;left:-19px;top:-19px;width: 254px;height: 171px;visibility: hidden;"
             id="myfocus">
            <img src="images/zhuanti/alllist/f0.png" width="426" height="252" id="myfocusimg">
        </div>
    </div>
</div>


<div style="position: absolute;left: 1247px;top:120px;width: 6px;height: 500px; background: url(images/vod/scrollBarBg.png) repeat-y;"
     id="showscrollbar">
    <div style="position: absolute;left: 0px;top:50px;width: 6px;height: 0px;"
         id="scorllbar">
        <img src="images/vod/scrollBarFocus.png" style="width: 6px;height: 1px;" id="scorllbar1">
    </div>
</div>
<script>
    var index = parseInt("<%=lastList[1]%>",10);              //当前下标
    var programData = new Array();
    var totalpage = 0;
    var page = parseInt("<%=lastList[0]%>",10);
    var totalcount = 0;
    function donothing() {
        return false;
    }
    function pageBack() {
//        top.jsHideOSD();
        document.location = "back.jsp";
    }
    function dook() {
        var leefocus=page+"-"+index;
         var url=programData[(page - 1) * 6 + index].linkURL;
//        alert("====linkURL====" + programData[(page - 1) * 6 + index].linkURL);
        //document.location=programData[index].linkURL;
        if(url.indexOf("?")>-1){
            url=url+"&leefocus="+leefocus;
        }else{
            url=url+"?leefocus="+leefocus;
        }
        url=url+"&programcode="+programData[(page - 1) * 6 + index].programcode+"&vodtype=100";
        document.location=url;
    }
    function doLeft() {
        if (index > 0) {
//            movefocus(0);
            index--;
            movefocus(1);
        }

    }
    function doRight() {
        if (index < totalcount - 1) {
//            movefocus(0);
            index++;
            movefocus(1);
        }

    }
    function doDown() {
        if (index < 3) {
//            movefocus(0);
            index += 3;
            if ((page - 1) * 5 + 1 + index > programData.length - 1) {
                index -= 3;
                return;
            }
            movefocus(1);
        } else {
            if (page < totalpage) {
                page++;
                showObj();
                index = 0;
                movefocus(1);
            }

        }
    }

    function doUp() {
        if (index > 2) {
            index -= 3;
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
    function showObj() {
        var start = 0;
        var end = 0;
        if (totalpage == page) {
            start = (page - 1) * 6;
            end = programData.length;
        } else {
            start = (page - 1) * 6;
            end = page * 6;
        }
        totalcount = end - start;
//        console.log(start+"=============="+end);
        for (var i = 0; i < 6; i++) {
            if (i < (end - start)) {
                dom("myimg" + i).src = programData[start + i].images;
                dom("name" + i).innerHTML = programData[start + i].name;
            } else {
                dom("myimg" + i).src = "images/btn_trans.gif";
                dom("name" + i).innerHTML = "";
            }
        }
        dom("scorllbar").style.top = (page-1) * parseInt(dom("scorllbar1").style.height);
    }
    function movefocus(id) {

        var leftdiv = dom("mydiv" + index).style.left;
        var topdiv = dom("mydiv" + index).style.top;
//        dom("myfocus").style.left=-19+(index%3)*395+"px";
        dom("myfocus").style.left = -19 + parseInt(leftdiv, 10);
        dom("myfocus").style.top = -19 + parseInt(topdiv, 10);
        dom("myfocus").style.webkitTransitionDuration = 300;
    }
    function init() {
//        programData = eval("(" + zhuantiJSON + ")");
        dom("showinfo").innerHTML = "全部专题|共<font color='#cc7d1d'>" + programData.length + "</font>部";
        if (programData.length == 0) {
            dom("showscrollbar").style.visibility = "hidden";
        } else {
            totalpage = Math.ceil(programData.length / 6);
            dom("scorllbar1").style.height = 500 / totalpage;

            showObj();
            dom("myfocus").style.visibility = "visible";
            movefocus(1);
        }

    }
//    init();
    function getZhuantiDate(){
//        alert("===============");
        var requestUrl = "action/get_zhuanti.jsp?index=<%=index%>";
        new net.ContentLoader(requestUrl, function () {
            var data = eval("(" + this.req.responseText + ")");
            programData=data;
//            alert("=====navigationJSON===="+navigationJSON);
            init();
        });
    }
    getZhuantiDate();
    function doMenu() {
         top.mainWin.document.location =  '<%=page_url%>' ;
    }
    function dokeypress(evt) {
        var keyCode = parseInt(evt.which);
        if (keyCode == 0x0008) {
            pageBack();
        } else if (keyCode == 0x0025) { //onKeyLeft
            doLeft();

        } else if (keyCode == 0x0027) { //onKeyRight
            doRight();

        } else if (keyCode == 0x0026) {//onKeyUp
            doUp();
        }
        if (keyCode == 0x0028) { //onKeyDown
            doDown();

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
<%@include file="inc/lastfocus.jsp" %>

</body>
</html>
