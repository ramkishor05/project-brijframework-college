<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/fee_manage.jpg"
			style="width: 57px;">
		<h1>Exam Report Home</h1>
		<h3>Exam Report Home</h3>
		<div id="app-back-button">
			<a href="#" onclick="history.back(); return false;"><img
				alt="Back" border="0" src="${img_url}/back1.png"></a>
		</div>
	</div>
<div>
<table border="1"style="margin-top: 40px;">
<tr>
<td style="width: 14px;">*</td><td>% of marks obtained</td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td>
<td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td></tr>
<tr>
<td style="width: 14px;">*</td><td>Highest % in class</td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td>
<td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td></tr>
<tr>
<td style="width: 14px;">*</td><td>Rank</td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td>
<td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td></tr>
<tr>
<td style="width: 14px;">*</td><td>Attendance in %</td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td>
<td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td></tr>
<tr>
<td style="width: 14px;">*</td><td>Uniform & Performance</td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td>
<td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td></tr>
<tr>
<td style="width: 14px;">*</td><td>Sign. of Class Teacher</td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td>
<td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td></tr>
<tr>
<td style="width: 14px;">*</td><td>Sign. of Principal</td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td>
<td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td></tr>
<tr>
<td style="width: 14px;">*</td><td>Sign. of Parents</td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td>
<td style="width: 58px;"></td><td style="width: 58px;"></td><td style="width: 58px;"></td></tr>
</table>
</div>
</div>