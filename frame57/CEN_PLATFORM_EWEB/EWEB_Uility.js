function getRequestParameter(param_name) {
	var request_url = window.location.href;
	var param_string = request_url.substring(request_url.indexOf("?") + 1, request_url.length).split("&");
	var param_array = {};
	var i = 0;
	var j = 0;
	for (i = 0; j = param_string[i]; i++) {
		param_array[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length)
	}
	var return_value = param_array[param_name.toLowerCase()];
	if (typeof(return_value) == "undefined") {
		return ""
	} else {
		return return_value
	}
};

function getEpgInfoFromURL(source_url, param_name) {
	var int_start = source_url.indexOf('<' + param_name + '>');
	var int_end = source_url.indexOf('</' + param_name + '>');
	var str_value = source_url.substring(int_start + param_name.length + 2, int_end);
	return str_value
};

function replaceUrlParams(source_url, target_param_name, target_param_value) {
	var index = source_url.indexOf(target_param_name + "=");
	if (index > -1) {
		var before = source_url.substring(0, index);
		var after = source_url.substring(index);
		index = after.indexOf("&");
		after = (index > -1) ? after.substring(index) : "";
		source_url = before + target_param_name + "=" + target_param_value + after
	} else {
		source_url += (source_url.indexOf("?") > -1) ? "&" : "?";
		source_url += target_param_name + "=" + target_param_value
	}
	return source_url
};

function getUrlParameterObj(request_url) {
	if (typeof(request_url) == "undefined" || request_url == null) request_url = window.location.href;
	var start_index = request_url.indexOf("?");
	var result_obj = null;
	if (start_index == -1 && request_url.indexOf("=") == -1) return result_obj;
	var parastr = decodeURI(request_url.substring(start_index + 1));
	var param_array = parastr.split("&");
	result_obj = {};
	for (var i = 0; i < param_array.length; i++) {
		var tempstr = param_array[i];
		start_index = tempstr.indexOf("=");
		result_obj[tempstr.substring(0, start_index)] = tempstr.substring(start_index + 1)
	}
	return result_obj
};

function gotoPage(target_url) {
	window.location.href = target_url
};

function getTotalPageCount(total_program_count, programs_per_page) {
	return Math.ceil(parseInt(total_program_count, 10) / parseInt(programs_per_page, 10))
};
String.prototype.trim = function() {
	return this.replace(/<\/?.+?>/g, "").replace(/[\r\n]/g, "").replace(/(^\s*)|(\s*$)/g, "")
};
String.prototype.replaceAll = function(s1, s2) {
	return this.replace(new RegExp(s1, "gm"), s2)
};

function isArray(obj) {
	var isArr = Object.prototype.toString.call(obj) == '[object Array]';
	if (!isArr && obj != null) {
		isArr = obj.constructor == Array
	}
	return isArr
};

function objectToStr(jsonObj) {
	var reStr = "";
	if (jsonObj != null && typeof(jsonObj) == "object") {
		var beginStr = "{";
		var endStr = "}";
		if (isArray(jsonObj)) {
			beginStr = "[";
			endStr = "]"
		}
		for (var item in jsonObj) {
			if (!(item >= 0)) {
				reStr += "'" + item + "':"
			}
			var type = typeof(jsonObj[item]);
			if (type == "number") {
				reStr += jsonObj[item]
			} else if (type == "object") {
				reStr += objectToStr(jsonObj[item])
			} else {
				reStr += "'" + jsonObj[item] + "'"
			}
			reStr += ","
		}
		if (reStr.length > 0) reStr = reStr.substr(0, reStr.length - 1);
		reStr = beginStr + reStr + endStr
	}
	return reStr
};

function getSubString(source_string, slice_step, suffix_string) {
	var int_string_length = 0;
	var int_target_string_length = 0;
	var result_string = '';
	int_target_string_length = source_string.length;
	for (var i = 0; i < int_target_string_length; i++) {
		var char_letter = source_string.charAt(i);
		int_string_length++;
		if (escape(char_letter).length > 4) {
			int_string_length++
		}
		result_string = result_string.concat(char_letter);
		if (int_string_length >= slice_step) {
			if (suffix_string != null || suffix_string != undefined) result_string = result_string.concat(suffix_string);
			return result_string
		}
	}
	if (int_string_length < slice_step) {
		return source_string
	}
};

