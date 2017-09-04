<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.zte.iptv.epg.util.*" %>
<%@page import="com.zte.iptv.epg.account.UserInfo" %>
<%!
	 /**
         *通过http绝对路径获取frame号
         * @param reqURI  请求绝对路径 http://
         * @return framexxxx
         */
    String getHTTPFrameCode1(String reqURI) {
        int start = reqURI.indexOf("frame");
        int end = reqURI.indexOf("/", start);
        return reqURI.substring(start, end);
    }
%>
<%
	String reqFrame1 = getHTTPFrameCode1(request.getRequestURI());
	String requestURL1 = request.getRequestURL().toString();
	String appUrl1 = requestURL1.substring(0, requestURL1.indexOf("frame"));
	String frameUrl1 = appUrl1 + reqFrame1; 
	UserInfo userInfo11 = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
%>
<div style="position: absolute;left: 65px;top:170px;width: 1280px;height: 510px;display: none;" id="my">
    <%
        for(int i=0;i<10;i++){
            int row = i / 5;
            int col = i % 5;
    %>
    <div style="position: absolute;left:<%=col*229%>px;top:<%=229*row%>px;width: 219px;height: 219px;" id="mydiv<%=i%>">
        <div>
            <img src="images/btn_trans.gif" id="myimg<%=i%>" width="219" height="219">
            <font id="myName_<%=i%>"
                  style="position:absolute; width: 219px; height: 37px; font-size:30px; left: 0px; top: 163px; color: #fff;text-align: center;"></font>

        </div>
        <div style="position: absolute;left:-17px;top:-17px;width: 254px;height: 171px;visibility: hidden;"
             id="myfocus<%=i%>">
            <img src="images/portal/my/f1.png"  >
        </div>
    </div>
    <%
        }
    %>


</div>
<script type="text/javascript">
    function returnMyObj() {
        this.objArray = myJSON;
        this.timer=null;
        this.posterIndex = 0;
        this.left = function () {
			try{
				if (myObj.posterIndex ==0||myObj.posterIndex ==5) {
					return;
				}
				myObj.posterblur();
				clearTimeout(myObj.timer);
				myObj.posterIndex--;
	//            myObj.posterfocus();
				myObj.timer=setTimeout(function(){
					myObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalyingyong left:' + e.message;
			}
        }
        this.right = function () {
			try{
				if (myObj.posterIndex ==4||myObj.posterIndex ==9) {
					return;
				}
				myObj.posterblur();
				clearTimeout(myObj.timer);
				myObj.posterIndex++;
	//            myObj.posterfocus();
				myObj.timer=setTimeout(function(){
					myObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalyingyong right:' + e.message;
			}
        }
        this.down = function () {
			try{
				if (myObj.posterIndex>4 ) {
					return;
				}
				myObj.posterblur();
				clearTimeout(myObj.timer);
				myObj.posterIndex+=5;
	//            myObj.posterfocus();
				myObj.timer=setTimeout(function(){
					myObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalyingyong down:' + e.message;
			}
        }
        this.up = function () {
			try{
				myObj.posterblur();
				if (myObj.posterIndex <5) {
	//               setTimeout(function(){
					   dom("navigation").style.visibility="visible";
					   clearTimeout(myObj.timer);
					   areaFlag = 0;
					   myObj.posterblur();
	//               },300);
					return;
				}
				clearTimeout(myObj.timer);
				myObj.posterIndex-=5;
	//            myObj.posterfocus();
				myObj.timer=setTimeout(function(){
					myObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalyingyong up:' + e.message;
			}
        }
        this.ok = function () {
			try{
				var leefocus=areaFlag+"|"+navigationObj.posterIndex+"|"+myObj.posterIndex;
				var url=myObj.objArray[myObj.posterIndex].linkURL;
				var subname=myObj.objArray[myObj.posterIndex].subname;
				if(url==""){
					return;
				}
				if(subname == '3'){
					var backUrl = '<%=requestURL1%>?lastfocus='+leefocus;
					var epg_info = '<server_ip><%=appUrl1%></server_ip><group_name><%=userInfo11.getUserGrpId()%></group_name><group_path>/iptvepg/<%=framecode11%></group_path><oss_user_id><%=userInfo11.getUserId()%></oss_user_id><page_url>'+backUrl+'</page_url><partner>YSZTE2X</partner><area><%=userInfo11.getAreaNo()%></area>';
					if(url.indexOf("?")>-1){
						url += '&epg_info='+epg_info;
					}else{
						url += '?epg_info='+epg_info;
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
					dom("myimg" +i).src=myObj.objArray[i].images;
					dom("myName_"+i).innerText=myObj.objArray[i].name;
				}
			}catch(e){
				dom('test').innerHTML = 'portalyingyong showObj:' + e.message;
			}
        }
        this.posterfocus = function () {
			try{
                dom("myfocus" + myObj.posterIndex).style.visibility = "visible";
				if(isscale){
					dom("mydiv" + myObj.posterIndex).style.webkitTransform="scale(1.1)";
				}
                dom("mydiv" + myObj.posterIndex).style.zIndex = 99;
			}catch(e){
				dom('test').innerHTML = 'portalyingyong posterfocus:' + e.message;
			}
        }
        this.posterblur = function () {
			try{
				dom("myfocus" + myObj.posterIndex).style.visibility = "hidden";
				if(isscale){
					dom("mydiv" + myObj.posterIndex).style.webkitTransform="scale(1)";
				}
				dom("mydiv" + myObj.posterIndex).style.zIndex = 1;
			}catch(e){
				dom('test').innerHTML = 'portalyingyong posterblur:' + e.message;
			}
        }
    }

</script>
