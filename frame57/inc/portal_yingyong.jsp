<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.zte.iptv.epg.util.*" %>
<%@page import="com.zte.iptv.epg.account.UserInfo" %>
<%!
	 /**
         *通过http绝对路径获取frame号
         * @param reqURI  请求绝对路径 http://
         * @return framexxxx
         */
    String getHTTPFrameCode2(String reqURI) {
        int start = reqURI.indexOf("frame");
        int end = reqURI.indexOf("/", start);
        return reqURI.substring(start, end);
    }
%>
<%
	String reqFrame2 = getHTTPFrameCode2(request.getRequestURI());
	String requestURL2 = request.getRequestURL().toString();
	String appUrl2 = requestURL2.substring(0, requestURL2.indexOf("frame"));
	String frameUrl2 = appUrl2 + reqFrame2; 
	UserInfo userInfo22 = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
%>
<div style="position: absolute;left: 65px;top:170px;width: 1280px;height: 510px;display: none;" id="yingyong">
    <%
        for(int i=0;i<10;i++){
            int row = i / 5;
            int col = i % 5;
    %>
    <div style="position: absolute;left:<%=col*229%>px;top:<%=229*row%>px;width: 219px;height: 219px;" id="yingyongdiv<%=i%>">
        <div>
            <img src="images/btn_trans.gif" id="yingyongimg<%=i%>" width="219" height="219">
            <font id="yingyongName_<%=i%>"
                  style="position:absolute; width: 219px; height: 37px; font-size:30px; left: 0px; top: 163px; color: #fff;text-align: center;">记录片</font>

        </div>
        <div style="position: absolute;left:-17px;top:-17px;width: 254px;height: 171px;visibility: hidden;"
             id="yingyongfocus<%=i%>"><div>
                <img src="images/portal/my/f1.png" id="yingyongfocusimg" >
            </div>
        </div>
    </div>
    <%
        }
    %>


</div>
<script type="text/javascript">
    function returnYingyongObj() {
        this.objArray = yingyongJSON;
        this.posterIndex = 0;
        this.timer=null;
        this.left = function () {
			try{
				if (yingyongObj.posterIndex ==0||yingyongObj.posterIndex ==5) {
					return;
				}
				yingyongObj.posterblur();
				clearTimeout(yingyongObj.timer);
				yingyongObj.posterIndex--;
				yingyongObj.timer=setTimeout(function(){
					yingyongObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalyingyong left:' + e.message;
			}
        }
        this.right = function () {
			try{
				if (yingyongObj.posterIndex ==4||yingyongObj.posterIndex ==9) {
					return;
				}
				yingyongObj.posterblur();
				clearTimeout(yingyongObj.timer);
				yingyongObj.posterIndex++;
				yingyongObj.timer=setTimeout(function(){
					yingyongObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalyingyong right:' + e.message;
			}
        }
        this.down = function () {
			try{
				if (yingyongObj.posterIndex>4 ) {
					return;
				}
				yingyongObj.posterblur();
				clearTimeout(yingyongObj.timer);
				yingyongObj.posterIndex+=5;
	//            yingyongObj.posterfocus();
				yingyongObj.timer=setTimeout(function(){
					yingyongObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalyingyong down:' + e.message;
			}
        }
        this.up = function () {
			try{
				yingyongObj.posterblur();
				if (yingyongObj.posterIndex <5) {
	//               setTimeout(function(){
					   dom("navigation").style.visibility="visible";
					clearTimeout(yingyongObj.timer);
					   areaFlag = 0;
					   yingyongObj.posterblur();
	//               },300);
					return;
				}
				clearTimeout(yingyongObj.timer);
				yingyongObj.posterIndex-=5;
	//            yingyongObj.posterfocus();
				yingyongObj.timer=setTimeout(function(){
					yingyongObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalyingyong up:' + e.message;
			}
        }
        this.ok = function () {
			try{
				var leefocus=areaFlag+"|"+navigationObj.posterIndex+"|"+yingyongObj.posterIndex;
				var url=yingyongObj.objArray[yingyongObj.posterIndex].linkURL;
				var subname=yingyongObj.objArray[yingyongObj.posterIndex].subname;
				if(url==""){
					return;
				}
				if(subname == '3'){
					var backUrl = '<%=requestURL2%>?lastfocus='+leefocus;
					var epg_info = '<server_ip><%=appUrl2%></server_ip><group_name><%=userInfo22.getUserGrpId()%></group_name><group_path>/iptvepg/<%=framecode11%></group_path><oss_user_id><%=userInfo22.getUserId()%></oss_user_id><page_url>'+backUrl+'</page_url><partner>YSZTE2X</partner><area><%=userInfo22.getAreaNo()%></area>';
					if(url.indexOf("?")>-1){
						url += '&epg_info='+epg_info+'&backUrl=';
					}else{
						url += '?epg_info='+epg_info+'&backUrl=';
					}
				}else{
					if(url.indexOf("?")>-1){
						url=url+"&leefocus="+leefocus;
					}else{
						url=url+"?leefocus="+leefocus;
					}
				}
				document.location=url;
			}catch(e){
				dom('test').innerHTML = 'portalyingyong ok:' + e.message;
			}
        }
        this.showObj = function () {
			try{
				for(var i=0;i<10;i++){
					dom("yingyongimg" +i).src=yingyongObj.objArray[i].images;
					dom("yingyongName_"+i).innerText=yingyongObj.objArray[i].name;
				}
			}catch(e){
				dom('test').innerHTML = 'portalyingyong showObj:' + e.message;
			}
        }
        this.posterfocus = function () {
			try{
                dom("yingyongfocus" + yingyongObj.posterIndex).style.visibility = "visible";
				if(isscale){
					dom("yingyongdiv" + yingyongObj.posterIndex).style.webkitTransform="scale(1.1)";
				}
                dom("yingyongdiv" + yingyongObj.posterIndex).style.zIndex = 99;
			}catch(e){
				dom('test').innerHTML = 'portalyingyong posterfocus:' + e.message;
			}
        }
        this.posterblur = function () {
			try{
				dom("yingyongfocus" + yingyongObj.posterIndex).style.visibility = "hidden";
				if(isscale){
					dom("yingyongdiv" + yingyongObj.posterIndex).style.webkitTransform="scale(1)";
				}
				dom("yingyongdiv" + yingyongObj.posterIndex).style.zIndex = 1;
			}catch(e){
				dom('test').innerHTML = 'portalyingyong posterblur:' + e.message;
			}
        }
    }

</script>
