<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />

<script type="text/javascript">
	function getYearlyCollection(year) {
		$
				.ajax({
					type : "post",
					url : 'show-yearly-collections',
					data : {
						'year' : year
					},
					success : function(data, status) {
						$("#feeDetails").empty();
						var j = JSON.parse(data);
						if (j != '') {
							var content = '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Datewise Collections</h2><ul class="buttons">'
									+ '<li><a return false; href="#"><div class="icon"><span class="ico-info"></span></div></a></li></ul>'
									+ '</div><table class="table table-bordered table-primary" style="width: 1059px;"><thead><tr>'
									+ '<th>Student Admission No</th>'
									+ '<th>L.F. No.</th><th>Receipt No.</th><th>Name</th><th>Amount Paid</th><th>Paid Date</th></tr></thead><tbody>';
							for ( var i = 0; i < j.length; i++) {
								content += '<tr><td class="center"><font size="2">'
										+ j[i].studentAdmissionNo
										+ '</font></td><td class="center"><font size="2">'
										+ j[i].lFno
										+ '</font></td><td class="center"><font size="2">'
										+ j[i].recieptNo
										+ '</font></td><td class="center"><font size="2">'
										+ j[i].studentName
										+ '</font></td><td class="center"><font size="2">'
										+ j[i].paidAmount
										+ '</font></td><td class="center"><font size="2">'
										+ j[i].feePaidDate
										+ '</font></td></tr>';

							}
							content += '</tbody></table>';
							$("#feeDetails").append(content);
						} else {
							$("#feeDetails")
									.append(
											'<div style="border: 2px solid rgb(236, 65, 65); background: none repeat scroll 0% 0% rgb(225, 114, 114); color: white; height: 30px; font: 135%/1.5 cursive;"><center>Data Not Found</center></div>');
						}
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
</script>

<div class="content">
	<div class="page-header" style="height: 90px;">
		<div class="icon">
			<span class="ico-pen-2"></span>
		</div>
		<h1>
			Collections <small>Show Yearly Collection Report</small>
		</h1>

		<div class="span6">
			<div class="block">
				<div class="head"></div>
				<div class="data-fluid" style="width: 490px; margin-top: -15px;">
					<div class="head"></div>
					<div class="row-form">
						<div class="span3"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row-form">
		<div class="span2">
			Select Year :<font color="red">*</font>
		</div>
		<div class="span4">
			<select onchange="getYearlyCollection(this.value)">
				<option value="">Select Year</option>
				<option value="2010">2010</option>
				<option value="2011">2011</option>
				<option value="2012">2012</option>
				<option value="2013">2013</option>
				<option value="2014">2014</option>
				<option value="2016">2015</option>
				<option value="2015">2016</option>
			</select>
		</div>
	</div>

	<div class="span12" style="margin-left: 0px; width: 1059px;"></div>
	<div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div id="feeDetails"></div>
		</div>
	</div>
</div>

