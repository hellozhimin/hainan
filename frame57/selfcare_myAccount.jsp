<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@page isELIgnored="false" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<%@ include file="inc/scrollString.jsp" %>
<epg:PageController name="selfcare_myAccount.jsp"/>
<%
    String lastfocus=request.getParameter("lastfocus");
    String focusType=request.getParameter("focusType");
    if("".equals(lastfocus)||lastfocus==null||"null".equals(lastfocus)){
        // leftFocusIndex- curPage -  vodIndex - curFocus
        if("0".equals(focusType)){
            lastfocus="0-1-0-0";
        }else if("1".equals(focusType)){
            lastfocus="1-1-0-0";
        }
//        else if("2".equals(focusType)){
//            lastfocus="2-1-0-0";
//        }
    }
    String[] position=lastfocus.split("-");
%>
<html>
<head>
    <title>myAccount</title>
    <meta name="page-view-size" content="1280*720"/>
    <meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="js/dom.js"></script>
    <script type="text/javascript" src="js/contentloader.js"></script>
    <style type="text/css">
        div {
            #border: 1px solid red;
        }

        .page-title {
            position: absolute;
            left: 45px;
            line-height: 40px;
            top: 45px;
            /*font-weight: bold;*/
            font-size: 30px;
            width: 150px;
            height: 40px;
            color: #FFF;
            #border: 1px solid red;
            text-align: center;
        }

        .page-title2-normal {
            position: absolute;
            left: 65px;
            line-height: 25px;
            /*font-weight: bold;*/
            font-size: 24px;
            width: 100px;
            height: 25px;
            color: #BAC6D6;
            #border: 1px solid red;
            text-align: center;
            z-index: 2;
        }

        .page-title2-focus {
            position: absolute;
            left: 55px;
            line-height: 30px;
            /*font-weight: bold;*/
            font-size: 30px;
            width: 120px;
            height: 30px;
            color: #FFF;
            text-align: center;
            z-index: 2;
        }

        .font-ellipsis {
            /*overflow: hidden;*/
            /*white-space: nowrap;*/
            /*text-overflow: ellipsis;*/
        }
    </style>
</head>
<body bgcolor="transparent" onLoad="init()">
<div style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px;">
    <img src="images/portal/my/bg.png"/>
</div>

<!--左边栏-->
<div class="page-title">个人中心</div>
<div style="position:absolute;left:230px;top:95px;width:3px;height:565px;">
    <img src="images/portal/my/my_divider_vertical.png" width="3" height="565" alt=""/></div>
<div id="leftColumn0" class="page-title2-normal" style="top:145px;">播放记录</div>
<div id="leftColumn1" class="page-title2-normal" style="top:210px;">我的收藏</div>
<%--<div id="leftColumn2" class="page-title2-normal" style="top:270px;">我的订购</div>--%>
<div id="leftFocusBG"
     style="position: absolute;left: 0px;top:130px;width: 230px;height: 60px;background-image: url('images/portal/my/leftBG.png');">
</div>

<!--没有数据提示信息-->
<div id="noDataMsg" class="page-title2-focus"
     style="position: absolute;color: #C5C4C4;font-size:35px;line-height:42px;left:230px;top:337px;width:1050px;height:42px;visibility:hidden;">
    您暂无播放记录，请移步播放区观看！
</div>

