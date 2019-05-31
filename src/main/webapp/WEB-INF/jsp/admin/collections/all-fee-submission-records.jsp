<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script>
	function getClassWiseCollection(classId) {

		$('#detail').empty();

		$
				.ajax({
					type : 'get',
					url : 'all-fee-submission-report-byclass',
					data : {
						'classId' : classId
					},
					success : function(data) {

						var value = JSON.parse(data);
						if (value.length == 0) {

							var classAssignDetails = '<div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Overall Collections</h2><ul class="buttons"><li><a return false; title="Export Fee Submission" href=student-excel-report.xls?classId='
									+ classId
									+ '><div class="icon"><span class="ico-info"></span></div> <span class="btn-btn-danger">Export</span></a></li></ul></div>'
									+ '<div class="data-fluid">'
									+ '<table class="table table-condensed" style="width: 1059px;">'
									+ '<thead><tr><th>S.No</th><th>Student Name</th><th>Father Name</th><th>Annual Fee</th><th>Transport Fee</th><th>Apr</th><th>May</th><th>Jun</th><th>Jul</th><th>Aug</th><th>Sep</th><th>Oct</th><th>Nov</th><th>Dec</th><th>Jan</th><th>Feb</th><th>Mar</th><th></th></tr></thead><tbody>'
							classAssignDetails += '<tr><td>No Record Found</td></tr></tbody></table>';
							$('#detail').append(classAssignDetails);

						} else {
							var classAssignDetails = '<div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Overall Collections</h2><ul class="buttons"><li><a return false; title="Export Fee Submission" href=student-excel-report.xls?classId='
									+ classId
									+ '><div class="icon"><span class="ico-info"></span></div> <span class="btn-btn-danger">Export</span></a></li></ul></div>'
									+ '<div class="data-fluid">'
									+ '<table class="table table-condensed" style="width: 1059px;">'
									+ '<thead><tr><th>S.No</th><th>Student Name</th><th>Father Name</th><th>Annual Fee</th><th>Transport Fee</th><th>Apr</th><th>May</th><th>Jun</th><th>Jul</th><th>Aug</th><th>Sep</th><th>Oct</th><th>Nov</th><th>Dec</th><th>Jan</th><th>Feb</th><th>Mar</th><th></th></tr></thead><tbody>';
							for (var i = 0; i < value.length; i++) {
								if (i != value.length - 1) {
									classAssignDetails += '<tr>'
									classAssignDetails += '<td class="center"><font size="2">'
									classAssignDetails += (i + 1)
									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									classAssignDetails += value[i].studentName
									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									classAssignDetails += value[i].fatherName
									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].annualFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].annualFee
									}
									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].transportFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].transportFee
									}
									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].aprFee == null) {
										classAssignDetails += 0.0;
									} else {
										classAssignDetails += value[i].aprFee
												+ '(TF:-'
												+ value[i].transportMonthly
												+ ')'
									}

									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].mayFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].mayFee
												+ '(TF:-'
												+ value[i].transportMonthly
												+ ')'
									}

									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].junFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].junFee
												+ '(TF:-'
												+ value[i].transportMonthly
												+ ')'
									}

									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].julFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].julFee
												+ '(TF:-'
												+ value[i].transportMonthly
												+ ')'
									}

									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].augFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].augFee
												+ '(TF:-'
												+ value[i].transportMonthly
												+ ')'
									}

									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].septFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].septFee
												+ '(TF:-'
												+ value[i].transportMonthly
												+ ')'
									}
									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].octFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].octFee
												+ '(TF:-'
												+ value[i].transportMonthly
												+ ')'
									}

									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].novFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].novFee
												+ '(TF:-'
												+ value[i].transportMonthly
												+ ')'
									}

									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].decFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].decFee
												+ '(TF:-'
												+ value[i].transportMonthly
												+ ')'
									}

									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].janFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].janFee
												+ '(TF:-'
												+ value[i].transportMonthly
												+ ')'
									}

									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].febFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].febFee
												+ '(TF:-'
												+ value[i].transportMonthly
												+ ')'
									}
									classAssignDetails += '</font></td>'
									classAssignDetails += '<td class="center"><font size="2">'
									if (value[i].marFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].marFee
												+ '(TF:-'
												+ value[i].transportMonthly
												+ ')'
									}

									classAssignDetails += '</font></td>'
									classAssignDetails += '<td><span class="label label-success"><font size="2">'

									if (value[i].studentFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].studentFee
									}

									classAssignDetails += '</font></span></td></tr>'
								}
								if (i == value.length - 1) {

									classAssignDetails += '<tr><td></td><td></td><td></td>'
									classAssignDetails += '<td class="center"><span class="label label-info">'

									if (value[i].totalannualFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totalannualFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td class="center"><span class="label label-info">'
									if (value[i].totaltransportFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totaltransportFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-info">'
									if (value[i].totalaprFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totalaprFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-info">'
									if (value[i].totalmayFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totalmayFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-info">'
									if (value[i].totaljunFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totaljunFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-info">'
									if (value[i].totaljulFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totaljulFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-info">'
									if (value[i].totalaugFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totalaugFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-info">'
									if (value[i].totalseptFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totalseptFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-info">'
									if (value[i].totaloctFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totaloctFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-info">'
									if (value[i].totalnovFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totalnovFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-info">'
									if (value[i].totaldecFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totaldecFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-info">'
									if (value[i].totaljanFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totaljanFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-info">'
									if (value[i].totalfebFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totalfebFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-info">'
									if (value[i].totalmarFee == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totalmarFee
									}

									classAssignDetails += '</span></td>'
									classAssignDetails += '<td><span class="label label-danger">'
									if (value[i].totalStudent == null) {
										classAssignDetails += 0.0
									} else {
										classAssignDetails += value[i].totalStudent
									}

									classAssignDetails += '</span></td>'
											+ '</tr>';
								}

							}

							classAssignDetails += '</tbody></table>';
							$('#detail').append(classAssignDetails);

						}
					},
					error : function(e) {

					}
				});

	}
</script>


<div class="content">
	<div id="content-header" style="height: 140px;">
		<img alt="Show_settings" src="${img_url}/collection.jpg"
			style="width: 50px;">
		<h1>Overall Fee Collection</h1>
		<h3>overall Fee Collection</h3>
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
	<div>
		<B
			style="border: 1px solid #009ad7; font-family: Times Roman; border-top-width: 5px; border-radius: 5px; float: right; margin-top: 12px; margin-bottom: 10px;">Overall
			Collections (in INR.) =${totalStudent}/-</B>
	</div>
	<br>
	<div class="span12" style="margin-left: 0px; width: 1059px;"></div>

	<div style="padding: 10px 0 0;" class="widget-body">
		<div>
			<select name="class"
				style="width: 189px; margin-left: 361px; margin-bottom: 16px;"
				onchange="getClassWiseCollection(this.value)">
				<option>---Select Class---</option>
				<c:forEach items="${classList}" var="list">

					<option value="${list.classId}">${list.className}</option>
				</c:forEach>
			</select>
		</div>
		<div class="block" id="detail">
			<%-- <div class="head blue">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Overall Collections</h2>
				<ul class="buttons">
					<li><a return false; href="student-excel-report.xls"
						title="Export Fee Submission"><div class="icon">
								<span class="ico-info"></span>
							</div> <span class="btn-btn-danger">Export</span></a></li>
				</ul>
			</div>
			<div class="data-fluid">
				<table class="table table-condensed" style="width: 1059px;">
					<thead>
						<tr>
							<th>S.No</th>
							<th>Student Name</th>
							<th>Father Name</th>
							<th>Annual Fee</th>
							<th>Transport Fee</th>
							<th>Apr</th>
							<th>May</th>
							<th>Jun</th>
							<th>Jul</th>
							<th>Aug</th>
							<th>Sep</th>
							<th>Oct</th>
							<th>Nov</th>
							<th>Dec</th>
							<th>Jan</th>
							<th>Feb</th>
							<th>Mar</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${list}" varStatus="loop">
							<tr>
								<td class="center"><font size="2">${loop.count}</font></td>
								<td class="center"><font size="2">${list.studentName}</font></td>
								<td class="center"><font size="2">${list.fatherName}</font></td>
								<td class="center"><font size="2">${list.annualFee}</font></td>
								<td class="center"><font size="2">${list.transportFee}</font></td>
								<td class="center"><font size="2">${list.aprFee}</font></td>
								<td class="center"><font size="2">${list.mayFee}</font></td>
								<td class="center"><font size="2">${list.junFee}</font></td>
								<td class="center"><font size="2">${list.julFee}</font></td>
								<td class="center"><font size="2">${list.augFee}</font></td>
								<td class="center"><font size="2">${list.septFee}</font></td>
								<td class="center"><font size="2">${list.octFee}</font></td>
								<td class="center"><font size="2">${list.novFee}</font></td>
								<td class="center"><font size="2">${list.decFee}</font></td>
								<td class="center"><font size="2">${list.janFee}</font></td>
								<td class="center"><font size="2">${list.febFee}</font></td>
								<td class="center"><font size="2">${list.marFee}</font></td>
								<td><span class="label label-success"><font size="2">${list.studentFee}</font></span></td>
							</tr>
						</c:forEach>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td><span class="label label-info">${totalAnnual}</span></td>
							<td><span class="label label-info">${totalTransport}</span></td>
							<td><span class="label label-info">${totalApr}</span></td>
							<td><span class="label label-info">${totalMay}</span></td>
							<td><span class="label label-info">${totalJun}</span></td>
							<td><span class="label label-info">${totalJul}</span></td>
							<td><span class="label label-info">${totalAug}</span></td>
							<td><span class="label label-info">${totalSept}</span></td>
							<td><span class="label label-info">${totalOct}</span></td>
							<td><span class="label label-info">${totalNov}</span></td>
							<td><span class="label label-info">${totalDec}</span></td>
							<td><span class="label label-info">${totalJan}</span></td>
							<td><span class="label label-info">${totalFeb}</span></td>
							<td><span class="label label-info">${totalMar}</span></td>
							<td><span class="label label-danger">${totalStudent}</span></td>
						</tr>
					</tbody>
				</table>
			</div> --%>
			<%-- <table style="margin-left: 461px;">
				<tr style="width: 10px;">
					<c:if test="${pageno > 1}">
						<td style="text-align: left;"><a
							href="show-overall-collections?pageno=${pageno - 1}">Previous</a></td>
					</c:if>
					<td style="text-align: center;">&nbsp;&nbsp;</td>
					<c:forEach begin="1" end="${totalNoOfPages}" var="i">
						<c:choose>
							<c:when test="${i==pageno}">
								<c:if test="${totalNoOfPages>1}">
								<td style="text-align: left;"><c:out value="${i}"></c:out></td>
								</c:if>
							</c:when>
							<c:otherwise>
								<td style="text-align: left;"><a
									href="show-overall-collections?pageno=${i}"><c:out
											value="${i}"></c:out></a></td>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<td style="text-align: center;">&nbsp;&nbsp;</td>
					<c:if test="${pageno < totalNoOfPages}">
						<td style="text-align: left;"><a
							href="show-overall-collections?pageno=${pageno + 1}">Next</a></td>
					</c:if>
				</tr>
			</table> --%>
		</div>
	</div>
</div>