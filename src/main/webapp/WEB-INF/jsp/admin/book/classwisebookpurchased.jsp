<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<spring:url value="/img" var="img" />
<spring:url value="/style/js" var="words" />
<script type="text/javascript" src="${words}/towards.js">
	
</script>

<script>
	function getSectionList(id) {

		$("#sectionId").empty();
		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {

				var j = JSON.parse(data);
				var content = '<option value="">Select Section</option>';
				for (var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].sectionId+'>'
							+ j[i].sectionName + '</option>';
				}
				$("#sectionId").append(content);

			},
			error : function(e) {

			}
		});

	}
	function getbookdetails() {
		var classId = $("#classId").val();
		var sessionId = $("#sessionId").val();
		var sectionId = $("#sectionId").val();
		$("#bookList")
				.append(
						'<center><img src="${img}/loads.gif" alt="Loading" style="width=200px;height=200px;"></center>');
		$
				.ajax({
					type : "post",
					url : 'getClasswisePurchasedBook',
					data : {
						'classId' : classId,
						'sessionId' : sessionId,
						'sectionId' : sectionId,

					},
					success : function(data, status) {
						$("#bookList").empty();
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>No Data found</b></font></h5></div>';
						} else {

							st = st
									+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block"  style="width: 626px; height: 208px; top: 53px;"><div class="head blue"><h4 style="text-align:center"> Purchased Book details</h4></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Subject</th><th>Book Title</th><th>Student Price</th><th>Quantity</th><th>Amount</th><th>Net Amount</th><th>Date</th><th>Supplier</th></tr></thead><tbody>';
							for (var i = 0; i < length; i++) {
								st += '<tr><td>' + (i + 1) + '</td><td>'
										+ j[i].subjectName + '</td><td>'
										+ j[i].bookTitle + '</td><td>'
										+ j[i].bookPrice + '</td><td>'
										+ j[i].boughtQuantity + '</td><td>'
										+ j[i].amount + '</td><td>'
										+ j[i].netAmount + '</td><td>'
										+ j[i].dateOfPurchase + '</td><td>'
										+ j[i].supplierName + '</td></tr>';
							}
							st += '</table>';
						}
						$("#bookList").append(st);
					},
					error : function(error, status) {
					}
				});
	}
</script>


<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/book1.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>View details of books purchased</h1>
		<h3>ClassWise Purchased Book Details</h3>
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

	<table
		style="width: 466px; height: 82px; margin-left: 231px; margin-top: 1px;">

		<tr>
			<td style="width: 200px;">Session</td>
			<td><select name="sessionId" class="form-control input-sm"
				id="sessionId" x-data-toggle-x="tooltip" onchange="getClear();"
				title="Specify the session of the student" required="required"
				data-original-title="Specify session">
					<c:forEach var="list" items="${sessionList}">
						<c:choose>
							<c:when test="${current.sessionId==list.sessionId}">
								<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
							</c:when>
							<c:otherwise>
								<option value="${list.sessionId}">${list.sessionDuration}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
			</select></td>

		</tr>
		<tr style="height: 0px;">
			<td style="width: 36px;">Class</td>
			<td><select id="classId" onchange="getSectionList(this.value);"
				style="width: 260px;" name="classId">
					<option value="">Select a class</option>
					<c:forEach var="list" items="${classList}">
						<option value="${list.classId}">${list.className}</option>
					</c:forEach>
			</select></td>

		</tr>

		<tr>
			<td style="width: 200px;">Section<font color="red">*</font></td>
			<td><select id="sectionId" class="validate[required]"
				style="width: 260px;" onchange="getbookdetails();" name="sectionId"
				class="select" required="required">
					<option value="">Select a Section</option>
			</select></td>
			<td><div id="sectionmsg"></div></td>
		</tr>


	</table>

	<div class="separator"></div>
	<hr>

	<div id="bookList" style="width: 852px; margin-left: 170px;"></div>

	<div class="separator"></div>

	<div id="err" class="form-inline">
		<p id="v1"></p>

	</div>


</div>
