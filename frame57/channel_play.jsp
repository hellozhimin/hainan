<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/epgtag.tld" prefix="epg"%>
<epg:PageController  name="back.jsp"/>
<epg:script lasturl="false"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> channel_play.jsp</title>
</head>
<body bgcolor="transparent"></body>
<%--<epg:script lasturl="false"/>--%>
<%!
    public String getPath(String uri) {
        String path = "";
        int begin = 0;
        int end = uri.lastIndexOf('/');
        if (end > 0) {
            path = uri.substring(begin, end + 1) + path;
        }
        return path;
    }
%>
<%
  String mixno = request.getParameter("mixno");
  String columncode = request.getParameter("columncode");
  String framechannel = request.getParameter("framechannel");
    String path = getPath(request.getRequestURI());
%>
<script type="text/javascript" src="js/contentloader.js"></script>
<script type="text/javascript">
  var mixno = parseInt("<%=mixno%>",10);
  top.doStop();
  var mixno1=top.channelList[0];
  if("<%=framechannel%>"!="1"){
	  top.jsSetControl("NUM_TO_PLAY", false);
      top.jsSetControl("showchannelinfo",1);
	  	top.channelInfo.columncode1111='<%=columncode%>';
      if("<%=columncode%>"=="xxx"){
          top.jsSetControl("showchannelinfo1",1);
            var  requestUrl="action/get_all_channel_favorite.jsp";
          new net.ContentLoader(requestUrl, function () {
//                var datatext = this.req.responseText;
//              channelObj.channelData = new Array();
              var data = eval("(" + this.req.responseText + ")");
              var channelData = data.channels;
              if(channelData.length>0){
                  setTimeout(function(){
                      top.jsRedirectChannel(channelData[0].mixno);
                  },200);
              } else{
                  setTimeout(function(){
                      top.jsRedirectChannel(mixno1);
                  },200);
              }
          });
      }else{
          top.jsSetControl("showchannelinfo1",0);
          setTimeout(function(){
              top.jsRedirectChannel(mixno);
          },200);
      }

  } else{
		  top.jsSetControl("showchannelinfo",0);
		  setTimeout(function(){
			  top.jsRedirectChannel(mixno);
		  },200);
  }

  //document.location = "channel_auth_orderlist.jsp?ContentID=" + channelId + "&mixno=" + global_mixno;
</script>
</html>