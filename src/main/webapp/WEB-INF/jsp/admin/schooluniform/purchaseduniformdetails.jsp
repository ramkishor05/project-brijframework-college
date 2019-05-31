<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<style>
.detailbox {
	display: none;
	background-color:lightyellow;
	border: 1px solid grey;
	width: 594px;
		box-shadow: 10px 10px 5px #888888;
	border-radius: 6px;
	margin-top: 160px;
	left: 220px;
	z-index: 1;
	position: absolute;
	
}

.detailbox-header {
	width: 594px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 30px;
	background-color: #FFCC99;
}
</style>
<script>

function viewdetails(id)
{
	
		$.ajax({
			type : "post",
			url : 'getBoughtDetails',
			data : {
				
				'stockPurchaseId' : id
			},
			success : function(data, status) {
				$("#uniformdetails").empty();
				var j = JSON.parse(data);
				var st = "";
		      var length = j.length;
				if (length == 0) {
					st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>No Data available</b></font></h5></div>';
				} else {
					$("#myModalLabel").text(j[0].shopName);
					
					if(j[0].paymentMode=='Cheque')
						{
						st=st+'<div><table  style="margin-bottom: 23px; margin-left: 43px;"><tr><td style="width: 112px;"><b>Cheque No.</b></td><td>'+j[0].chequeno+'</td></tr>'
						+'<tr><td><b>Bank Name</b></td><td>'+j[0].bankName+'</td></tr>'
						+'</table><div>';
						}
	                   st = st
							+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
							+ '</div><div class="block" style="margin-left: 21px; margin-right: 15px; margin-top: 39px;"><div class="head green"><h4 style="text-align: center; height: 31px; padding-top: 5px;">Uniform Details</h4></div>'
							+ '<table class="table table-bordered table-primary"><thead><tr><th>S No</th><th>Uniform Type</th><th>Category</th><th>Size</th><th>Price</th><th>Quantity</th><th>Amount</th><th>Net Amount</th></tr></thead><tbody>';
					for ( var i = 0; i < length; i++) {
						st += '<tr><td>' + (i + 1)
								+ '</td><td>'+ j[i].uniformName
								+ '</td><td>' + j[i].uniformCategory
								+ '</td><td>' + j[i].uniformSize
								+ '</td><td>'+ j[i].uniformPrice
								+ '</td><td>' + j[i].boughtQuantity
								+ '</td><td>' + j[i].amount
								+ '</td><td>' + j[i].netAmount
								+ '</td></tr>';
					}
					st += '</table>';
				}
				$("#uniformdetails").append(st);
				$(".detailbox").show();
			},
			error : function(e) {
				
			}
		});
		
	}
	
function hidedetailbox() {
	$(".detailbox").hide();
	
}
function changePaidStatus(receiptno,status)
{
	document.location.href='change-paid-status?id='+receiptno+'&status='+status;
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
				<div id="uniformdetails"></div>
				
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
	<div id="content-header" style="height: 140px;">
		<img alt="Show_settings" src="${img_url}/uniform.jpg"
			style="width: 50px;">
		<h1>Purchased Uniform Details</h1>
		<h3>View Purchased Uniform Details</h3>
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
	<div class="span12" style="margin-left: 0px; width: 1059px;"></div>

	<div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div class="head blue">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Purchased Uniform Details</h2>
				<ul class="buttons">
					<li><a return false; href="#"><div class="icon">
								<span class="ico-info"></span>
							</div></a></li>
				</ul>
			</div>
			<div class="data-fluid">
				<table class="table fTable lcnp" style="width: 1059px;">
					<thead>
						<tr>
							<th>S No.</th>
							<th>Date of Purchase</th>
							<th>Receipt No.</th>
							<th>Supplier Name</th>
							<th>Total Amount</th>
							<th>Discount</th>
							<th>Paid Amount</th>
							<th>Dues</th>
							<th>Payment Mode</th>
							<th>Payment Status</th>
							<th>View Details</th>
							<th>View Receipt</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${alluniforms}" varStatus="loop">
							<tr>
								<td>${loop.count}</td>
								<td>${list.dateOfPurchase}</td>
								<td>${list.receiptNo}</td>
								<td>${list.supplierName}</td>
								<td>${list.grossAmount}</td>
								<td>${list.discount}</td>
								<td>${list.paidAmount}</td>
								<td>${list.balanceAmount}</td>
								<td>${list.paymentMode}</td>
								<c:choose>
								<c:when test="${list.paidStatus=='Inhand'}">
								<td><select
										onchange="changePaidStatus(${list.receiptNo},this.value);"
										style="width: 94px;"><option value="Inprogress">Inhand
											</option>
											<option value="Completed">Completed</option>
											<option value="Cancel">Cancel</option></select></td>
								</c:when>
								
							<c:otherwise><td>${list.paidStatus}</td></c:otherwise>
								</c:choose>
						
								<td><a
									href="javascript:viewdetails(${list.stockPurchaseId});"><span
										class="label label-important">View</span></a></td>
									<c:choose>
								<c:when test="${list.receiptNo=='0'}">	
								<td></td>
								</c:when>
								<c:otherwise>
								<td><a href="viewpurchased-receipt?id=${list.receiptNo}"target="_blank"><span
										class="label label-primary">Show</span></a></td>
										</c:otherwise>
										</c:choose>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>

		</div>
	</div>
</div>