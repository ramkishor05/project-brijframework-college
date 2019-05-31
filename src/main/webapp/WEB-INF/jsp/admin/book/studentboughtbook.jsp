<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">


<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/book1.jpg"
			style="width: 57px;">
		<h1>Sell Books</h1>
		<h3>Sell books to students</h3>
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
	<br>


	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div
					style="border: 1px solid; border-radius: 10px; height: 129px; width: 577px; margin-top: -4px; padding-top: 10px; padding-left: 20px;"
					id="box">
					<table style="width: 600px; margin-left: 10px; margin-top: 7px;">
						<tbody>
							<tr>
								<td width="25%"><span><font size="2"><b>Name:</b></font></span></td>
								<td width="25%"><span><font size="2">${student.firstName}&nbsp; ${student.middleName}&nbsp; ${student.lastName}</font></span></td>
							</tr>
							<tr>
								<td width="25%"><span><font size="2"><b>Father Name:</b></font></span></td>
								<td width="25%"><span><font size="2">${student.fatherName}</font></span></td>
								<td width="25%"><span></span></td>
								<td width="25%"><span></span></td>
							</tr>
							<tr></tr>
							<tr>
								<td width="25%"><span><font size="2"><b>Class</b></font></span></td>
								<td width="25%"><span><font size="2">${student.className}</font></span></td>
								<td width="25%"><span><font size="2"><b>Section</b></font></span></td>
								<td width="25%"><span><font size="2">${student.sectionName}</font></span></td>
							</tr>
							<tr>
								<td width="25%"><span><font size="2"><b>Mobile No:</b></font></span></td>
								<td width="25%"><span><font size="2">${student.mobile}</font></span></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<c:forEach var="value" items="${list}" varStatus="loop" begin="0" end="0">
	<c:choose>
	
	<c:when test="${value.feeCategoryName =='no'}">
	<div class="failedmsg" style="margin-top: 146px;">Books cannot be alloted because fees is paid for the whole session</div>
	</c:when>
	<c:otherwise>
		<div class="span12" style="margin-left: 0px; width: 1059px;"></div>

	<div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div class="head blue">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Fee Allotments for ${value.monthName}</h2>
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
						<th>Fee Category</th>
						<th>Amount</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="list" items="${list}" varStatus="loop">
							<tr>
								<td>${list.feeCategoryName}</td>
								<td>${list.amounts}</td>
									</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>

		</div>
	</div>
	
	</c:otherwise>
	</c:choose>
	</c:forEach>
	</div>