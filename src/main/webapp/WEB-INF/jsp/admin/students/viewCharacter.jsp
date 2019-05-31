<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/css" var="css_url" />
<spring:url value="/img" var="img_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create</title>
</head>
<script type="text/javascript">
		function searchData(name) {
			$("#some").empty();
			$("#all").show();
			// $('#searchtotalrecords').empty();
			if (name == '') 
			{
				//$('#totalrecords').show();
			}
			else {
				$
						.ajax({
							url : 'ShowSearch',
							type : 'GET',
							data : {
								'name' : name
							},
							success : function(data, status) {
								var j = JSON.parse(data);
								if (j.length == 0) {
									$("#all").hide();
									
								} else {
									var st = '<table class="table table-bordered table-striped datatable dataTable" id="table-2" aria-describedby="table-2_info"><col width="50px"><col width="100px"><col width="50px"><col width="150px"><thead><tr role="row">'
											+ '<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="table-2" rowspan="1" colspan="1" aria-sort="ascending" aria-label="#: activate to sort column descending">Sr No</th>'
											+ '<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="table-2" rowspan="1" colspan="1" aria-sort="ascending" aria-label="#: activate to sort column descending">Student</th>'
											+ '<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="table-2" rowspan="1" colspan="1" aria-sort="ascending" aria-label="#: activate to sort column descending">Session</th>'
											+ '<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="table-2" rowspan="1" colspan="1" aria-sort="ascending" aria-label="#: activate to sort column descending">Class</th>'
											+ '<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="table-2" rowspan="1" colspan="1" aria-sort="ascending" aria-label="#: activate to sort column descending">Section</th>'
											+ '<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="table-2" rowspan="1" colspan="1" aria-sort="ascending" aria-label="#: activate to sort column descending">Character</th>'
											+ '<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="table-2" rowspan="1" colspan="1" aria-sort="ascending" aria-label="#: activate to sort column descending">Action</th>'
											+ '</tr></thead><tbody role="alert" aria-live="polite" aria-relevant="all">';
									for (var i = 0; i < j.length; i++) {
										st += '<tr class="odd"><td class=" sorting_1">'
												+ i+1
												+ '</td><td class=" ">'
												+ j[i].fullName + '</td>'
												+'<td class=" ">'
												+ j[i].session + '</td>'
												+'<td class=" ">'
												+ j[i].classes + '</td>'
												+'<td class=" ">'
												+ j[i].sectionName+ '</td>'
												+'<td class=" ">'
												+ j[i].character + '</td>'
										
										st += '<td class=" "><a href="create-character-pdf?id='
												+ j[i].characterId
												+ '" class="label label-success" style="margin-left: 8px;"> PDF</a> </td></tr>';
												
	
												

									}
									st += '</tbody></table>';
									$("#all").hide();
									$("#some").append(st);
									
									
								} 

							},
							error : function(data, status) {

							}
						});
			}
		}
	</script>


<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/bluediamond-logo.jpg"
			style="width: 50px;height: 50">
		<h1>Character Certificate</h1>
		<h3>Character Certificate Details</h3>
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
				<br>
				<br>
				<!-- <a id="namesc" class="btn btn-success" href="searchCharacter"
					style="width: 101px; height: 25px; display: block; margin-top: 79px; padding-top: 5px; margin-right: -136px;"><b>Search
						By Name</b></a> -->
						<div style="clear: both;"></div>
								<br>
								<div class="dataTables_filter" id="table-2_filter">
									<label><strong> Search Student:</strong> <input type="text"
										aria-controls="table-2" name="name"
										oninput="searchData(this.value)" placeholder="Search By Name" />
									</label>
								</div>
		</div>
	</div>

	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue"
					style="border-top-width: 10px; margin-top: 46px;">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Character Certificate</h2>
					
				</div>
				
				<div class="data-fluid">
				<div id="some"></div>
					<div id="all">
					<table cellpadding="0" cellspacing="0" width="100%" class="table">
						<thead>
							<tr>
								<th width="20%">S.No</th>
								<th width="20%">Student</th>
								<th width="20%">Session</th>
								<th width="20%">Class</th>
								<th width="20%">Section</th>
								<td width="20%">Character</td>
								<th width="20%">Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${charc}" var="character">
								<tr>
									<td>${character.characterId}</td>
									<td>${character.fullName}</td>
									<td>${character.session}</td>
									<td>${character.classes}</td>
									<td>${character.sectionName}</td>
									<td>${character.character}</td>
									<td><a
										href="create-character-pdf?id=${character.characterId}"><span
											class="label label-success">PDF</span></a> <%-- <a
										href="deleteclass.html?classId=${studentClass.classId}"><span
											class="label label-important">Delete</span></a> --%></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</div>
</div>
<!-- Bootrstrap modal form -->
