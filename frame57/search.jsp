<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@ page import="com.zte.iptv.epg.util.*" %>
<%@ page import="java.util.*" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ include file="inc/scrollString.jsp" %>
<epg:PageController name="search.jsp"/>
<%
    String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
    HashMap param = PortalUtils.getParams(path, "UTF-8");
    String columncode = String.valueOf(param.get("column01"));
//    columncode="06";
    String lastfocus = String.valueOf(request.getParameter("lastfocus"));
    //System.out.println("6407000229:lastfocus:"+lastfocus);
    if (lastfocus.equals("null") || lastfocus.equals("")) {
        lastfocus = "leftKey-0-1";
    }
    String[] lastList=lastfocus.split("-");
%>
<html>
<head>
    <title>搜索列表</title>
    <meta name="page-view-size" content="1280*720"/>
    <meta http-equiv="content-Type" content="text/html; charset=utf-8">
    <style>
    	*{padding:0;margin:0;border:0;}
        body {
            font-size: 24px;
            color: #FFFFFF;
            width: 1280px;
            height: 720px;
        }

        div {
            -webkit-transition-duration: 200ms;
        }

        .keyNum {
            position: absolute;
            width: 60px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            color: #999999;
            font-size: 28px;
        }

        .keyEn {
            position: absolute;
            width: 60px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            color: #CCCCCC;
            font-size: 22px;
        }

        .keyClean {
            position: absolute;
            width: 25px;
            height: 27px;
            left: 19px;
            background: url(images/search/searchClean.png)
        }

        .keyDel {
            position: absolute;
            width: 27px;
            height: 19px;
            left: 16px;
            top: 5px;
            background: url(images/search/searchDel.png)
        }

        .mkey {
            position: absolute;
            width: 30px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            font-size: 30px;
            color: #CCCCCC;
        }

        .rightVod {
            position: absolute;
            width: 141px;
            height: 193px;
            left: 25px;
            top: 10px;
        }

        .rightVod img {
            position: absolute;
            width: 100%;
            height: 100%;
            left: 0px;
            top: 0px;
        }

        .rightVod div {
            position: absolute;
            width: 130px;
            height: 30px;
            line-height: 30px;
            left: 5px;
            top: 200px;
            text-align: center;
            font-size: 20px;
            /*overflow: hidden;*/
            /*white-space: nowrap;*/
            /*text-overflow: ellipsis;*/
        }

        .keyFocus0 {
            position: absolute;
            width: 142px;
            height: 142px;
            background: url(images/search/keyFocus0.png) no-repeat;
            left: 17px;
            top: 159px;
            visibility: visible;
        }

        .keyFocus1 {
            position: absolute;
            width: 142px;
            height: 142px;
            background: url(images/search/keyFocus0.png) no-repeat;
            left: 117px;
            top: 159px;
            visibility: visible;
        }

        .keyFocus2 {
            position: absolute;
            width: 142px;
            height: 142px;
            background: url(images/search/keyFocus0.png) no-repeat;
            left: 217px;
            top: 159px;
            visibility: visible;
        }

        .keyFocus3 {
            position: absolute;
            width: 142px;
            height: 142px;
            background: url(images/search/keyFocus0.png) no-repeat;
            left: 17px;
            top: 259px;
            visibility: visible;
        }

        .keyFocus4 {
            position: absolute;
            width: 142px;
            height: 142px;
            background: url(images/search/keyFocus0.png) no-repeat;
            left: 117px;
            top: 259px;
            visibility: visible;
        }

        .keyFocus5 {
            position: absolute;
            width: 142px;
            height: 142px;
            background: url(images/search/keyFocus0.png) no-repeat;
            left: 217px;
            top: 259px;
            visibility: visible;
        }

        .keyFocus6 {
            position: absolute;
            width: 142px;
            height: 142px;
            background: url(images/search/keyFocus0.png) no-repeat;
            left: 17px;
            top: 349px;
            visibility: visible;
        }

        .keyFocus7 {
            position: absolute;
            width: 142px;
            height: 142px;
            background: url(images/search/keyFocus0.png) no-repeat;
            left: 117px;
            top: 349px;
            visibility: visible;
        }

        .keyFocus8 {
            position: absolute;
            width: 142px;
            height: 142px;
            background: url(images/search/keyFocus0.png) no-repeat;
            left: 217px;
            top: 349px;
            visibility: visible;
        }

        .keyFocus9 {
            position: absolute;
            width: 112px;
            height: 106px;
            background: url(images/search/keyFocus1.png) no-repeat;
            left: 33px;
            top: 470px;
            visibility: visible;
        }

        .keyFocus10 {
            position: absolute;
            width: 142px;
            height: 142px;
            background: url(images/search/keyFocus0.png) no-repeat;
            left: 117px;
            top: 449px;
            visibility: visible;
        }

        .keyFocus11 {
            position: absolute;
            width: 112px;
            height: 106px;
            background: url(images/search/keyFocus1.png) no-repeat;
            left: 232px;
            top: 470px;
            visibility: visible;
        }

        .keyMinFocus0 {
            position: absolute;
            width: 53px;
            height: 53px;
            background: url(images/search/keyFocusM0.png) no-repeat;
            left: 46px;
            top: 46px;
        }
