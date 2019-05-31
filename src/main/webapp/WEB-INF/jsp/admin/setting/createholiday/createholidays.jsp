<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script type="text/javascript">
	function createholiday(date) {
		$("#appendFeeCategoryId").empty();
		$("#holidayDate").val(date);
		$("#stateId").empty();
		$
				.ajax({
					type : "post",
					url : 'check-holidays.html',
					data : {
						"holidayDate" : date
					},
					success : function(data) {
						var obj = JSON.parse(data);
						if (obj.description == null) {
							$("#submitform").attr('action',
									'create-holidays.html')
						} else {

							var input = '<input type="hidden" value="'+obj.holidayId+'" name="holidayId">';
							$("#appendFeeCategoryId").append(input);
							$("#description").val(obj.description);
							$("#submitform")
									.attr('action', 'edit-holiday.html');

						}
					},
					error : function(e) {
						$('#loading').hide();
					}
				});
		$(".feecategorycreateedit").show();
	}
	function hidefeecategorycreateedit() {
		$("#description").val('');
		$("#holidayDate").val('');
		$(".feecategorycreateedit").hide();
	}
</script>
<style>
.feecategorycreateedit {
	display: none;
	background-color: white;
	border: 1px solid grey;
	width: 450px;
	height: 266px;
	border-radius: 6px;
	margin-top: 60px;
	left: 220px;
	z-index: 1;
	position: absolute;
	background-color: white;
}

.feecategorycreateedit-header {
	width: 450px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 50px;
}
</style>
<div class="feecategorycreateedit">
	<div class="feecategorycreateedit-header">
		<a href="javascript:hidefeecategorycreateedit();" class="close"
			data-dismiss="modal" style="margin-right: 10px; margin-top: 10px;"
			aria-hidden="true">×</a>
		<h3 id="myModalLabel">Create Holiday</h3>
	</div>
	<f:form commandName="HolidayDTO" action="create-holidays.html"
		method="POST" id="submitform">
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendFeeCategoryId"></div>
				<div class="row-form" style="height: 50px;">
					<div class="span12">
						<span class="top title">Holiday Date<font color="red">*</font>
							:
						</span>
						<f:input id="holidayDate" path="holidayDate" value=""
							maxlength="20" readonly="true"
							style="width: 266px; margin-top: -25px; margin-left: 122px;" />
						<div id="feeCategoryNamemsg"></div>
						<input type="hidden" id="hiddenclassname">
					</div>
				</div>
				<div class="row-form" style="height: 50px;">
					<div class="span12">
						<span class="top title">Description<font color="red">*</font>
							:
						</span>
						<f:input id="description" path="description" value=""
							maxlength="20"
							style="width: 266px; margin-top: -25px; margin-left: 122px;" />
						<div id="feeCategoryNamemsg"></div>
						<input type="hidden" id="hiddenclassname">
					</div>
				</div>
			</div>
		</div>
		<div class="feecategorycreateedit-footer" style="float: right">
			<button class="btn btn-primary" data-dismiss="modal" type="submit"
				id="submitbutton" aria-hidden="true">Save updates</button>
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidefeecategorycreateedit();"
				style="margin-right: 15px" aria-hidden="true">Close</a>
		</div>
		<div id="successmsg" style="display: none;">
			<font color="red">This Session Exist</font>
		</div>
	</f:form>
</div>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/createweekdays.png"
			style="width: 57px;">
		<h1>Home</h1>
		<h3>Create Holidays</h3>
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
				<div class="head blue">
					<%-- <div  style="float: left;">
							<a href="create-holidays.html?monthId=${MONTHID-1}">Preveous
								Month</a>
					</div> --%>
					<center>
						<h2>
							<a href="create-holidays.html?monthId=${MAP.MONTHID-1}&year=${MAP.YEAR}">Previous
								Month</a>
						</h2>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<h2 style="text-align: center;">${MAP.MONTHOfYEAR}</h2>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<h2><a href="create-holidays.html?monthId=${MAP.MONTHID+1}&year=${MAP.YEAR}">Next
								Month</a></h2>
					</center>
					<%-- <div style="float: left;">
							<a href="create-holidays.html?monthId=${MONTHID+1}">Next
								Month</a>
					</div> --%>

				</div>
				<div class="data-fluid">
					<table cellspacing="0" cellpadding="0" width="100%" class="table">
						<thead>
							<tr>
								<th width="14%" style="border: 1px solid red;">Sunday</th>
								<th width="14%" style="border: 1px solid red;">Monday</th>
								<th width="14%" style="border: 1px solid red;">Tuesday</th>
								<th width="14%" style="border: 1px solid red;">Wednesday</th>
								<th width="14%" style="border: 1px solid red;">Thursday</th>
								<th width="14%" style="border: 1px solid red;">Friday</th>
								<th width="14%" style="border: 1px solid red;">Saturday</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach items="${MAP.HOLIDAYSLIST}" var="Holiday"
								varStatus="count">
								<c:choose>
									<c:when test="${Holiday.description=='Sunday'}">
										<tr>	``````
											<td style="border: 1px solid red;"><font color="green"><b>${Holiday.description}</b>
													<c:if test="${Holiday.holidayCount!=0}">${Holiday.holidayCount}</c:if></font></td>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${Holiday.holidayCount=='0'}">
												<td style="border: 1px solid red;"></td>
											</c:when>
											<c:otherwise>
												<td style="border: 1px solid red;">
													<div style="width: 100%">
														<div style="width: 30%; float: left;">
															<fmt:parseDate type="date" value="${Holiday.holidayDate}"
																var="calenderDate" pattern="dd-MMM-yyyy" />
															<fmt:formatDate pattern="dd-MMM-yyyy" var="currentDate"
																value="<%=new java.util.Date()%>" />
															<fmt:parseDate value="${currentDate}" var="currentDate1"
																pattern="dd-MMM-yyyy" />
															<c:choose>
																<c:when test="${calenderDate>=currentDate1}">
																	<a
																		href="javascript:createholiday('${Holiday.holidayDate}')"
																		class="btn">${Holiday.holidayCount}</a>
																	<c:if test="${Holiday.description!=''}">
																		<a
																			href="delete-holiday.html?holidayId=${Holiday.holidayId}"
																			class="btn">Delete</a>
																	</c:if>
																</c:when>
																<c:otherwise>
																	<a href="javascript:void(0);" class="btn">${Holiday.holidayCount}</a>
																</c:otherwise>
															</c:choose>
														</div>
														<div style="width: 65%; float: left;">${Holiday.description}</div>
													</div>
												</td>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</div>
</div>