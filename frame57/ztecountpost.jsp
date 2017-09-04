<%@ page language="java"  contentType="text/html; charset=UTF-8"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLConnection"%>

<%-- 用户id获取（中兴） --%>
<%@ page import="com.zte.iptv.epg.util.EpgConstants"%>
<%@ page import="com.zte.iptv.epg.util.PortalUtils"%>
<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%!

private String sendPost(String url, String param) {
    PrintWriter out = null;
    BufferedReader in = null;
    String result = "";
    try {
        URL realUrl = new URL(url);
        URLConnection conn = realUrl.openConnection();
        conn.setRequestProperty("accept", "*/*");
        conn.setRequestProperty("connection", "Keep-Alive");
        conn.setRequestProperty("user-agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
        conn.setDoOutput(true);
        conn.setDoInput(true);
        out = new PrintWriter(conn.getOutputStream());
        out.print(param);
        out.flush();
        in = new BufferedReader(
                new InputStreamReader(conn.getInputStream()));
        String line;
        while ((line = in.readLine()) != null) {
            result += line;
        }
    }
    catch (Exception e) {
        //System.out.println("发送 POST 请求出现异常！"+e);
        //e.printStackTrace();
    }
    finally{
        try{
            if(out!=null){
                out.close();
            }
            if(in!=null){
                in.close();
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }
    return result;
}
%>
<%
  UserInfo userInfo_adlog = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
	String firstcatid = request.getParameter("firstcatid");//栏目ID(一级)
	String firstcatname = request.getParameter("firstcatname");//栏目名称(一级)
	String secondcatid = request.getParameter("secondcatid");//栏目ID(二级)
	String secondcatname = request.getParameter("secondcatname");//栏目名称(二级)
  //secondcatname = java.net.URLDecoder.decode(secondcatname , "UTF-8");
	String handletime = request.getParameter("handletime");//操作时间(systemtime)
	// String userid = (String)session.getAttribute("USERID");//用户名
	String userid = userInfo_adlog.getUserId();//用户名
  String vodname = request.getParameter("vodname");//节目名称
  //vodname = java.net.URLDecoder.decode(vodname , "UTF-8");//节目名称
  String vodid = request.getParameter("vodid");//节目ID
  String watchtime = request.getParameter("watchtime");//观看时长
  String orderuser = request.getParameter("orderuser");//是否是订购用户
  String handlestarttime = request.getParameter("handlestarttime");//开始播放系统时间
  String handleendtime = request.getParameter("handleendtime");//结束播放系统时间





	// String params = String.format("vodid=%1$s-&vodname=%2$s-&userid=%3$s-&username=%4$s-&stb=%5$s-&catid=%6$s",vodid,vodname,userid,username,stb,catid);//普通点击
	// String paramscommon = String.format("firstcatid=%1$s-&firstcatname=%2$s-&secondcatid=%3$s-&secondcatname=%4$s-&handletime=%5$s-&userid=%6$s-&vodname=%7$s-&vodid=%8$s",firstcatid,firstcatname,secondcatid,secondcatname,handletime,userid,vodname,vodid);//视频点播
	// String paramsvideo = String.format("firstcatid=%1$s-&firstcatname=%2$s-&secondcatid=%3$s-&secondcatname=%4$s-&handletime=%5$s-&userid=%6$s-&vodname=%7$s-&vodid=%8$s-&watchtime=%9$s-&orderuser=%10$s-&starttime=%11$s-&endtime=%12$s",firstcatid,firstcatname,secondcatid,secondcatname,handletime,userid,vodname,vodid,watchtime,orderuser,starttime,endtime);//视频点播

  // if (watchtime == "") {
  //   params = String.format("firstcatid=%1$s&firstcatname=%2$s&secondcatid=%3$s&secondcatname=%4$s&handletime=%5$s&userid=%6$s&vodname=%7$s&vodid=%8$s",firstcatid,firstcatname,secondcatid,secondcatname,handletime,userid,vodname,vodid);//视频点播
  // }else{
    String params = String.format("firstcatid=%1$s&firstcatname=%2$s&secondcatid=%3$s&secondcatname=%4$s&handletime=%5$s&userid=%6$s&vodname=%7$s&vodid=%8$s&watchtime=%9$s&orderuser=%10$s&handlestarttime=%11$s&handleendtime=%12$s&type=%13$s",firstcatid,firstcatname,secondcatid,secondcatname,handletime,userid,vodname,vodid,watchtime,orderuser,handlestarttime,handleendtime,5);//视频点播
  // }
	// String url = "http://172.25.44.213:8080/cms/index.php?r=mobile/IptvLog&";
	String url = "http://172.25.44.214:8099/cms/index.php?r=IptvMobile/IptvLog";
//	String result = sendPost(url,params);
//	out.clear();
//	out.println(result);
%>

