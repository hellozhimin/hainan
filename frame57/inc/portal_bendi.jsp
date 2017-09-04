<%@ page contentType="text/html; charset=UTF-8" %>
<div style="position: absolute;left: 56px;top:160px;width: 1280px;height: 510px;display: none;" id="bendi">
    <%
        for (int i = 0; i < 8; i++) {
            int row = i / 2;
            int col = i % 2;
    %>
    <div style="position: absolute;left:<%=col*150%>px;top:<%=87*row%>px;width: 143px;height: 80px;"
         id="bendidiv<%=i%>">
        <div>
            <img src="images/btn_trans.gif" id="bendiimg<%=i%>" width="143" height="80">
            <font id="bendiName_<%=i%>"
                  style="position:absolute; width: 143px; height: 80px; font-size:25px; left: 0px; top: 0px; color: #fff;text-align: center;line-height: 80px;">记录片</font>

        </div>
    </div>
    <%
        }
    %>
    <div style="position: absolute;left:303px;top:0px;width: 599px;height: 342px;" id="bendidiv8">
        <div style="position: absolute;left:0px;top:0px;width: 596px;height: 334px;">
            <img src="images/btn_trans.gif" id="bendiimg8" width="596" height="334">
            <img src="images/portal/bendi/centerfloot.png"
                 style="position: absolute;left:0px;top:293px;width: 599px;height: 49px;">
            <font id="bendiName_8"
                  style="position:absolute; width: 500px; height: 49px; font-size:28px; left: 18px; top: 293px; line-height:49px;color: #fff;" class="font_ellipsis"></font>
        </div>
    </div>
    <div style="position: absolute;left:912px;top:0px;width: 252px;height: 157px;" id="bendidiv9">
        <div style="position: absolute;left:0px;top:0px;width: 252px;height: 167px;">
            <img src="images/btn_trans.gif" id="bendiimg9" width="252" height="167">
            <img src="images/portal/bendi/rightfloot.png"
                 style="position: absolute;left:0px;top:135px;width: 252px;height: 32px;">
            <font id="bendiName_9"
                  style="position:absolute; width: 233px; height: 32px; font-size:22px; left: 18px; top: 135px; line-height:32px;color: #fff;" class="font_ellipsis"></font>
        </div>
    </div>
    <div style="position: absolute;left:912px;top:175px;width: 252px;height: 167px;" id="bendidiv10">
        <div style="position: absolute;left:0px;top:0px;width: 252px;height: 167px;">
            <img src="images/btn_trans.gif" id="bendiimg10" width="252" height="167">
            <img src="images/portal/bendi/rightfloot.png"
                 style="position: absolute;left:0px;top:135px;width: 252px;height: 32px;">
            <font id="bendiName_10"
                  style="position:absolute; width: 233px; height: 32px; font-size:22px; left: 18px; top: 135px; line-height:32px;color: #fff;" class="font_ellipsis"></font>
        </div>
    </div>
    <%
        for (int j = 0; j < 3; j++) {
    %>
    <div style="position: absolute;left:<%=j*305%>px;top:352px;width: 293px;height: 154px;" id="bendidiv<%=11+j%>">
        <div style="position: absolute;left:0px;top:0px;width: 293;height: 154px;">
            <img src="images/btn_trans.gif" id="bendiimg<%=11+j%>" width="293" height="154">
            <img src="images/portal/bendi/btufloot.png"
                 style="position: absolute;left:0px;top:119px;width: 293px;height: 35px;">
            <font id="bendiName_<%=11+j%>"
                  style="position:absolute; width: 274px; height: 35px; font-size:22px; left: 18px; top: 119px; line-height:35px;color: #fff;" class="font_ellipsis"></font>
        </div>
    </div>
    <%
        }
    %>
    <div style="position: absolute;left:912px;top:352px;width: 252px;height: 154px;" id="bendidiv14">
        <div style="position: absolute;left:0px;top:0px;width: 252;height: 154px;">
            <img src="images/btn_trans.gif" id="bendiimg14" width="252" height="154">
            <img src="images/portal/bendi/btufloot.png"
                 style="position: absolute;left:0px;top:119px;width: 252px;height: 35px;">
            <font id="bendiName_14"
                  style="position:absolute; width: 233px; height: 35px; font-size:22px; left: 18px; top: 119px; line-height:35px;color: #fff;" class="font_ellipsis"></font>
        </div>
    </div>
    <div style="position: absolute;left:-19px;top:-20px;width: 254px;height: 171px;visibility: hidden;"
         id="bendifocus">
        <img src="images/portal/bendi/f0.png" id="bendifocusimg">
    </div>
