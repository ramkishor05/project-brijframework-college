<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<spring:url value="/" var="baseurl"></spring:url>
<c:url value="/style/theme/images" var="imageurl" />
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
		document.cookie = 'auto-refresh=YES';
		history.go(-1);
	}
	$(function() {
		setTimeout(function() {
			$('.successmsg').remove();
		}, 5000);
	});
	window.onload = function() {
		if (document.cookie) {
			document.cookie("auto-refresh=");
			window.location = window.location;
		}
	};
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/notice1.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Show Notice</h1>
		<h3>Edit Delete & Show</h3>
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
	<c:if test="${! empty msg}">
		<div class="successmsg">${msg}</div>
	</c:if>

	<br>

	<div class="span12" style="margin-left: 0px; width: 1059px;">
	</div>
	<div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div class="head blue">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Notice Details</h2>
			</div>
			<table class="table table-bordered table-primary"
				style="width: 1059px;">
				<thead>
					<tr>
						<th width="25%">Subject</th>
						<th width="20%">Date</th>
						<th width="25%">Description</th>
						<th width="25%">Generated By</th>
						<th width="30%" style="padding-right: 85px;">Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${noticeList}" var="list">
						<tr>
							<td>${list.noticeSubject}</td>
							<td>${list.noticeDate}</td>
							<td>${list.noticeDescription}</td>
							<td>${list.genratedBy}</td>
							<td><a href="view-notice-pdf?id=${list.noticeId}"
								title="Pdf" target="-blank"><img alt=""
									src="${img_url}/pdf_icon.gif" style="width: 20px;"></a> | <a
								href="edit.html?id=${list.noticeId}&pageno=${pageno}" title="Edit"><img
									alt="" src="${img_url}/Edit.jpg" style="width: 20px;"></a> |
								<a href="view.html?id=${list.noticeId}" title="View"><img
									alt="" src="${img_url}/view1.jpg" style="width: 25px;"></a> |<a
								href="delete.html?id=${list.noticeId}&pageno=${pageno}"
								title="Delete"><img alt="" src="${img_url}/delete.png"
									style="width: 20px;"></a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<table style="margin-left: 461px;">
				<tr style="width: 10px;">
					<c:if test="${pageno > 1}">
						<td style="text-align: left;"><a
							href="show-notice.html?pageno=${pageno - 1}">Previous</a></td>
					</c:if>
					<td style="text-align: center;">&nbsp;&nbsp;</td>
					<c:forEach begin="1" end="${totalNoOfPages}" var="i">
						<c:choose>
							<c:when test="${i==pageno}">
								<td style="text-align: left;"><c:out value="${i}"></c:out></td>
							</c:when>
							<c:otherwise>
								<td style="text-align: left;"><a
									href="show-notice.html?pageno=${i}"><c:out value="${i}"></c:out></a></td>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<td style="text-align: center;">&nbsp;&nbsp;</td>
					<c:if test="${pageno < totalNoOfPages}">
						<td style="text-align: left;"><a
							href="show-notice.html?pageno=${pageno + 1}">Next</a></td>
					</c:if>
				</tr>
			</table>
		</div>
	</div>

</div>