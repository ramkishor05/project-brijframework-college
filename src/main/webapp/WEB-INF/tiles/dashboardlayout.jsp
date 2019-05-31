<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<spring:url value="/css" var="css_url" />
<spring:url value="/js" var="js_url" />
<spring:url value="/img" var="img" />
<spring:url value="/style" var="stylejs_url" />

<style>
.error {
	padding: 15px;
	margin-bottom: -20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #BB0000;
	background-color: #FFDFDF;
	border-color: #FA9381;
	text-align: center;
}

.successmsg {
	padding: 15px;
	margin: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
	text-align: center;
}
.failedmsg {
	padding: 15px;
	margin: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #BB0000;
	background-color: #FFDFDF;
	border-color: #FA9381;
	text-align: center;
}
</style>
<link href="${css_url}/style/theme/scripts/plupload/js/jquery.plupload.queue/css/jquery.plupload.queue.css" rel="stylesheet" type="text/css" />
<link href="${css_url}/stylesheets.css" rel="stylesheet" type="text/css" />
<script type='text/javascript'
	src='${js_url}/plugins/jquery/jquery-1.9.1.min.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/jquery/jquery-ui-1.10.1.custom.min.js'></script>
<script type='text/javascript' src='${js_url}/lib/jquery.min.js'></script>
<script type='text/javascript'
	src='${js_url}/lib/jquery-ui.custom.min.js'></script>
<link href="${js_url}/fullcalendar/fullcalendar.css" rel="stylesheet"
	type="text/css" />
<link href="${js_url}/fullcalendar/fullcalendar.print.css"
	rel="stylesheet" type="text/css" />
<script type='text/javascript'
	src='${js_url}/fullcalendar/fullcalendar.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/jquery/jquery-migrate-1.1.1.min.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/jquery/globalize.js'></script>
<script type='text/javascript' src='${js_url}/plugins/other/excanvas.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/other/jquery.mousewheel.min.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/bootstrap/bootstrap.min.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/cookies/jquery.cookies.2.2.0.min.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js'></script>
<script type='text/javascript'
	src="${js_url}/plugins/uniform/jquery.uniform.min.js"></script>
<script type='text/javascript'
	src="${js_url}/plugins/select/select2.min.js"></script>
<script type='text/javascript'
	src='${js_url}/plugins/tagsinput/jquery.tagsinput.min.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/maskedinput/jquery.maskedinput-1.3.min.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/multiselect/jquery.multi-select.min.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/validationEngine/languages/jquery.validationEngine-en.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/validationEngine/jquery.validationEngine.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/shbrush/XRegExp.js'></script>
<script type='text/javascript' src='${js_url}/plugins/shbrush/shCore.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/shbrush/shBrushXml.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/shbrush/shBrushJScript.js'></script>
<script type='text/javascript'
	src='${js_url}/plugins/shbrush/shBrushCss.js'></script>
<script src="${stylejs_url}/js/jquery.autosize.js"
	type="text/javascript"></script>
<script src="${stylejs_url}/js/jquery.autosize.min.js"
	type="text/javascript"></script>
<script type='text/javascript' src='${js_url}/plugins.js'></script>
<script type='text/javascript' src='${js_url}/charts.js'></script>
<script type='text/javascript' src='${js_url}/actions.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><tiles:insertAttribute name="title" ignore="true" /></title>
</head>
<body>
	<div class="wrapper">
		<tiles:insertAttribute name="menu" />
		<div class="body">

			<tiles:insertAttribute name="body" />
		</div>
	</div>
</body>
</html>