</div>
<script type="text/javascript">
    function returnBendiObj() {
        this.objArray = bendiJSON;
        this.posterIndex = 0;
        this.timer=null;
        this.left = function () {
			try{
				if (bendiObj.posterIndex == 2 || bendiObj.posterIndex == 0 || bendiObj.posterIndex == 4 || bendiObj.posterIndex == 6 || bendiObj.posterIndex == 11) {
					return;
				}
				bendiObj.posterblur();
				clearTimeout(bendiObj.timer);
				if (bendiObj.posterIndex == 9 || bendiObj.posterIndex == 10) {
					bendiObj.posterIndex = 8;
				} else if (bendiObj.posterIndex == 8) {
					bendiObj.posterIndex = 1;
				} else {
					bendiObj.posterIndex--;
				}
				bendiObj.timer=setTimeout(function(){
					bendiObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalbendi left:' + e.message;
			}
        }
        this.right = function () {
			try{
				if (bendiObj.posterIndex == 9 || bendiObj.posterIndex == 10 || bendiObj.posterIndex == 14) {
					return;
				}
				bendiObj.posterblur();
				clearTimeout(bendiObj.timer);
				if (bendiObj.posterIndex == 1 || bendiObj.posterIndex == 3 || bendiObj.posterIndex == 5 || bendiObj.posterIndex == 7) {
					bendiObj.posterIndex = 8;
				} else {
					bendiObj.posterIndex++;
				}
				bendiObj.timer=setTimeout(function(){
					bendiObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalbendi right:' + e.message;
			}
        }
        this.down = function () {
			try{
				if (bendiObj.posterIndex > 10) {
					return;
				}
				bendiObj.posterblur();
				clearTimeout(bendiObj.timer);
				if ((bendiObj.posterIndex > 5 && bendiObj.posterIndex < 9)) {
	//            alert("======down========="+bendiObj.posterIndex);
					bendiObj.posterIndex+= 5;
				} else if (bendiObj.posterIndex == 10) {
					bendiObj.posterIndex = 14;
				} else if (bendiObj.posterIndex == 9) {
					bendiObj.posterIndex = 10;
				} else {
					bendiObj.posterIndex+= 2;
				}
				bendiObj.timer=setTimeout(function(){
					bendiObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalbendi down:' + e.message;
			}
        }
        this.up = function () {
			try{
				if (bendiObj.posterIndex == 0 || bendiObj.posterIndex == 1 || bendiObj.posterIndex == 8 || bendiObj.posterIndex == 9) {
	//               setTimeout(function(){
					  clearTimeout(bendiObj.timer);
					   areaFlag = 0;
					   bendiObj.posterblur();
					   dom("navigation").style.visibility="visible";
	//               },300);
					return;
				}
				bendiObj.posterblur();
				clearTimeout(bendiObj.timer);
				if ((bendiObj.posterIndex > 10 && bendiObj.posterIndex < 14)) {
					bendiObj.posterIndex -= 5;
				} else if (bendiObj.posterIndex == 14) {
					bendiObj.posterIndex = 10;
				} else if (bendiObj.posterIndex == 10) {
					bendiObj.posterIndex = 9;
				} else {
					bendiObj.posterIndex -= 2;
				}
				bendiObj.timer=setTimeout(function(){
					bendiObj.posterfocus();
				},300);
			}catch(e){
				dom('test').innerHTML = 'portalbendi up:' + e.message;
			}
        }
        this.ok = function () {
			try{
				var leefocus = areaFlag + "|" + navigationObj.posterIndex + "|" + bendiObj.posterIndex;
				var url = bendiObj.objArray[bendiObj.posterIndex].linkURL;
				if (url == "") {
					return;
				}
				if (url.indexOf("?") > -1) {
					url = url + "&leefocus=" + leefocus;
				} else {
					url = url + "?leefocus=" + leefocus;
				}
				
			    document.location = url + '&d=' + new Date().getTime();
				dom('test').innerHTML = url + '&d=' + new Date().getTime();
			}catch(e){
				dom('test').innerHTML = 'portalbendi ok:' + e.message;
			}
        }
        //加载数据
        this.showObj = function () {
			try{
				for (var i = 0; i < 15; i++) {
	//            console.log("=====showObj======="+i);
					dom("bendiimg" + i).src = bendiObj.objArray[i].images;
	//                dom("bendiName_" + i).innerText = bendiObj.objArray[i].name;
					var divWidth = document.getElementById("bendiName_" +i).style.width;
	//                alert("===divWidth===="+divWidth);
					if(i==8){
						dom("bendiName_" + i).innerText =subStringFunction(bendiObj.objArray[i].name,1,(divWidth-40));
					}   else{
						stopScroll("bendiName_" +i,bendiObj.objArray[i].name);
					}
	
				}
			}catch(e){
				dom('test').innerHTML = 'portalbendi showObj:' + e.message;
			}
        }
        //图片获取焦点所执行的方法
        this.posterfocus = function () {
			try{
				if(bendiObj.posterIndex == 0){
					setTimeout(function(){
						 dom("bendifocus").style.visibility = "visible";
					},300);
				}else{
					 dom("bendifocus").style.visibility = "visible";
				}
				
				var leftdiv = dom("bendidiv" + bendiObj.posterIndex).style.left;
				var topdiv = dom("bendidiv" + bendiObj.posterIndex).style.top;
				dom("bendifocus").style.zIndex = 99;
				dom("bendidiv" + bendiObj.posterIndex).style.zIndex = 99;
				dom("bendifocus").style.left = -19 + parseInt(leftdiv, 10);
				dom("bendifocus").style.top = -20 + parseInt(topdiv, 10);
				if (bendiObj.posterIndex > -1 && bendiObj.posterIndex < 8) {
					dom("bendifocusimg").src = "images/portal/bendi/f0.png";
				} else if (bendiObj.posterIndex == 8) {
					dom("bendifocusimg").src = "images/portal/bendi/f2.png";
				} else if (bendiObj.posterIndex == 14) {
					dom("bendifocusimg").src = "images/portal/bendi/f5.png";
				} else if (bendiObj.posterIndex == 9 || bendiObj.posterIndex == 10) {
					dom("bendifocusimg").src = "images/portal/bendi/f1.png";
				} else {
					dom("bendifocusimg").src = "images/portal/bendi/f4.png";
				}
				if(bendiObj.objArray[bendiObj.posterIndex].name!=""){
					starScroll("bendiName_" + bendiObj.posterIndex,bendiObj.objArray[bendiObj.posterIndex].name,dom("bendidiv" + bendiObj.posterIndex).style.width);
				}
			}catch(e){
				dom('test').innerHTML = 'portalbendi posterfocus:' + e.message;
			}
        }
        // 图片失去焦点执行的方法
        this.posterblur = function () {
			try{
				dom("bendifocusimg").src = "images/btn_trans.gif";
				dom("bendidiv" + bendiObj.posterIndex).style.zIndex = 1;
				dom("bendifocus").style.visibility = "hidden";
				if(bendiObj.objArray.length==0) return;
				if(bendiObj.objArray[bendiObj.posterIndex].name!=""){
					if(bendiObj.posterIndex==8){
						dom("bendiName_" + bendiObj.posterIndex).innerText =subStringFunction(bendiObj.objArray[bendiObj.posterIndex].name,1,460);
					}   else{
						stopScroll("bendiName_" + bendiObj.posterIndex,bendiObj.objArray[bendiObj.posterIndex].name);
					}
				}
			}catch(e){
				dom('test').innerHTML = 'portalbendi posterblur:' + e.message;
			}
        }
    }

</script>
