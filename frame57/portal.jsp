<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@page import="com.zte.iptv.epg.util.*" %>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%
    pageContext.removeAttribute(EpgConstants.STACK, PageContext.SESSION_SCOPE);
    pageContext.removeAttribute(EpgConstants.CHANNEL_STACK, PageContext.SESSION_SCOPE);
%>
<epg:PageController name="portal.jsp"/>
<%!
	public String unescape(String src) {  
        StringBuffer tmp = new StringBuffer();  
        tmp.ensureCapacity(src.length());  
        int lastPos = 0, pos = 0;  
        char ch;  
        while (lastPos < src.length()) {  
            pos = src.indexOf("%", lastPos);  
            if (pos == lastPos) {  
                if (src.charAt(pos + 1) == 'u') {  
                    ch = (char) Integer.parseInt(src  
                            .substring(pos + 2, pos + 6), 16);  
                    tmp.append(ch);  
                    lastPos = pos + 6;  
                } else {  
                    ch = (char) Integer.parseInt(src  
                            .substring(pos + 1, pos + 3), 16);  
                    tmp.append(ch);  
                    lastPos = pos + 3;  
                }  
            } else {  
                if (pos == -1) {  
                    tmp.append(src.substring(lastPos));  
                    lastPos = src.length();  
                } else {  
                    tmp.append(src.substring(lastPos, pos));  
                    lastPos = pos;  
                }  
            }  
        }  
        return tmp.toString();  
    } 
%>
<%
	
	String paramStr = request.getQueryString();
	if (null == paramStr || paramStr.equals("")) {
        paramStr = "";
    }
    String stbtype = String.valueOf(getConfigurationByName(request,"stbtype",null,"GBK"));
    String lastfocus = String.valueOf(request.getParameter("lastfocus"));
    System.out.println("-------------stbtype:"+stbtype);
    if (lastfocus.equals("null") || lastfocus.equals("")) {
        lastfocus = "0|0|0";
    }
    String[] lastList = lastfocus.split("\\|");
    for(int k=0;k<lastList.length;k++){
//        System.out.println("======"+lastList[k]);
    }
	/* 处理封套数据 BEGIN */
	UserInfo userInfo111 = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
	String epg_info = request.getParameter("epg_info");
	String page_url = ""; //处理封套返回路径
	String group_path = ""; 
	String server_ip = ""; 
    System.out.println("=====request====epg_info=======" + epg_info);
	if(null == epg_info || "".equals(epg_info) || "null".equals(epg_info) || "undefined".equals(epg_info)){
		epg_info = (String) session.getAttribute("epg_info_as");
   	 	System.out.println("=====session====epg_info=======" + epg_info);
	}
	if(null != epg_info && !"".equals(epg_info) && epg_info.length() > 20){
		session.setAttribute("epg_info_as",epg_info);
		group_path = epg_info.substring(epg_info.indexOf("<group_path>")+12,epg_info.indexOf("</group_path>"));
		page_url = epg_info.substring(epg_info.indexOf("<page_url>")+10,epg_info.indexOf("</page_url>"));
		server_ip = epg_info.substring(epg_info.indexOf("<server_ip>")+11,epg_info.indexOf("</server_ip>"));
		
		System.out.println("=========group_path=======" + group_path);
		System.out.println("=========page_url=======" + page_url);
		System.out.println("=========server_ip=======" + server_ip);
	}
	String path111 = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
    path111=path111.replace("/action","");
    HashMap param111 = PortalUtils.getParams(path111, "GBK");
	String framecode11 = String.valueOf(param111.get("framecode"));
	System.out.println("=========framecode11=======" + framecode11);
	/* 处理封套数据 END */
	
	
	String curUrl = request.getRequestURL().toString();
	if(null != curUrl && "".equals(server_ip)){
		server_ip = curUrl.substring(0,curUrl.indexOf("frame"));
		System.out.println("=========server_ip=======" + server_ip);
	}
	
	
    String reload_flag_as = (String) session.getAttribute("reload_flag_as");
	System.out.println("=========reload_flag_as=======" + reload_flag_as);
	if(null == reload_flag_as || "".equals(reload_flag_as)){
		session.setAttribute("reload_flag_as","1");
		//response.sendRedirect(server_ip + "/" + framecode11 "/portal.jsp?" + paramStr); 
	}else{
		session.setAttribute("reload_flag_as",null);
	}
%>
<html>

