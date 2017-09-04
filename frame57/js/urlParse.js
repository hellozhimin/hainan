/**
 * 当前页面url
 * [pageUrl description]
 * @type {[type]}
 */
var pageUrl = window.location.href;
/**
 * 协议类型
 * [protocol description]
 * @type {[type]}
 */
var protocol = window.location.protocol;
/**
 * IP
 * [host description]
 * @type {[type]}
 */
var host = window.location.host;
/**
 * 端口号
 * [port description]
 * @type {[type]}
 */
var port = window.location.port;
/**
 * 文件路径
 * [pathname description]
 * @type {[type]}
 */
var pathname = window.location.pathname;

/**
 * 上一级页面地址
 * [lastUrl description]
 * @type {[type]}
 */
var lastUrl=document.referrer;
/**
 * 获取参数值
 * [getParameter description]
 * @param  {[type]} parameter [description]
 * @return {[type]}           [description]
 */
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
/**
 * 获取所有参数，返回数组
 * [getParameter description]
 * @return {[type]}           [description]
 */
function getAllParameter(){
    var url=window.location.search;
    var intUrl = url.indexOf("?"); 
    var urlRight = url.substr(intUrl + 1); 
    var arrTmp = urlRight.split("&"); 
    var result=new Array(arrTmp.length);
    for(var i = 0; i < arrTmp.length; i++) {
         var arrTemp = arrTmp[i].split("="); 
         result[i]=arrTemp[1];
    }
    return result; 
}