<!--播放记录|我的收藏-->
<div id="playAndFavShow" style="visibility: hidden;">
    <div id="allMovicesName" class="page-title2-focus"
         style="position: absolute;color: #C4C2CF;font-size:22px;line-height:25px;left:283px;top:86px;width: 90px;height: 25px;">
        全部影片
    </div>
    <div style="position: absolute;left:384px;top:86px;width:1px;height:32px;">
        <img src="images/portal/my/shortDividerLine2.png" width="1px" height="32px"/></div>
    <div id="" class="page-title2-focus"
         style="position: absolute;font-size:24px;line-height:25px;left:393px;top:86px;width: 100px;height: 25px;">
        共<font id="totalNum" color="#B58522">
    </font>部
    </div>
    <div id="delButton"
         style="position: absolute;left: 1072px;top:65px;width: 105px;height: 42px;background-image: url('images/portal/my/topDelBg.png')">
        <div style="position:absolute;left:12px;width:21px;height:22px;top:10px;">
            <img src="images/portal/my/icon_delete_small.png" width="21px" height="22px"/></div>
        <div id="delName" class="page-title2-focus"
             style="position: absolute;color: #C4C2CF;font-size:26px;line-height:27px;left:45px;top:9px;width: 55px;height: 27px;">
            删除
        </div>
    </div>
    <div id="delFocus"
         style="position: absolute;left:1058px;top:50px;width:134px;height:73px;z-index:3;visibility:hidden;">
        <img width="134px" height="73px" src="images/portal/my/delFocus.png"/>
    </div>
    <!--海报焦点-->
    <div id="posterFocus"
         style="position:absolute;left:268px;top:111px;width:195px;height:257px;z-index: 3;visibility:hidden;">
        <img width="195px" height="257px" src="images/portal/my/posterFocus.png"/>
    </div>
    <%
        int totalCount = 18;//数据总条数
        int length = 10;    //当前页取出的数据条数
        int curPageNum = 0;    //当前展示的是第几页
        int pageTotalNum = length / 10 + 1;  //总页数

        for (int i = 0; i < length; i++) {
            int row = i / 5;
            int col = i % 5;
            int topvalue = 130;
            int leftvalue = 284;
    %>
    <div style="position:absolute;left:<%=col * (160+25)+leftvalue%>px;top:<%=row*(220+57)+topvalue%>px;width:160px;height:220px;">
        <img id="poster_img_<%=i%>" src="" width="160px" height="220px"/>
    </div>
    <div id="poster_name_<%=i%>" class="page-title2-focus font-ellipsis"
         style="position:absolute;color: #C4C2CF;font-size:24px;line-height:25px;left:<%=col * (160+25)+leftvalue+8%>px;top:<%=row*(220+57)+topvalue+220+8%>px;width:145px;height:25px;">
    </div>
    <div id="posterbg_img_<%=i%>" style="position:absolute;left:<%=col * (160+25)+leftvalue%>px;top:<%=row*(220+57)+topvalue%>px;width:160px;height:220px;visibility:hidden;">
        <img  src="images/listDeleteTran.png" width="160px" height="220px"/>
    </div>
    <div id="posDel_div_<%=i%>" style="visibility:hidden;position:absolute;z-index:10;left:<%=col * (160+25)+leftvalue%>px;top:<%=row*(220+57)+topvalue + 70%>px;width:160px;height:220px;text-align:center;line-height:220px;">
        <img id="posDel_img_<%=i%>" src="images/portal/my/info_delete_normal.png" width="43px" height="43px"/>
    </div>
    <%
        }
    %>
</div>

