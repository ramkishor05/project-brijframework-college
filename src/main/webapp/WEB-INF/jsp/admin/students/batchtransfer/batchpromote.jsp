<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<spring:url value="/img" var="img_url" />
<spring:url value="/" var="base_url" />
<script type="text/javascript">
	function changefromsession(value) {
		
			$
					.ajax({
						type : "post",
						url : 'gettosession',
						data : {
							"sessionId" : value,
						},
						success : function(data) {
							$('#toSession').empty();
							var obj = JSON.parse(data);
							var content = '<option value="">Choose To Session</option>';
							$.each(obj, function(key, value) {
								content += '<option value="'+value.sessionId+'">'
										+ value.sessionDuration + '</option>';
							});
							$('#toSession').append(content);
						},error : function(e) {
							alert('Error: ' + e);
						}
					});
		/* var toSession = document.getElementById("toSession");
		for (i = value; i > 0; i--) {
			toSession.remove(i);
		} */
	}

	function getsection(value, id, index) {
		var toClassId = document.getElementById("toClassId");
		var toClassVar = parseInt(index) - 1;
		for (i = toClassVar; i > 0; i--) {
			toClassId.remove(i);
		}

		if ($("#fromSession").val() != "") {
			$.ajax({
				type : "post", 
				url : '${base_url}getsectionbyclassid',
				data : {
					"sessionId" : $("#fromSession").val(),
					"classId" : value,
				},
				success : function(data) {
					var obj = JSON.parse(data);
					var content = '<option value="">Choose Section</option>';
					$.each(obj, function(key, value) {
						content += '<option value="'+value.sectionId+'">'
								+ value.sectionName + '</option>';
					});
					if (id == "fromClassId") {
						$("#fromSectionId").empty();
						$("#fromSectionId").append(content);
					}
					if (id == "toClassId") {
						$("#toSectionId").empty();
						$("#toSectionId").append(content);
					}
				},
				error : function(e) {
					alert('Error: ' + e);
				}
			});
		} else {
			alert("Select Session First");
		}
	}
	function studentlist(sectionId) {
		if ($("#fromSession").val() != "") {
			$
					.ajax({
						type : "post",
						url : 'getstudentforbatchtransfer',
						data : {
							"classId" : +$("#fromClassId").val(),
							"sessionId" : $("#fromSession").val(),
							"sectionId" : sectionId
						},
						success : function(data) {
							$("#appendstudents").empty();
							var obj = JSON.parse(data);
							var content = '<div class="head blue"><div class="icon"><i class="ico-layout-9"></i></div><h2>Student List</h2></div><div class="data-fluid">';
							content += '<div role="grid" class="dataTables_wrapper" id="DataTables_Table_0_wrapper" style="overflow-y: scroll; height: auto; max-height: 400px;">';
							content += '<table cellspacing="0" cellpadding="0" width="100%" class="table dtable lcnp dataTable" id="DataTables_Table_0" style="width: 100%;">';
							content += '<thead> <tr role="row"> <th class="sorting_1" role="columnheader" rowspan="1" colspan="1" style="width: 93px;" aria-label="">';
							content += '<div style="margin-top: -25px;"><span><input type="checkbox" onclick="selectcheckbox(this.checked);"></span></div></th> <th width="20%" class="sorting" role="columnheader" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 192px;" aria-label="Name: activate to sort column ascending">Name</th>';
							content += '<th class="sorting" role="columnheader" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 211px;" aria-label="Product: activate to sort column ascending">Father Name</th></thead>';
							content += '<tbody role="alert" aria-live="polite" aria-relevant="all">';
							$
									.each(
											obj,
											function(key, value) {
												content += '<tr class="odd"><td class="sorting_1"><span><input type="checkbox" value="'+value.admissionNo+'" name="studentId" class="studentId"></span></td>';
												content += '<td class=" ">'
														+ value.firstName + ' '
														+ value.middleName
														+ ' ' + value.lastName
														+ '</td>';
												content += '<td class=" ">'
														+ value.fatherName
														+ '</td></tr>';
											});
							content += '<tr class="odd"><td></td><td></td><td><button class="btn" style="float: right; margin-right:500px;" type="submit">Batch Transfer</button></td></tr>';
							if (obj.length > 0) {
								$("#appendstudents").append(content);
							}
						},
						error : function(e) {
							alert('Error: ' + e);
						}
					});
		}
	}

	function selectcheckbox(flage) {
		var studentIds = document.getElementsByClassName("studentId");
		$.each(studentIds, function(key, value) {
			if (flage) {
				value.checked = true;
			} else {
				value.checked = false;
			}
		});
	}
	function formvalidate() {
		var flage = false;
		var studentIds = document.getElementsByClassName("studentId");
		$.each(studentIds, function(key, value) {
			if (value.checked) {
				flage = true;
			}
		});
		if (!flage) {
			alert("Please select atleast one student");
		}
		return flage;
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}/employeeImages/EmployeeAdd.png" style="width: 57px;">
		<h1>Batch Transfer</h1>
		<h3>Promote Students To Higher Class</h3>
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
	<c:if test="${not empty msg}">
		<div class="successmsg">${msg}</div>
	</c:if>
	<f:form action="transfer-batch.html" onsubmit="return formvalidate();"
		commandName="FeecategoryAmountDTO" method="POST">
		<div class="row-fluid">
			<div class="span6">
				<div class="block">
					<div class="data-fluid">
						<div class="row-form">
							<div class="span4">From Session:</div>
							<div class="span8">
								<f:select path="fromSession" id="fromSession"
									onchange="changefromsession(this.selectedIndex)"
									required="required" placeholder="choose a class">
									<option value="">Choose Session</option>
									<c:forEach items="${Sessiones}" var="Sessione">
										<option value="${Sessione.sessionId}">${Sessione.sessionDuration}</option>
									</c:forEach>
								</f:select>
							</div>
						</div>
						<div class="row-form">
							<div class="span4">From Class:</div>
							<div class="span8">
								<f:select path="fromClassId" id="fromClassId"
									required="required"
									onchange="getsection(this.value,this.id,this.selectedIndex);"
									placeholder="choose a class">
									<option value="">Choose Class</option>
									<c:forEach items="${Classes}" var="Classe">
										<option value="${Classe.classId}">${Classe.className}</option>
									</c:forEach>
								</f:select>
							</div>
						</div>
						<div class="row-form">
							<div class="span4">From Section:</div>
							<div class="span8">
								<f:select path="fromSectionId" id="fromSectionId"
									onchange="studentlist(this.value);" required="required"
									placeholder="choose a sections">
									<option value="">Choose Section</option>
								</f:select>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="span6">
				<div class="block">
					<div class="data-fluid">
						<div class="row-form">
							<div class="span4">To Session:</div>
							<div class="span8">
								<f:select path="toSession" id="toSession" required="required"
									placeholder="choose a class">
									<option value="">Choose To Session</option>
								<%-- 	<c:forEach items="${Sessiones}" var="Sessione">
										<option value="${Sessione.sessionId}">${Sessione.sessionDuration}</option>
									</c:forEach> --%>
								</f:select>
							</div>
						</div>
						<div class="row-form">
							<div class="span4">To Class:</div>
							<div class="span8">
								<f:select path="toClassId" id="toClassId" required="required"
									onchange="getsection(this.value,this.id);"
									placeholder="choose a class">
									<option value="">Choose Class</option>
									<c:forEach items="${Classes}" var="Classe">
										<option value="${Classe.classId}">${Classe.className}</option>
									</c:forEach>
								</f:select>
							</div>
						</div>
						<div class="row-form">
							<div class="span4">To Section:</div>
							<div class="span8">
								<f:select path="toSectionId" required="required"
									id="toSectionId" placeholder="choose a sections">
									<option value="">Choose Section</option>
								</f:select>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span12">
				<div class="block" id="appendstudents"></div>
			</div>
		</div>
	</f:form>
</div>