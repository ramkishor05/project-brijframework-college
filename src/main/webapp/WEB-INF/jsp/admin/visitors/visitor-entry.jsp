<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:url value="/style/theme/images/back.png" var="backurl" />
<c:url value="/style/theme/images/admission_page_logo.jpg"
	var="StudentAddLogo" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<spring:url value="/style/datepicks" var="datepicks" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">

<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>
<script type="text/javascript">
	function date() {
		$('#admissionDate').datepick(
				{
					dateFormat : "yyyy-mm-dd",
					inline : true,
					onSelect : function(dateText, inst) {
						var date = $(this).datepick('getDate')
						var formatedDate = $.datepicker.formatDate('yy-mm-dd',
								new Date(date));
						getData(formatedDate);
					}
				});
	}
	function getData(date) {
	
		$("#appendData").empty();
		$
				.ajax({
					type : "post",
					url : 'visitor.html',
					data : {
						'date' : date,
					},
					success : function(data, status) {
						$("#sectionId").empty();
						var obj = JSON.parse(data);
						var appendData = '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div>';
						appendData += '<h2>Visitors List&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=javascript:getData("'
								+ obj.yesterDayDate
								+ '"); ><<</a>'
								+ date
								+ '<a href=javascript:getData("'
								+ obj.tommarowDayDate + '"); >>></a></h2>';
						appendData += '<ul class="buttons"><li><a id="admissionDate" href="javascript:date();" class="btn">Calenders</a></li></ul></div>';
						appendData += '<table class="table table-bordered table-primary">';
						appendData += '<thead><tr><th>Visibility</th><th>Name</th><th>Phone No</th><th>Address</th><th>Purose</th><th>To-Meet</th>';
						appendData += '<th>In Time</th><th>Out Time</th><th>Operations</th></tr></thead><tbody>';
						$
								.each(
										obj.VisitorsDetailsList,
										function(key, value) {
											appendData += '<tr>';
											if (value.outTime == null) {
												appendData += '<td><font size="6" color="green">*</font></td>';
											} else {
												appendData += '<td><font size="6" color="red">*</font></td>';
											}
											appendData += '<td>'
													+ value.visitorName
													+ '</td><td>'
													+ value.mobileNo + '</td>';
											appendData += '<td>'
													+ value.address
													+ '</td><td>'
													+ value.purpose
													+ '</td><td>'
													+ value.toMeet + '</td>';
											appendData += '<td>' + value.inTime
													+ '</td>';

											if (value.outTime == null) {
												appendData += '<td>hh:mm:ss</td><td><a href="update-visitors.html?visitorId='
														+ value.visitorId
														+ '&outDate='
														+ date
														+ '">Out</a></td>';
											} else {
												appendData += '<td>'
														+ value.outTime
														+ '</td><td>Out</td>';
											}
											appendData += '</tr>';
										});
						appendData += '</tbody></table>';
						$("#appendData").append(appendData);
					},
					error : function(e) {
						
					}
				});

	}
	function getvisitorbyname(value) {
		$("#appendData").empty();
		$
				.ajax({
					type : "post",
					url : 'filter-visitors.html',
					data : {
						'visitorName' : value,
					},
					success : function(data, status) {
						$("#sectionId").empty();
						var obj = JSON.parse(data);
						var appendData = '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div>';
						appendData += '<h2>Visitors List</h2>';
						appendData += '<ul class="buttons"><li><a id="admissionDate" href="javascript:date();" class="btn">Calenders</a></li></ul></div>';
						appendData += '<table class="table table-bordered table-primary">';
						appendData += '<thead><tr><th>Visibility</th><th>Name</th><th>Phone No</th><th>Address</th><th>Purose</th><th>To-Meet</th><th>Visited Date</th>';
						appendData += '<th>In Time</th><th>Out Time</th><th>Operations</th></tr></thead><tbody>';
						$
								.each(
										obj,
										function(key, value) {
											appendData += '<tr>';
											if (value.outTime == null) {
												appendData += '<td><font size="6" color="green">*</font></td>';
											} else {
												appendData += '<td><font size="6" color="red">*</font></td>';
											}
											appendData += '<td>'
													+ value.visitorName
													+ '</td><td>'
													+ value.mobileNo + '</td>';
											appendData += '<td>'
													+ value.address
													+ '</td><td>'
													+ value.purpose
													+ '</td><td>'
													+ value.toMeet
													+ '</td><td>'
													+ $.datepicker
															.formatDate(
																	'yy-mm-dd',
																	new Date(
																			value.visitDate))
													+ '</td>';
											appendData += '<td>' + value.inTime
													+ '</td>';

											if (value.outTime == null) {
												appendData += '<td>hh:mm:ss</td><td><a href=update-visitors.html?visitorId='
														+ value.visitorId
														+ '&outDate='
														+ $.datepicker
																.formatDate(
																		'yy-mm-dd',
																		new Date())
														+ '>Out</a></td>';
											} else {
												appendData += '<td>'
														+ value.outTime
														+ '</td><td>Out</td>';
											}
											appendData += '</tr>';
										});
						appendData += '</tbody></table>';
						$("#appendData").append(appendData);
					},
					error : function(e) {
						
					}
				});
	}