<!--我的订购-->
<div id="MyOrderDiv" style="position:absolute;left:304px;width:855px;height:495px;top:128px;visibility: hidden;">
    <div id="orderTitle"
         style="position:absolute;left:0px;top:0px;width:855px;height:62px;background-image: url('images/portal/my/orderTitle.png');">
        <div class="page-title2-normal" style="left:113px;top:17px;width:48px;height:28px;">名称</div>
        <div style="position: absolute;left:294px;top:15px;width:1px;height:32px;">
            <img src="images/portal/my/shortDividerLine2.png" width="1px" height="32px"/></div>

        <div class="page-title2-normal" style="left:332px;top:17px;width:48px;height:28px;">资费</div>
        <div style="position: absolute;left:430px;top:15px;width:1px;height:32px;">
            <img src="images/portal/my/shortDividerLine2.png" width="1px" height="32px"/></div>

        <div class="page-title2-normal" style="left:468px;top:17px;width:96px;height:28px;">订购时间</div>
        <div style="position: absolute;left:600px;top:15px;width:1px;height:32px;">
            <img src="images/portal/my/shortDividerLine2.png" width="1px" height="32px"/></div>

        <div class="page-title2-normal" style="left:664px;top:17px;width:96px;height:28px;">到期时间</div>
    </div>
    <div id="orderBody"
         style="position:absolute;left:0px;top:62px;width:855px;height:432px;background-image: url('images/portal/my/orderBody.png');">
        <%
            int orderLength = 8;
            for (int j = 0; j < orderLength - 1; j++) {
        %>
        <div style="position:absolute;left:0px;top:<%=(j+1)*54%>px;width:855px;height:3px;">
            <img id="line_<%=j%>" src="images/portal/my/line01.png" width="855px" height="2px"/></div>
        <!--<hr style="width: 853px;height: 1px; color: black;">-->
        <div id="moviceName_<%=j%>" class="page-title2-focus font-ellipsis"
             style="left:0px;top:<%=j*54+14%>px;width:294px;height:28px; font-size:28px;line-height:28px;"></div>

        <div class="page-title2-focus" id="feeFatherDiv_<%=j%>"
             style="left:294px;top:<%=j*54+14%>px;width:140px;height:28px; font-size:28px;line-height:28px;">
            <span id="fee_<%=j%>"></span>
        </div>

        <div id="orderTime_<%=j%>" class="page-title2-focus"
             style="left:435px;top:<%=j*54+14%>px;width:170px;height:28px; font-size:28px;line-height:28px;"></div>

        <div id="overTime_<%=j%>" class="page-title2-focus"
             style="left:603px;top:<%=j*54+14%>px;width:250px;height:28px; font-size:28px;line-height:28px;"></div>
        <%
            }
        %>
        <div id="moviceName_<%=orderLength-1%>" class="page-title2-focus font-ellipsis"
             style="left:0px;top:<%=(orderLength-1)*54+14%>px;width:294px;height:28px; font-size:28px;line-height:28px;"></div>

        <div class="page-title2-focus" id="feeFatherDiv_<%=orderLength-1%>"
             style="left:294px;top:<%=(orderLength-1)*54+14%>px;width:140px;height:28px; font-size:28px;line-height:28px;">
            <span id="fee_<%=orderLength-1%>"></span>
        </div>

        <div id="orderTime_<%=orderLength-1%>" class="page-title2-focus"
             style="left:435px;top:<%=(orderLength-1)*54+14%>px;width:170px;height:28px; font-size:28px;line-height:28px;"></div>

        <div id="overTime_<%=orderLength-1%>" class="page-title2-focus"
             style="left:603px;top:<%=(orderLength-1)*54+14%>px;width:250px;height:28px; font-size:28px;line-height:28px;"></div>
    </div>
</div>

<!--右边滚动条-->
<div id="scrollDiv" style="visibility:hidden;">
    <div style="position:absolute;left:1225px;top:130px;width:6px;height:500px;">
        <img src="images/portal/my/scrollBackImg.png" width="6" height="500" alt=""/>
    </div>
    <div id="scrollBar" style="position:absolute;left:1225px;top:130px;width:6px;height:80px;">
        <img src="images/portal/my/scrollBar.png" width="6" height="0" alt="" id="scrollBar1"/>
    </div>
</div>
</body>
<script type="text/javascript">
// 左侧栏目下标
var leftFocusIndex = parseInt("<%=position[0]%>",10);
// 当前页码
var  curPage=parseInt("<%=position[1]%>",10);
// 当前VOD海报索引
var vodIndex=parseInt("<%=position[2]%>",10);
// 当前焦点区域索引 0：表示左侧栏目区域  1：右侧海报区域  2：删除按钮区域  3：删除状态区域
var curFocus =parseInt("<%=position[3]%>",10);
//  总页码
var  totalPage=1;
//  当前页码VOD的个数
var vodNumCurPage=10;
//  收藏数据数组
var favData=[];
// 书签数据数组
var bookMarkData=[];
//  订购数据数组
var ppvData=[];
// 相关数据的总数
var dataTotalNum=0;
// 有无数据标志符
var noDataFlag=false;
 // 第一次进入
var initFlag=true;
//  按键保护
var keyProtect=false;
// 删除按钮，还是取消删除按钮
var isCancelFlag=true;
function goUp() {
    if (curFocus ===0) {
        // 左侧栏目区域
        if (leftFocusIndex > 0) {
            leftColumnGetBlur(leftFocusIndex);
            leftFocusIndex--;
            leftColumnGetFocus(leftFocusIndex);
            curPage=1;
            vodIndex=0;
            //刷新数据
            loadPlayAndFavData(leftFocusIndex);
        }
    }else if(curFocus===1){
          if(vodIndex>4){
              scrollstr(0) ;
                vodIndex-=5;
               setPosterFocus();
                scrollstr(1) ;
          }else{
              if(curPage>1){
                   doPageUp();
                  scrollstr(1) ;
              }else {
                   hidePosterFocusDiv();
                   curFocus=2;
                   cancelBtnGetFocus();
                  scrollstr(0) ;
              }
          }
    }else if(curFocus===3){
        posterCancelDivGetBlur();
         if(vodIndex>4){
             scrollstr(0) ;
             vodIndex-=5;
             scrollstr(1) ;
             posterCancelDivGetFocus();
         }else{
             if(curPage>1){
                 scrollstr(0) ;
                 doPageUp();
                 scrollstr(1) ;
             }else{
                 scrollstr(0) ;
                 curFocus=2;
                 cancelBtnGetFocus();
             }
         }
    }
}

