<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<spring:url value="/img" var="img_url" />
<spring:url value="/" var="base_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<script>
	function getStudentlistByClassId(classId) {

		$
				.ajax({
					type : "post",
					url : 'getStudentConcessionListByClassId',
					data : {
						'classId' : +classId
					},
					success : function(data) {
						var obj = JSON.parse(data);
						
						$("#concessionList").empty();
						var content = '<table class="table table-bordered table-primary"><thead><tr><th>Student Adm.No</th><th>Name</th>'
						content += '<th>Father Name</th><th>Class</th><th>Concession</th><th>Fee Category</th><th>Reason For Concession</th><th>Concession By</th></thead>';
						if (obj.length > 0) {
							for (var i = 0; i < obj.length; i++) {
								content += '<tr>'
								content += '<td style="width: 200px;"><a href="show-student-details?id='+obj[i].studentAdmissionNo+'">'
										+ obj[i].studentAdmissionNo+'</td>'
								        +'<td>' + obj[i].studentFullName
										+ '</td>' + '<td>' + obj[i].fatherName
										+ '</td>' + '<td>' + obj[i].className
										+ '</td>' + '<td>' + obj[i].discount
										+ '</td>' + '<td>'
										+ obj[i].feeCategoryName + '</td>'
										+ '<td>' + obj[i].reasonForDiscount
										+ '</td>' + '<td>'
										+ obj[i].discountGivenBy + '</td>'
										+ '</tr>'
							}
						} else {
							var content = '<table class="table table-bordered table-primary"><thead><tr><th>Student Adm.No</th><th>Name</th>'
								content += '<th>Father Name</th><th>Class</th><th>Concession</th><th>Fee Category</th><th>Reason For Concession</th><th>Concession By</th></thead>'

							content += '<tr><td colspan="8"><font color="red">No Record Fount</font></td></tr>';
						}
						content += '</table>'
						$("#concessionList").append(content);

					},
					error : function(e) {

					}
				});

	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/student_profile.jpg"
			style="width: 74px; margin-top: -15px;">
		<h1>Discounted Student List</h1>
		<h3>Students Alloated Discount</h3>
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
</div>
<div style="padding: 10px 0 0;" class="widget-body">
	<div class="separator"></div>
	<div style="width: 1059px;" class="btn-group"></div>
	<select name="classId"
		style="width: 200px; margin-left: 858px; margin-top: -1px;"
		onchange="getStudentlistByClassId(this.value)"><c:forEach
			items="${classesList}" var="list">
			<option value="${list.classId}">${list.className}</option>
		</c:forEach></select>
		<a class="btn btn-primary" href="discount-concession-list-PDF">Concession PDF</a>
	<div class="block">
		<div style="height: 30px; padding: 0.5px 0 0 20px;" class="head blue">
			<h4>Students List</h4>
		</div>
		<div id="concessionList">
			<table class="table table-bordered table-primary">
				<thead>
					<tr>
						<th>Student Adm.No</th>
						<th>Name</th>
						<th>Father Name</th>
						<th>Class</th>
						<th>Concession</th>
						<th>Fee Category</th>
						<th>Reason For Concession</th>
						<th>Concession By</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach items="${editFeeList}" var="list">
						<tr>
							<td style="width: 200px;"><a href="show-student-details?id=${list.studentAdmissionNo}"></a>${list.studentAdmissionNo}</td>							<td>${list.studentFullName}</td>
							<td>${list.fatherName}</td>
							<td>${list.className}</td>
							<td>${list.discount}</td>
							<td>${list.feeCategoryName}</td>
							<td>${list.reasonForDiscount}</td>
							<td>${list.discountGivenBy}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>