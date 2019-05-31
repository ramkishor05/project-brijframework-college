<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<spring:url value="/style" var="style_url"/>
<link href="${style_url}/theme/css/style.css" rel="stylesheet" type="text/css"   media="screen" />
<spring:url value="/style/js" var="js_url"/>
<script src="${js_url}/jquery-1.9.1.js" type="text/javascript"></script>
<script src="${js_url}/jquery-2.0.2.min.js" type="text/javascript"></script>
<script src="${js_url}/jquery-2.0.2.js" type="text/javascript"></script>
<script src="${js_url}/jquery.autosize.js" type="text/javascript"></script>
<script src="${js_url}/jquery.autosize.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function()
		{ 
		       $(document).bind("contextmenu",function(e){
		              return false;
		       }); 
		});</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><tiles:insertAttribute name="title" ignore="true" /></title>
</head>
<body>
<table cellpadding="2" cellspacing="2" align="center">
	<tr>
		<td height="30" colspan="2"><tiles:insertAttribute name="header" />
		</td>
	</tr>
	<tr>
		<td height="150"><tiles:insertAttribute name="menu" /></td>
		<td valign="top" width="1400"><tiles:insertAttribute name="body" /></td>
	</tr>
	<tr>
		<td height="30" colspan="2"><tiles:insertAttribute name="footer" />
		</td>
	</tr>
</table>
</body>
</html>
