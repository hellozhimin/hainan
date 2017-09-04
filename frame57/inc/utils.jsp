<%@ page import="java.util.Set" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="com.zte.iptv.epg.util.PortalUtils" %>
<%!
    /**
     * java字符串赋值给js变量前对引号的转义
     * @param str 待转义字符串
     * @return 转义后的字符串
     */
    public String escapingQuotes(String str) {
        if (str != null && !"".equals(str)) {
            str = str.replaceAll("\\\\", "\\\\\\\\");
            str = str.replaceAll("\"", "\\\\\"");
            str = str.replaceAll("\'", "\\\\\'");
        } else {
            str = "";
        }
        return str;
    }

    /**
     * JSON串转义函数，拼接JSON串前调用
     * 功能：转义反斜杠、单双引号
     * @param str 待转移字符串
     * @return 转义后的字符串
     * 注意:调用本方法之前不要，不能用String.valueOf封装字符串，否则对象为null时候，返回字符串"null"
     */
    public String getJsonPattern(String str) {
        if (null != str && !"".equals(str)) {
            str = str.replaceAll("\\\\", "\\\\\\\\")
                    .replaceAll("'", "\\\\\'")
                    .replaceAll("\"", "\\\\\"");
        } else {
            str = "";
        }
        return str;
    }

    /**
     * 拼接Json串
     * @param params Key数组
     * @param values Value数组
     * @return 拼接后的Json串，如{Key1:"Value1",Key2:"Value2"}
     */
    public String getJsonObject(String[] params, String[] values) {
        StringBuffer result = new StringBuffer();
        try {
            if (params != null && values != null && params.length == values.length) {
                result.append("{");
                for (int i = 0, length = params.length; i < length; i++) {
                    result.append(params[i]).append(":\"").append(values[i]).append("\"");
                    if (i != length - 1) {
                        result.append(",");
                    }
                }
                result.append("}");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result.toString();
    }

    /**
     * 拼接多个Json串对象数组
     * @param jsonObjectArr Json串对象数组，数组元素格式：{Key1:"Value1",Key2:"Value2"}
     * @return 返回Json串对象数组拼接后的Json串，如[{Key1:"Value1",Key2:"Value2"},{Key1:"Value1",Key2:"Value2"}]
     */
    public String getJsonArray(String[] jsonObjectArr) {
        StringBuffer result = new StringBuffer();
        if (jsonObjectArr != null) {
            result.append("[");
            for (int i = 0, length = jsonObjectArr.length; i < length; i++) {
                result.append(jsonObjectArr[i]);
                if (i != length - 1) {
                    result.append(",");
                }
            }

            result.append("]");
        }
        return result.toString();
    }

    /**
     * translate List<Map<String,String>> to json
     * objectList: items的内容,由ex:search获取
     * field :items展示的数据库字段
     * pageInfoList:分页信息
     */
    String listToJson(List dataList, String[] fields, Map pageInfo) {

        StringBuilder sb = new StringBuilder("{");
        if (pageInfo != null && pageInfo.size() > 0) {
            Set pageSetMapEntry = pageInfo.entrySet();
            for (Map.Entry entry : (Set<Map.Entry>) pageSetMapEntry) {
                String entryValue = (String) (entry.getValue());
                entryValue = getJsonPattern(entryValue);
                sb.append("\"").append(entry.getKey()).append("\"").append(":");
                sb.append("\"").append(entryValue).append("\"");
                sb.append(",");

            }
        }
        sb.append("\"items\":").append("[");
        if (dataList != null && !dataList.isEmpty()) {

            for (Map ObjectMap : (List<Map>) dataList) {
                if (ObjectMap != null && ObjectMap.size() > 0) {
                    sb.append("{");
                    for (String field : fields) {
                        String fieldValue = ObjectMap.get(field) == null ? "" : (String) ObjectMap.get(field);
                        fieldValue = getJsonPattern(fieldValue);
                        sb.append("\"").append(field).append("\"").append(":");
                        sb.append("\"").append(fieldValue).append("\"");
                        sb.append(",");
                    }
                    sb.deleteCharAt(sb.length() - 1);
                    sb.append("}");
                }
                sb.append(",");
            }
            sb.deleteCharAt(sb.length() - 1);
        }
        sb.append("]}");
        return sb.toString();
    }

    /**
     * 获取影片的大海报
     * @param postfilelist 12张海报路径字符串
     * @return 影片的大海报URL
     **/
    public String getNormalPoster(String postfilelist) {
        String posterPath = "images/poster/defaultposter_n.png";
        if (null != postfilelist) {
            String[] tempArr = postfilelist.split(";");
            if (tempArr.length > 0 && !"".equals(tempArr[0])) {
                return "../images/poster/" + tempArr[0];
            }
        }
        return posterPath;
    }

    /**
     * 根据名称获取该模板配置项对应的值
     * @param request HttpServletRequest
     * @param name 配置项名称
     * @param defaultValue 默认值
     * @param charsetName 编码格式，默认为UTF-8
     * @return 该配置项对应的值
     * 如果获取不到且有默认值返回默认值，否则返回空字符串
     */
    public String getConfigurationByName(HttpServletRequest request, String name,
                                         String defaultValue, String charsetName) {
        // 默认UTF-8
        if (null == charsetName || "".equals(charsetName)) {
            charsetName = "UTF-8";
        }
        // 拼接配置文件的路径
        String contextPath = request.getContextPath();
        String uri = request.getRequestURI();
        uri = uri.replaceFirst(contextPath + "/", "");
        String frameName = uri.substring(0, uri.indexOf("/") + 1);
        String portalPropertyPath = "/" + frameName + "portal.properties";

        // 读取配置项，如果获取不到且有默认值返回默认值，否则返回空字符串
        HashMap param = PortalUtils.getParams(portalPropertyPath, charsetName);
        String value = (String) param.get(name);
        if (null == value) {
            if (null == defaultValue || "".equals(defaultValue)) {
                value = "";
            } else {
                value = defaultValue;
            }
        }
        return value;
    }

    /**
     * 判断栏目号是否在列表中，或者是否是列表中栏目的子栏目
     * @param columnId 待判断栏目号
     * @param columnIds 栏目号列表，逗号分隔
     * @return 栏目号在列表中或者是列表中栏目的子栏目，返回true，否则返回false
     */
    public boolean containsColumn(String columnId, String columnIds) {
        if (null == columnIds || "".equals(columnIds) || null == columnId || "".equals(columnId)) {
            return false;
        } else {
            String[] columnIdArray = columnIds.split(",");
            for (int i = columnIdArray.length - 1; i >= 0; i--) {
                // 相等或者是它的子栏目
                if (columnId.indexOf(columnIdArray[i]) == 0) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * 字符串左起补零
     * @param str 待补齐字符串
     * @param totalLen 字符总位数
     * @return 左补全后字符串
     */
    public String leftCompleteStr(String str, int totalLen) {
        int strLen = str.length();
        if (strLen < totalLen) {
            while (strLen < totalLen) {
                StringBuffer strBf = new StringBuffer();
                strBf.append("0").append(str);//左补0
                str = strBf.toString();
                strLen++;
            }
        }
        return str;
    }

        /**
         *通过http绝对路径获取frame号
         * @param reqURI  请求绝对路径 http://
         * @return framexxxx
         */
    String getHTTPFrameCode(String reqURI) {
        int start = reqURI.indexOf("frame");
        int end = reqURI.indexOf("/", start);
        return reqURI.substring(start, end);
    }

        /**
         * 通过用户语言，获取多语配置中匹配语种配置
         * @param configStr   原始多语配置字符串 Europe American:America,美国,America
         * @param userLan      当前用户语言， userInfo.getUserlanguage();
         * @param configLan    模板支持语种配置项   epgLanguage=eng,zho,ina
         * @return  返回支持当前语言的配置内置   Europe American:America
         */
    public static String getConfigByUserLan(String configStr,String userLan,String configLan){
        StringBuffer newStr = new StringBuffer();
        String[] epgLanS = configLan.split(",");
        int lanIndex = 0;
        for(int j = 0;j<epgLanS.length;j++){
            if(userLan.equals(epgLanS[j])){
                lanIndex = j;
            }
        }
        String[] aaS = configStr.split(";");
        for(int i = 0;i<aaS.length;i++){
            String bb = aaS[i];
            String[] bbS = bb.split(":");
            newStr.append(bbS[0]).append(":");
            String cc = bbS[1];
            String[] ccS = cc.split(",");
            newStr.append(ccS[lanIndex]);
            if(i<aaS.length-1){
                newStr.append(";");
            }
        }
        return newStr.toString();
    }
%>