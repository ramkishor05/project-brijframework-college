<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<script>
	$(document).ready(function() {
		$('#date').append(new Date);
	});
</script>

<script>
	function getyearlyCollectionDetails(year) {
		$
				.ajax({
					type : "post",
					url : 'show-yearly-collection-details',
					data : {
						'year' : year,
					},
					success : function(data, status) {
						$("#feeDetails").empty();
						var j = JSON.parse(data);
						var containt = '<div style="margin-left: 158px; width: 631px; margin-top: 24px; border: 1px solid rgb(78, 182, 224); box-shadow: 4px 6px 6px rgb(154, 208, 237); color: white; background: none repeat scroll 0% 0% rgb(207, 238, 251);"><div class="row-form"><div class="span3">Total Expected &nbsp;&nbsp;&nbsp;&nbsp:'
								+ '</div><div class="span2">'
								+ j.totalExpectedAmount
								+ '/-</div></div><div class="row-form"><div class="span3">Extra/Fine Amount &nbsp;&nbsp;&nbsp;&nbsp:'
								+ '</div><div class="span2">'
								+ j.extraCollectionAmount
								+ '/-</div></div><div class="row-form"><div class="span3">'
								+ 'Total Discount &nbsp;&nbsp;&nbsp;&nbsp;:</div><div class="span2">'
								+ j.totalDiscountAmount
								+ '/-</div></div>'
								+ '<div class="row-form"><div class="span3">Total Collections &nbsp;&nbsp;&nbsp;&nbsp;:</div><div class="span2">'
								+ j.totalCollectionAmount + '/-</div></div>'
						if (j.totalCollectionAmount < j.totalExpectedAmount) {
							containt += '<div class="row-form"><div class="span3">Rest Collection Amount &nbsp;&nbsp;&nbsp;&nbsp;:</div><div class="span2">'
									+ j.restAmount + '/-</div></div>';
						} else {
							containt += '<div class="row-form"><div class="span3">Rest Collection Amount &nbsp;&nbsp;&nbsp;&nbsp;:</div><div class="span2">'
									+ 0
									+ '/-</div></div>'
									+ '<div class="row-form"><div class="span3">Extra Collections &nbsp;&nbsp;&nbsp;&nbsp;:</div><div class="span2">'
									+ Math.abs(j.totalCollectionAmount
											- j.totalExpectedAmount)
									+ '/-</div></div>';
						}
						containt += '</div><div style="margin-left: 158px; width: 631px; margin-top: 24px; border: 1px solid rgb(78, 182, 224); box-shadow: 4px 6px 6px rgb(154, 208, 237); color: white; background: none repeat scroll 0% 0% rgb(207, 238, 251);"><div class="row-form"><div class="span3">Expenses Amount &nbsp;&nbsp;&nbsp;&nbsp;:</div><div class="span2">'
								+ j.totalExpensesAmount
						if (j.totalExpensesAmount < j.totalCollectionAmount) {
							containt += '/-</div></div><div class="row-form"><div class="span3">Available Amount &nbsp;&nbsp;&nbsp;&nbsp;:</div><div class="span2">'
									+ j.availabelAmount + '/-</div></div>';
						} else {
							containt += '/-</div></div><div class="row-form"><div class="span3">Available Amount &nbsp;&nbsp;&nbsp;&nbsp;:</div><div class="span2">'
									+ 0
									+ '/-</div></div>'
									+ '<div class="row-form"><div class="span3">Extra Expenses &nbsp;&nbsp;&nbsp;&nbsp;:</div><div class="span2">'
									+ Math.abs(j.totalExpensesAmount
											- j.totalCollectionAmount)
									+ '/-</div></div></div>';
						}

						$("#feeDetails").append(containt);

					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
</script>


<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/collection1.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Collections</h1>
		<h3>Show Yearly Collections & Expenses Details & Available
			Details</h3>
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
			Select Year :<font color="red">*</font>
		</div>
		<div class="span4">

			<select class="form-control input-sm" name="year" id="Year"
				style="width: 200px;"
				onchange="getyearlyCollectionDetails(this.value)"
				data-original-title=""
				title=" The details are corresponding to Selected session i.e April to March">
				<option value="">Select Year</option>
				<c:forEach var="session" items="${sessionList}">
					<option value="${session.sessionId}">${session.sessionDuration}</option>
				</c:forEach>

			</select>

		</div>
	</div>

	<div id="feeDetails"></div>
</div>