.keyMinFocus1{position:absolute; width:63px; height:111px; background:url(images/search/kefFocus0.png) no-repeat; left: -4px; top: 17px; }
.keyMinFocus2{position:absolute; width:111px; height:63px; background:url(images/search/kefFocus1.png) no-repeat; left: 16px; top: -3px; }
.keyMinFocus3{position:absolute; width:63px; height:111px; background:url(images/search/kefFocus2.png) no-repeat; left: 82px; top: 16px; }
.keyMinFocus4{position:absolute; width:111px; height:63px; background:url(images/search/kefFocus3.png) no-repeat; left: 16px; top: 84px; }

        .tj0NameDiv {
            position: absolute;
            width: 400px;
            height: 40px;
            line-height: 40px;
            z-index: 1;
            color: #999999;
        }

        .tj0Focus0 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 384px;
            top: 167px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus1 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 384px;
            top: 232px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus2 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 384px;
            top: 297px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus3 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 384px;
            top: 362px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus4 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 384px;
            top: 427px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus5 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 384px;
            top: 492px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus6 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 384px;
            top: 557px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus7 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 808px;
            top: 167px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus8 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 808px;
            top: 232px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus9 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 808px;
            top: 297px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus10 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 808px;
            top: 362px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus11 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 808px;
            top: 427px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus12 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 808px;
            top: 492px;
            visibility: visible;
            z-index: 2;
        }

        .tj0Focus13 {
            position: absolute;
            width: 417px;
            height: 47px;
            background: url(images/search/tj0Focus.png) no-repeat;
            left: 808px;
            top: 557px;
            visibility: visible;
            z-index: 2;
        }

        .searchFocus0 {
            position: absolute;
            width: 161px;
            height: 216px;
            background: url(images/search/searchVodFocus.png) no-repeat;
            left: 383px;
            top: 136px;
            visibility: visible;
            z-index: 1;
        }

        .searchFocus1 {
            position: absolute;
            width: 161px;
            height: 216px;
            background: url(images/search/searchVodFocus.png) no-repeat;
            left: 549px;
            top: 136px;
            visibility: visible;
            z-index: 1;
        }

        .searchFocus2 {
            position: absolute;
            width: 161px;
            height: 216px;
            background: url(images/search/searchVodFocus.png) no-repeat;
            left: 715px;
            top: 136px;
            visibility: visible;
            z-index: 1;
        }

        .searchFocus3 {
            position: absolute;
            width: 161px;
            height: 216px;
            background: url(images/search/searchVodFocus.png) no-repeat;
            left: 881px;
            top: 136px;
            visibility: visible;
            z-index: 1;
        }

        .searchFocus4 {
            position: absolute;
            width: 161px;
            height: 216px;
            background: url(images/search/searchVodFocus.png) no-repeat;
            left: 1047px;
            top: 136px;
            visibility: visible;
            z-index: 1;
        }

        .searchFocus5 {
            position: absolute;
            width: 161px;
            height: 216px;
            background: url(images/search/searchVodFocus.png) no-repeat;
            left: 383px;
            top: 386px;
            visibility: visible;
            z-index: 1;
        }

        .searchFocus6 {
            position: absolute;
            width: 161px;
            height: 216px;
            background: url(images/search/searchVodFocus.png) no-repeat;
            left: 549px;
            top: 386px;
            visibility: visible;
            z-index: 1;
        }

        .searchFocus7 {
            position: absolute;
            width: 161px;
            height: 216px;
            background: url(images/search/searchVodFocus.png) no-repeat;
            left: 715px;
            top: 386px;
            visibility: visible;
            z-index: 1;
        }

        .searchFocus8 {
            position: absolute;
            width: 161px;
            height: 216px;
            background: url(images/search/searchVodFocus.png) no-repeat;
            left: 881px;
            top: 386px;
            visibility: visible;
            z-index: 1;
        }

        .searchFocus9 {
            position: absolute;
            width: 161px;
            height: 216px;
            background: url(images/search/searchVodFocus.png) no-repeat;
            left: 1047px;
            top: 386px;
            visibility: visible;
            z-index: 1;
        }

        .searchBtnFocus {
            position: absolute;
            width: 90px;
            height: 85px;
            background: url(images/search/searchFocus.png) no-repeat;
            left: 277px;
            top: 66px;
            visibility: visible;
        }

        .font_ellipsis {
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
		.vod_scrollbar{
            position: absolute;
            left:1218px;
            top:150px;
            width: 6px;
            height: 500px;
            /*background-color: #2E1E1A;*/
            background: url(images/vod/scrollBarBg.png) repeat-y;
            /*y轴最大265px*/
            /*background-position: 0px 265px;*/
        }
        .scrollbar{
            position: absolute;
            left: 0px;
            width: 6px;
			top:0px;
            /*background-color: #3D344D;*/
            /*background: url(images/vod/scrollBarFocus.png) repeat-y;*/
        }
    </style>
</head>
<body onUnload="exitPage()" bgcolor="transparent" onLoad="getSearchDate();">
<!-- 解决MR820适配问题  modify by cny 2017/8/14 -->
<!-- 背景 -->
<div style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px;">
    <img src="images/bg.png">
</div>
<div style="position:absolute; top: 29px; left: 54px; width:143px; height:28px;">搜索</div>
<div style="position:absolute; left: 50px; top: 74px; width: 322px; height: 70px; font-size:36px; font-weight:bold; color:#000000;">
    <div id="searchKey"
         style="position:absolute;width:222px; height:47px; line-height:47px; left:10px; top:9px; background:url(images/search/searchIptBg.png) no-repeat;"></div>
    <!-- 搜索按钮 -->
    <div id="searchBtn"
         style="position:absolute;width:64px; height:60px; left:242px; top:3px; background:url(images/search/searchBtn.png) no-repeat;"></div>
</div>
<!-- 主数据区域提示信息 -->
<div id="searchTitle"
     style="position:absolute;width:600px; height:30px; line-height:30px; left:389px; top:73px; font-size:26px;">别人正在搜:
</div>
<div id="searchLine"
     style="position:absolute;width:845px; height:2px; left:389px; top:112px; background:url(images/search/searchLine.png) no-repeat;"></div>

<div style="position:absolute;width:4px; height:622px; left:367px; top:97px; background:url(images/search/searchHLine.png) no-repeat;"></div>

<!-- 键盘焦点 -->
<div id="focus" class="">
    <div id="mFocus"></div>
    <div id="mKey0" style="left:56px; top:56px;" class="mkey"></div>
    <div id="mKey1" style="left:11px; top:56px;" class="mkey"></div>
    <div id="mKey2" style="left:56px; top:11px;" class="mkey"></div>
    <div id="mKey3" style="left:101px; top:56px;" class="mkey"></div>
    <div id="mKey4" style="left:56px; top:101px;" class="mkey"></div>
</div>
<!-- 键盘 -->
<div id="keyPanel" style="position:absolute; width:310px; height:485px; left:48px; top:163px;">
    <div id="key1" class="keyNum" style="left:10px; top:35px;"></div>
    <div id="key2" class="keyNum" style="left:110px; top:35px;"></div>
    <div id="key3" class="keyNum" style="left:210px; top:35px;"></div>
    <div id="key4" class="keyNum" style="left:10px; top:135px;"></div>
    <div id="key5" class="keyNum" style="left:110px; top:135px;"></div>
    <div id="key6" class="keyNum" style="left:210px; top:135px;"></div>
    <div id="key7" class="keyNum" style="left:10px; top:235px;"></div>
    <div id="key8" class="keyNum" style="left:110px; top:235px;"></div>
    <div id="key9" class="keyNum" style="left:210px; top:235px;"></div>
    <div id="key10" class="keyNum" style="left:10px; top:330px;"></div>
    <div id="key11" class="keyNum" style="left:110px; top:330px;"></div>
    <div id="key12" class="keyNum" style="left:210px; top:330px;"></div>
    <div id="keyen1" class="keyEn" style="left:10px; top:60px;"></div>
    <div id="keyen2" class="keyEn" style="left:110px; top:60px;"></div>
    <div id="keyen3" class="keyEn" style="left:210px; top:60px;"></div>
    <div id="keyen4" class="keyEn" style="left:10px; top:160px;"></div>
    <div id="keyen5" class="keyEn" style="left:110px; top:160px;"></div>
    <div id="keyen6" class="keyEn" style="left:210px; top:160px;"></div>
    <div id="keyen7" class="keyEn" style="left:10px; top:260px;"></div>
    <div id="keyen8" class="keyEn" style="left:110px; top:260px;"></div>
    <div id="keyen9" class="keyEn" style="left:210px; top:260px;"></div>
    <div id="keyen10" class="keyEn" style="left:10px; top:358px;"></div>
    <div id="keyen11" class="keyEn" style="left:110px; top:388px;"></div>
    <div id="keyen12" class="keyEn" style="left:210px; top:358px;"></div>
    <div style="position:absolute; width:323px; height:60px; line-height:30px; left:0px; top:430px; font-size:18px;">
        支持电影、节目、首字母搜索<br/>
        例如：搜索“星光大道” 输入“XGDD”
    </div>
</div>
<!-- 首次进入推荐影片列表 -->
<div id="rightTj0Panel"
     style="position:absolute; width:867px; height:485px; left:369px; top:140px; display:none; z-index:99;">
    <div id="tj0Name0" class="tj0NameDiv" style="left:32px; top:30px;"></div>
    <div id="tj0Name1" class="tj0NameDiv" style="left:32px; top:95px;"></div>
    <div id="tj0Name2" class="tj0NameDiv" style="left:32px; top:160px;"></div>
    <div id="tj0Name3" class="tj0NameDiv" style="left:32px; top:225px;"></div>
    <div id="tj0Name4" class="tj0NameDiv" style="left:32px; top:290px;"></div>
    <div id="tj0Name5" class="tj0NameDiv" style="left:32px; top:355px;"></div>
    <div id="tj0Name6" class="tj0NameDiv" style="left:32px; top:420px;"></div>
    <div id="tj0Name7" class="tj0NameDiv" style="left:456px; top:30px;"></div>
    <div id="tj0Name8" class="tj0NameDiv" style="left:456px; top:95px;"></div>
    <div id="tj0Name9" class="tj0NameDiv" style="left:456px; top:160px;"></div>
    <div id="tj0Name10" class="tj0NameDiv" style="left:456px; top:225px;"></div>
    <div id="tj0Name11" class="tj0NameDiv" style="left:456px; top:290px;"></div>
    <div id="tj0Name12" class="tj0NameDiv" style="left:456px; top:355px;"></div>
    <div id="tj0Name13" class="tj0NameDiv" style="left:456px; top:420px;"></div>
</div>
<!-- 搜索不到影片 -->
<div id="rightTj1Panel" style="position:absolute; width:854px; height:485px; left:369px; top:140px; display:none;">
    <div style="position:absolute; width:61px; height:62px; left: 174px; top: 66px; background:url(images/search/tips.png) no-repeat;"></div>
    <div style="position:absolute; width:502px; height:40px; line-height:40px; left: 257px; top: 78px;">
        对不起，没有与搜索项符合的结果！
    </div>
    <div style="position:absolute; width:200px; height:40px; line-height:40px; color:#FF9900; left: 26px; top: 195px;">
        您可能要找：
    </div>
    <div id="rightTj1Vod0" style="top:260px;" class="rightVod">
        <img id="rightTj1Vod0Img"/>

        <div id="rightTj1Vod0Name"></div>
    </div>
    <div id="rightTj1Vod1" style="left:191px; top:260px;" class="rightVod">
        <img id="rightTj1Vod1Img"/>

        <div id="rightTj1Vod1Name"></div>
    </div>
    <div id="rightTj1Vod2" style="left:357px; top:260px;" class="rightVod">
        <img id="rightTj1Vod2Img"/>

        <div id="rightTj1Vod2Name"></div>
    </div>
    <div id="rightTj1Vod3" style="left:523px; top:260px;" class="rightVod">
        <img id="rightTj1Vod3Img"/>

        <div id="rightTj1Vod3Name"></div>
    </div>
    <div id="rightTj1Vod4" style="left:689px; top:260px;" class="rightVod">
        <img id="rightTj1Vod4Img"/>

        <div id="rightTj1Vod4Name"></div>
    </div>
</div>
<!-- 搜索影片列表 -->
<div id="rightPanel" style="position:absolute; width:854px; height:485px; left:369px; top:140px;">
    <div id="rightVod0" style="left:25px;" class="rightVod">
        <img id="rightVod0Img"/>

        <div id="rightVod0Name" style="width:141px; "></div>
    </div>
    <div id="rightVod1" style="left:191px;" class="rightVod">
        <img id="rightVod1Img"/>

        <div id="rightVod1Name" style="width:141px; "></div>
    </div>
    <div id="rightVod2" style="left:357px;" class="rightVod">
        <img id="rightVod2Img"/>

        <div id="rightVod2Name" style="width:141px; "></div>
    </div>
    <div id="rightVod3" style="left:523px;" class="rightVod">
        <img id="rightVod3Img"/>

        <div id="rightVod3Name" style="width:141px; "></div>
    </div>
    <div id="rightVod4" style="left:689px;" class="rightVod">
        <img id="rightVod4Img"/>

        <div id="rightVod4Name" style="width:141px; "></div>
    </div>
    <div id="rightVod5" style="top:260px;" class="rightVod">
        <img id="rightVod5Img"/>

        <div id="rightVod5Name" style="width:141px; "></div>
    </div>
    <div id="rightVod6" style="left:191px; top:260px;" class="rightVod">
        <img id="rightVod6Img"/>

        <div id="rightVod6Name" style="width:141px; "></div>
    </div>
    <div id="rightVod7" style="left:357px; top:260px;" class="rightVod">
        <img id="rightVod7Img"/>

        <div id="rightVod7Name"  style="width:141px; "></div>
    </div>
    <div id="rightVod8" style="left:523px; top:260px;" class="rightVod">
        <img id="rightVod8Img"/>

        <div id="rightVod8Name" style="width:141px; "></div>
    </div>
    <div id="rightVod9" style="left:689px; top:260px;" class="rightVod">
        <img id="rightVod9Img"/>

        <div id="rightVod9Name" style="width:141px; "></div>
    </div>
</div>
<!-- 滚动条 -->
<div class="vod_scrollbar" id="vod_scrollbar1" style="visibility:hidden;">
  <div id="vodScrollBar" class="scrollbar">
      <img src="images/vod/scrollBarFocus.png" style="width: 6px;height: 1px;" id="vodScrollBar1">
  </div>
</div>

</body>
<%--<script src="js/keyPress.js" language="javascript"></script>--%>
<%--<script src="data/search.js" language="javascript"></script>--%>
<script src="js/dom.js" language="javascript"></script>
<script src="js/contentloader.js" language="javascript"></script>
<script>
//var url = window.location.href;
var isNeedAddUrl = 1;
var url = window.location.href;
var destpage = parseInt("<%=lastList[2]%>",10);
var pagecount = 0;
var programLeng = 0;
var programData = new Array();
//leftSearch搜索按钮区域 leftKey左侧键盘区域 rightTj0首次进入推荐列表区域 rightTj1搜索不到结果地步推荐海报区域 right搜索结果列表区域
var area = "<%=lastList[0]%>";//parent.Util.getURLParameter("area",url)==""?"leftSearch":parent.Util.getURLParameter("area",url);
var keyIndex = 0;//parent.Util.getURLParameter("keyIndex",url)==""?"0":parent.Util.getURLParameter("keyIndex",url);
var keyMIndex = 0;//parent.Util.getURLParameter("keyMIndex",url)==""?"0":parent.Util.getURLParameter("keyMIndex",url);
var tj0Index = 0;//parent.Util.getURLParameter("tj0Index",url)==""?"0":parent.Util.getURLParameter("tj0Index",url);
var tj1Index = 0;//parent.Util.getURLParameter("tj1Index",url)==""?"0":parent.Util.getURLParameter("tj1Index",url);
var rightIndex = parseInt("<%=lastList[1]%>",10) ;//parent.Util.getURLParameter("rightIndex",url)==""?"0":parent.Util.getURLParameter("rightIndex",url);
//键盘数据
var keyDatas = [
    {'mkey':'1', 'fkey':[]},
    {'mkey':'2', 'fkey':['A', 'B', 'C']},
    {'mkey':'3', 'fkey':['D', 'E', 'F']},
    {'mkey':'4', 'fkey':['G', 'H', 'I']},
    {'mkey':'5', 'fkey':['J', 'K', 'L']},
    {'mkey':'6', 'fkey':['M', 'N', 'O']},
    {'mkey':'7', 'fkey':['P', 'Q', 'R', 'S']},
    {'mkey':'8', 'fkey':['T', 'U', 'V']},
    {'mkey':'9', 'fkey':['W', 'X', 'Y', 'Z']},
    {'mkey':'<div class="keyClean"></div>', 'fkey':['清空']},
    {'mkey':'0', 'fkey':[]},
    {'mkey':'<div class="keyDel"></div>', 'fkey':['退格']}
];
//推荐影片信息

//右侧区域显示类型  first第一次进入改页面 hasNoResult没有搜索到结果 hasResult搜索到结果
var rightShowType = 'first';
//function dom(obj) {
//    return document.getElementById(obj);
//}
function init() {
    initKeyDatas();
    searchListDatas();
    initTjListDatas();
    if(area=="right"){
        dom("searchKey").innerHTML= top.jsGetControl("searchKey");
        searchreq();
    }
    setTimeout(function(){
        starScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname,11);
        setFocus();
    }, 200);
    //初始化展示右侧三种面板
    if (rightShowType == 'first') {
        dom('rightTj0Panel').style.display = 'block';
        dom('rightTj1Panel').style.display = 'none';
        dom('rightPanel').style.display = 'none';
    } else if (rightShowType == 'hasNoResult') {
        dom('rightTj0Panel').style.display = 'none';
        dom('rightTj1Panel').style.display = 'block';
        dom('rightPanel').style.display = 'none';
    } else if (rightShowType == 'hasResult') {
        dom('rightTj0Panel').style.display = 'none';
        dom('rightTj1Panel').style.display = 'none';
        dom('rightPanel').style.display = 'block';
    }
    setFocus();
}
//初始化推荐数据
function initTjListDatas() {
    for (var i = 0; i < tjVodDatas.length; i++) {
        dom('tj0Name' + i).innerHTML = tjVodDatas[i].vodName;
        if (i < 5) {
            dom('rightTj1Vod' + i + 'Img').src = tjVodDatas[i].vodImgUrl;
            dom('rightTj1Vod' + i + 'Name').innerHTML = tjVodDatas[i].vodName;
        }
    }
}
//初始化键盘数据
function initKeyDatas() {
    for (var i = 0; i < keyDatas.length; i++) {
        dom('key' + (i + 1)).innerHTML = keyDatas[i].mkey;
        dom('keyen' + (i + 1)).innerHTML = keyDatas[i].fkey.join('');
    }
}
//初始化列表数据
function searchListDatas() {
    for (var i = 0; i < tjVodDatas.length && i < 10; i++) {
        dom('rightVod' + i + 'Img').src = tjVodDatas[i].vodImgUrl;
        dom('rightVod' + i + 'Name').innerHTML = tjVodDatas[i].vodName;
    }
}

