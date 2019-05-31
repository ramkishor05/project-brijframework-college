<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">



<div class="content">
	<div id="content-header" style="height: 140px;">
		<img alt="Show_settings" src="${img_url}/collection.jpg"
			style="width: 50px;">
		<h1>All defaulters List</h1>
		<h3>Check Fee Defaulter Students</h3>
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
<div style="float:right;">
		<a href="pdf-alldefaulters" target="_blank"><span class="label label-success" style="margin-top: 20px;">View Report</span></a>
			
	</div>
	<br>
	<div class="span12" style="margin-left: 0px; width: 1059px;"></div>

	<div style="padding: 10px 0 0;" class="widget-body" style="padding: 10px 0px 0px; margin-top: 30px;">
		<div class="block">
			<div class="head blue">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Alter Fee Dateils</h2>
				<ul class="buttons">
					<li><a return false; href="#"><div class="icon">
								<span class="ico-info"></span>
							</div></a></li>
				</ul>
			</div>
			<div class="data-fluid">
				<table class="table fTable lcnp" style="width: 1059px;">
					<thead>
						<tr>
							<th>S No.</th>
							<th>Fee Category</th>
							<th>Amount</th>
							<th>Section</th>
							<th>Balance Amount</th>
							<th>Mobile</th>
							<th>Address</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${defaulterlist}"
							varStatus="loop">
							<tr>
								<td class="center"><font size="2">${list.admissionNo}</font></td>
								<td class="center"><font size="2">${list.fullName}</font></td>
								<td class="center"><font size="2">${list.className}</font></td>
								<td class="center"><font size="2">${list.sectionName}</font></td>
								<td class="center"><font size="2">${list.balanceAmount}</font></td>
								<td class="center"><font size="2">${list.mobile}</font></td>
								<td class="center"><font size="2">${list.addressLine1}</font></td>
							</tr>
						</c:forEach>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							
						</tr>
					</tbody>
				</table>
			</div>
			<table style="margin-left: 461px;">
				<tr style="width: 10px;">
					<c:if test="${pageno > 1}">
						<td style="text-align: left;"><a
							href="all-defaulters?pageno=${pageno - 1}">Previous</a></td>
					</c:if>
					<td style="text-align: center;">&nbsp;&nbsp;</td>
					<c:forEach begin="1" end="${totalNoOfPages}" var="i">
						<c:choose>
							<c:when test="${i==pageno}">
								<%-- <c:if test="${totalNoOfPages>1}"> --%>
								<td style="text-align: left;"><c:out value="${i}"></c:out></td>
								<%-- </c:if> --%>
							</c:when>
							<c:otherwise>
								<td style="text-align: left;"><a
									href="all-defaulters?pageno=${i}"><c:out
											value="${i}"></c:out></a></td>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<td style="text-align: center;">&nbsp;&nbsp;</td>
					<c:if test="${pageno < totalNoOfPages}">
						<td style="text-align: left;"><a
							href="all-defaulters?pageno=${pageno + 1}">Next</a></td>
					</c:if>
				</tr>
			</table>
		</div>
	</div>
</div>