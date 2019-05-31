<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div class="content">
		<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/student_category.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Delete Student Categories</h1>
		<h3>Manage Student Categories</h3>
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


		<div class="widget-body" style="padding: 10px 0 0;">
			<div class="separator"></div>
			<div class="btn-group" style="width: 1059px;"></div>

			<c:if test="${msg!=null}">
				<div class="alert alert-success">
					<h5 align="center">
						<font color="red"><b>${msg}</b></font>
					</h5>
				</div>
			</c:if>
			<c:if test="${list.isEmpty()}">
				<div class="alert alert-success">
					<h5 align="center">
						<font color="red"><b>There are no categories</b></font>
					</h5>
				</div>
			</c:if>
			<c:if test="${!list.isEmpty()}">
				<div class="block">
					<div class="head blue">
						<div class="icon">
							<span class="ico-pen-2"></span>
						</div>
						<h2>Delete Categories</h2>
					</div>
					<table class="table table-bordered table-primary">
						<thead>
							<tr>
								<th>Category Name</th>
								<th>Operations</th>


							</tr>
						</thead>
						<c:forEach var="list" items="${list}">
							<tr>
								<td style="width: 200px;">${list.studentCategoriesName}</td>
								<td><a href="delete-categories?id=${list.studentCategoriesId}">Delete</a>
									<div id="exist"></div></td>
							</tr>


						</c:forEach>

					</table>
				</div>
			</c:if>
		</div>

	</div>


</body>
</html>