<head>
<title>portal.html</title>
<meta name="page-view-size" content="1280*720">
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<style type="text/css">
    div{
        
    }
    .font_ellipsis {
        /*overflow: hidden;*/
        /*white-space: nowrap;*/
        /*text-overflow: ellipsis;*/
    }

    .navigationfocus{
        color: #48AAFD;
        font-size: 40px;
        line-height: 50px;
    }
    .navigationblur{
        color: #fff;
        font-size: 35px;
        line-height: 50px;
    }

</style>
<script type="text/javascript" src="js/dom.js"></script>
<script type="text/javascript" src="js/contentloader.js"></script>
<script type="text/javascript" src="js/navigation.js"></script>
<script type="text/javascript" src="js/diagnosis.js"></script>
<%--<script type="text/javascript" src="data/frame_envelope_conf.js"></script>--%>
<script language="javascript" type="">
    toast("测试信息");
	//OSD....................................
	top.jsSetControl("UserModel","<%=framecode11%>");//修改直播OK键返回键封套EPG呼出控制页 cny 2017/8/8
	if('<%=reload_flag_as %>' == '1') {
		var WIN_SRC = "<%=server_ip%>/<%=framecode11%>/portal.jsp";
		if('<%=lastfocus%>' != ''){
			WIN_SRC += '?lastfocus=<%=lastfocus%>';
		}
		top.location.href = "<%=server_ip%>/function/frameset_builder.jsp?MAIN_WIN_SRC=" + escape(WIN_SRC);
		//window.location.href = WIN_SRC;
	}
	top.currState = 0;
    top.doStop();
// 固定设置ITUOSD,否则机顶盒语言为中文时候，页面透明度会被设置为25
//top.INFOR.osdKind = "ITUOSD";
//top.jsSetControl("isDonePortal", "true");
//alert("================"+recommendJSON);

	/* 适配封套 ADD BEGIN */
	var IS_FT_FRAME_IN = ('' == '<%=page_url%>' ? false : true);
	/* 适配封套 ADD END */
var areaFlag = "<%=lastList[0]%>";
//var navigationIndex = 0;
var recommObj = null;  //推荐对象
var navigationObj = null;  //导航栏对象
var channelObj = null;  //导航栏对象
var vodObj = null;  //导航栏对象
var zhuantiObj = null;  //导航栏对象
var myObj = null;  //导航栏对象
var jingpinObj = null;  //导航栏对象
var bendiObj = null;  //导航栏对象
var yingyongObj = null;  //导航栏对象
function initPageObj() {
    navigationObj = new returnNavigationObj();
    recommObj = new returnRecommObj();
    channelObj = new returnChannelObj();
    vodObj = new returnVodObj();
    zhuantiObj = new returnZhuantiObj();
    myObj = new returnMyObj();
    jingpinObj = new returnJingpinObj();
    bendiObj = new returnBendiObj();
    yingyongObj = new returnYingyongObj();
	
}
function initShowPage() {
    navigationObj.showObj();
}

//重置封套模板
function restFTEPGModel(kc) {
	//var requestUrl = "action/resetEPGModel.jsp?group_path=<%=group_path%>&kc="+kc;
	/*
	var requestUrl = "action/resetEPGModel.jsp?group_path=&kc="+kc;
	new net.ContentLoader(requestUrl, function () {
	});
	*/
}

