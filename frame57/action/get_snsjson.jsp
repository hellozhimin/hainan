<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="java.io.*" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="com.zte.iptv.epg.account.UserInfo" %>
<%@page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@page import="com.zte.iptv.epg.util.PortalUtils" %>
<%!
    public String getJsonData(String httpUrl) {
        long timeBegin = System.currentTimeMillis();
        StringBuilder sb = new StringBuilder();
        try {
            URL url = new URL(httpUrl);
            HttpURLConnection httpconn;
            httpconn = (HttpURLConnection) url.openConnection();
            httpconn.setConnectTimeout(10000);
            httpconn.setRequestMethod("GET");
            System.out.println(">>>>>>>>>>>>>HttpURLConnection ===========" + httpconn.getResponseCode());
            System.out.println(">>>>>>>>>>>>>HttpURLConnection ===========" + HttpURLConnection.HTTP_OK);
            if (httpconn.getResponseCode() == HttpURLConnection.HTTP_OK) {
                InputStreamReader inreder = new InputStreamReader(httpconn.getInputStream(), "UTF-8");
                char[] charbuffer = new char[1024];
                int readnum = 0;
                while ((readnum = inreder.read(charbuffer)) > 0) {
                    sb.append(new String(charbuffer, 0, readnum));
                }
                inreder.close();
                long timeEnd = System.currentTimeMillis();
                System.out.println(">>>>>>>>>>>>>jsonResult ===========");
                System.out.println(sb);
                System.out.println(">>>>>>>>>>>>>jsonLink success.use time " + (timeEnd - timeBegin) + "ms~~~~~~~~~ \n\n");

            }
            httpconn.disconnect();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            System.out.println("[can't connect to search server:" + httpUrl + "]>>>dfbb:" + e.getMessage());
            sb.append("{\"status\":\"1\"}");
        }
        return sb.toString();
    }

    String replaceApp(HttpServletRequest req, String expression) throws Exception {
        String ret = expression;
        if (ret == null) return "";

        UserInfo userInfo = (UserInfo) req.getSession().getAttribute(EpgConstants.USERINFO);
//        String pathTempCheckInLike = PortalUtils.getPath(req.getRequestURI(), req.getContextPath());
//        pathTempCheckInLike = pathTempCheckInLike.replace("action/", "");
//        HashMap paramTempCheckInLike = PortalUtils.getParams(pathTempCheckInLike, "UTF-8");
//
//        String source = String.valueOf(paramTempCheckInLike.get("Source"));//系统类型source:(1:iptv  2:wap  3:internet  4:qt)
//        String IPTVProvider = String.valueOf(paramTempCheckInLike.get("IPTVProvider"));//0：中兴;1：华为;2：UT
//        HttpSession s = req.getSession();
//        String sessionId = s.getId();
        //http://10.41.126.119:6001/pcc/rest/sns/behavior/share/{source}/{userid}/{token}/{type1}?content={content}&type={type2}


        ret = ret.replaceAll("\\{userid\\}", userInfo.getUserId());
        //ret = ret.replaceAll("\\{token\\}", "00100299007012100000C864C795DCDC");//测试-- stbid
        ret = ret.replaceAll("\\{token\\}", userInfo.getUserToken());
        return ret;
    }
%>

<%
    String path = PortalUtils.getPath(request.getRequestURI(), request.getContextPath());
    path = path.replace("action/", "");
    HashMap paramete = PortalUtils.getParams(path, "GBK");
    String authUrl = String.valueOf(paramete.get("authUrl"));

    String url = "";
    url =  replaceApp(request, authUrl);
    String snsjson = getJsonData(url);
//    System.out.println("====get_snsjson.jsp111111111111111111111111111=======" + snsjson);
    out.print(snsjson);
%>