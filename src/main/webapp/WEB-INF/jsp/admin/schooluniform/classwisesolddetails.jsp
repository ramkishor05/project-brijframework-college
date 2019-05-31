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
<style>
#err {
	color: red;
	font-weight: normal;
	font-size: 20px;
	padding: 2px 8px 0px;
	margin-top: 2px;
	margin-bottom: -2px;
}
</style>
<style>
.detailbox {
	display: none;
	background-color:lightyellow;
	border: 1px solid grey;
 width: 629px;
	border-radius: 6px;
	margin-top: 160px;
	left: 220px;
	z-index: 1;
	position: absolute;
	
}
#paytable {
background-color:white;
	width: 780px;
	margin-top: 160px;
	display: none;
	left: 220px;
	z-index: 1;
	position: absolute;
	border: 1px solid grey;
	border-radius: 6px;
	
}
#dueTable {
background-color:white;
	width: 800px;
	margin-top: 160px;
	display: none;
	left: 10px;
	z-index: 1;
	position: absolute;
	border: 1px solid grey;
	border-radius: 6px;
	
}

.detailbox-header {
	width: 629px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
background-color: #FFCC99;
	height: 30px;
}
.paytable-header {
	background-color:lightblue;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 30px;
}
</style>
<script>
function hidedetailbox() {
	$(".detailbox").hide();
	
}
function getstudentdetails(classId,sessionId) {
	
 
 	$
 	.ajax({
 		type : "post",
 		url : 'getStudentUniformdetails',
 		data : {
 			'classId' : classId,
 			'sessionId' : sessionId,
 			
 		},
 				success : function(data, status) {
 					$("#bookdetails").empty();
 					var j = JSON.parse(data);
 					var st = "";
 					var length = j.length;
 					if (length == 0) {
 						st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>No student found</b></font></h5></div>';
 					} else {
 						$("#myModalLabel").text(j[0].fullname);
 						st = st
 								+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
 								+ '</div><div class="block"  style="width: 626px; height: 208px; top: 53px; margin-top: 20px;">'
 								+ '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Date</th><th>Amount</th><th>Action</th></tr></thead><tbody>';
 						for ( var i = 0; i < length; i++) {
 							st += '<tr><td>' + (i + 1)
 							        + '</td><td>' + j[i].payDate
 									+ '</td><td>' + j[i].totalAmount
 									+ '</td><td><a href="javascript:showdetails('+j[i].studentwiseFeeId+')">'
 									+ '<span class="label label-primary">View details</span></a></td></tr>';
 						}
 						st += '</table>';
 					}
 					$("#bookdetails").append(st);
					$(".detailbox").show();
 				},
 				error : function(error, status) {
 				}
 			});
}

function getstudentdetailsofdress()
{
	
	var classId=$("#classId").val();
    var sessionId=$("#sessionId").val();

	$("#studentList")
			.append('<center><img src="${img}/loads.gif" alt="Loading" style="width=200px;height=200px;"></center>');
	$
	.ajax({
		type : "post",
		url : 'getStudentUniformAmounts',
		data : {
			'classId' : classId,
			'sessionId' : sessionId,
			
		},
				success : function(data, status) {
					$("#studentList").empty();
					var j = JSON.parse(data);
					var st = "";
					var length = j.length;
					if (length == 0) {
						st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>No student found</b></font></h5></div>';
					} else {

						st = st
								+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
								+ '</div><div class="block"  style="width: 626px; height: 208px; top: 53px;"><div class="head blue"><h4 style="text-align:center"> Sold Uniform details</h4></div>'
								+ '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Student Name</th><th>Father Name</th><th>Class</th><th>Section</th><th>Amount</th><th>Action</th></tr></thead><tbody>';
						for ( var i = 0; i < length; i++) {
							st += '<tr><td>' + (i + 1)
							        + '</td><td>' + j[i].fullname
									+ '</td><td>' + j[i].fatherName
									+ '</td><td>' + j[i].className
									+ '</td><td>' + j[i].sectionName
									+ '</td><td>' + j[i].totalAmount
									+ '</td><td><a href="javascript:getstudentdetails('+classId+','+sessionId+')">'
									+ '<span class="label label-primary">View details</span></a></td></tr>';
						}
						st += '</table>';
					}
					$("#studentList").append(st);
				
				},
				error : function(error, status) {
				}
			});
	
	}

function showdetails(id)
{
	$("#"+id).remove();
	$.ajax({
		type : "post",
		url : 'viewallsolduniformsdetails',
		data : {
			
			'feeId' : id
		},
		success : function(data, status) {
			
			var j = JSON.parse(data);
			var st = "";
	      var length = j.length;
			if (length == 0) {
				st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>No Data available</b></font></h5></div>';
			} else {
				
				
                   st = st
						+ '<div id="'+id+'"><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
						+ '</div><div class="block" style="width: 626px; height: 208px; top: 53px; margin-top: 18px;"><div class="head green"><h4 style="text-align: center; height: 31px; padding-top: 5px;">Uniform Details</h4></div>'
						+ '<table class="table table-bordered table-primary"><thead><tr><th>S No</th><th>Name</th><th>Category</th><th>Size</th><th>Price</th><th>Quantity</th><th>Amount</th></tr></thead><tbody>';
				for ( var i = 0; i < length; i++) {
					st += '<tr><td>' + (i + 1)
							+ '</td><td>'+ j[i].dressName
							+ '</td><td>'+ j[i].category
							+ '</td><td>'+ j[i].size
							+ '</td><td>'+ j[i].price
							+ '</td><td>'+ j[i].quantity
							+ '</td><td>'+ j[i].amount
							+ '</td></tr>';
				}
				st += '</table></div></div></div>';
			}
			$("#bookdetails").append(st);
			$(".detailbox").show();
		},
		error : function(e) {
			
		}
	});
	
}

</script>
<div class="detailbox">
	<div class="detailbox-header">
		<a href="javascript:hidedetailbox();" class="close" data-dismiss="modal"
			style="margin-right: 10px; margin-top: 10px;" aria-hidden="true"><span class="ico-remove-sign"></span></a>
		<center><h5 id="myModalLabel">Sold Uniform Detais</h5></center>
	</div>
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="bookdetails"></div>
				
			</div>

		</div>

		<div class="detailbox-footer"
			style="float: right;">
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidedetailbox();"style="margin-right: 16px;"
				aria-hidden="true">Close</a>
		</div>

</div>


<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/uniform.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>View details of uniforms sold</h1>
		<h3>ClassWise Sold Uniforms Details</h3>
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

<tr style="height: 62px;">
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
			<td><select id="classId"
				onchange="getstudentdetailsofdress();"  style="width: 260px;"
				name="classId">
					<option value="">Select a class</option>
					<c:forEach var="list" items="${classList}">
						<option value="${list.classId}">${list.className}</option>
					</c:forEach>
			</select></td>

		</tr>




	</table>

	<div class="separator"></div>
	<hr>
	
				<div id="studentList" style="width: 852px; margin-left: 170px;"></div>
			
	<div class="separator"></div>

	<div id="err" class="form-inline">
		<p id="v1"></p>

	</div>


</div>
