<%@ page contentType="text/html; charset=UTF-8" %>
<%
	UserInfo userInfoVod = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
	String userId_vod = userInfoVod.getUserId();
%>
<div style="position: absolute;left: 0px;top:135px;width: 1280px;height: 560px;overflow: hidden;">
    <div style="position: absolute;left:80px;top:40px;width: 2560px;height: 460px;display: none;" id="vod" >
        <div style="position: absolute;left:-2px;top:0px;width: 295px;height: 467px;" id="voddiv0">
            <div>
                <img src="images/btn_trans.gif" id="vodimg0">
                <font id="vodName_0"
                      style="position:absolute; width: 100px; height: 37px; font-size:30px; left: 167px; top: 382px; line-height:37px;color: #fff;">电影</font>

            </div>
            <div style="position: absolute;left:-17px;top:-16px;width: 254px;height: 171px;visibility: hidden;" id="vodfocus0">
                <img src="images/portal/vod/f0.png" >
            </div>
        </div>
        <div style="position: absolute;left:306px;top:0px;width: 361px;height: 226px;" id="voddiv1">
            <div>
                <img src="images/btn_trans.gif" id="vodimg1">
                <font id="vodName_1"
                      style="position:absolute; width: 100px; height: 37px; font-size:30px; left: 218px; top: 155px; color: #fff;">电影</font>
            </div>
            <div style="position: absolute;left:-17px;top:-17px;width: 361px;height: 226px;visibility: hidden;" id="vodfocus1">
                <img src="images/portal/vod/f1.png" >
            </div>
        </div>
        <div style="position: absolute;left:680px;top:0px;width: 229px;height: 227px;" id="voddiv2">
            <div>
                <img src="images/btn_trans.gif" id="vodimg2">
                <font id="vodName_2"
                      style="position:absolute; width: 229px; height: 37px; font-size:30px; left: 0px; top: 155px; color: #fff;text-align: center;">新闻</font>

            </div>
            <div style="position: absolute;left:-17px;top:-17px;width: 229px;height: 227px;visibility: hidden;" id="vodfocus2">
                <img src="images/portal/vod/f3.png" >
            </div>
        </div>
        <div style="position: absolute;left:921px;top:0px;width: 361px;height: 226px;" id="voddiv3">
            <div>
                <img src="images/btn_trans.gif" id="vodimg3">
                <font id="vodName_3"
                      style="position:absolute; width: 100px; height: 37px; font-size:30px; left: 249px; top: 155px; color: #fff;">体育</font>

            </div>
            <div style="position: absolute;left:-17px;top:-17px;width: 361px;height: 226px;visibility: hidden;" id="vodfocus3">
                <img src="images/portal/vod/f1.png" >
            </div>
        </div>
        <div style="position: absolute;left:1294px;top:0px;width: 229px;height: 227px;" id="voddiv4">
            <div>
                <img src="images/btn_trans.gif" id="vodimg4">
                <font id="vodName_4"
                      style="position:absolute; width: 229px; height: 37px; font-size:30px; left: 0px; top: 155px; color: #fff;text-align: center;">记录片</font>

            </div>
            <div style="position: absolute;left:-17px;top:-17px;width: 229px;height: 227px;visibility: hidden;" id="vodfocus4">
                <img src="images/portal/vod/f3.png" >
            </div>
        </div>
        <div style="position: absolute;left:1535px;top:0px;width: 229px;height: 227px;" id="voddiv5">
            <div>
                <img src="images/btn_trans.gif" id="vodimg5">
                <font id="vodName_5"
                      style="position:absolute; width: 229px; height: 37px; font-size:30px; left: 0px; top: 155px; color: #fff;text-align: center;">记录片</font>

            </div>
            <div style="position: absolute;left:-17px;top:-17px;width: 229px;height: 227px;visibility: hidden;" id="vodfocus5">
                <img src="images/portal/vod/f3.png" >
            </div>
        </div>
        <div style="position: absolute;left:1776px;top:0px;width: 229px;height: 227px;" id="voddiv6">
            <div>
                <img src="images/btn_trans.gif" id="vodimg6">
                <font id="vodName_6"
                      style="position:absolute; width: 229px; height: 37px; font-size:30px; left: 0px; top: 155px; color: #fff;text-align: center;">记录片</font>

            </div>
            <div style="position: absolute;left:-17px;top:-17px;width: 229px;height: 227px;visibility: hidden;" id="vodfocus6">
                <img src="images/portal/vod/f3.png" >
            </div>
        </div>

        <div style="position: absolute;left:306px;top:239px;width: 361px;height: 226px;" id="voddiv7">
            <div>
                <img src="images/btn_trans.gif" id="vodimg7">
                <font id="vodName_7"
                      style="position:absolute; width: 100px; height: 37px; font-size:30px; left: 65px; top: 155px; color: #fff;">电影</font>

            </div>
            <div style="position: absolute;left:-17px;top:-17px;width: 361px;height: 226px;visibility: hidden;" id="vodfocus7">
                <img src="images/portal/vod/f1.png" >
            </div>
        </div>
        <div style="position: absolute;left:680px;top:239px;width: 229px;height: 227px;" id="voddiv8">
            <div>
                <img src="images/btn_trans.gif" id="vodimg8">
                <font id="vodName_8"
                      style="position:absolute; width: 229px; height: 37px; font-size:30px; left: 0px; top: 155px; color: #fff;text-align: center;">新闻</font>

            </div>
            <div style="position: absolute;left:-17px;top:-17px;width: 229px;height: 227px;visibility: hidden;" id="vodfocus8">
                <img src="images/portal/vod/f3.png" >
            </div>
        </div>
        <div style="position: absolute;left:921px;top:239px;width: 361px;height: 230px;" id="voddiv9">
            <div>
                <img src="images/btn_trans.gif" id="vodimg9">
                <font id="vodName_9"
                      style="position:absolute; width: 100px; height: 37px; font-size:30px; left: 65px; top: 155px; color: #fff;">体育</font>

            </div>
            <div style="position: absolute;left:-17px;top:-17px;width: 361px;height: 230px;visibility: hidden;" id="vodfocus9">
                <img src="images/portal/vod/f1.png" >
            </div>
        </div>
        <div style="position: absolute;left:1294px;top:239px;width: 229px;height: 227px;" id="voddiv10">
            <div>
                <img src="images/btn_trans.gif" id="vodimg10">
                <font id="vodName_10"
                      style="position:absolute; width: 229px; height: 37px; font-size:30px; left: 0px; top: 155px; color: #fff;text-align: center;">记录片</font>

            </div>
            <div style="position: absolute;left:-17px;top:-17px;width: 229px;height: 227px;visibility: hidden;" id="vodfocus10">
                <img src="images/portal/vod/f3.png" >
            </div>
        </div>
        <div style="position: absolute;left:1535px;top:239px;width: 229px;height: 227px;" id="voddiv11">
            <div>
                <img src="images/btn_trans.gif" id="vodimg11">
                <font id="vodName_11"
                      style="position:absolute; width: 229px; height: 37px; font-size:30px; left: 0px; top: 155px; color: #fff;text-align: center;">记录片</font>

            </div>
            <div style="position: absolute;left:-17px;top:-17px;width: 229px;height: 227px;visibility: hidden;" id="vodfocus11">
                <img src="images/portal/vod/f3.png" >
            </div>
        </div>
        <div style="position: absolute;left:1776px;top:239px;width: 229px;height: 227px;" id="voddiv12">
            <div>
                <img src="images/btn_trans.gif" id="vodimg12">
                <font id="vodName_12"
                      style="position:absolute; width: 229px; height: 37px; font-size:30px; left: 0px; top: 155px; color: #fff;text-align: center;">记录片</font>

            </div>
            <div style="position: absolute;left:-17px;top:-17px;width: 229px;height: 227px;visibility: hidden;" id="vodfocus12">
                <img src="images/portal/vod/f3.png" >
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function returnVodObj() {
        this.objArray = vodJSON;
        this.posterIndex = 0;
        this.timer=null;
        this.left = function () {
			try{
				if (vodObj.posterIndex == 0) {
					return;
				}
				vodObj.posterblur();
				clearTimeout(vodObj.timer);
				if (vodObj.posterIndex == 7) {
					vodObj.posterIndex = 0;
				} else {
					vodObj.posterIndex--;
				}
	
				if (vodObj.posterIndex == 2 || vodObj.posterIndex == 8) {
					dom("vod").style.left = 80 + "px";
				}
	//            this.posterfocus();
				vodObj.timer=setTimeout(function(){
					vodObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalvod left:' + e.message;
			}
        }
        this.right = function () {
			try{
				if (vodObj.posterIndex == 6 || vodObj.posterIndex == 12) {
					return;
				}
				vodObj.posterblur();
				clearTimeout(vodObj.timer);
				vodObj.posterIndex++;
				if (vodObj.posterIndex == 3 || vodObj.posterIndex == 9) {
					dom("vod").style.left = -800 + "px";
				}
	//            this.posterfocus();
				vodObj.timer=setTimeout(function(){
					vodObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalvod right:' + e.message;
			}
        }
        this.down = function () {
			try{
				if ((vodObj.posterIndex == 0 ) || vodObj.posterIndex > 6) {
					return;
				}
				vodObj.posterblur();
				clearTimeout(vodObj.timer);
				vodObj.posterIndex += 6;
	//            this.posterfocus();
				vodObj.timer=setTimeout(function(){
					vodObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalvod down:' + e.message;
			}
        }
        this.up = function () {
			try{
				if (vodObj.posterIndex < 7) {
	//               setTimeout(function(){
					clearTimeout(vodObj.timer);
					   areaFlag = 0;
					   vodObj.posterblur();
					   dom("navigation").style.visibility="visible";
	//               },300);
					return;
				}
				vodObj.posterblur();
				clearTimeout(vodObj.timer);
				vodObj.posterIndex -= 6;
	//            vodObj.posterfocus();
				vodObj.timer=setTimeout(function(){
					vodObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalvod up:' + e.message;
			}
        }
        this.ok = function () {
			try{
				var leefocus=areaFlag+"|"+navigationObj.posterIndex+"|"+vodObj.posterIndex;
				var url=vodObj.objArray[vodObj.posterIndex].linkURL;
				var urls=url.split("=");
				if(urls.length > 0){
					var firstcatid=urls[1];
					var firstcatname=vodObj.objArray[vodObj.posterIndex].name;
				}
				if(url==""){
					return;
				}
				if(url.indexOf("?")>-1){
					url=url+"&leefocus="+leefocus;
				}else{
					url=url+"?leefocus="+leefocus;
				}
			    document.location=url;
			}catch(e){
				dom('test').innerHTML = 'portalvod ok:' + e.message;
			}
        }
        this.showObj = function () {
			try{
				for(var i=0;i<13;i++){
					dom("vodimg" +i).src=vodObj.objArray[i].images;
					dom("vodName_"+i).innerText=vodObj.objArray[i].name;
				}
			}catch(e){
				dom('test').innerHTML = 'portalvod showObj:' + e.message;
			}
        }
        this.posterfocus = function () {
			try{
				dom("vodfocus" + vodObj.posterIndex).style.visibility = "visible";
				if(isscale){
					dom("voddiv" + vodObj.posterIndex).style.webkitTransform="scale(1.1)";
				}
				dom("voddiv" + vodObj.posterIndex).style.zIndex = 99;
			}catch(e){
				dom('test').innerHTML = 'portalvod posterfocus:' + e.message;
			}
        }
        this.posterblur = function () {
			try{
				dom("vodfocus" + vodObj.posterIndex).style.visibility = "hidden";
				if(isscale){
					dom("voddiv" + vodObj.posterIndex).style.webkitTransform="scale(1)";
				}
				dom("voddiv" + vodObj.posterIndex).style.zIndex = 1;
			}catch(e){
				dom('test').innerHTML = 'portalvod posterblur:' + e.message;
			}
        }

    }
</script>