function searchreq(){
    var searhText = dom("searchKey").innerHTML;
	if(searhText == '') return false;
    searhText=encodeURIComponent(searhText);
    var requestUrl = "action/get_searchData.jsp?columnid=<%=columncode%>&searchTitle=" + searhText + "&destpage=" + destpage + "&numperpage=10";
    new net.ContentLoader(requestUrl, function () {
        var data = eval("(" + this.req.responseText + ")");
        programData = new Array();
        pagecount = data.pageCount;
        programData = data.vodData;
        programLeng = programData.length;
//        alert("===========programLeng============"+programLeng);
//        alert("===========programLeng============"+(programLeng==0));
        dom("searchTitle").innerHTML= "搜索结果|共"+"<font color='#cc7d1d'>"+data.totalCount+"</font>"+"部影片";
		dom("vodScrollBar").style.visibility="hidden";
        dom("vod_scrollbar1").style.visibility="hidden";
		//dom("test").innerHTML= area+'------'+rightIndex+'----'+keyIndex;
        if (programLeng == 0) {
            rightShowType = 'hasNoResult';
            dom('rightTj0Panel').style.display = 'none';
            dom('rightTj1Panel').style.display = 'block';
            dom('rightPanel').style.display = 'none';
        } else {
            rightShowType = 'hasResult';
            dom('rightTj0Panel').style.display = 'none';
            dom('rightTj1Panel').style.display = 'none';
            dom('rightPanel').style.display = 'block';
            for(var i=0;i<10;i++){
                if(i<programLeng){
                    dom('rightVod' + i + 'Img').src = programData[i].normalposter;
//                    dom('rightVod' + i + 'Name').innerHTML = programData[i].programname;
                    stopScroll('rightVod' + i + 'Name',programData[i].programname);
                } else{
                    dom('rightVod' + i + 'Img').src = "images/btn_trans.gif";
                    dom('rightVod' + i + 'Name').innerHTML = "";
                }
            }
			/* 设置滚动条滚动 */
            if(pagecount>1){
				showScrollBar();
            } else{
                dom("vodScrollBar").style.visibility="hidden";
                dom("vod_scrollbar1").style.visibility="hidden";
            }
			
        }
		
		//lh
		var currProgram = (destpage-1)*10+rightIndex+1;
		if(currProgram > data.totalCount){
			area = 'leftSearch';
			rightIndex = 0;
		}
		
		
    });
}
//设置滚动条滚动
function showScrollBar(){
    dom("vodScrollBar").style.visibility="visible";
    dom("vod_scrollbar1").style.visibility="visible";
    // 设置滚动条的大小
    var scrollBarSize=Math.ceil(500/pagecount);
    var scrollBarHeight=scrollBarSize>500?500:scrollBarSize;
    dom("vodScrollBar1").style.height=scrollBarHeight;
    // 设置滚动条滚动的位置
    // 设置滚动条能够滚动的区域大小
    var scrollBottomSize=500-scrollBarHeight;
    var scrollY=Math.ceil((destpage/pagecount)*scrollBottomSize);
    var y=scrollY>scrollBottomSize?scrollBottomSize:scrollY;
    if(pagecount===1||destpage===1){
        y=0;
    }
    dom("vodScrollBar").style.top=y+"px";
}
	
