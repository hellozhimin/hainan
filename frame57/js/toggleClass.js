/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-9-6
 * Time: 下午6:30
 * To change this template use File | Settings | File Templates.
 */
//判断元素ele是否含有指定class，返回布尔值
function hasClass(ele, className) {
    return (new RegExp('(\\s|^)' + className + '(\\s|$)')).test(ele.className);
}

//为元素ele添加指定class
function addClass(ele, className) {
    if(ele.className == ''){
        ele.className = className;
    } else if (!hasClass(ele,className)){
        ele.className += ' ' + className;
    }
}

//为元素ele删除指定class
function removeClass(ele, className) {
    if (hasClass(ele, className)) {
        if(ele.className == className){
            ele.className = '';
        }else {
            ele.className = ele.className.replace(new RegExp('(\\s|^)' + className + '(\\s|$)'),' ');
        }
    }
}
