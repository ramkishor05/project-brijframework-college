<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<script type="text/javascript">
	function getDateWiseCollections() {
		var fromDate = $('#fromDate').val();
		var toDate = $('#toDate').val();
		if (fromDate == '') {
			alert("Fill From Date First.");
		} else {
			$
					.ajax({
						type : "post",
						url : 'show-datewise-collections',
						data : {
							'fromDate' : fromDate,
							'toDate' : toDate
						},
						success : function(data, status) {
							$("#feeDetails").empty();
							$("#totalCollection").empty();
							var j = JSON.parse(data);
							if (j != '') {
								var totalCollection = 0;
								var totalFine = 0;
								var totalDiscount = 0;
								var content = '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Datewise Collections</h2><ul class="buttons">'
										+ '<li><a return false; title="Date Wise Collections" href="datewise-collection.xls?fromDate='
										+ fromDate
										+ '&toDate='
										+ toDate
										+ '"><div class="icon"><span class="ico-info"></span></div>Export</a></li></ul>'
										+ '</div><table class="table table-bordered table-primary" style="width: 1059px;"><thead><tr>'
										+ '<th>Student Admission No</th>'
										+ '<th>L.F. No.</th><th>Receipt No.</th><th>Name</th><th>Amount Paid</th><th>Fine Amount</th><th>Discount</th><th>Paid Date</th></tr></thead><tbody>';
								for (var i = 0; i < j.length; i++) {
									totalCollection += parseInt(j[i].paidAmount);
									totalFine += parseInt(j[i].fineAmount);
									totalDiscount += parseInt(j[i].discountAmount);
									content += '<tr><td class="center"><font size="2">'
											+ j[i].studentId
											+ '</font></td><td class="center"><font size="2">'
											+ j[i].lFno
											+ '</font></td><td class="center"><font size="2">'
											+ j[i].recieptNo
											+ '</font></td><td class="center"><font size="2">'
											+ j[i].studentName
											+ '</font></td><td class="center"><font size="2">'
											+ j[i].paidAmount
											+ '</font></td><td class="center"><font size="2">'
											+ j[i].fineAmount
											+ '</font></td><td class="center"><font size="2">'
											+ j[i].discountAmount
											+ '</font></td><td class="center"><font size="2">'
											+ j[i].feePaidDate
											+ '</font></td></tr>';
								}
								content += '<tr><td class="center"><font size="2"></font></td>'
										+ '<td class="center"><font size="2"></font></td>'
										+ '<td class="center"><font size="2"></font></td>'
										+ '<td class="center"><font size="2"></font></td>'
										+ '<td class="center"><font size="2"><b>Total='
										+ totalCollection
										+ '</b></font></td>'
										+ '<td class="center"><font size="2"><b>Total='
										+ totalFine
										+ '</b></font></td>'
										+ '<td class="center"><font size="2"><b>Total='
										+ totalDiscount
										+ '</b></font></td></tr>'

								/* var total = '<div><B style="border: 1px solid #009ad7; font-family:Times Roman; border-top-width:5px; border-radius: 5px; float: right; margin-top: -28px; margin-bottom: 10px;">DateWise '
										+ 'Collections (in INR.) = '
										+ (totalCollection + totalFine - totalDiscount)
										+ '/-</B></div>'; */
								var total = '<div><B style="border: 1px solid #009ad7; font-family:Times Roman; border-top-width:5px; border-radius: 5px; float: right; margin-top: -28px; margin-bottom: 10px;">DateWise '
										+ 'Collections (in INR.) = '
										+ (totalCollection) + '/-</B></div>';
								content += '</tbody></table>';
								$("#feeDetails").append(content);
								$("#totalCollection").append(total);
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
	}
</script>

<div class="content">
	<div id="content-header" style="height: 140px;">
		<img alt="Show_settings" src="${img_url}/collection.jpg"
			style="width: 50px;">
		<h1>Date-Wise Collections</h1>
		<h3>date-wise collections report</h3>
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

	<div class="row-form">
		<div class="span2">
			Select From Date :<font color="red">*</font>
		</div>
		<div class="span4">
			<input type="text" class="datepicker validate[required]"
				placeholder="Select From Date" id="fromDate">
		</div>
	</div>

	<div class="row-form">
		<div class="span2">
			Select To Date :<font color="red">*</font>
		</div>
		<div class="span4">
			<input type="text" class="datepicker validate[required]"
				placeholder="Select To Date" id="toDate"
				onchange="getDateWiseCollections();">
		</div>
	</div>

	<div class="span12" style="margin-left: 0px; width: 1059px;"></div>
	<div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div id="totalCollection"></div>
			<div id="feeDetails"></div>
		</div>
	</div>
</div>