/*
滚动条
 */
function showScrollBar(curNum){
    showScroll();
//    var tempNum = 8;
//    if(leftFocusIndex<2){
//        tempNum = 10;
//    }
//    var programTotalPage =Math.ceil(dataTotalNum/tempNum);
//    var scrollY=Math.ceil((curNum/programTotalPage)*420);
//    var y=scrollY>420?420:scrollY;
//
//    if(programTotalPage===1||curNum===1){
//        y=0;
//    }
//    y+=130;
//     dom("scrollBar").style.top = y + "px";
    var scrollBarSize=Math.ceil(500/totalPage);
    var scrollBarHeight=scrollBarSize>500?500:scrollBarSize;
    dom("scrollBar1").style.height=scrollBarHeight;
    // 设置滚动条滚动的位置
    // 设置滚动条能够滚动的区域大小
    var scrollBottomSize=500-scrollBarHeight;
    var scrollY=Math.ceil((curPage-1)*scrollBarSize);
    var y=scrollY>scrollBottomSize?scrollBottomSize:scrollY;
    if(totalPage===1||dataTotalNum===1){
        y=0;
    }
    dom("scrollBar").style.top=130+y+"px";
}
function goDown() {
    if (curFocus ===0) {
        //  左侧栏目区域
        if (leftFocusIndex < 1) {
            leftColumnGetBlur(leftFocusIndex);
            leftFocusIndex++;
            leftColumnGetFocus(leftFocusIndex);
            curPage=1;
            vodIndex=0;
            //刷新数据
            loadPlayAndFavData(leftFocusIndex);
        }
    }else if(curFocus===1){
         if(vodIndex<5){
           if(vodIndex+5<vodNumCurPage){
               scrollstr(0) ;
               vodIndex+=5;
               setPosterFocus();
               scrollstr(1) ;
           }
         }else{
            if(curPage<totalPage){
                doPageDown();
                scrollstr(1) ;
            }
         }
    }else if(curFocus===3){
          if(vodIndex<5){
             if(vodIndex+5<vodNumCurPage){
                posterCancelDivGetBlur();
                 scrollstr(0) ;
                 vodIndex+=5;
                 scrollstr(1) ;
                 posterCancelDivGetFocus();
             }
          }else{
               //  已经在第二行了 ,此时在删除状态
              if(curPage<totalPage){
                  scrollstr(0) ;
                  doPageDown();
                  scrollstr(1) ;
              }
          }
    }else if(curFocus===2){
          cancelBtnGetBlur();
          if(isCancelFlag){
            // VOD海报为正常状态
              curFocus=1;
              setPosterFocus();
              scrollstr(1) ;
          }else{
//              scrollstr(0) ;
              scrollstr(1) ;
              curFocus=3;
              posterCancelDivGetFocus();
          }
    }
}
// 删除按钮获取焦点
function cancelBtnGetFocus(){
    dom("delFocus").style.visibility = "visible";
}
// 删除按钮失去焦点
function cancelBtnGetBlur(){
    dom("delFocus").style.visibility = "hidden";
}
// 显示正常海报焦点框
function showPosterFocusDiv(){
    dom("posterFocus").style.visibility = "visible";
}
// 隐藏正常海报焦点框
function hidePosterFocusDiv(){
    dom("posterFocus").style.visibility = "hidden";
}
// 海报删除框获得焦点
function posterCancelDivGetFocus(){
    dom("posDel_img_" + vodIndex).src = "images/portal/my/info_delete_focus.png";
}
// 海报删除框失去焦点
function posterCancelDivGetBlur(){
    dom("posDel_img_" + vodIndex).src = "images/portal/my/info_delete_normal.png";
}
function scrollstr(id){
    var  object=null;
    if (leftFocusIndex == 0) {
        object = bookMarkData[vodIndex];
    } else if (leftFocusIndex == 1) {
        object = favData[vodIndex];
    } else if (leftFocusIndex == 2) {
        object = ppvData[vodIndex];
    }
       if(id==1){
           starScroll("poster_name_" + vodIndex,object.programName,11);
       }else{
           stopScroll("poster_name_" + vodIndex,object.programName);
       }
}
function goRight() {
    if(curFocus===0){
         if(noDataFlag){
            return false;
         }
         if(leftFocusIndex===2){
              return false;
         }
          curFocus=1;
          setPosterFocus();
          scrollstr(1) ;
    }else if(curFocus===1){
           if(vodIndex<vodNumCurPage-1){
               scrollstr(0) ;
               vodIndex++;
               setPosterFocus();
               scrollstr(1) ;
           }
    }else if(curFocus===3){
          if(vodIndex<vodNumCurPage-1){
               posterCancelDivGetBlur();
              scrollstr(0) ;
              vodIndex++;
              scrollstr(1) ;
              posterCancelDivGetFocus();
          }
    }
}

