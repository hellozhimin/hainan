
function toast(text,left, top, width, height, background){
            if (text) {
                text = text.replace(/&/g, " ");
            } else {
                text = "message";
            }
            left = left || 0;
            top = top || 0;
            width = width || 1280;
            height = height || 300;
            background = background || "#00000000";

            var div = document.createElement("div");
            div.innerHTML += text + "<br>";
            div.style.left = left + "px";
            div.style.top = top + "px";
            div.style.width = width + "px";
            div.style.height = height + "px";
            div.style.background = background;
            div.style.position = "absolute";
            div.style.wordBreak = "break-word";
            div.style.color='red'
            document.body.appendChild(div);
            // setTimeout(function () {
            //     document.body.removeChild(div);
            // }, time);
}
