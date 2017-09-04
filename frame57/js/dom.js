/**
 * 存取dom对象
 * 使用方法：dom("elementId")
 * 返回对象：名称id为"elementId"的页面DOM对象
 * 说明：$$ 是用于缓存的元素数组，第二次执行时直接从该数组读取
 * 注意事项：
 * 1、当页面元素需要经常删除和生成同名的元素是$元素的返回值不能保证正确，请删除元素时同时清除$$中对应的项 $$["deletedDiv"] = null;
 * 2、对于循环中频繁使用的对象，建议设置临时变量调用 var objA = dom("abcd");
 */
var $$ = {};
function dom(domId) {
    if (!$$[domId]) {
        $$[domId] = document.getElementById(domId);
    }
    return $$[domId];
}