function keyEnter() {
//    alert(area+"============================");
    if (area == 'leftSearch') {
        //测试数据，按OK键可切换三种不同的数据展示

//        if(rightShowType == 'first') {
//            rightShowType = 'hasNoResult';
//            dom('rightTj0Panel').style.display = 'none';
//            dom('rightTj1Panel').style.display = 'block';
//            dom('rightPanel').style.display = 'none';
//        }else if(rightShowType == 'hasNoResult') {
//            rightShowType = 'hasResult';
//            dom('rightTj0Panel').style.display = 'none';
//            dom('rightTj1Panel').style.display = 'none';
//            dom('rightPanel').style.display = 'block';
//        }else if(rightShowType == 'hasResult') {
//            rightShowType = 'first';
//            dom('rightTj0Panel').style.display = 'block';
//            dom('rightTj1Panel').style.display = 'none';
//            dom('rightPanel').style.display = 'none';
//        }
         destpage=1;
         searchreq();
    } else if (area == 'leftKey') {
        if (keyIndex == 9) {
            dom('searchKey').innerHTML = '';
        } else if (keyIndex == 11) {
            if (dom('searchKey').innerText.length > 0) {
                dom('searchKey').innerHTML = dom('searchKey').innerText.substr(0, dom('searchKey').innerText.length - 1);
            }
        } else {
            dom('searchKey').innerHTML = dom('searchKey').innerText + ((keyMIndex == 0) ? keyDatas[keyIndex].mkey : keyDatas[keyIndex].fkey[keyMIndex - 1]);
        }
    } else if(area =="right"){
//        alert("========111======");
         var title=dom('searchKey').innerHTML;
        top.jsSetControl("searchKey", title);
        var url="";
        var leefocus=area+"-"+rightIndex+"-"+destpage;
        if(programData[rightIndex].programtype==1){
            url="vod_detail.jsp?columncode=" + programData[rightIndex].columnid +
                    "&programid=" + programData[rightIndex].programid +
                            "&mediaservices=" + programData[rightIndex].mediaservices +
                            "&leefocus=" + leefocus;
        } else{
          url="vod_series_head.jsp?columncode=" + programData[rightIndex].columnid +
                  "&programid=" + programData[rightIndex].programid +
                  "&mediaservices=" + programData[rightIndex].mediaservices +
                  "&leefocus=" + leefocus;
        }
        document.location=url;
    }else if(area =="rightTj0"){
//        var leefocus=area+"-"+tj0Index;
//        var url=tjVodDatas[tj0Index].vodUrl;
//        if()
        document.location=tjVodDatas[tj0Index].vodUrl;
    }else if(area =="rightTj1"){
        document.location=tjVodDatas[tj1Index].vodUrl;
    }
}
function keyDown() {
    freeFocus();
    if (area == 'leftSearch') {
        area = 'leftKey';
        keyMIndex = 0;
    } else if (area == 'leftKey') {
        if (keyIndex == 0) {
            keyIndex += 3;
        } else if (keyIndex > 0 && keyIndex < 9) {
            if (keyIndex == 6 || keyIndex == 8) {
                if (keyMIndex == 0 || keyMIndex == 1 || keyMIndex == 3) {
                    keyMIndex = 4;
                } else if (keyMIndex == 2) {
                    keyMIndex = 0;
                } else {
                    keyIndex += 3;
                    keyMIndex = 0;
                }
            } else {
                if (keyMIndex == 0 || keyMIndex == 1 || keyMIndex == 3) {
                    keyIndex += 3;
                    keyMIndex = 0;
                } else {
                    keyMIndex = 0;
                }
            }
        }
    } else if (area == 'rightTj0') {
        if (tj0Index < (tjVodDatas.length - 1)) {
            tj0Index++;
        }
    } else if (area == 'rightTj1') {

    } else {
        if (rightIndex +5< programLeng){
            stopScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname);
            rightIndex += 5;
            starScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname,11);
        } else{
            if(destpage<pagecount){
                stopScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname);
               destpage++;
			   rightFlip(destpage);
			    rightIndex=0;
                searchreq();
				setTimeout(function(){
					 starScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname,11);
				}, 200);
            }else{
                if(rightIndex>4) return;
                stopScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname);
                rightIndex=programLeng-1;
                starScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname,11);
            }
        }
    }
    setFocus();
}
function keyLeft() {
    freeFocus();
    if (area == 'leftSearch') {

    } else if (area == 'leftKey') {
        if (keyIndex == 0 || keyIndex == 9) {

        } else if (keyIndex == 10 || keyIndex == 11) {
            keyIndex--;
        } else if (keyIndex == 4 || keyIndex == 7) {
            if (keyMIndex == 0 || keyMIndex == 2 || keyMIndex == 4) {
                keyMIndex = 1;
            } else if (keyMIndex == 3) {
                keyMIndex = 0;
            } else {
                keyIndex--;
                keyMIndex = 0;
            }
        } else {
            if (keyMIndex == 0 || keyMIndex == 2 || keyMIndex == 4) {
                keyMIndex = 1;
            } else if (keyMIndex == 3) {
                keyMIndex = 0;
            } else {
                keyIndex--;
                keyMIndex = 0;
            }
        }
    } else if (area == 'rightTj0') {
        if (tj0Index <7) {
            area = 'leftKey';
        } else {
            tj0Index -= 7;
        }
    } else if (area == 'rightTj1') {
        if (tj1Index > 0) {
            tj1Index--;
        } else {
            area = 'leftKey';
        }
    } else {
        if (rightIndex == 0 || rightIndex == 5){
            area = 'leftKey';
            stopScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname);
        } else{
            stopScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname);
            rightIndex--;
            starScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname,11);
        }
    }
    setFocus();
}
function keyRight() {
    freeFocus();
    //alert(keyIndex+"========area========="+area);
    if (area == 'leftSearch') {
        if (rightShowType == 'first'){area = 'rightTj0';}
        else if (rightShowType == 'hasNoResult'){area = 'rightTj1';}
        else{
            area = 'right';
            starScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname,11);
        }
        keyMIndex = 0;
    } else if (area == 'leftKey') {
        if (keyIndex == 2 || keyIndex == 5 || keyIndex == 8) {
            if (keyMIndex == 0 || keyMIndex == 2 || keyMIndex == 4) {
                keyMIndex = 3;
            } else if (keyMIndex == 1) {
                keyMIndex = 0;
            } else {
                if (rightShowType == 'first'){
                    area = 'rightTj0';
                } else if (rightShowType == 'hasNoResult'){
                    area = 'rightTj1';
                } else{
                    area = 'right';
                    starScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname,11);
                }
                keyMIndex = 0;
            }
        } else if (keyIndex == 11) {
            if (rightShowType == 'first'){
                area = 'rightTj0';
            }else if (rightShowType == 'hasNoResult'){
                area = 'rightTj1';
            } else{
                area = 'right';
                starScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname,11);
            }
            keyMIndex = 0;
        } else if (keyIndex == 0 || keyIndex == 9 || keyIndex == 10) {
            keyIndex++;
            keyMIndex = 0;
        } else {
            if (keyMIndex == 0 || keyMIndex == 2 || keyMIndex == 4) keyMIndex = 3;
            else if (keyMIndex == 1) keyMIndex = 0;
            else {
                keyIndex++;
                keyMIndex = 0;
            }
        }
    } else if (area == 'rightTj0') {
        if (tj0Index + 7 <= (tjVodDatas.length - 1)) {
            tj0Index += 7;
        }
    } else if (area == 'rightTj1') {
        if (tj1Index < 4) {
            tj1Index++;
        }
    } else {
        if (rightIndex < programLeng-1){
            stopScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname);
            rightIndex++;
            starScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname,11);
        }
    }
    setFocus();
}
function keyUp() {
    freeFocus();
    if (area == 'leftSearch') {
    } else if (area == 'leftKey') {
        if (keyIndex == 0) {
            area = 'leftSearch';
        } else if (keyIndex == 1 || keyIndex == 2) {
            if (keyMIndex == 0 || keyMIndex == 1 || keyMIndex == 3) {
                keyMIndex = 2;
            } else if (keyMIndex == 2) {
                area = 'leftSearch';
            }
        } else if (keyIndex > 2 && keyIndex < 9) {
            if (keyMIndex == 0 || keyMIndex == 1 || keyMIndex == 3) {
                keyMIndex = 2;
            } else if (keyMIndex == 2) {
                keyMIndex = 0;
                keyIndex -= 3;
            } else if (keyMIndex == 4) {
                keyMIndex = 0;
            }
        } else {
            area = 'leftKey';
            keyMIndex = 0;
            keyIndex -= 3;
        }
    } else if (area == 'rightTj0') {
        if (tj0Index > 0) {
            tj0Index--;
        }
    } else if (area == 'rightTj1') {
    } else {
        if (rightIndex > 4){
            stopScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname);
            rightIndex -= 5;
            starScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname,11);
        }else{
            if(destpage>1){
                stopScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname);
                destpage--;
			   rightFlip(destpage);
			   rightIndex=0;
                searchreq();
				setTimeout(function(){
					starScroll('rightVod' + rightIndex+ 'Name',programData[rightIndex].programname,11);
				}, 200);
            }
        }
    }
    setFocus();
}
function setFocus() {
    if (area == 'leftSearch') {
        dom('focus').className = 'searchBtnFocus';
    } else if (area == 'leftKey') {
        dom('focus').className = 'keyFocus' + keyIndex;
        if (keyIndex != 9 && keyIndex != 11) {
            for (var i = 0; i < 5; i++) {
                dom('mKey' + i).style.visibility = 'visible';
            }
            dom('mFocus').style.display = 'block';
            dom('key' + (keyIndex + 1)).innerHTML = '';
            dom('keyen' + (keyIndex + 1)).innerHTML = '';
            dom('mKey0').innerHTML = keyDatas[keyIndex].mkey;
            var fkeyArr = keyDatas[keyIndex].fkey;
            for (var i = 0; i < fkeyArr.length; i++) {
                dom('mKey' + (i + 1)).innerHTML = fkeyArr[i];
            }
            dom('mFocus').className = 'keyMinFocus' + keyMIndex;
        }
    } else if (area == 'rightTj0') {
        for (var i = 0; i < 5; i++) {
            dom('mKey' + i).style.visibility = 'hidden';
        }
        dom('mFocus').style.display = 'none';
        dom('focus').className = 'tj0Focus' + tj0Index;
    } else if (area == 'rightTj1') {
        for (var i = 0; i < 5; i++) {
            dom('mKey' + i).style.visibility = 'hidden';
        }
        dom('mFocus').style.display = 'none';
        dom('focus').className = 'searchFocus' + (tj1Index + 5);
    } else if (area == 'right') {
        for (var i = 0; i < 5; i++) {
            dom('mKey' + i).style.visibility = 'hidden';
        }
        dom('mFocus').style.display = 'none';
        dom('focus').className = 'searchFocus' + rightIndex;
    }
}
function freeFocus() {
    if (area == 'leftSearch') {
    } else if (area == 'leftKey') {
        if (keyIndex != 9 || keyIndex != 11) {
            dom('key' + (keyIndex + 1)).innerHTML = keyDatas[keyIndex].mkey;
            dom('keyen' + (keyIndex + 1)).innerHTML = keyDatas[keyIndex].fkey.join('');
            dom('mKey0').innerHTML = '';
            for (var i = 0; i < 4; i++) {
                dom('mKey' + (i + 1)).innerHTML = '';
            }
            dom('mFocus').style.display = 'none';
        }
    }
}
function keyBack() {
//    isNeedAddUrl = 0;
//    parent.TurnPage.goBack(window);
    document.location = "back.jsp";
}
//function dom(obj) {
//    return document.getElementById(obj);
//}
function exitPage() {
//    mp.stop();
//    parent.TurnPage.addUrl("search.html?area="+area,isNeedAddUrl);
    //	parent.PageManager.destroy("alert");
}
var tjVodDatas=null;
function getSearchDate(){

document.onkeydown = dokeyPress;
    var requestUrl = "action/get_search.jsp";
    new net.ContentLoader(requestUrl, function () {
        var data = eval("(" + this.req.responseText + ")");
        tjVodDatas = data;
//            alert("=====navigationJSON===="+navigationJSON);
        init();
    });
}
function dokeyPress(evt) {
    //alert("---------");
    var keyCode = parseInt(evt.which);
    if (keyCode == 0x0008) {
        keyBack();
    } else if (keyCode == 0x0025) { //onKeyLeft
        keyLeft();
    } else if (keyCode == 0x0027) { //onKeyRight
        keyRight();

    } else if (keyCode == 0x0026) {//onKeyUp
        keyUp();
    } else if (keyCode == 0x0028) { //onKeyDown
        keyDown();
    } else if (keyCode == 0x000D) {  //OK
        keyEnter();
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
</script>
</html>