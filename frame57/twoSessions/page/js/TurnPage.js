function TurnPage()
{
	this._firstPage = "";//首页地址
	this._list = [];//页面url的堆栈
	this._isNeedSaveUrl = 1;

	this.setNeedflag = function(flag)
	{
		this._isNeedSaveUrl = flag;
	}

	this.setFirstPage = function (url)
	{
		this._firstPage = url;
	}

	this.goTo = function (url, doc)
	{
		PageManager.destroy(doc);
		PageManager.create("epg",url);
	//	doc.location.href = url;
		
	}
	
	//添加
	this.addUrl = function (url, isneed)
	{
		if(undefined != isneed) this._isNeedSaveUrl = isneed;
		if(this._isNeedSaveUrl == 1)
		{
			var length = this._list.length;
			if(length > 0)
			{
				var isExit = -1;
				for(var i=0; i<length; i++)
				{
					var strurl = this._list[i];
					if(this.getUrl(url)== this.getUrl(strurl))      
					{	
						isExit = i;
						break;
						//document.getElementById("testDiv").innerHTML = "ddd";
					//	this._list.push(url);
					}
				}

				//如果要加入队列的页面在队列中己存在。那么替换掉该页面，并将该位置之后的队列去掉
				if(isExit == -1)
				{
					this._list.push(url);
				}
				else
				{
					var length = this._list.length;
					for(var i=length; i>isExit; i--)
					{
						this._list.pop();
					}
					this._list.push(url);
				}
				/*var strurl = this._list[length-1];
				if(this.getUrl(url)!= this.getUrl(strurl))      
				{	
					//document.getElementById("testDiv").innerHTML = "ddd";
					this._list.push(url);
				}
				else			//队列中最后一个页面和需要加入队列中的url相同，就删除队列中的url
				{
					//document.getElementById("testDiv").innerHTML = "aaa";
					this._list.pop();
					this._list.push(url);
				}*/
			}
			else
			{	
				//document.getElementById("testDiv").innerHTML = "ssss";
				this._list.push(url);
			}
		}
		this._isNeedSaveUrl = 1;
		
	}
	
	//返回到上一页面
	this.goBack = function (doc)
	{
		var url = doc.location.href;      //绝对路径
		var index = url.indexOf("en/");
		var strurl = url.substring(index+3);  //当前要离开的页面
		
		var returnUrl = this._firstPage;
		this._isNeedSaveUrl = 0;
		if (this._list.length > 0)
		{
			var tempreturnUrl = this._list.pop();
			//document.getElementById("testDiv").innerHTML = "tempreturnUrl======"+tempreturnUrl;
			if(this.getUrl(strurl) != this.getUrl(tempreturnUrl))  // 当前要离开的页面 和队列中最后一个url相同时，做同样的操作
			{
				returnUrl = tempreturnUrl;
			}
			else
			{
				//this.goBack(doc);
				returnUrl = this._list.pop();
			}
		}
		this.goTo(returnUrl, doc);
	}

	this.reset = function()
	{
		this._list = [];
	}

	this.switchPageToCategory = function (innerFlag)
	{
		this._go(this._firstPage);
		this.reset();
	}
	//获取页面名，不要后面的参数
	this.getUrl = function (tempurl)
	{
		if(null != tempurl&& ""!= tempurl)
		{
			var index = tempurl.indexOf("?");
			if(index >=0)
			{
				return tempurl.substring(0,index);
			}
			else
			{
				return tempurl;
			}
		}
	}
}
var TurnPage = new TurnPage();