function getStringRealLength(source_string) {
	if (typeof(source_string) != "string" || source_string.length == 0) return 0;
	var real_length = 0;
	var strLen = source_string.length;
	var tmp_char = null;
	for (var i = 0; i < strLen; i++) {
		tmp_char = source_string.charAt(i);
		real_length++;
		if (escape(tmp_char).length > 4) {
			real_length++
		}
	}
	return real_length
};

function addLeadingCharacter(source_string, leading_string) {
	source_string = leading_string + source_string;
	return source_string.substring(source_string.length - leading_string.length)
};

function createJsonp(request_url, callback_func) {
	var request_script = document.createElement('script');
	request_script.src = request_url + "&callback=" + callback_func;
	request_script.id = callback_func;
	document.head.appendChild(request_script)
};

function destroyJsonp(request_id) {
	var tmp_script_item = document.getElementById(request_id);
	if (tmp_script_item == null || tmp_script_item == undefined) return;
	tmp_script_item.parentNode.removeChild(tmp_script_item)
};

function jsonTrim(source_string) {
	return source_string.replace(/\r/g, ' ').replace(/\n/g, ' ')
};

function sendAjaxGetRequest(request_url, callback_func) {
	var asyn_flag = false;
	if (callback_func == null || callback_func == undefined) {
		asyn_flag = false
	} else {
		asyn_flag = true
	}
	var ajax_obj = null;
	if (window.XMLHttpRequest) {
		ajax_obj = new XMLHttpRequest()
	}
	ajax_obj.onreadystatechange = function() {
		if (ajax_obj.readyState == 4 && ajax_obj.status == 200) {
			eval(callback_func(jsonTrim(ajax_obj.responseText)))
		}
	};
	ajax_obj.open("GET", request_url, asyn_flag);
	ajax_obj.send(null);
	return jsonTrim(ajax_obj.responseText)
};

function sendAjaxPostRequest(request_url, callback_func) {
	var asyn_flag = false;
	if (callback_func == null || callback_func == undefined) {
		asyn_flag = false
	} else {
		asyn_flag = true
	}
	var ajax_obj = null;
	if (window.XMLHttpRequest) {
		ajax_obj = new XMLHttpRequest()
	}
	ajax_obj.onreadystatechange = function() {
		if (ajax_obj.readyState == 4 && ajax_obj.status == 200) {
			eval(callback_func(jsonTrim(ajax_obj.responseText)))
		}
	};
	ajax_obj.open("POST", request_url, asyn_flag);
	ajax_obj.send(null);
	return jsonTrim(ajax_obj.responseText)
};

function setCookie(cookie_id, cookie_value) {
	var days_to_keep = 7;
	var expire_date = new Date();
	expire_date.setTime(expire_date.getTime() + days_to_keep * 24 * 60 * 60 * 1000);
	document.cookie = cookie_id + "=" + escape(cookie_value) + ";expires=" + expire_date.toGMTString() + ";path=/"
};

function getCookie(cookie_id) {
	var result_array = null;
	if (document.cookie != null && document.cookie.length > 0) result_array = document.cookie.match(new RegExp("(^| )" + cookie_id + "=([^;]*)(;|$)"));
	if (result_array != null) return unescape(result_array[2]);
	return null
};

function deleteCookie(cookie_id) {
	var cookie_date = new Date();
	cookie_date.setTime(cookie_date.getTime() - 10000);
	document.cookie = cookie_id + "=;expires=" + cookie_date.toGMTString() + ";path=/"
};

function transSecondToFormatedTime(second_to_trans) {
	var hour = parseInt(second_to_trans / 3600, 10);
	second_to_trans = parseInt(second_to_trans % 3600, 10);
	var minute = parseInt(second_to_trans / 60, 10);
	second_to_trans = parseInt(second_to_trans % 60, 10);
	var second = parseInt(second_to_trans, 10);
	var timeStr = '';
	if (hour < 10) timeStr += "0";
	timeStr += hour + ":";
	if (minute < 10) timeStr += "0";
	timeStr += minute + ":";
	if (second < 10) timeStr += "0";
	timeStr += second;
	return timeStr
};

function getToday(date_format) {
	var time = new Date();
	var day = time.getDate();
	var year = time.getFullYear();
	var month = time.getMonth() + 1;
	month = month < 10 ? "0" + month : month;
	day = day < 10 ? "0" + day : day;
	if (date_format == 'mm-dd') {
		var date = month + '-' + day
	} else {
		var date = year + '-' + month + '-' + day
	}
	return date
};