</script>


<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}/employeeImages/EmployeeAdd.png" style="width: 57px;">
		<h1>Add Visitor Details</h1>
		<h3>Add View Visitors</h3>
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
	<c:if test="${msg!=null}">
		<div id="successmsg">${msg}</div>
	</c:if>


	<f:form id="validate" method="POST" name="myForm"
		enctype="multipart/form-data" action="add-visitors.html"
		commandName="VisitorsDetails">
		<div class="row-fluid">
			<div class="span6">
				<div class="block">
					<div class="head"></div>
					<div class="data-fluid">
						<!-- <div id="wizard_validate-titles" class="stepy-titles"></div> -->
						<div class="row-form">
							<div class="span3">
								Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<f:input path="visitorName" id="visitorName" maxlength="30"
									class="validate[required,minSize[2],custom[onlyLetterSp]]" />
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Mobile No:<font color="red">*</font>
							</div>
							<div class="span2">
								<input type="text" readonly="readonly" value="+91">
							</div>
							<div class="span7">
								<!-- <input type="text" name="mobile" id="mobile" maxlength="10"
									placeholder="Enter 10 Digit Number"
									class="validate[required,custom[integer],minSize[10],maxSize[10]]"> -->
								<f:input path="mobileNo" id="mobileNo" maxlength="10"
									class="validate[required,custom[integer],minSize[10],maxSize[10]]" />
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Address:<font color="red">*</font>
							</div>
							<div class="span9">
								<f:textarea path="address" id="address" maxlength="200"
									class="validate[required,minSize[4],custom[onlyLetterSp]]"></f:textarea>
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Purpose:<font color="red">*</font>
							</div>
							<div class="span9">
								<f:input path="purpose" id="purpose" maxlength="40"
									class="validate[required,minSize[4],custom[onlyLetterSp]]" />
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Contact Person:<font color="red">*</font>
							</div>
							<div class="span9">
								<f:input path="toMeet" id="toMeet" maxlength="40"
									class="validate[required,minSize[4],custom[onlyLetterSp]]" />
							</div>
						</div>
						<div class="row-form">
							<div class="span3"></div>
							<div class="span9">
								<button class="btn" type="submit">Add</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</f:form>
	<%-- <c:if test="${not empty VisitorsDetailsList}"> --%>
	<div class="row-fluid">
		<div class="span6">
			<div class="block"></div>
		</div>
		<div class="span6">
			<div class="block">
				<div class="data-fluid">
					<div class="row-form">
						<div class="span7"></div>
						<div class="span2">Filter</div>
						<div class="span3">
							<input type="text" onkeyup="getvisitorbyname(this.value);"
								placeholder="Name" style="float: right;">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="block" id="appendData">
		<div class="head blue">
			<div class="icon">
				<span class="ico-pen-2"></span>
			</div>
			<h2>
				Visitors
				List&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
					href='javascript:getData("${map.yesterDayDate}");'><<</a>
				<c:set var="currentDate"></c:set>
				<fmt:formatDate var="Date" pattern="yyyy-M-dd"
					value="<%=new java.util.Date()%>" />
				<c:choose>
					<c:when test="${map.currentDate==''}">
						${Date}
						<c:set var="currentDate" value="${Date}"></c:set>
					</c:when>
					<c:otherwise>${map.currentDate}<c:set
							var="currentDate" value="${map.currentDate}"></c:set>
					</c:otherwise>
				</c:choose>
				<a href="javascript:getData('${map.tommarowDayDate}');">>></a>
			</h2>

			<ul class="buttons">
				<li><a id="admissionDate" href="javascript:date();" class="btn">Calenders</a></li>
			</ul>
		</div>

		<table class="table table-bordered table-primary">
			<thead>
				<tr>
					<th>Visibility</th>
					<th>Name</th>
					<th>Phone No</th>
					<th>Address</th>
					<th>Purose</th>
					<th>To Meet</th>
					<th>In Time</th>
					<th>Out Time</th>
					<th>Operations</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${map.VisitorsDetailsList}" var="VisitorsDetail">
					<tr>
						<c:choose>
							<c:when test="${VisitorsDetail.outTime==null}">
								<td><font size="6" color="green">*</font></td>
							</c:when>
							<c:otherwise>
								<td><font size="6" color="red">*</font></td>
							</c:otherwise>
						</c:choose>
						<td>${VisitorsDetail.visitorName}</td>
						<td>${VisitorsDetail.mobileNo}</td>
						<td>${VisitorsDetail.address}</td>
						<td>${VisitorsDetail.purpose}</td>
						<td>${VisitorsDetail.toMeet}</td>
						<td>${VisitorsDetail.inTime}</td>
						<c:choose>
							<c:when test="${VisitorsDetail.outTime==null}">
								<td>hh:mm:ss</td>
								<td><a
									href="update-visitors.html?visitorId=${VisitorsDetail.visitorId}&outDate=${currentDate}">Out</a></td>
							</c:when>
							<c:otherwise>
								<td>${VisitorsDetail.outTime}</td>
								<td>Out</td>
							</c:otherwise>
						</c:choose>

					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<%-- </c:if> --%>
</div>