function goLeft() {
    if(curFocus===1){
           if(vodIndex===0||vodIndex===5){
                hidePosterFocusDiv();
                curFocus=0;
               // 因为左边栏目焦点无变化，所以不要特意获取焦点
               scrollstr(0) ;
           }else{
               scrollstr(0) ;
               vodIndex--;
               setPosterFocus();
               scrollstr(1) ;
           }
    }else if(curFocus===3){
         if(vodIndex>0){
             posterCancelDivGetBlur();
             scrollstr(0) ;
             vodIndex--;
             scrollstr(1) ;
             posterCancelDivGetFocus();
         }
    }
}

function setPosterFocus(){
    if(vodIndex>4){
        dom("posterFocus").style.left = (268 + (vodIndex -5)*185) + "px";
        dom("posterFocus").style.top = "388px";
    }else{
        dom("posterFocus").style.left = (268 + vodIndex *185) + "px";
        dom("posterFocus").style.top = "111px";
    }
    showPosterFocusDiv();
}
function leftColumnGetFocus(index) {
    dom("leftFocusBG").style.top = (130 + leftFocusIndex * 60) + "px";
    dom("leftColumn" + index).className = "page-title2-focus";
    dom("leftColumn" + index).style.top = (145 + index * 60) + "px";
}

function leftColumnGetBlur(index) {
    dom("leftColumn" + index).className = "page-title2-normal";
    dom("leftColumn" + index).style.top = (150 + leftFocusIndex * 60) + "px";
}
// 展示删除图标
function showDel(){
    for(var i=0;i<vodNumCurPage;i++){
        dom("posDel_div_"+i).style.visibility="visible";
        dom("posterbg_img_"+i).style.visibility="visible";
    }
}
// 隐藏删除图标
function hideDel(){
    for(var i=0;i<10;i++){
        dom("posDel_div_"+i).style.visibility="hidden";
        dom("posterbg_img_"+i).style.visibility="hidden";
    }
}
// 对删除按钮按OK键
function pressCancelBtn(){
    if(isCancelFlag){
        vodIndex=0;
        isCancelFlag=false;
        dom("delName").innerText="完成";
        showDel();
        goDown();
    }else{
        isCancelFlag=true;
        vodIndex=0;
        dom("delName").innerText="删除";
        hideDel();
    }
}
function doOk() {
    if(curFocus===1){
           goDetail();
    }else if(curFocus===2){
           pressCancelBtn();
    }else if(curFocus===3){
           if(leftFocusIndex===0){
                  delBookmark();
           }else if(leftFocusIndex===1){
                   delFavorite();
           }
    }
}
function delFavorite(){
    keyProtect=true;
    var delUrl="action/favorite_add.jsp?isfav=true&ContentID="+favData[vodIndex].contentCode+
            "&SubjectID="+favData[vodIndex].columnCode+
            "&programtype="+favData[vodIndex].programType;
//    alert("=====swb=====delFavorite=====>>>url>>>>>"+delUrl);
    new net.ContentLoader(delUrl,function(){
        var responseResult=eval("("+this.req.responseText+")");
       keyProtect=false;
        if(responseResult.returnCode==0){
            posterCancelDivGetBlur();
            clearAllPoster();
            // 判断当前页面的VOD海报数量
            if(vodNumCurPage>1){
                // 普通情况下向左移动一下
                // 如果当前选择删除的VOD不是最后一页的数据的最后一条数据的话，
                // vodIndex的值可以不变
                if(curPage==totalPage){
                     if(vodIndex==vodNumCurPage-1){
                        vodIndex--;
                     }
                }                            
            }else if(vodNumCurPage==1){
                //如果当前页是只有一个数据的时候，需要加载上一页的数据
                if(curPage==1){
                    // todo 要做特殊处理 ,展示无数据记录，并且将删除按钮消失，焦点区域设置为0
                    curFocus=0;
                    vodNumCurPage=0;
                    cancelBtnGetBlur();
                    showNoDataInfo();
                    return false;
                }else{
                    curPage--;
                    vodIndex=0;
                }
            }
            loadPlayAndFavData(leftFocusIndex);
        }else{
            //todo 失败后的操作
        }
    });
}
function delBookmark(){
    keyProtect=true;
    var delUrl="action/del_bookmark.jsp?bookmarkType="+bookMarkData[vodIndex].programType+
            "&contentId="+bookMarkData[vodIndex].contentCode+
            "&subjectId="+bookMarkData[vodIndex].columnCode;
//    alert("=====swb=====delBookMarkUrl>>>> "+delUrl);
    new net.ContentLoader(delUrl,function(){
        var resultFlag=eval("("+this.req.responseText+")");
        keyProtect=false;
//        alert("=======huwenxi====="+resultFlag.returnCode);
        if(resultFlag.returnCode==0){
            //success
            // 删除成功需要将原来的删除焦点图标恢复到默认普通
            posterCancelDivGetBlur();
            clearAllPoster();
            // 判断当前页面的VOD海报数量
            if(vodNumCurPage>1){
                 // 普通情况下向左移动一下
                 // 如果当前选择删除的VOD不是最后一页的数据的最后一条数据的话，
                // vodIndex的值可以不变
                if(curPage==totalPage){
                     if(vodIndex==vodNumCurPage-1){
                        vodIndex--;
                     }
                }       
            }else if(vodNumCurPage==1){
                //如果当前页是只有一个数据的时候，需要加载上一页的数据
                if(curPage==1){
                    // todo 要做特殊处理 ,展示无数据记录，并且将删除按钮消失，焦点区域设置为0
                    curFocus=0;
                    vodNumCurPage=0;
                    cancelBtnGetBlur();
                    showNoDataInfo();
                    return false;
                }else{
                    curPage--;
                    vodIndex=0;
                }
            }
            loadPlayAndFavData(leftFocusIndex);
        }else{
            //todo 删除失败是什么操作
        }
    });
}
function goDetail(){
    var url = "vod_detail.jsp",
            detailColumncode,
            detailContentCode,
            detailMediaServices,
            detailPorgramCode,
            detailProgrameType,
            breakInfo,
            leefocus;
    if(leftFocusIndex===0){
        detailColumncode=bookMarkData[vodIndex].columnCode;
        detailContentCode=bookMarkData[vodIndex].contentCode;
        detailMediaServices=bookMarkData[vodIndex].mediaServices;
        detailPorgramCode=bookMarkData[vodIndex].programCode;
        detailProgrameType=bookMarkData[vodIndex].programType;
        breakInfo=bookMarkData[vodIndex].breakInfo;
    }else if(leftFocusIndex===1){
        detailColumncode=favData[vodIndex].columnCode;
        detailContentCode=favData[vodIndex].contentCode;
        detailMediaServices=favData[vodIndex].mediaServices;
        detailPorgramCode=favData[vodIndex].programCode;
        detailProgrameType=favData[vodIndex].programType;
    }
    // leftFocusIndex- curPage -  vodIndex - curFocus
    leefocus=leftFocusIndex+"-"+curPage+"-"+vodIndex+"-"+curFocus;
    if (detailProgrameType == "14"||detailProgrameType == "10") {
        url = "vod_series_head.jsp";
    }
    var queryString="?columncode=" +detailColumncode +
            "&programid=" + detailPorgramCode +
            "&programtype=" + detailProgrameType +
            "&contentcode=" + detailContentCode+
            "&mediaservices=" + detailMediaServices;
//    alert("=====swb=====queryString>>> "+url+queryString+"&leefocus="+leefocus);
     if(leftFocusIndex==0) {
         document.location="checkbookpoint.jsp"+queryString+"&leefocus="+leefocus+"&breakInfo="+breakInfo;
     }  else{
         document.location=url+queryString+"&leefocus="+leefocus;
     }

}
//  如果没有获取到数据展示相关区域
function showNoDataInfo(){
    if (vodNumCurPage == 0) {
        noDataFlag = true;
        dom("noDataMsg").style.visibility = "visible";
        dom("playAndFavShow").style.visibility = "hidden";
        dom("delName").innerHTML = "删除";
        if (leftFocusIndex == 0) {
            dom("noDataMsg").innerHTML = "您暂无播放记录，请移步播放区观看！";
        } else if (leftFocusIndex == 1) {
            dom("noDataMsg").innerHTML = "您暂无收藏内容，请移步播放区添加收藏！";
        } else if (leftFocusIndex == 2) {
            dom("noDataMsg").innerHTML = "您暂无订购内容，请移步播放区订购内容！";
        }
        dom("scrollDiv").style.visibility = "hidden";
    }
}
// 清空数据
function clearAllPoster(){
       if(leftFocusIndex!=2){
           for(var i=0;i<10;i++){
               dom("poster_img_" + i).src ="images/vod/btn_trans.gif";
               dom("poster_name_" + i).innerText = "";
           }
           if(curFocus===3){
               hideDel();
           }
       }else{
           clearPPV();
       }
}
function clearPPV(){
    for(var j=0;j<8;j++){
        dom("moviceName_" + j).innerText = "";
        dom("fee_" + j).innerText ="";
        dom("orderTime_" + j).innerText ="";
        dom("overTime_" + j).innerText = "";
    }
}
//  展示数据
function showDataInfo(){
    clearAllPoster();
    noDataFlag = false;
    //  展示相关区域
    dom("noDataMsg").style.visibility = "hidden";
    if (leftFocusIndex != 2) {
        dom("playAndFavShow").style.visibility = "visible";
        dom("MyOrderDiv").style.visibility = "hidden";
        dom("totalNum").innerText = dataTotalNum;
    } else {
        dom("playAndFavShow").style.visibility = "hidden";
        dom("MyOrderDiv").style.visibility = "visible";
    }
    // 显示VOD海报和名称，以及ppv信息
    for (var i = 0; i < vodNumCurPage; i++) {
        var object = null;
        if (leftFocusIndex == 0) {
            object = bookMarkData[i];
        } else if (leftFocusIndex == 1) {
            object = favData[i];
        } else if (leftFocusIndex == 2) {
            object = ppvData[i];
        }

        if (leftFocusIndex != 2) {
            dom("poster_img_" + i).src = object.normalPoster;
//            dom("poster_name_" + i).innerText = object.programName;
            stopScroll("poster_name_" +i,object.programName);
        } else {
            dom("moviceName_" + i).innerText = object.programName;
            dom("fee_" + i).innerText = parseInt(object.feecost) / 100+"元";
            dom("orderTime_" + i).innerText = object.begintime;
            dom("overTime_" + i).innerText = object.endtime;
        }
        if(curFocus===3){
              showDel();
              posterCancelDivGetFocus();
        }
    }
}
// 焦点记忆
function getFocus(){
    // 焦点记忆
    // leftFocusIndex- curPage -  vodIndex - curFocus
    //  0-1-0-0
    if(curFocus===0){
        leftColumnGetFocus(leftFocusIndex);
    }else if(curFocus===1){
        if (leftFocusIndex != 2) {
            // 书签和收藏
            if(vodIndex>vodNumCurPage-1){
                vodIndex=vodNumCurPage-1;
            }
            setPosterFocus();
        }
    }
}

