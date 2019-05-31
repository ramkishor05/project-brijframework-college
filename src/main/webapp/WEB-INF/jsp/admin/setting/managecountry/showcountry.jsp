<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/country.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>View Country</h1>
		<h3>Manage Countries</h3>
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

	<div class="span12" style="margin-left: 0px; width: 1059px;">
		<%
			Object msg = request.getAttribute("msg");
			if (msg != null) {
		%>

		<div class="failedmsg" style="height: 36px;">
			<h5 align="center">
				<font color="red"><b>${msg}</b></font>
			</h5>
		</div>
		<%
			}
		%>
	</div>
	<div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div class="head blue">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Default</h2>
				<ul class="buttons">
					<li><a return false; href="#"><div class="icon">
								<span class="ico-info"></span>
							</div></a></li>
				</ul>
			</div>

			<table class="table table-bordered table-primary"
				style="width: 1059px;">
				<thead>
					<tr>
						<th>Country Name</th>
						<!-- <th>Country Code</th> -->
						<th>Operations</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${countrylist}" varStatus="loop">
						<tr>
							<td class="center"><font size="2">${list.countryName}</font></td>
						<%-- 	<td>${list.countryCode}</td> --%>
							<td class="center"><a href="editcountry?id=${list.id}"><font
									size="2">Edit</b></font></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

</div>

