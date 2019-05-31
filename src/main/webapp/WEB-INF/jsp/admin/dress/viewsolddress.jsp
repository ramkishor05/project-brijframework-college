<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
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
<script>
function gettoclear()
{
	
	$("#toDate").val('');
}
function getSoldDressDetails()
{

		var f= $("#fromDate").val();
		var t= $("#toDate").val();
	

		if(f=="" || f==null)
			{
			
document.getElementById("err").innerHTML = "Fill all above fields first";
			
			}
		else
			{
			document.getElementById("err").innerHTML = "";
			var url = 'viewsolddressdetsils/' + f+'/'+t;
			$
			.ajax({
				url : url,

				type : 'POST',
				success : function(data, status) {
					$("#appenddata").empty();
					var j = JSON.parse(data);
					var st = "";
					var length = j.length;
			st = '<table cellpadding="0" cellspacing="0" width="100%" class="table"><thead><tr><th>Date</th><th>Student Name</th><th>Class</th>'
				+'<th>Section</th><th>Total Amount</th><th>Paid Amount</th><th>Discount</th><th>View Receipt</th></tr></thead><tbody>'
						for ( var i = 0; i < length; i++) {
							st += '<tr><td>'
									+ j[i].payDate
									+ '</td><td>' + j[i].fullname
									+ '</td><td>' + j[i].className
									+ '</td><td>' + j[i].sectionName
									+ '</td><td>' + j[i].totalAmount
									+ '</td><td>' + j[i].paidAmount
									+ '</td><td>' + j[i].discount
									+ '</td><td><a href="getDressReceipt?id='+j[i].receiptno+'" target="_blank"><span class="label label-success">Receipt</span></a></td></tr>';
						}
						st += '</table>';
						if (length > 0) {
							$("#appenddata").append(st);
						} else {
							$("#appenddata")
									.append(
											'<font color="red">No Data Found For your Search </font>');
						}
					
				},
					error : function(e) {
						
					}
				});
			}
	}
	function getClear() {
		$("#classById").val('');
		$("#name").val('');
	
	}									
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/uniform.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Allot Dresses</h1>
		<h3>Allot Dress to Students</h3>
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

	<div class="row-form">
		<div class="span2">
			Select From Date :<font color="red">*</font>
		</div>
		<div class="span4">
			<input type="text" class="datepicker validate[required]"
				onchange="gettoclear();" placeholder="Select From Date"
				id="fromDate">
		</div>
	</div>

	<div class="row-form">
		<div class="span2">
			Select To Date :<font color="red">*</font>
		</div>
		<div class="span4">
			<input type="text" class="datepicker validate[required]"
				placeholder="Select To Date" id="toDate"
				onchange="getSoldDressDetails();">
		</div>
	</div>
		<div class="row-form">
						<div class="span3"></div>
						<div class="span9">
							
<div id="err" class="form-inline">
		<p id="v1"></p>

	</div>
						</div>
					</div>
					<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Detail List</h2>
					<ul class="buttons">
						<li><a onclick="source('table_default'); return false;"
							href="#"><div class="icon">
									<span class="ico-info"></span>
								</div></a></li>
					</ul>
				</div>
				<div class="data-fluid" id="appenddata"></div>
			</div>
		</div>

	</div>
</div>