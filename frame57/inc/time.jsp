<%@ page contentType="text/html; charset=UTF-8" %>
<div id="Date"
     style="left: 930px;  top:6px;width:350px;height:80px; position:absolute;visibility: visible;z-index: 9;line-height: 80px;color: #fff;font-size: 30px;">
</div>
<script type="text/javascript">
    function showClock() {
        var datatime = new Date();
        var  month = datatime.getMonth() + 1;
        var  day = datatime.getDate();
        var daytime = datatime.getDay();
        var hour = datatime.getHours();
        var minute = datatime.getMinutes();
        if (hour < 10) hour = "0" + hour;
        if (minute < 10) minute = "0" + minute;
        var strTime = hour + ":" + minute;
        var strDate = month + '月' + day + '日';
        document.getElementById("Date").innerHTML = strTime+"&nbsp;"+strDate+"&nbsp;"+showtime(daytime);
    }
    function showtime(time) {
        if (time == 0)         return "星期日"
        if (time == 1)         return "星期一"
        if (time == 2)         return "星期二"
        if (time == 3)         return "星期三"
        if (time == 4)         return "星期四"
        if (time == 5)         return "星期五"
        if (time == 6)         return "星期六"

    }
    setInterval('showClock()', 1000);

</script>
