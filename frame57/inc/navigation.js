function returnNavigationObj(){
    this.objArray = navigationJSON;
    this.posterIndex = 0;
    this.timer=null;
    this.left = function () {
        this.posterblur();
        if(this.posterIndex>0){
            this.posterIndex--;
        }else{
            this.posterIndex= this.objArray.length-1;
        }
        this.posterfocus();
    }
    this.right = function () {
        this.posterblur();
        if(this.posterIndex<this.objArray.length-1){
            this.posterIndex++;
        } else{
            this.posterIndex=0;
        }
        this.posterfocus();
    }
    this.down = function () {
        areaFlag=1;
        dom("navigation").style.visibility="hidden";
        if(this.objArray[this.posterIndex].code==0){
            recommObj.posterfocus();
        }  else if(this.objArray[this.posterIndex].code==1){
            channelObj.posterfocus();
        }else if(this.objArray[this.posterIndex].code==2){
            vodObj.posterfocus();
        }else if(this.objArray[this.posterIndex].code==3){
            zhuantiObj.posterfocus();
        }else if(this.objArray[this.posterIndex].code==4){
            myObj.posterfocus();
        } else if(this.objArray[this.posterIndex].code==5){
            jingpinObj.posterfocus();
        }else if(this.objArray[this.posterIndex].code==6){
            bendiObj.posterfocus();
        }else if(this.objArray[this.posterIndex].code==7){
            yingyongObj.posterfocus();
        }
    }
    this.up = function () {

    }
    this.posterfocus=function(){

        if(this.timer!=null){
            clearTimeout(this.timer);
        }
        dom("navigation").style.visibility="visible";
        dom("navigation").style.left=2+this.posterIndex*120+"px";
        dom("navigation").style.visibility="visible";
		if(isscale){
        	dom("navigation").style.webkitTransitionDuration = 0;
		}
        setTimeout(function(){
//            dom("name"+navigationObj.posterIndex).style.fontSize=35+"px";
//            dom("name"+navigationObj.posterIndex).style.color="#48AAFD";
            dom("name"+navigationObj.posterIndex).className="navigationfocus";
        },300);

        this.timer=setTimeout(function(){
            colsediv();
			changeBgImg(navigationObj.objArray[navigationObj.posterIndex].code);
            if(navigationObj.objArray[navigationObj.posterIndex].code==0){
		
				/* ÊÊÅä·âÌ× ADD BEGIN */
				setPortalUrlFT();
				/* ÊÊÅä·âÌ× ADD END */
				
                if(recommendJSON.length==0){
                    getRecommendDate();
                }
                dom("recomm").style.display="block";
                dom("recomm").style.left=56+"px";
				
				if(isscale){
					if(areaFlag==0){
						dom("recomm").style.webkitTransitionDuration = 0;
					} else{
						dom("recomm").style.webkitTransitionDuration = 0;
					}
				}
                recommObj.posterIndex=0;
                recommObj.posterblur();

            }else if(navigationObj.objArray[navigationObj.posterIndex].code==1){
                if(channelJSON.length==0){
                    getRecommendDate();
                }
                dom("channel").style.display="block";
                dom("channel").style.left=0+"px";
				
				if(isscale){
					if(areaFlag==0){
						dom("channel").style.webkitTransitionDuration = 0;
					} else{
						dom("channel").style.webkitTransitionDuration = 0;
					}
				}
                channelObj.posterIndex=0;
                channelObj.posterblur();
                setTimeout(function(){
                    //channelObj.playchannel();
                },550);

            } else if(navigationObj.objArray[navigationObj.posterIndex].code==2){
                if(vodJSON.length==0){
                    getRecommendDate();
                }
                channelObj.colsechannel();
                dom("vod").style.display="block";
                dom("vod").style.left=80+"px";
				
				if(isscale){
					if(areaFlag==0){
						dom("vod").style.webkitTransitionDuration = 0;
					} else{
						dom("vod").style.webkitTransitionDuration = 0;
					}
				}
                vodObj.posterIndex=0;
                vodObj.posterblur();

            }else if(navigationObj.objArray[navigationObj.posterIndex].code==3){
                if(zhuantiJSON.length==0){
                    getRecommendDate();
                }
                dom("zhuanti").style.display="block";
//                dom("zhuanti").style.left=80+"px";
//                dom("zhuanti").style.webkitTransitionDuration = 500;
                zhuantiObj.posterIndex=0;
                zhuantiObj.posterblur();

            } else if(navigationObj.objArray[navigationObj.posterIndex].code==4){
                if(myJSON.length==0){
                    getRecommendDate();
                }
                dom("my").style.display="block";
//                dom("my").style.left=65+"px";
//                dom("my").style.webkitTransitionDuration = 500;
                myObj.posterIndex=0;
                myObj.posterblur();

            } else if(navigationObj.objArray[navigationObj.posterIndex].code==5){
                if(jingpinJSON.length==0){
                    getRecommendDate();
                }
                dom("jingpin").style.display="block";
//                dom("jingpin").style.left=0+"px";
//                dom("jingpin").style.webkitTransitionDuration = 500;
                jingpinObj.posterIndex=-1;
                jingpinObj.posterblur();
                jingpinObj.xunhuangIndex=0;
                setTimeout(function(){
                    dom("jingpinimg").src=jingpinObj.objArray[jingpinObj.xunhuangIndex+16].images;
//                    dom("jingpinName").innerText=jingpinObj.objArray[jingpinObj.xunhuangIndex].name;
//                    stopScroll("jingpinName",jingpinObj.objArray[jingpinObj.xunhuangIndex].name);
                    dom("jingpinName" ).innerText =subStringFunction(jingpinObj.objArray[jingpinObj.xunhuangIndex+16].name,1,500);
                    jingpinObj.startPoster();
                },400);

            }else if(navigationObj.objArray[navigationObj.posterIndex].code==6){
                if(bendiJSON.length==0){
                    getRecommendDate();
                }
                dom("bendi").style.display="block";
//                dom("bendi").style.left=56+"px";
//                dom("bendi").style.webkitTransitionDuration = 500;
                bendiObj.posterIndex=0;
                bendiObj.posterblur();

            }else if(navigationObj.objArray[navigationObj.posterIndex].code==7){
                if(yingyongJSON.length==0){
                    getRecommendDate();
                }
                dom("yingyong").style.display="block";
//                dom("yingyong").style.left=65+"px";
//                dom("yingyong").style.webkitTransitionDuration = 500;
                yingyongObj.posterIndex=0;
                yingyongObj.posterblur();

            }
        },300);
    }
    this.posterblur=function(){
//        dom("name"+this.posterIndex).style.fontSize=30+"px";
//        dom("name"+this.posterIndex).style.color="#fff";
        dom("name"+navigationObj.posterIndex).className="navigationblur";
		
		/* ÊÊÅä·âÌ× ADD BEGIN */
		setPortalUrlYS();
		/* ÊÊÅä·âÌ× ADD END */
    }
    this.showObj=function(){
        for(var i=0;i<8;i++){
            if(i<this.objArray.length){
                dom("name"+i).innerText=this.objArray[i].name;
            }  else{
                dom("name"+i).innerText="";
            }
        }
    }
}

function changeBgImg(code){
	if(code == 1){
		dom("bgDiv").style.visibility = 'hidden';
		dom("vodBgDiv").style.visibility = 'visible';
	}else{
		dom("bgDiv").style.visibility = 'visible';
		dom("vodBgDiv").style.visibility = 'hidden';
	}
}

function colsediv(){
    channelObj.colsechannel();
    jingpinObj.xunhuangIndex=0;
    jingpinObj.colsePoster();
    dom("recomm").style.display="none";
    dom("channel").style.display="none";
    dom("vod").style.display="none";
    dom("zhuanti").style.display="none";
    dom("my").style.display="none";
    dom("jingpin").style.display="none";
    dom("bendi").style.display="none";
    dom("yingyong").style.display="none";
}