function getYesterday(date_format) {
	var date_today = new Date();
	var yesterday_milliseconds = date_today.getTime() - 1000 * 60 * 60 * 24;
	var time = new Date();
	time.setTime(yesterday_milliseconds);
	var day = time.getDate();
	var year = time.getFullYear();
	var month = time.getMonth() + 1;
	month = month < 10 ? "0" + month : month;
	day = day < 10 ? "0" + day : day;
	if (date_format == 'mm-dd') {
		var date = month + '-' + day
	} else {
		var date = year + '-' + month + '-' + day
	}
	return date
};

function getDayBeforeYesterday(date_format) {
	var date_today = new Date();
	var day_before_yesterday_milliseconds = date_today.getTime() - 1000 * 60 * 60 * 24 * 2;
	var time = new Date();
	time.setTime(day_before_yesterday_milliseconds);
	var day = time.getDate();
	var year = time.getFullYear();
	var month = time.getMonth() + 1;
	month = month < 10 ? "0" + month : month;
	day = day < 10 ? "0" + day : day;
	if (date_format == 'mm-dd') {
		var date = month + '-' + day
	} else {
		var date = year + '-' + month + '-' + day
	}
	return date
};

function getCurrentTime() {
	var time = new Date();
	var hour = time.getHours();
	var minute = time.getMinutes();
	var second = time.getSeconds();
	hour = hour < 10 ? "0" + hour : hour;
	minute = minute < 10 ? "0" + minute : minute;
	second = second < 10 ? "0" + second : second;
	var time = hour + ':' + minute + ':' + second;
	return time
};

function getCurrentWeek() {
	var week = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
	var time = new Date();
	var weekDay = time.getDay();
	for (var i = 0; i < week.length; i++) {
		if (weekDay == i) {
			return week[i]
		}
	}
};

function getFullTime() {
	var time = new Date();
	var day = time.getDate();
	var year = time.getFullYear();
	var month = time.getMonth() + 1;
	var hour = time.getHours();
	var minute = time.getMinutes();
	var second = time.getSeconds();
	month = month < 10 ? "0" + month : month;
	day = day < 10 ? "0" + day : day;
	hour = hour < 10 ? "0" + hour : hour;
	minute = minute < 10 ? "0" + minute : minute;
	second = second < 10 ? "0" + second : second;
	var date = year + '-' + month + '-' + day;
	var timer = hour + ":" + minute + ':' + second;
	return date + ' ' + timer
};

function parseUTC2Date(utcTime) {
	var year = parseInt(utcTime.substr(0, 4), 10);
	var month = parseInt(utcTime.substr(4, 2), 10);
	var day = parseInt(utcTime.substr(6, 2), 10);
	var hour = parseInt(utcTime.substr(9, 2), 10);
	var min = parseInt(utcTime.substr(11, 2), 10);
	var sec = parseInt(utcTime.substr(13, 2), 10);
	if (month == 0) month = parseInt(utcTime.substr(5, 1), 10);
	if (day == 0) day = parseInt(utcTime.substr(7, 1), 10);
	if (hour == 0) hour = parseInt(utcTime.substr(10, 1), 10);
	if (min == 0) min = parseInt(utcTime.substr(12, 1), 10);
	if (sec == 0) sec = parseInt(utcTime.substr(14, 1), 10);
	var result_date = new Date(year, month - 1, day, hour + 8, min, sec);
	return result_date
};

function parseDateToUTC(time) {
	if (time == undefined || time == "") time = 0;
	var dateobj = new Date(time);
	var sec = dateobj.getSeconds();
	var min = dateobj.getMinutes();
	var hour = dateobj.getHours();
	dateobj.setHours(hour - 8);
	var year = dateobj.getFullYear();
	var month = dateobj.getMonth() + 1;
	var day = dateobj.getDate();
	hour = dateobj.getHours();
	min = dateobj.getMinutes();
	if (month < 10) month = "0" + month;
	if (day < 10) day = "0" + day;
	if (hour < 10) hour = "0" + hour;
	if (min < 10) min = "0" + min;
	if (sec < 10) sec = "0" + sec;
	var timeStamp = "" + year + month + day + "T" + hour + min + sec + "Z";
	return timeStamp
};