function dokeyPress(evt) {
    var keyCode = parseInt(evt.which ? evt.which : evt.keyCode);
	//dom("test").innerHTML = dom("test").innerHTML + "<br/>keyCode" + keyCode;
	
    //alert(keyCode);
    if (keyCode == 0x0008) {
        if (areaFlag == 0) {
			if (navigationObj.objArray[navigationObj.posterIndex].code == 0) {
				if(IS_FT_FRAME_IN){
                    document.location = '<%=page_url%>' ;
                }
			} else {
				navigationObj.posterblur();
				navigationObj.posterIndex = 0;
				navigationObj.posterfocus();
			}
		}
		else {
			areaFlag = 0;
			if (navigationObj.objArray[navigationObj.posterIndex].code == 0) {
				recommObj.posterblur();
				recommObj.posterIndex = 0;
				clearTimeout(recommObj.timer);
			} else if (navigationObj.objArray[navigationObj.posterIndex].code == 1) {
				channelObj.posterblur();
				channelObj.posterIndex = 0;
				clearTimeout(channelObj.timer);
			} else if (navigationObj.objArray[navigationObj.posterIndex].code == 2) {
				vodObj.posterblur();
				vodObj.posterIndex = 0;
				clearTimeout(vodObj.timer);
			} else if (navigationObj.objArray[navigationObj.posterIndex].code == 3) {
				zhuantiObj.posterblur();
				zhuantiObj.posterIndex = 0;
				clearTimeout(zhuantiObj.timer);
			} else if (navigationObj.objArray[navigationObj.posterIndex].code == 4) {
				myObj.posterblur();
				myObj.posterIndex = 0;
				clearTimeout(myObj.timer);
			} else if (navigationObj.objArray[navigationObj.posterIndex].code == 5) {
				jingpinObj.posterblur();
				jingpinObj.posterIndex = 0;
				clearTimeout(jingpinObj.timer);
			} else if (navigationObj.objArray[navigationObj.posterIndex].code == 6) {
				bendiObj.posterblur();
				bendiObj.posterIndex = 0;
				clearTimeout(bendiObj.timer);
			} else if (navigationObj.objArray[navigationObj.posterIndex].code == 7) {
				yingyongObj.posterblur();
				yingyongObj.posterIndex = 0;
				clearTimeout(yingyongObj.timer);
			}
			navigationObj.posterfocus();
		}
    } else if (keyCode == <%=STBKeysNew.remoteMenu%>) {
		if (navigationObj.objArray[navigationObj.posterIndex].code == 0) {
			if(IS_FT_FRAME_IN){
				 document.location = '<%=page_url%>' ;
			}
		} else {
                                        document.location = '<%=page_url%>' ;
			//Authentication.CTCSetConfig("KeyValue", "0x110");
			// document.location = "portal.jsp";
		}
    } else if (keyCode == 0x0025) { //onKeyLeft
        //doLeft();
        if (areaFlag == 0) {
            navigationObj.left();
        } else {
            if (navigationObj.objArray[navigationObj.posterIndex].code == 0) {
                recommObj.left();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 1) {
                channelObj.left();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 2) {
                vodObj.left();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 3) {
                zhuantiObj.left();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 4) {
                myObj.left();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 5) {
                jingpinObj.left();
            }  else if (navigationObj.objArray[navigationObj.posterIndex].code == 6) {
                bendiObj.left();
            }else if (navigationObj.objArray[navigationObj.posterIndex].code == 7) {
                yingyongObj.left();
            }

        }

    } else if (keyCode == 0x0027) { //onKeyRight
        //doRight();
        if (areaFlag == 0) {
            navigationObj.right();
        } else {
            if (navigationObj.objArray[navigationObj.posterIndex].code == 0) {
                recommObj.right();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 1) {
                channelObj.right();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 2) {
                vodObj.right();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 3) {
                zhuantiObj.right();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 4) {
                myObj.right();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 5) {
                jingpinObj.right();
            }else if (navigationObj.objArray[navigationObj.posterIndex].code == 6) {
                bendiObj.right();
            }else if (navigationObj.objArray[navigationObj.posterIndex].code == 7) {
                yingyongObj.right();
            }

        }

    } else if (keyCode == 0x0026) {//onKeyUp
        //doUP();
        if (areaFlag == 0) {
            //  navigationObj.right();
	  		//window.location.href= 'http://172.28.166.1:8080/jsyxen/category.html';
			return false;
        } else {
            if (navigationObj.objArray[navigationObj.posterIndex].code == 0) {
                recommObj.up();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 1) {
                channelObj.up();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 2) {
                vodObj.up();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 3) {
                zhuantiObj.up();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 4) {
                myObj.up();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 5) {
                jingpinObj.up();
            }else if (navigationObj.objArray[navigationObj.posterIndex].code == 6) {
                bendiObj.up();
            }else if (navigationObj.objArray[navigationObj.posterIndex].code == 7) {
                    yingyongObj.up();
            }

        }
    } else if (keyCode == 0x0028) { //onKeyDown
        //doDown();
        if (areaFlag == 0) {
            navigationObj.down();
        } else {
            if (navigationObj.objArray[navigationObj.posterIndex].code == 0) {
                recommObj.down();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 1) {
                channelObj.down();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 2) {
                vodObj.down();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 3) {
                zhuantiObj.down();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 4) {
                myObj.down();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 5) {
                jingpinObj.down();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 6) {
                bendiObj.down();
            }else if (navigationObj.objArray[navigationObj.posterIndex].code == 7) {
                yingyongObj.down();
            }

        }

    } else if (keyCode == 0x000D) {  //OK
        if (areaFlag == 1) {
			
			/* 适配封套 ADD BEGIN */
			setPortalUrlYS();
			/* 适配封套 ADD END */
			
            if (navigationObj.objArray[navigationObj.posterIndex].code == 0) {
                recommObj.ok();
				stopMarquee();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 1) {
                channelObj.ok();
				stopMarquee();
//                document.location="/iptvepg/frame389/channel_pre.jsp";
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 2) {
//                document.location="vod_new_list.jsp";
                vodObj.ok();
				stopMarquee();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 3) {
                zhuantiObj.ok();
				stopMarquee();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 4) {
                myObj.ok();
				stopMarquee();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 5) {
                jingpinObj.ok();
				stopMarquee();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 6) {
                bendiObj.ok();
				stopMarquee();
            }else if (navigationObj.objArray[navigationObj.posterIndex].code == 7) {
                yingyongObj.ok();
				stopMarquee();
            }
        }else{
            if(navigationObj.objArray[navigationObj.posterIndex].url!=""){
                document.location=navigationObj.objArray[navigationObj.posterIndex].url;
            }else{
				navigationObj.ok();
			}
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
		//restFTEPGModel(keyCode);
        top.doKeyPress(evt);
        return true;
    }
    return false;
}
</script>
</head>
<body bgcolor="transparent" style="overflow: hidden;" onLoad="getDaohangDate();">

<%--<body bgcolor="transparent" >--%>
<div id="bgDiv" style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px; background:url(images/bg.png) no-repeat; visibility:hidden;"></div>
<div id="vodBgDiv" style="position: absolute;left: 0px;top:0px;width: 1280px;height: 720px; background:url(images/vod_bg.png) no-repeat; visibility:hidden;"></div>
<div style="position: absolute;left: 46px;top:27px;">
    <img src="images/logo/logo.png">
</div>
<!-- 导航div -->
<div style="position: absolute;left: 120px;top:80px;width: 1000px;height: 200px;">
    <%
        for (int i = 0; i < 8; i++) {
    %>
    <div style="position: absolute;left: <%=i*120%>px;top:0px;width: 120px;height: 50px;" class="navigationblur"
         id="name<%=i%>">

    </div>
    <%
        }
    %>
    <div style="position: absolute;left: 0px;top:45px;width: 83px;height: 11px;visibility: hidden;" id="navigation">
        <img src="images/portal/recommend/dao.png" width="72" height="11">
    </div>
</div>
<!-- 推荐div -->
<%@include file="inc/recommend.jsp" %>

<!-- 直播的div-->
<%@include file="inc/portal_channel.jsp" %>

<!--  点播div -->
<%@include file="inc/portal_vod.jsp" %>

<!--  专题div -->
<%@include file="inc/portal_zhuanti.jsp" %>

<!--  我的div -->
<%@include file="inc/portal_my.jsp" %>

<!--  精品div -->
<%@include file="inc/portal_jingpin.jsp" %>

<!--  本地div -->
<%@include file="inc/portal_bendi.jsp" %>

<!--  应用div -->
<%@include file="inc/portal_yingyong.jsp" %>
<!-- 跑马灯DIV begin -->
<div id='marqueeDiv00' style='position:absolute; width: 1240px; height: 50px; left: 20px; top: 674px; font-size:30px; z-index:9999; color:#FFFFFF'>
</div>
<!-- 跑马灯DIV end -->

<%@include file="inc/scrollString.jsp" %>
<%@include file="inc/lastfocus.jsp" %>
<%@include file="inc/time.jsp" %>
<%@include file="inc/chan_addjsset.jsp" %>
</body>
<script type="text/javascript">
    var navigationJSON = new Array();
    var recommendJSON = new Array();
    var channelJSON = new Array();
    var vodJSON = new Array();
    var zhuantiJSON = new Array();
    var myJSON = new Array();
    var jingpinJSON = new Array();
    var bendiJSON = new Array();
    var yingyongJSON = new Array();
	var scrollJSON = new Array();
    var   responseText = "";

    <%--var stytype="<%=stbtype%>";--%>
    var isscale=true;
    //ajax获取数据
    function getDaohangDate() {
		restFTEPGModel('----start_load_daohangDate---');
        var requestUrl = "action/getPortal_daohang.jsp";
        new net.ContentLoader(requestUrl, function () {
            var data = eval("(" + this.req.responseText + ")");
            navigationJSON = data;
//            alert("=====navigationJSON===="+navigationJSON);
			restFTEPGModel('----daohangDate_data_call---');
            init();
        });
    }
    function getRecommendDate() {
        var requestUrl = "action/getPortal_recommend.jsp?index=" + navigationObj.objArray[navigationObj.posterIndex].code;
        new net.ContentLoader(requestUrl, function () {
            responseText = this.req.responseText;
            //dom("test").innerHTML ="responseText===="+ responseText;
            var data = eval("(" + this.req.responseText + ")");
            if (navigationObj.objArray[navigationObj.posterIndex].code == 0) {
//                alert("=====navigationJSON===1111="+recommendJSON);
                recommendJSON = data;
                recommObj.objArray = recommendJSON;
                recommObj.showObj();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 1) {
                channelJSON = data;
//                channelObj = new returnChannelObj();
                channelObj.objArray = channelJSON;
                channelObj.showObj();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 2) {
                vodJSON = data;
//                channelObj = new returnChannelObj();
                vodObj.objArray = vodJSON;
                vodObj.showObj();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 3) {
                zhuantiJSON = data;
//                channelObj = new returnChannelObj();
                zhuantiObj.objArray = zhuantiJSON;
                zhuantiObj.showObj();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 4) {
                myJSON = data;
//                channelObj = new returnChannelObj();
                myObj.objArray = myJSON;
                myObj.showObj();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 5) {
                jingpinJSON = data;
//                channelObj = new returnChannelObj();
                jingpinObj.objArray = jingpinJSON;
                jingpinObj.showObj();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 6) {
                bendiJSON = data;
//                channelObj = new returnChannelObj();
                bendiObj.objArray = bendiJSON;
                bendiObj.showObj();
            } else if (navigationObj.objArray[navigationObj.posterIndex].code == 7) {
                yingyongJSON=data;
//                channelObj = new returnChannelObj();
                yingyongObj.objArray=yingyongJSON;
                yingyongObj.showObj();
            }
        });
    }
    var stbType = Authentication.CTCGetConfig("STBType");
	stbType = stbType.toUpperCase();
    //初始化化数据
    function init() {
		restFTEPGModel('-init-' + 'stbType' + '-' + stbType);
		restFTEPGModel('-init-' + '1' + '-');
		if(stbType.indexOf('EC2108') != -1 || stbType.indexOf('B860A') != -1){
           isscale=false;
       }
		restFTEPGModel('------------isscale:' + isscale + '-----stbType:' + stbType);
		restFTEPGModel('-init-' + '2' + '-');
        initPageObj();
		restFTEPGModel('-init-' + '3' + '-');
        initShowPage();
		restFTEPGModel('-init-' + '4' + '-areaFlag:' + areaFlag);
		
		navigationObj.posterfocus();
		//getRecommendDate();
		
        if (areaFlag == 0) {
           // navigationObj.posterfocus();
           //getRecommendDate();
        } else {
			restFTEPGModel('-init-' + '5' + '-');
            //焦点记忆
            navigationObj.posterIndex = parseInt("<%=lastList[1]%>", 10);
        	dom("navigation").style.left=2+navigationObj.posterIndex*120+"px";
            dom("navigation").style.visibility="hidden";
            setTimeout(function () {
				restFTEPGModel('-init-' + '6' + '-code:' + navigationObj.objArray[navigationObj.posterIndex].code);
                if (navigationObj.objArray[navigationObj.posterIndex].code * 1 == 0) {
					
                    recommObj.posterIndex = parseInt("<%=lastList[2]%>", 10);
                    if ((recommObj.posterIndex > 3 && recommObj.posterIndex < 7) || (recommObj.posterIndex > 10)) {
                        dom("recomm").style.left = -891 + "px";
                    }
					recommObj.posterfocus();
					restFTEPGModel('-' + '12' + '-' + recommObj.posterIndex);
                } else if (navigationObj.objArray[navigationObj.posterIndex].code == 1) {
                    channelObj.posterIndex = parseInt("<%=lastList[2]%>", 10);
                    channelObj.posterfocus();
                } else if (navigationObj.objArray[navigationObj.posterIndex].code == 2) {
                    vodObj.posterIndex = parseInt("<%=lastList[2]%>", 10);
                    if ((vodObj.posterIndex > 2 && vodObj.posterIndex < 7) || (vodObj.posterIndex > 8)) {
                        dom("vod").style.left = -800 + "px";
                    }
                    vodObj.posterfocus();
                } else if (navigationObj.objArray[navigationObj.posterIndex].code == 3) {
                    zhuantiObj.posterIndex = parseInt("<%=lastList[2]%>", 10);
                    zhuantiObj.posterfocus();
                } else if (navigationObj.objArray[navigationObj.posterIndex].code == 4) {
                    myObj.posterIndex = parseInt("<%=lastList[2]%>", 10);
                    myObj.posterfocus();
                }else if (navigationObj.objArray[navigationObj.posterIndex].code == 5) {
                    jingpinObj.posterIndex = parseInt("<%=lastList[2]%>", 10);
                    jingpinObj.posterfocus();
                } else if (navigationObj.objArray[navigationObj.posterIndex].code == 6) {
                    bendiObj.posterIndex = parseInt("<%=lastList[2]%>", 10);
                    bendiObj.posterfocus();
                } else if (navigationObj.objArray[navigationObj.posterIndex].code == 7) {
                    yingyongObj.posterIndex = parseInt("<%=lastList[2]%>", 10);
                    yingyongObj.posterfocus();
                }
            }, 500);
        }
		
		 new net.ContentLoader("action/getPortal_recommend.jsp?index=0", function () {
					var data = eval("(" + this.req.responseText + ")");
						scrollJSON = data;
       		 });

		startMarquee();
		
		document.onkeypress = dokeyPress;
		window.focus();
    }
	/* 跑马灯配置，---begin */
	/* 启动跑马灯 */
	function startMarquee(){
		var marqueeStr = scrollJSON[16].subname;;
		var marqueeEle = "<marquee width=1280>" + marqueeStr + "</marquee>";
		document.getElementById('marqueeDiv00').innerHTML = marqueeEle;
	}
	/* 暂停跑马灯 */
	function stopMarquee(){
		document.getElementById('marqueeDiv00').innerHTML = "";
	}

    
    //设置全局配置，按数字键直播播放:true
    top.jsSetControl("NUM_TO_PLAY", true);
	//dom("test").innerHTML = dom("test").innerHTML + "<br/><%=userInfo111.getUserModel()%><br/>" + top.location.href+"<br/>styType:" + stbType;
	
	/*
	 * 当从封套进入央视模板
	 * 如果是华为机顶盒
	 * 进入央视模板推荐页面，设置首页键响应地址
	 */
	function setPortalUrlFT(){
		if(stbIsNeedAdapt() && IS_FT_FRAME_IN){
			//dom("test").innerHTML = dom("test").innerHTML + "<br/> set FT portal key's address!";
			Authentication.CTCSetConfig('EPGDomain',"<%=server_ip%>/function/index.jsp");
		}
	}
	/*
	 * 当从封套进入央视模板
	 * 如果是华为机顶盒
	 * 进入央视模板非推荐页面，则设置首页键响应地址
	 */
	function setPortalUrlYS(){
		if(stbIsNeedAdapt() && IS_FT_FRAME_IN){
			//dom("test").innerHTML = dom("test").innerHTML + "<br/> set YS portal key's address!";
			Authentication.CTCSetConfig('EPGDomain',"<%=server_ip%>/function/frameset_builder.jsp?MAIN_WIN_SRC=" + escape('/iptvepg/<%=framecode11%>/portal.jsp'));
			//Authentication.CTCSetConfig('EPGDomain',"/iptvepg/frame57/portal.jsp");
		}
	}
	function stbIsNeedAdapt(){
		return false;
		//return (stbType.indexOf('EC6108') != -1 || stbType.indexOf('HG680') != -1 || stbType.indexOf('EC2106') != -1 || stbType.indexOf('EC2108') != -1 || stbType.indexOf('HG650') != -1);
		//return (stbType.indexOf('EC6108') != -1 || stbType.indexOf('HG680') != -1 || stbType.indexOf('EC2106') != -1 || stbType.indexOf('EC2108') != -1);
	}
	//dom("test").innerHTML = dom("test").innerHTML + "<br/> stbType:" + stbType + "-----stbIsNeedAdapt:" + stbIsNeedAdapt() + "--------------<%=STBKeysNew.remoteMenu%>";
    //dom("test").innerHTML ="UserModel="+ "<%=reqFrame%>";
	
</script>
</html>