//加载播放记录|我的收藏 数据
function loadPlayAndFavData(leftFocusIndex) {
    var requestUrl = null;
    if (leftFocusIndex == 0) {	//播放记录
        requestUrl = "action/get_bookmark.jsp?destpage=" + curPage + "&pagecount=10"
    } else if (leftFocusIndex == 1) {	//我的收藏
        requestUrl = "action/get_vod_favorite_new.jsp?destpage=" + curPage + "&pagecount=10";
    } else if (leftFocusIndex == 2) {	//我的订购
        requestUrl = "action/self_rented_program.jsp?curpage=" + curPage;
    }
     keyProtect=true;
    new net.ContentLoader(requestUrl, function () {
        // 获取栏目数据
        var resultData = eval("(" + this.req.responseText + ")");
        //总个数
        dataTotalNum = parseInt(resultData.totalcount,10);
        if(leftFocusIndex===0){
            // 书签数据
            bookMarkData=resultData.markData;
            vodNumCurPage=bookMarkData.length;
            totalPage=Math.ceil(dataTotalNum/10);
        }else if(leftFocusIndex===1){
            //  收藏数据
            favData=resultData.favData;
            vodNumCurPage=favData.length;
            totalPage=Math.ceil(dataTotalNum/10);
        }else if(leftFocusIndex===2){
            //  订购数据
            ppvData=resultData.vodData;
            vodNumCurPage=ppvData.length;
            totalPage=Math.ceil(dataTotalNum/8);
        }

        if(vodNumCurPage===0){
            showNoDataInfo();
        }else {
            showDataInfo();
            if(initFlag){
                initFlag=false;
                getFocus();
            }
            showScrollBar(curPage);
        }
        keyProtect=false;
    });
}

