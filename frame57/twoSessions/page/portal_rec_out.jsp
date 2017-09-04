<%@ taglib uri="/WEB-INF/epgtag.tld" prefix="epg" %>
<%@taglib uri="/WEB-INF/extendtag.tld" prefix="ex" %>
<epg:PageController name="portal_rec_in.jsp"/>
<%
	String url = request.getParameter("url");
%>
<script type="text/javascript">
	window.location.href = "../../"+unescape("<%=url%>");
</script>