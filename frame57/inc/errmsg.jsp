<%@ page import="com.zte.iptv.epg.account.UserInfo" %>
<%@ page import="com.zte.iptv.epg.util.EpgConstants" %>
<%@ page import="java.lang.reflect.*" %>
<%@ page import="com.zte.iptv.volcano.epg.account.User" %>
<%!
    public String getErrorMsg(String errorcode) {
        String key = "ERR_" + errorcode;
        String value = "";
        String unknownValue = "";
        String thisClsName = this.getClass().getName();
        Class cls = null;
        try {
            cls = Class.forName(thisClsName);
            Field[] field = cls.getDeclaredFields();
            for (int i = 0; i < field.length; i++) {
                String name = field[i].getName();
                if (name.equals("ERR_UNKOWN")) {
                    unknownValue = field[i].get(null).toString() + "(" + errorcode + ")";
                }
                // 根据错误码key值查找对应的错误信息
                if (name.equals(key)) {
                    value = field[i].get(null).toString();
                    return value;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return unknownValue;
    }
%>
<%
    UserInfo userInfoErr = (UserInfo) session.getAttribute(EpgConstants.USERINFO);
    String errorLan =  userInfoErr.getUserlanguage();
    errorLan = errorLan == null ? "" : errorLan;
%>

<%@ include file="../errormsg/errmsg_decl.jsp" %>
<%@include file="../errormsg/errmsg_zh.jsp" %>

