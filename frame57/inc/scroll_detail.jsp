<%@ page contentType="text/html; charset=UTF-8" %>
<style type="text/css">
    /*自动截取后不加...*/
    .font_clip {
        overflow: hidden;
        white-space: nowrap;
        text-overflow: clip;
    }

    /*自动截取后加...*/
    .font_ellipsis {
        /*overflow: hidden;*/
        /*white-space: nowrap;*/
        /*text-overflow: ellipsis;*/
    }

    /*多行展示，超长部分直接隐藏，不加省略号*/
    .font_ellipsis2 {
        overflow: hidden;
        white-space: normal;
        text-overflow: ellipsis;
        -o-text-overflow: ellipsis;
    }
</style>
<div style="position: absolute;left:40px;top:40px;">
    <div  id="dvCompute"></div>
</div>
<%--<%--%>
    <%--Object isAndroid = session.getAttribute("isAndroid");--%>
    <%--if ("1".equals(isAndroid)) {--%>
<%--%>--%>
<%--<style type="text/css">--%>
    <%--/*多行展示，超长部分直接隐藏，不加省略号*/--%>
    <%--.font_ellipsis2 {--%>
        <%--overflow: hidden;--%>
        <%--white-space: normal;--%>
        <%--line-height: 125%;--%>
        <%--text-overflow: ellipsis;--%>
        <%---o-text-overflow: ellipsis;--%>
    <%--}--%>
<%--</style>--%>
<%--<%--%>
    <%--}--%>
<%--%>--%>
<script type="text/javascript">
    function escapeHTMLTag(sourceStr){
        if (sourceStr != null) {
            sourceStr = sourceStr.replace(new RegExp("&", "gm"), "&amp;");
            sourceStr = sourceStr.replace(new RegExp("<", "gm"), "&lt;");
            sourceStr = sourceStr.replace(new RegExp(">", "gm"), "&gt;");
        }
        return sourceStr;
    }
//    String.prototype.getWidth = function(fontSize)
//    {
//        var span = document.getElementById("__getwidth");
//        if (span == null) {
//            span = document.createElement("span");
//            span.id = "__getwidth";
//            document.body.appendChild(span);
//            span.style.visibility = "hidden";
//            span.style.whiteSpace = "nowrap";
//        }
//        span.innerText = this;
//        span.style.fontSize = fontSize + "px";
//
//        return span.offsetWidth;
//    }
    var strArr ={"Q":16, "W":19, "E":13, "R":14, "T":12, "Y":13, "U":14, "I":7, "O":16, "P":13,
        "A":13, "S":13, "D":14, "F":12, "G":16, "H":14, "J":11, "K":13, "L":11,
        "Z":12, "X":13, "C":14, "V":13, "B":13, "N":14, "M":18,
        "q":11, "w":14, "e":11, "r":8, "t":7, "y":11, "u":11, "i":5, "o":11, "p":11,
        "a":11, "s":11, "d":11, "f":7,"g":11, "h":11, "j":5, "k":11, "l":5,
        "z":11, "x":11, "c":11, "v":11, "b":11, "n":11, "m":17,
        "`":8, "1":11, "2":11, "3":11, "4":11, "5":11, "6":11, "7":11, "8":11, "9":11, "0":11, "-":8, "=":12, "~":12,
        "!":7, "@":20, "#":12, "$":11, "%":18, "^":10, "&":13, "*":10, "(":8, ")":8, "_":11, "+":12,
        "[":7, "]":7, ";":7, "'":5, ".":7, "/":8, "\\":8, "{":8, "}":8, ":":5, "\"":8, "<":12, ">":12,
        "?":11, "|":6," ":5};

function getStringLen(sourceStr, len)
    {
        var strWidth = 0;
        var retObj = {"isSub":false, "index":0};
        for(var i=0; i<sourceStr.length; i++)
        {
            var Char = sourceStr.charAt(i);
            var size = strArr[Char];
//            alert("=========size========="+size);
            strWidth = strWidth + (typeof(size)=="undefined"?25:size)*1;
            if (strWidth > len)
            {
                retObj.isSub = true;
                retObj.index = i;
                retObj.width = strWidth;
                return retObj;
            }
        }
        return retObj;
    }
//    function getStringLen(str, len)
//    {
//        var str_length = 0;
//        var str_len = 0;
//       var str_cut = new String();
//        str_len = str.length;
//        var retObj = {"isSub":false, "index":0};
//        for (var i = 0; i < str_len; i++) {
//          var  a = str.charAt(i);
//            str_length++;
//            if (escape(a).length > 4) {
//                //中文字符的长度经编码之后大于4
//                str_length++;
//            }
//            str_cut = str_cut.concat(a);
//            if (str_length >= len) {
////                str_cut = str_cut.concat("...");
////                return str_cut;
//                retObj.isSub = true;
//                retObj.index = i;
//                retObj.width = str_length;
//                return retObj;
//            }
//        }
//        //如果给定字符串小于指定长度，则返回源字符串；
////        if (str_length < len) {
////            return str;
////        }
//        return retObj;
//    }
    function subStringFunction(sourceStr, row, len)
    {
        if(typeof(sourceStr) == "" || len<20)
        {
            return sourceStr;
        }
        var retStr = "";
        row = row<=0? 1: row;
        for(var i=0; i<row;i++)
        {
            var strObj =getStringLen(sourceStr, len);
//            alert(len+"=========strObj.isSub==========="+strObj.isSub)
            if(strObj.isSub)
            {
                if(i == row - 1)
                {
                    retStr += sourceStr.substring(0, strObj.index -2)+"...";
                    break;
                }
                retStr += sourceStr.substring(0, strObj.index) + "</br>";

                sourceStr = sourceStr.substring(strObj.index, sourceStr.length);
            }
            else
            {
                retStr += sourceStr.substring(0, sourceStr.length);
                break;
            }
        }
        return retStr;

    }

    /*
    id:div的ID
    text:div的文字
    divWidth：div的宽度
    */

    function starScroll(id, text, divWidth) {
        var divWidth1 = document.getElementById(id).style.width;
		if(id.indexOf('programname0_') != -1 && divWidth1 == ''){
			divWidth1 = 210;
		}else if(id.indexOf('programname0_') != -1 && divWidth1 == ''){
			divWidth1 = 145;
		}else if(id.indexOf('column_name') != -1 && divWidth == ''){
			divWidth1 = 251;
		}
        divWidth1=parseInt(divWidth1,10);
        var strObj =getStringLen(text, divWidth1);
        if (strObj.isSub) {
            document.getElementById(id).innerHTML = "";
            document.getElementById(id).innerHTML = "<marquee>" + text + "</marquee>";
        } else {
//            document.getElementById(id).innerHTML = text;
        }
    }
    function stopScroll(id, text) {
        var divWidth = document.getElementById(id).style.width;
		//有些盒子获取不到div的宽度
		 if(id.indexOf('programname0_') != -1 && divWidth == ''){
			divWidth = 210;
		 }else if(id.indexOf('programname_') != -1 && divWidth == ''){
			divWidth = 145;
		 }else if(id.indexOf('column_name') != -1 && divWidth == ''){
			divWidth = 251;
		 }
         divWidth=parseInt(divWidth,10);
         var text1= subStringFunction(text,1,divWidth);
        document.getElementById(id).innerHTML = text1;
    }
</script>