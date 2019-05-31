<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />

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

<script type="text/javascript">
	function expenseView() {
		var yearf = $("#YearFrom").val();
		var yeart = $("#YearTo").val();
		

		if ((yearf == "" || yearf == null)||(yeart == "" || yeart == null))

		{
			$("#ExpenseList").empty();
			document.getElementById("v1").innerHTML = "All fields are required";

		} else {
			document.getElementById("v1").innerHTML = "";
			getYearlyExpense(yearf,yeart);
		}

	}
	function getYearlyExpense(yearf,yeart) {
		
		var url = 'getYearlyExpense/' + yearf+'/'+yeart;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {

						$("#ExpenseList").empty();

						var j = JSON.parse(data);

						var length = j.length;

						if (length == 0) {
							st = '<div class="alert alert-success"><h5 align="center"><font color="red"><b>There are no expense between these dates</b></font></h5></div>';
						} else {
							var st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Date Wise Expense Report</h2></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Date</th><th>Employee Name</th><th>Designation</th><th>Purpose Details</th><th>Amount</th></tr>';

							for ( var i = 0; i < length; i++) {
st=st+'<tr><td>'+j[i].dateofexpense+'</td><td>'+j[i].employeeName+'</td><td>'+j[i].roleName+'</td><td>'+j[i].purposeDetails+'</td><td>'+j[i].expenseAmount+'</td></tr>';
							
						
						}
							st = st + '</table>';
						
						}
						$("#ExpenseList").append(st);

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
			Date Wise Expenses <small>View Date wise Expense Report</small>
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


	<br>

	<table style="width: 1059px; height: 200px;">


	<tr>
				<td style="width: 200px;">Select Session From</td>
				<td><div id="year1">
						<select class="form-control input-sm" name="year" id="YearFrom" style="width:200px;"
							data-original-title="" title="">
							<option value="" data-original-title="" title="">-Select
								Year-</option>
							<c:forEach var="i" begin="2010" end="2030">

								<option value="${i}" data-original-title="" title="">${i}</option>
							</c:forEach>

						</select>
					</div></td>
			</tr>
			<tr>
				<td style="width: 200px;">Select Session To</td>
				<td><div id="year2">
						<select class="form-control input-sm" name="year" id="YearTo" style="width:200px;"
							data-original-title="" title="">
							<option value="" data-original-title="" title="">-Select
								Year-</option>
							<c:forEach var="i" begin="2010" end="2030">

								<option value="${i}" data-original-title="" title="">${i}/${i+1}</option>
							</c:forEach>

						</select>
					</div></td>
			</tr>
		<tr>
			<td><a href="javascript:expenseView();">
					<h4>View</h4>
			</a></td>
			<td></td>
		</tr>

	</table>
	<div class="separator"></div>

	<div id="ExpenseList"></div>
	<div class="separator"></div>

	<div id="err" class="form-inline">
		<p id="v1"></p>

	</div>


</div>