function parseUTC2Time(utc_time) {
	utc_time = parseUTC2Date(utc_time);
	var sec = utc_time.getSeconds();
	var hour = utc_time.getHours();
	var min = utc_time.getMinutes();
	if (hour < 10) hour = "0" + hour;
	if (min < 10) min = "0" + min;
	if (sec < 10) sec = "0" + sec;
	return hour + ":" + min + ":" + sec
};

function getCatchUpBeginTime(mediaTime) {
	var currTime = new Date();
	var beginTime = new Date(currTime.getTime() - mediaTime * 1000);
	var min = beginTime.getMinutes();
	var sec = beginTime.getSeconds();
	var hour = beginTime.getHours();
	if (hour < 10) hour = "0" + hour;
	if (min < 10) min = "0" + min;
	if (sec < 10) sec = "0" + sec;
	return hour + ":" + min + ":" + sec
};

function getCatchUpRelativeDuration(currPlayTime, mediaTime) {
	currPlayTime = parseUTC2Date(currPlayTime);
	var currTime = new Date();
	var beginTime = new Date(currTime.getTime() - mediaTime * 1000);
	var relativeTime = (currPlayTime.getTime() - beginTime.getTime()) / 1000;
	return relativeTime
};

function getCurrentShiftUTCTime(time, mediaTime) {
	if (time == undefined || time == "") time = 0;
	var currTime = new Date();
	var dateobj = new Date(currTime.getTime() - (mediaTime - time) * 1000);
	var sec = dateobj.getSeconds();
	var min = dateobj.getMinutes();
	var hour = dateobj.getHours();
	dateobj.setHours(hour - 8);
	var year = dateobj.getFullYear();
	var month = dateobj.getMonth() + 1;
	var day = dateobj.getDate();
	hour = dateobj.getHours();
	min = dateobj.getMinutes();
	if (month < 10) month = "0" + month;
	if (day < 10) day = "0" + day;
	if (hour < 10) hour = "0" + hour;
	if (min < 10) min = "0" + min;
	if (sec < 10) sec = "0" + sec;
	var timeStamp = "" + year + month + day + "T" + hour + min + sec + "Z";
	return timeStamp
};

function getCurrentShiftTime(time, mediaTime) {
	if (time == undefined || time == "") time = 0;
	var currTime = new Date();
	var beginTime = new Date(currTime.getTime() - (mediaTime - time) * 1000);
	var min = beginTime.getMinutes();
	var sec = beginTime.getSeconds();
	var hour = beginTime.getHours();
	min = beginTime.getMinutes();
	if (hour < 10) hour = "0" + hour;
	if (min < 10) min = "0" + min;
	if (sec < 10) sec = "0" + sec;
	return hour + ":" + min + ":" + sec
};

function setDebugInfo(debug_txt, append_mode) {
	var tmp_debug_div = document.getElementById('debug_div');
	if (tmp_debug_div == null || tmp_debug_div == 'undefined') {
		var head = document.head || document.getElementsByTagName('head').item(0);
		var tmp_debu_css = document.createElement('style');
		head.appendChild(tmp_debu_css);
		tmp_debu_css.type = 'text/css';
		tmp_debu_css.id = 'debug_div_css';
		var tmp_debu_css_text = '.debug_css {';
		tmp_debu_css_text += 'z-index: 200;';
		tmp_debu_css_text += 'line-height: 40px;';
		tmp_debu_css_text += 'font-size: 30px;';
		tmp_debu_css_text += 'color: red;';
		tmp_debu_css_text += 'text-align: left;';
		tmp_debu_css_text += 'background-color: white;';
		tmp_debu_css_text += '}';
		tmp_debu_css.innerHTML = tmp_debu_css_text;
		tmp_debug_div = document.createElement('div');
		document.body.appendChild(tmp_debug_div);
		tmp_debug_div.id = 'debug_div';
		tmp_debug_div.style.position = 'absolute';
		tmp_debug_div.style.left = '50px';
		tmp_debug_div.style.top = '50px';
		tmp_debug_div.style.width = '1180px';
		tmp_debug_div.style.height = '400px';
		tmp_debug_div.className = 'debug_div_css'
	}
	if (append_mode == null) append_mode = true;
	if (append_mode == true) tmp_debug_div.innerHTML += debug_txt;
	else tmp_debug_div.innerHTML = debug_txt
};