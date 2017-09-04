<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<epg:PageController name="zhuanti_list.jsp"/>
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
    //System.out.println("6407000229:lastfocus:"+lastfocus);
    if (lastfocus.equals("null") || lastfocus.equals("")) {
        lastfocus = "0";
    }
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
        .posterfocus {
            width: 229px;
            height: 308px;
            left: -11px;
            top:-38px;
            position: absolute;
        }

        .posterblur {
            width: 206px;
            height: 277px;
            left: 0px;
            top:0px;
            position: absolute;
        }
        div {
            /*-webkit-transform:scale(1.2,1.2);*/
            transition: All 0.3s;
            /*z-index:99;*/
        }

    </style>
    <script type="text/javascript" src="js/contentloader.js"></script>
    <script type="text/javascript" src="js/dom.js"></script>
    <%--<script type="text/javascript" src="data/zhuanti_list.js"></script>--%>
    <%@include file="inc/scrollString.jsp" %>
</head>
<body  style="width: 1280px;height: 720px;overflow: hidden;">
<div style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px;overflow: hidden;" >
    <img src="images/btn_trans.gif" id="bgpic">
    <%--<img src="images/zhuanti/list1/bg.png" src="bgpic">--%>

    <div style="position: absolute;left: 40px;top:285px;width: 2580px;height: 720px;" id="my">
        <%
            for (int i = 0; i < 10; i++) {      //-11,0
        %>
        <div style="position: absolute;left:<%=i*239%>px;top:38px;width: 206px;height: 277px;" id="mydiv<%=i%>">
            <img src="images/btn_trans.gif" id="myimg<%=i%>" width="100%" height="100%">
        </div>
        <div style="position: absolute;left:<%=i*239%>px;top:322px;width: 206px;height: 40px;font-size: 25px;color: #3E9DFC;line-height: 40px;"
             class="font_ellipsis" align="center" id="name<%=i%>">

        </div>
        <%
            }
        %>

        <div style="position: absolute;left:-22px;top:-15px;width: 254px;height: 171px;visibility: hidden;"
             id="myfocus">
            <img src="images/zhuanti/list/foucs.png" id="myfocusimg">
        </div>
    </div>
</div>
<script>
    var index = "<%=lastfocus%>";              //当前图片的获取焦点的下标
    var programData = new Array();     // 数据存放的数组
    function donothing() {
        return false;
    }
    // 遥控器按返回键执行的方法
    function pageBack(){
//        top.jsHideOSD();
        document.location="back.jsp";
    }
    // 遥控器按ok键执行的方法
    function dook(){
        var leefocus=index;
        var url=programData[index].linkURL;
//        alert("====linkURL====" + programData[index].linkURL);
        //document.location=programData[index].linkURL;
        if(url.indexOf("?")>-1){
            url=url+"&leefocus="+leefocus;
        }else{
            url=url+"?leefocus="+leefocus;
        }
        document.location=url;
    }
    // 遥控器按左键执行的方法
    function doLeft(){
        if(index>0){
            movefocus(0);
            index--;
            if(index<5){
                dom("my").style.left=40+"px";
            }
            movefocus(1);
        }

    }
    // 遥控器按右键执行的方法
    function doRight(){
        if(index<programData.length-1){
            movefocus(0);
            index++;
            if(index>4){
               dom("my").style.left=-1150+"px";
            }
            movefocus(1);
        }

    }
    // 图片获取焦点时候和失去焦点的时候，执行的方法，id=0是失去焦点，id=1的时候得到焦点
    function movefocus(id){
         if(id==0){
             dom("myimg"+index).setAttribute("class","posterblur");
             stopScroll("name"+index, programData[index].name);
         }else{
             dom("myimg"+index).setAttribute("class","posterfocus");
             starScroll("name"+index, programData[index].name,11);
         }
        dom("myfocus").style.left=-22+index*239+"px";
        dom("myfocus").style.webkitTransitionDuration = 300;
    }
    //初始化方法，显示页面的数据
    function init(){
//        programData=eval("(" + zhuantiJSON + ")");
        for(var i=0;i<programData.length;i++){
           dom("myimg"+i).src= programData[i].images;
//           dom("name"+i).innerText= programData[i].name;
            stopScroll("name"+i, programData[i].name);
        }
        if(programData.length==0){

        } else{
            if(index>4){
                dom("my").style.left=-1150+"px";
            }
            dom("myfocus").style.visibility="visible";
            movefocus(1);
        }

    }
//    init();
    //ajax从配置文件中获取数据可以根据index值不同，获取不同的数据，需要在配置文件中配置
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
    function getZhuantiBgpic(){
//        alert("===============");
        var requestUrl = "action/get_zhuantipic.jsp?index=0";
        new net.ContentLoader(requestUrl, function () {
            var data = eval("(" + this.req.responseText + ")");
            dom("bgpic").src=data.images;
        });
    }
    getZhuantiBgpic();
    getZhuantiDate();
    function doMenu(){
        // top.mainWin.document.location = "portal.jsp";
         top.mainWin.document.location =  '<%=page_url%>' ;
    }
    function dokeypress(evt){
        var keyCode = parseInt(evt.which);
        if (keyCode == 0x0008) {
            pageBack();
        } else if (keyCode == 0x0025) { //onKeyLeft
            doLeft();

        } else if (keyCode == 0x0027) { //onKeyRight
            doRight();

        } else if (keyCode == 0x0026) {//onKeyUp
            //doUP();
        }
        if (keyCode == 0x0028) { //onKeyDown
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
<%@include file="inc/lastfocus.jsp" %>

</body>
</html>
