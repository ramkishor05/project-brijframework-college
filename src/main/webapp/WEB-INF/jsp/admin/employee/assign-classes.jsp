<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/js" var="js_url" />
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<script type="text/javascript">
	function getClassesAssign(employeeId) {
		$('#alertmsg').empty();
		$("#classId").val('');
		$
				.ajax({
					type : 'get',
					url : 'getclassassigned',
					data : {
						'employeeId' : employeeId
					},
					success : function(data) {
						$('#ShowDetails').empty();
						$('#msg').empty();
						var value = JSON.parse(data);
						
						if(value.length==0)
							{
							$("#some").show();
							$('#alertmsg').empty();
							}
						else
							{
						var classAssignDetails = '<table class="table table-bordered table-primary"style="width: 1059px;">'
								+ '<thead><tr><th>SL No.</th><th>Employee Id</th><th>Employee Name</th><th>Class Name</th><th>Section Name</th><th>Action</th></tr></thead>';
						for ( var i = 0; i < value.length; i++) {
							classAssignDetails += '<tbody><tr><td>'
									+ (i + 1)
									+ '</td><td>'
									+ value[i].employeeId
									+ '</td><td>'
									+ value[i].employeeFullName
									+ '</td><td>'
									+ value[i].className
									+ '</td><td>'
									+ value[i].sectionName
									+ '</td><td><a href="javaScript:delateClassAssigned('
									+ value[i].assignClassId + ');">Delete</a>'
									+ '</td><td>';
						}
						classAssignDetails += '</tbody></table>';
						$('#ShowDetails').append(classAssignDetails);
						$("#some").hide();
						$('#alertmsg')
						.append(
								'<div style="color:red;">*This teacher has been already assigned a class</div>');
							}
					},
					error : function(e) {
						
					}
				});
	}
	function checkClassesAssign(sectionId) {
		
		var classId=$("#classId").val();
		$
				.ajax({
					type : "post",
					url : 'checkclassassign',
					data : {
						'classId' : classId,
						'sectionId': sectionId,
					},
					success : function(data) {
						$('#subButton').show();
						$('#msg').empty();
						$('#alertmsg').empty();
						var status = JSON.parse(data);
						if (status == 'true')
							{
							
							}
						else
						{
							$('#subButton').hide();
							$('#alertmsg')
									.append(
											'<div style="color:red;">*This Class Is Already Assigned To  "'+status+' "</div>');
						}
					},
					error : function(e) {
						
					}
				});
	}
	function delateClassAssigned(id) {
		$
				.ajax({
					type : "post",
					url : 'deleteclassassigned',
					data : {
						'classAssignId' : id,
					},
					success : function(data) {
						$('#alertmsg').empty();
						$('#msg').empty();
						var status = JSON.parse(data);
						if (status == true) {
							$('#alertmsg')
									.append(
											'<div class="successmsg">Assigned Class Deleted Successfully.</div>');
							getClassesAssign($('#employeeId').val());
						}
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
	function getSectionList(id) {
		$("#sectionId").empty();
		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {

				var j = JSON.parse(data);
				var content = '<option value="">Select Section</option>';
				for ( var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].sectionId+'>'
							+ j[i].sectionName + '</option>';
				}
				$("#sectionId").append(content);
			},
			error : function(e) {

			}
		});
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/takeattendance.png"
			style="width: 57px;">
		<h1>Classes Assign</h1>
		<h3>Classes Assign To Teacher</h3>
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

	<f:form commandName="AssignClassDTO" method="POST" id="validate"
		action="assign-classes">
		<div id="searches" style="height: auto; width: auto;">
			<br> <br> <br>
			<table>
				<tr>
					<td style="width: 200px;">Select Teacher</td>
					<td><select id="employeeId" class="validate[required]"
						style="width: 250px;" onchange="getClassesAssign(this.value);"
						name="employeeId" class="select">
							<option value="">Select a Teacher</option>							<c:forEach var="list" items="${TeacherList}">
								<option value="${list.employeeId}">${list.firstName}</option>
							</c:forEach>
					</select></td>
				</tr>
				</table>
				
				<div id="some">
				<table>
				<tr>
					<td style="width: 200px;">Select Class</td>
					<td><select id="classId" class="validate[required]"
					        onchange="getSectionList(this.value);"
						style="width: 250px;" 
						name="classId" class="select">
							<option value="">--Choose A Class--</option>
							<c:forEach var="list" items="${ClassesList}">
								<option value="${list.classId}">${list.className}</option>
							</c:forEach>
					</select></td>
				</tr>
					<tr>
					<td style="width: 200px;">Select Section :</td>
					<td><select id="sectionId" class="validate[required]"
						style="width: 250px;"onchange="checkClassesAssign(this.value);"
						name="sectionId" class="select">
							<option value="">Select Section</option>
					</select></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<div id="subButton" style="width: 654px; float: left;">
							<input type="submit" value="Assign Class">
						</div>
					</td>
				</tr>
				</table>
				</div>
		
			<div id="alertmsg"></div>
		</div>
	</f:form>
	<hr>
	<c:if test="${! empty msg && msg!='0'}">
		<div id='msg' class="successmsg">${msg}</div>
	</c:if>
	<div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div class="head blue">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Assigned Classes</h2>
			</div>
			<div id="ShowDetails"></div>
		</div>
	</div>
</div>