function showScroll() {
    if (totalPage<2) {
        dom("scrollDiv").style.visibility = "hidden";
    } else {
        dom("scrollDiv").style.visibility = "visible";
    }
}
function doBack(){
    document.location = "back.jsp";
}
function dokeyPress(evt) {
    if(keyProtect){
        return false;
    }
    var keyCode = parseInt(evt.which);
    if (keyCode == 0x0008) {
        doBack();
        //document.location="channel_all_ok.jsp?mixno=28&columncode=07";
    } else if (keyCode == 0x0025) { //onKeyLeft
        goLeft();
    } else if (keyCode == 0x0027) { //onKeyRight
        goRight();
    } else if (keyCode == 0x0026) { //onKeyUp
        goUp();
    } else if (keyCode == 0x0028) { //onKeyDown
        goDown();
    } else if (keyCode == 0x000D) {  //OK
        doOk();
    }else if(keyCode ==34){
         doPageDown();
    }else if(keyCode==33){
          doPageUp();
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
}
function doPageDown(){
      if(curFocus===0){
           if(leftFocusIndex===2){
                if(curPage<totalPage){
                    curPage++;
                    loadPlayAndFavData(2);
                }
           }
      }else if(curFocus===1){
          // 普通状态下的VOD海报区域
          if(leftFocusIndex==0||leftFocusIndex==1){
               if(curPage<totalPage){
                     curPage++;
                     vodIndex=0;
                     loadPlayAndFavData(leftFocusIndex);
                     setPosterFocus();
               }
          }
      }else if(curFocus===3){
          //  删除状态下的VOD海报区域
          if(leftFocusIndex==0||leftFocusIndex==1){
               if(curPage<totalPage){
                    posterCancelDivGetBlur();
                   curPage++;
                   vodIndex=0;
                   loadPlayAndFavData(leftFocusIndex);
                   posterCancelDivGetFocus();
               }
          }
      }

}
function doPageUp(){
    if(curFocus===0){
          if(leftFocusIndex===2){
              if(curPage>1){
                  curPage--;
                  loadPlayAndFavData(2);
              }
          }
    }else if(curFocus===1){
        //  普通状态下的VOD海报区域
        if(leftFocusIndex==0||leftFocusIndex==1){
            if(curPage>1){
                 curPage--;
                 vodIndex=0;
                loadPlayAndFavData(leftFocusIndex);
                setPosterFocus();
            }
        }
    }else if(curFocus===3){
         //  删除状态下的VOD海报区域
         if(leftFocusIndex==0||leftFocusIndex==1){
               if(curPage>1){
                   posterCancelDivGetBlur();
                    curPage--;
                     vodIndex=0;
                     loadPlayAndFavData(leftFocusIndex);
                     posterCancelDivGetFocus();
               }
         }
    }
}
function init() {
document.onkeypress = dokeyPress;
    leftColumnGetFocus(leftFocusIndex);
    loadPlayAndFavData(leftFocusIndex);
}
window.focus();
</script>
</html>
