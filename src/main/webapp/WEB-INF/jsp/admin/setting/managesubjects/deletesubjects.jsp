<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />

<script type="text/javascript">
	function getbranchList(id) {
		var url = 'getbranch/' + id;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#branch").empty();

						var st = '<select name="brachId" onchange=getbatchList(this.value,'
								+ id
								+ ') class="form-control input-sm" id="currentbrachId" x-data-toggle-x="tooltip"  required="required" title="Specify the branch for the selected course" data-original-title="Specify the branch for the selected course">'
								+ '<option selected="selected" value="" data-original-title="" title="">-- Select Branch --</option>';
						var j = JSON.parse(data);
						var length = j.length;

						for ( var i = 0; i < length; i++) {

							st = st + '<option value=' + j[i].id + '>'
									+ j[i].branchName + '</option>';

						}
						st = st + '</select>';

						$("#branch").append(st);

					},
					error : function(error, status) {

					}
				});

	}
	function getbatchList(id, courseId) {
		var url = 'getbatchList/' + id + '/' + courseId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#batch").empty();

						var st = '<select name="batchesId" class="form-control input-sm" id="currentbatchId" x-data-toggle-x="tooltip"  required="required" onchange=getsubjectList('
								+ id
								+ ','
								+ courseId
								+ ',this.value) title="Specify the batch for the selected course" data-original-title="Specify the batch for the selected course">'
								+ '<option selected="selected" value="" data-original-title="" title="">-- Select Batch --</option>';
						var j = JSON.parse(data);

						var length = j.length;

						for ( var i = 0; i < length; i++) {

							st = st + '<option value=' + j[i].id + '>'
									+ j[i].batchesName + '</option>';

						}
						st = st + '</select>';

						$("#batch").append(st);

					},
					error : function(error, status) {

					}
				});

	}
	function getsubjectList(id, courseId, batchId) {
		
		var url = 'getsubjectList/' + id + '/' + courseId + '/' + batchId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#subject").empty();

						var j = JSON.parse(data);

						var length = j.length;
						var st = "";
						if (length == 0) {
							st = '<div class="alert alert-success"><h5 align="center"><font color="red"><b>There are no subjects</b></font></h5></div>';
						} else {
							st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Delete Subjects</h2></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Subject Name</th><th>Operations</th></tr></thead><tbody>';

							for ( var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 200px;">'
										+ j[i].subjectName
										+ '</td>'
										+ '<td><a href="javascript:void(0)" onclick="javascript:removeSubject('
										+ j[i].id + ',' + courseId + ',' + id
										+ ',' + batchId
										+ ')">Delete</a></td></tr>';

							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#subject").append(st);

					},
					error : function(error, status) {
						alert(error);

					}
				});
	}
	function removeSubject(id, courseId, branchId, batchId) {
	
		var url = 'removeSubject/' + id + '/' + courseId + '/' + '/' + branchId
				+ '/' + batchId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#subject").empty();

						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="alert alert-success"><h5 align="center"><font color="red"><b>Deleted Successfully</b></font></h5></div>';
						} else {

							st = '<div class="alert alert-success"><h5 align="center"><font color="red"><b>Deleted Successfully</b></font></h5>'
									+ '</div><div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Delete Subjects</h2></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Subject Name</th><th>Operations</th></tr></thead><tbody>';

							for ( var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 200px;">'
										+ j[i].subjectName
										+ '</td>'
										+ '<td><a href="javascript:void(0)" onclick="removeSubject('
										+ j[i].id + ',' + id + ',' + courseId
										+ ',' + batchId
										+ ')">Delete</a></td></tr>';

							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#subject").append(st);

					},
					error : function(error, status) {
						

					}
				});

	}
</script>

<div class="content">
	<div class="page-header">
		<div class="icon">
			<span class="ico-pen-2"></span>
		</div>
		<h1>
			Subjects <small>Delete Subject</small>
		</h1>

		<div class="span6">

			<div class="block">
				<div class="head"></div>
				<div class="data-fluid" style="width: 490px; margin-top: -15px;">


					<div class="head"></div>
					<div class="row-form">
						<div class="span3"></div>
						<div class="span9" style="float: right;">

							<button class="btn btn-success" type="button"
								onclick="history.back(); return false;"
								style="float: right; margin-left: 0px; border-left-width: 0px; padding-left: 12px; margin-right: -384px; margin-top: 0px; border-top-width: 0px; width: 75px;">Back</button>
						</div>

					</div>

				</div>

			</div>

		</div>
	</div>

	<f:form action="delete-student-subjects" method="post"
		commandName="subjectsDTO">
		<br>

		<table style="width: 1059px; height: 200px;">

			<tr>
				<td style="width: 200px;">Course Name:</td>
				<td><f:select path="courseId" class="form-control input-sm"
						id="currentcourseId" x-data-toggle-x="tooltip" title=""
						required="required" data-original-title="Specify the course"
						onchange="getbranchList(this.value)">
						<option selected="selected" value="" data-original-title=""
							title="">-- Select Course --</option>
						<c:forEach var="list" items="${list}" varStatus="loop">


							<option value="${list.id}" data-original-title="" title="">
								${list.courseName}</option>
						</c:forEach>


					</f:select></td>
			</tr>
			<tr>
				<td style="width: 200px;">Branch Name</td>
				<td><div id="branch">
						<f:select path="brachId" class="form-control input-sm"
							id="currentbrachId" x-data-toggle-x="tooltip" required="required"
							title="Specify the branch for the selected course"
							data-original-title="Specify the branch for the selected course"
							onchange="getbatchList(this.value)">

							<option selected="selected" value="" data-original-title=""
								title="">-- Select Branch --</option>

						</f:select>
					</div></td>
			</tr>

			<tr>
				<td style="width: 200px;">Batch Name</td>
				<td><div id="batch">
						<f:select path="batchesId" class="form-control input-sm"
							id="currentbatchesId" x-data-toggle-x="tooltip"
							required="required"
							title="Specify the batch for the selected course"
							data-original-title="Specify the batch for the selected course">
							<option selected="selected" value="" data-original-title=""
								title="">-- Select Batch --</option>

						</f:select>
					</div></td>
			</tr>


		</table>
		<div class="separator"></div>


		<!-- <button class="btn btn-success" type="submit">Submit</button> -->


	</f:form>
	
	<div id="subject"></div>
</div>