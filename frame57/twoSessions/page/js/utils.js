function setCookie(name,value){
	var Days = 1;
	var exp = new Date();
	exp.setTime(exp.getTime() + Days*24*60*60*1000);
	document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

function getCookie(name){
	var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	if(arr=document.cookie.match(reg))
		return unescape(arr[2]);
	else
		return null;
}

function delCookie(name){
	var exp = new Date();
	exp.setTime(exp.getTime() - 1);
	var cval=getCookie(name);
	if(cval!=null)
	document.cookie= name + "="+cval+";expires="+exp.toGMTString();
}

function set_focus(name){
	var _pageObj = focus_logic.page;
	setCookie(name,_pageObj.curAreaIndex+"&"+_pageObj.areas[_pageObj.curAreaIndex].curDomIndex+"&"+_pageObj.areas[_pageObj.curAreaIndex].pageNumber);
}

function set_focus_ex(name){
	var _pageObj = focus_logic.page;
	var _AreaObj = _pageObj.areas[_pageObj.curAreaIndex];
	var _parent_focus_str = "&"+_AreaObj.parentAreaIndex+"&"+_pageObj.areas[_AreaObj.parentAreaIndex].curDomIndex+"&"+_pageObj.areas[_AreaObj.parentAreaIndex].pageNumber;
	if(_AreaObj.parentAreaIndex == undefined){
		_parent_focus_str = "&"+0+"&"+0+"&"+1;
	}
	setCookie(name,_pageObj.curAreaIndex+"&"+_AreaObj.curDomIndex+"&"+_AreaObj.pageNumber+_parent_focus_str);
}

function get_focus(name,default_focus){
	var _focusStr = getCookie(name);
	if(_focusStr != null){
		var _focusArr = _focusStr.split("&");
		var focusArr = new Array();
		focusArr.push(parseInt(_focusArr[0]));
		focusArr.push(parseInt(_focusArr[1]))
		focusArr.push(parseInt(_focusArr[2]))
		return focusArr;
	}else{
		if(default_focus==undefined){
			return [0,0,1];
		}else{
			return default_focus;
		}
	}
}

function get_focus_ex(name,default_focus){
	var _focusStr = getCookie(name);
	if(_focusStr != null){
		var _focusArr = _focusStr.split("&");
		var focusArr = new Array();
		focusArr.push(parseInt(_focusArr[0]));
		focusArr.push(parseInt(_focusArr[1]))
		focusArr.push(parseInt(_focusArr[2]))
		focusArr.push(parseInt(_focusArr[3]))
		focusArr.push(parseInt(_focusArr[4]))
		focusArr.push(parseInt(_focusArr[5]))
		return focusArr;
	}else{
		if(default_focus==undefined){
			return [0,0,1,0,0,1];
		}else{
			return default_focus;
		}
	}
}

function getParameter(parameter){
	var url=window.location.search;
	var intUrl = url.indexOf("?"); 
	var urlRight = url.substr(intUrl + 1); 
	var arrTmp = urlRight.split("&"); 
	for(var i = 0; i < arrTmp.length; i++) {
	var arrTemp = arrTmp[i].split("="); 
		if(arrTemp[0] == parameter){
			return arrTemp[1]; 
		}
	}
	return null; 
}