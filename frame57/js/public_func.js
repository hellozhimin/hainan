function formatText(text,num)
{
	var textlength = strlenEn(text);
	if(textlength>num)
	{
		return text.substring(0,num-2)+"...";
	}
	return text;
}

function formatChannel(mixno)
{
	if(mixno>-1&&mixno<10)
	{
		return "00"+mixno;
	}
	else if(mixno>=10&&mixno<100)
	{
		return "0"+mixno;
	}
	else
	{
		return mixno;
	}
}
function formatDate(datetime)
{
	var y = datetime.getFullYear();
	var m = formatZero(datetime.getMonth()+1);
	var d = formatZero(datetime.getDate());
	var h = formatZero(datetime.getHours());
	var im = formatZero(datetime.getMinutes());
	var s = formatZero(datetime.getSeconds());
	var weekDay =  datetime.getDay();
	return y+"."+m+"."+d+" "+h+":"+im+":"+s;
}
function formatZero(num)
{
	if(num<10)
	{
		return "0"+num
	}
	return num;
}

function returnTime(y,m,d,h,im,s)
{
	var thetime = new Date();
	thetime.setFullYear(y, m-1, d);
	thetime.setHours(h, im, s);
	return thetime;
}
function onblurText(colname,rowid,text,num){
	var marid= colname + rowid;
    var divElement = document.getElementById(marid);
    var textlength = strlenEn(text);
    if(divElement == null){
      return;
    }
    var curwidth = 0;
    for (var i = 0; i < textlength; i++) {
        if (text.charCodeAt(i) > 255) { // zhong
            curwidth = curwidth + 2;
        } else {                     //yin
            curwidth = curwidth + 1;
        }
        if (curwidth >= num) {
            break;
        }
    }
    if(i<textlength-1)
    {
        text = text.substring(0,i)+"...";
    }
  /*  if(textlength>num)
	{
    	text = text.substring(0,num-2)+"...";
	}*/
    var scrollText =  text ;
    divElement.innerHTML = scrollText;
}

function onfocusText(colname,rowid,text,num){
	var marid= colname + rowid;
    var divElement = document.getElementById(marid);
    var textlength = strlenEn(text);
    if(divElement == null){
      return;
    }
    if(textlength > num)
    {
    	var scrollText = "<marquee version='3' scrolldelay='250' >" + text + "</marquee>";
    	divElement.innerHTML = scrollText;
    }
}
function strlenEn(str)
{
	if(!str)return 0;
    return str.length;
}
function strlen(str)
{
    if(!str)return 0;
    var matchArr = str.match(/[^\u0000-\u00FF]/g);
    if(!matchArr) return str.length;
    return str.length+matchArr.length;
}

function strLengthCn(str){
    if(!str)return 0;
    var matchArr = str.match(/[^\u0000-\u00FF]/g);
    if(!matchArr) return 0;
    return matchArr.length;
}

function pxtosize(px) {
    var size = 4;
    if (px == 50) {
        size = 7;
    } else if (px == 29 ||px == 30) {
        size = 6;
    } else if (px == 22) {
        size = 5;
    } else if (px == 18) {
        size = 4;
    } else if (px == 16) {
        size = 3;
    } else if (px == 15) {
        size = 2;
    } else if (px == 10) {
        size = 1;
    }
    return size;
}
