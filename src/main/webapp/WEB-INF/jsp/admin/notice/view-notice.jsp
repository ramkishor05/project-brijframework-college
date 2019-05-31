<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>

<script>
	$(function() {
		$('#noticeDate').datepick({
			dateFormat : "yyyy-mm-dd"
		});
	});
	function goBackAndRefresh() {
		createCookie('auto-refresh', 'YES');
		history.go(-1);
	}
	window.onload = function() {
		if (readCookie('auto-refresh') === 'YES') {
			deleteCookie('auto-refresh');
			window.location = window.location;
		}
	};
</script>
<div id="content_wrapper">
	<div id="side_bar">

		<div id="sidebar_news_area"></div>
	</div>
	<div id="content">
		<div id="content-header">
			<img alt="Show_settings" src="${img_url}/notice1.jpg"
				style="width: 74px; height: 74px;">
			<h1>View Notice</h1>
			<h3>View notice</h3>
			<div id="app-back-button">
			<a href="home"><img alt="Back" border="0"
				src="${img_url}/home.png"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="javascript:location.reload(true);"><img
				alt="Back" border="0" src="${img_url}/refresh.png"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="history.back(); return false;"><img alt="Back"
				border="0" src="${img_url}/back.png"
				style="margin-top: -6px; height: 40px; width: 40px;"></a>
		</div>
		</div>

		<div id="page-yield">



			<div id="box"
				style="margin-top: 47px; border: 1px solid; border-radius: 10px; height: 300px; width: 700px;">
				<br>
				<div style="float: right; font: bold; margin-right: 22px;">
					<b>Date:-${noticeDto.noticeDate}</b>
				</div>
				<div>
					<u><b style="margin-left: 200px;">Notice:-
							${noticeDto.noticeSubject}</b></u>
				</div>
				<br>
				<div>
					<b style="margin-left: 13px;">Respected Sir/Madam,</b>
				</div>
				<br>
				<div style="margin-left: 75px;">${noticeDto.noticeDescription}</div>
				<br>
				<div style="float: right; margin-right: 16px;">
					<b>(${noticeDto.genratedBy})</b>
				</div>
			</div>
		</div>


	</div>
</div>

<div class="extender"></div>
</div>

