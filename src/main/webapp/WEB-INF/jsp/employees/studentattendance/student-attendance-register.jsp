<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<spring:url value="/js" var="js_url" />
<spring:url value="/" var="baseUrl" />

<c:url value="/style/theme/images" var="hr1" />
<c:url value="/style/theme/images" var="backurl" />

<div class="content">
	<div class="page-header">
		<div class="icon">
			<span class="ico-pen-2"></span>
		</div>
		<h1>
			Attendance <small>Attendance Register</small>
		</h1>
		<div class="buttons pull-right">
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

	<script type="text/javascript">
		function getSectionList(id) {
			$.ajax({
				type : "post",
				url : 'getsectionlist/' + id,
				success : function(data, status) {
					$("#sectionId").empty();
					var j = JSON.parse(data);
					var content = '<option value="">Select Section</option>';
					for ( var i = 0; i < j.length; i++) {
						content += '<option value='+j[i].sectionId+'>'
								+ j[i].sectionName + '</option>';
					}
					$("#sectionId").append(content);
				},
				error : function(e) {
					alert('Error: ' + e);
				}
			});
		}

		function saveAttendanceRecord(title, todate, id) {
			var classId = $('#classId').val();
			var sectionId = $('#sectionId').val();
			$.ajax({
				type : 'post',
				url : 'setattendencerecord',
				data : {
					'id' : id,
					'title' : title,
					'classId' : classId,
					'sectionId' : sectionId,
					'cd' : todate
				},
				error : function(e) {
					alert('error in data');
				}
			});
		}

		function getRegister() {
			var id1 = $('#classId').val();
			var id2 = $('#sectionId').val();
			var url = 'attendance-register/' + id1 + '/' + id2;
			$
					.ajax({
						url : url,

						type : 'POST',
						success : function(data, status) {
							$("#AttendanceList").empty();
							var cDate = new Date;
							var dmy = cDate.getFullYear() + '-'
									+ (cDate.getMonth() + 1) + '-'
									+ cDate.getDate();
							var j = JSON.parse(data);
							if (j != '' || j != null) {
								var length = j.length;
								var st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
										+ '</div><div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Attendance Report</h2></div>'
										+ '<table class="table table-bordered table-primary"><tr><td></td>';
								var arr = [];
								for ( var i = 0; i < 1; i++) {
									var attenDanceList = j[i].studentAttendanceDTOs;
									for ( var k = 0; k < attenDanceList.length; k++) {
										arr
												.push(attenDanceList[k].dateOfAttendance);
										st = st
												+ '<td><b>'
												+ attenDanceList[k].attendanceDate
												+ '</b></td>';
									}
									if (attenDanceList == '') {
										st += '<td>' + dmy + '</td></tr>';
									} else if (attenDanceList[attenDanceList.length - 1].status != "true") {
										st += '<td>' + dmy + '</td></tr>';
									}
								}
								for ( var i = 0; i < length; i++) {
									var attenDanceList = j[i].studentAttendanceDTOs;
									st = st + '</tr><tr><td><b>'
											+ j[i].fullName + '</b></td>';

									for ( var m = 0, l = 0; m < arr.length,
											l < attenDanceList.length; m++, l++) {
										if (attenDanceList[l].attendanceStatus == "P") {
											if (attenDanceList[l].status != "true") {
												st += '<td>P</td>'
											} else { 
												st += '<td><select class="attendanceStatus" required="required" onChange=saveAttendanceRecord(this.value,"'
														+ dmy
														+ '","'
														+ j[i].admissionNo
														+ '");><option value="A">A</option><option value="P" selected="selected">P</option></select></td>';
											}
										} else if (attenDanceList[l].attendanceStatus == "A") {
											 if (attenDanceList[l].status != "true") {
												st += '<td>A</td>'
											} else { 
												st += '<td><select class="attendanceStatus" required="required" onChange=saveAttendanceRecord(this.value,"'
														+ dmy
														+ '","'
														+ j[i].admissionNo
														+ '");><option value="A" selected="selected">A</option><option value="P">P</option></select></td>';
											 } 
										} else {
											st += '<td>-</td>';
											if (attenDanceList.length < arr.length
													&& m < arr.length - 1) {
												l--;
											}
										}
									}
									if (attenDanceList == ''
											|| attenDanceList == null
											|| attenDanceList.length == 0) {
										if (arr[arr.length - 1] == dmy) {
											for ( var a = 0; a < arr.length - 1; a++) {
												st += '<td>-</td>';
											}
										} else {
											for ( var a = 0; a < arr.length; a++) {
												st += '<td>-</td>';
											}
										}

										st += '<td><select required="required" onChange=saveAttendanceRecord(this.value,"'
												+ dmy
												+ '","'
												+ j[i].id
												+ '");><option value=" "></option><option value="A">A</option><option value="P">P</option></select></td>';
									} else if (attenDanceList[attenDanceList.length - 1].status != "true") {
										st += '<td><select required="required" onChange=saveAttendanceRecord(this.value,"'
												+ dmy
												+ '","'
												+ j[i].id
												+ '");><option value=" "></option><option value="A">A</option><option value="P">P</option></select></td>';
										st = st + '</tr>';
									}
								}
								st = st + '</table>';
								$("#AttendanceList").append(st);
							} else {
								$("#AttendanceList").append('Data Not Found');
							}
						},
						error : function(error, status) {
							alert("bad");

						}
					});
		}
	</script>
	<f:form method="post" modelAttribute="studentAttendance">
		<div
			class="widget widget-2 widget-tabs widget-tabs-2 tabs-right border-bottom-none"></div>
		<div class="row-form" style="margin-top: -160px;">
			<div class="span2">
				Class :<font color="red">*</font>
			</div>
			<div class="span4">
				<select id="classId" class="validate[required]"
					style="width: 250px;" onchange="getSectionList(this.value);"
					name="classId" class="select">
					<option value="">Select a Class</option>
					<c:forEach var="list" items="${Classes}">
						<option value="${list.classId}">${list.className}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="row-form">
			<div class="span2">
				Section<font color="red">*</font>:
			</div>
			<div class="span4">
				<select id="sectionId" class="validate[required]"
					onchange="getRegister();" style="width: 250px;" name="sectionId"
					class="select">
					<option value="">Select a Section</option>
				</select>
			</div>
		</div>
		<div id="AttendanceList"></div>
	</f:form>
</div>