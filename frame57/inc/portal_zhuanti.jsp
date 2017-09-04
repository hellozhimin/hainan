<%@ page contentType="text/html; charset=UTF-8" %>
<div style="position: absolute;left: 80px;top:170px;width: 1280px;height: 510px;display: none;" id="zhuanti">
    <div style="position: absolute;left:0px;top:0px;width: 424px;height: 173px;" id="zhuantidiv0">
        <div>
            <img src="images/btn_trans.gif" id="zhuantiimg0">
        </div>
        <div style="position: absolute;left:-16px;top:-17px;width: 424px;height: 173px;visibility: hidden;" id="zhuantifocus0">
            <img src="images/portal/zhuanti/f3.png" >
        </div>
    </div>
    <div style="position: absolute;left:433px;top:0px;width: 424px;height: 173px;" id="zhuantidiv1">
        <div>
            <img src="images/portal/zhuanti/2.png" id="zhuantiimg1">
        </div>
        <div style="position: absolute;left:-16px;top:-17px;width: 424px;height: 173px;visibility: hidden;" id="zhuantifocus1">
            <img src="images/portal/zhuanti/f3.png" >
        </div>
    </div>
    <div style="position: absolute;left:865px;top:0px;width: 218px;height: 173px;" id="zhuantidiv2">
        <div>
            <img src="images/portal/zhuanti/3.png" id="zhuantiimg2" width="218px" height="173px">
        </div>
        <div style="position: absolute;left:-17px;top:-14px;width: 218px;height: 173px;visibility: hidden;" id="zhuantifocus2">
            <img src="images/portal/zhuanti/f2.png"  width="250" height="200">
        </div>
    </div>
    <div style="position: absolute;left:0px;top:182px;width: 178px;height: 144px;" id="zhuantidiv3">
        <div>
            <img src="images/portal/zhuanti/4.png" id="zhuantiimg3" >
        </div>
        <div style="position: absolute;left:-17px;top:-17px;width: 178px;height: 144px;visibility: hidden;" id="zhuantifocus3">
            <img src="images/portal/zhuanti/f1.png">
        </div>
    </div>
    <div style="position: absolute;left:188px;top:182px;width: 351px;height: 144px;" id="zhuantidiv4">
        <div>
            <img src="images/portal/zhuanti/5.png" id="zhuantiimg4" >
        </div>
        <div style="position: absolute;left:-17px;top:-17px;width: 351px;height: 144px;visibility: hidden;" id="zhuantifocus4">
            <img src="images/portal/zhuanti/f0.png" >
        </div>
    </div>
    <div style="position: absolute;left:547px;top:182px;width: 536px;height: 297px;" id="zhuantidiv5">
        <div>
            <img src="images/portal/zhuanti/6.png" id="zhuantiimg5" >
        </div>
        <div style="position: absolute;left:-16px;top:-15px;width: 536px;height: 297px;visibility: hidden;" id="zhuantifocus5">
            <img src="images/portal/zhuanti/f4.png" >
        </div>
    </div>
    <div style="position: absolute;left:0px;top:335px;width: 178px;height: 144px;" id="zhuantidiv6">
        <div>
            <img src="images/portal/zhuanti/7.png" id="zhuantiimg6" >
        </div>
        <div style="position: absolute;left:-17px;top:-17px;width: 178px;height: 144px;visibility: hidden;" id="zhuantifocus6">
            <img src="images/portal/zhuanti/f1.png" >
        </div>
    </div>
    <div style="position: absolute;left:188px;top:335px;width: 351px;height: 144px;" id="zhuantidiv7">
        <div>
            <img src="images/portal/zhuanti/8.png" id="zhuantiimg7" >
        </div>
        <div style="position: absolute;left:-17px;top:-17px;width: 351px;height: 144px;visibility: hidden;" id="zhuantifocus7">
            <img src="images/portal/zhuanti/f0.png" >
        </div>
    </div>
    <%--<div style="position: absolute;left:-17px;top:-17px;width: 254px;height: 171px;visibility: hidden;"--%>
         <%--id="zhuantifocus">--%>
        <%--<img src="images/portal/zhuanti/f3.png" id="zhuantifocusimg" class="imgStyle0">--%>
    <%--</div>--%>
</div>
<script type="text/javascript">
    function returnZhuantiObj() {
        this.objArray = zhuantiJSON;
        this.posterIndex = 0;
        this.timer=null;
        this.left = function () {
            if (this.posterIndex ==0||this.posterIndex ==3||this.posterIndex ==6) {
                return;
            }
            this.posterblur();
            clearTimeout(this.timer);
            this.posterIndex--;
//            this.posterfocus();
            this.timer=setTimeout(function(){
                zhuantiObj.posterfocus();
            },300);
        }
        this.right = function () {
            if (this.posterIndex ==2||this.posterIndex ==5) {
                return;
            }
            this.posterblur();
            clearTimeout(this.timer);
            if(this.posterIndex ==7){
                this.posterIndex=5;
            } else{
                this.posterIndex++;
            }
            this.timer=setTimeout(function(){
                zhuantiObj.posterfocus();
            },300);
//            this.posterfocus();
        }
        this.down = function () {
            if (this.posterIndex>4 ) {
                return;
            }
            this.posterblur();
            clearTimeout(this.timer);
            this.posterIndex+=3;
//            this.posterfocus();
            this.timer=setTimeout(function(){
                zhuantiObj.posterfocus();
            },300);
        }
        this.up = function () {
            if (this.posterIndex <3) {
//               setTimeout(function(){
                clearTimeout(this.timer);
                   areaFlag = 0;
                   zhuantiObj.posterblur();
                   dom("navigation").style.visibility="visible";
//               },300);
                return;
            }
            this.posterblur();
            clearTimeout(this.timer);
            this.posterIndex-=3;
//            this.posterfocus();
            this.timer=setTimeout(function(){
                zhuantiObj.posterfocus();
            },300);
        }
        this.ok = function () {
            var leefocus=areaFlag+"|"+navigationObj.posterIndex+"|"+this.posterIndex;
            var url=this.objArray[this.posterIndex].linkURL;
            if(url==""){
                return;
            }
            if(url.indexOf("?")>-1){
                url=url+"&leefocus="+leefocus;
            }else{
                url=url+"?leefocus="+leefocus;
            }
            document.location=url;
        }
        this.showObj = function () {
            for(var i=0;i<8;i++){
                dom("zhuantiimg" +i).src=this.objArray[i].images;
            }
        }
        this.posterfocus = function () {
//            setTimeout(function(){
                dom("zhuantifocus" + zhuantiObj.posterIndex).style.visibility = "visible";
            if(isscale){
                dom("zhuantidiv" + zhuantiObj.posterIndex).style.webkitTransform="scale(1.1)";
            }
                dom("zhuantidiv" + zhuantiObj.posterIndex).style.zIndex = 99;
//            },300);
        }
        this.posterblur = function () {
            dom("zhuantifocus" + zhuantiObj.posterIndex).style.visibility = "hidden";
            if(isscale){
                dom("zhuantidiv" + zhuantiObj.posterIndex).style.webkitTransform="scale(1)";
            }
            dom("zhuantidiv" + this.posterIndex).style.zIndex = 1;
        }
    }
</script>
