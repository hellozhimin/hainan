<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<epg:PageController name="back.jsp"/>
<%--<%@include file="inc/words.jsp"%>--%>
<%
 String ContentID=request.getParameter("channelcode");
 String subjectId=request.getParameter("columnid");
 String currTime = request.getParameter("currTime");
 String channelname = request.getParameter("channelname");
  channelname=java.net.URLDecoder.decode(channelname,"UTF-8");
  boolean isfav=false;
    StringBuffer sql = new StringBuffer();
    sql.append(" favoritetype=5  and state=1");
%>
<ex:params var="inputparams">
    <ex:param name="unique" value="1"/>
</ex:params>
<ex:search tablename="user_favorite" fields="*" inputparams="${inputparams}" condition="<%=sql.toString()%>"
           var="vodFavList" order="savetime desc">
    <%
        List favoriteList = (ArrayList) pageContext.getAttribute("vodFavList");
//        System.out.println("--------favoriteList.size()---1111111----" + favoriteList);
        if (favoriteList != null) {
//            System.out.println("--------favoriteList.size()-------" + favoriteList);
            for (int i = 0; i < favoriteList.size(); i++) {
                Map tempMap = (Map) favoriteList.get(i);
                String contentcode=String.valueOf(tempMap.get("contentcode"));
                if(contentcode.equals(ContentID)){
                    isfav=true;
                    break;
                }
            }
        }
    %>
</ex:search>
<html>
<head>
    <meta name="page-view-size" content="1280*720">
</head>
<script type="text/javascript" src="js/contentloader.js"></script>
<body bgcolor="transparent"  style="background: url(images/channel/allbg.png);">
<div style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px;">
    <div  style="left:0; top:236;width:1280;height:100px; position:absolute;font-size: 35px;color: #fff;" align="center">
       是否退出直播节目？
    </div>
    <%--<div style="position: absolute;top:328px;left: 391px;" id="focusimg">--%>
           <%--<img src="images/channel/btufoucs.png">--%>
    <%--</div>--%>
    <div style="position: absolute;top:328px;left: 391px;width: 151px;height: 64px;">
        <img src="images/channel/15.png" width="151" height="64" id="focusimg0">
    </div>
    <div style="position: absolute;top:328px;left: 561px;width: 151px;height: 64px;">
        <img src="images/channel/14.png" width="151" height="64" id="focusimg1">
    </div>
    <div style="position: absolute;top:328px;left: 730px;width: 151px;height: 64px;">
        <img src="images/channel/14.png" width="151" height="64" id="focusimg2">
    </div>
    <div style="position: absolute;top:328px;left: 391px;width: 151px;height: 64px;line-height: 64px;color: #fff;font-size: 30px;" align="center">
        继续观看
    </div>
    <div style="position: absolute;top:328px;left: 561px;width: 151px;height: 64px;line-height: 64px;color: #fff;font-size: 30px;" align="center">
        退出
    </div>
    <div style="position: absolute;top:328px;left: 730px;width: 151px;height: 64px;line-height: 64px;color: #fff;font-size: 30px;" id="isfav" align="center">

    </div>
</div>
<script language="javascript">
    var index=0;
    function addfav(){
        var subjectId="<%=subjectId%>"
        if(subjectId=="xxx"){
            subjectId="";
        }
        var url = "action/add_channel_favorite.jsp?SubjectID=<%=subjectId%>&ContentID=<%=ContentID%>&FavoriteTitle=&time="+new Date();
        new net.ContentLoader(url, function() {
//            var addFavResult = eval("(" + this.req.responseText + ")");
//           var result = addFavResult.returnCode;
//            if(result==0){
//
//            }
        });
    }
    <%--function queryfav(){--%>
        <%--var url = "action/get_all_channel_favorite.jsp?time="+new Date();--%>
        <%--new net.ContentLoader(url, function() {--%>
<%--//            var addFavResult = eval("(" + this.req.responseText + ")");--%>
<%--//            alert("=======xx=x=====");--%>
            <%--var data = eval("(" + this.req.responseText + ")");--%>
            <%--var channelData = data.channels;--%>
<%--//            alert("========channelData========="+channelData.length);--%>
            <%--if(channelData.length>0){--%>
                <%--for(var i=0;i<channelData.length;i++){--%>
                    <%--if("<%=ContentID%>"==channelData[i].channelcode){--%>
                        <%--document.getElementById("isfav").innerHTML="移出收藏";--%>
                        <%--break;--%>
                    <%--} else{--%>
                        <%--document.getElementById("isfav").innerHTML="加入收藏";--%>
                    <%--}--%>
                <%--}--%>
            <%--} else{--%>
                <%--document.getElementById("isfav").innerHTML="加入收藏";--%>
            <%--}--%>

        <%--});--%>
    <%--}--%>
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
    function dook(){
//        document.location="back.jsp";
        if(index==0){
            pageBack();
        }else if(index==1){
			top.doStop();
			//top.doStopVideo();
			//top.pageResume();
			//setTimeout(function(){
				top.currState = 0;
            	document.location="back.jsp";
			//},3000);
        }else{
            addfav();
            setTimeout(function(){
                top.jsHideOSD();
            },800);

        }
    }
    function doLeft(){

        if(index>0){
            document.getElementById("focusimg"+index).src="images/channel/14.png";
            index--;
            document.getElementById("focusimg"+index).src="images/channel/15.png";
        }

    }
    function doRight(){

        if(index<2){
            document.getElementById("focusimg"+index).src="images/channel/14.png";
            index++;
            document.getElementById("focusimg"+index).src="images/channel/15.png";
        }

    }
    function doMenu(){
        top.mainWin.document.location = "portal.jsp";
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
//    queryfav();
    var isfav="<%=isfav%>";
    if(isfav=="true"){
        document.getElementById("isfav").innerHTML="移出收藏";
    }  else{
        document.getElementById("isfav").innerHTML="加入收藏";
    }
    window.focus();
</script>
</body>
<%@include file="inc/lastfocus.jsp" %>
</html>
