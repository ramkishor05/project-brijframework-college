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
			<h1>Update Notice</h1>
			<h3>Update Notice</h3>
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
			<div id="box">
				<f:form id="validate" action="update-notice.html"
					commandName="noticetDTO">
					<input type="hidden" name="noticeId" value="${edit.noticeId}">
					<input type="hidden" name="pageno" value="${edit.pageno}">
					<table>
						<tr>
							<td>Subject:<font color="red">*</font></td>
							<td><input type="text" name="noticeSubject"
								value="${edit.noticeSubject}" id="noticeSubject"
								class="validate[required,minSize[2]]" style="margin-left: 60px;"></td>
						</tr>
						<tr>
							<td><br></td>
						</tr>
						<tr>
							<td>Date:<font color="red">*</font></td>
							<td><input type="text" size="30px" name="noticeDate"
								value="${edit.noticeDate}" id="noticeDate"
								style="margin-left: 60px;" class=" validate[required]"></td>
						</tr>
						<tr>
							<td><br></td>
						</tr>
						<tr>
							<td>Genrated By:<font color="red">*</font></td>
							<td><input type="text" size="30px" name="genratedBy"
								value="${edit.genratedBy}" id="genratedBy"
								style="margin-left: 60px;" class=" validate[required]"></td>
						</tr>
						<tr>
							<td><br></td>
						</tr>
						<tr>
							<td>Description:<font color="red">*</font></td>
							<td><textarea rows="1" cols="10" name="noticeDescription" d
									id="noticeDescription" style="margin-left: 60px;"
									class=" validate[required]"> ${edit.noticeDescription}</textarea></td>
						</tr>
						<tr>
							<td><br> <br></td>
						</tr>
						<tr>
							<td></td>
							<td><input type="submit" class="btn" value="Update Notice"
								style="margin-left: 60px;"></td>
						</tr>
						<tr>
							<td></td>
							<td style="color: fuchsia;">${create}</td>
						</tr>
					</table>
				</f:form>
			</div>
		</div>
	</div>
</div>
<div class="extender"></div>


