<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">




<div class="content">
	<div id="content-header" style="height: 140px;">
		<img alt="Show_settings" src="${img_url}/collection.jpg"
			style="width: 50px;">
		<h1>Today's Collections</h1>
		<h3>Today collections report</h3>
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
			style="border: 1px solid #009ad7; font-family: Times Roman; border-radius: 5px; border-top-width: 5px; float: right; margin-top: 12px; margin-bottom: 10px;">Today
			Collections (in INR.) = ${today_collections}/-</B>
	</div>
	<div class="span12" style="margin-left: 0px; width: 1059px;"></div>
	<div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div class="head blue">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Today's Collections from fees</h2>
				<ul class="buttons">
					<li><a return false; title="Today Fee Collections" href="today-fee-collection.xls"><div class="icon">
								<span class="ico-info"></span>
							</div>Export</a></li>
				</ul>
			</div>

			<table class="table table-bordered table-primary"
				style="width: 1059px;">
				<thead>
					<tr>
						<th>Student Admission No</th>
						<th>L.F. No.</th>
						<th>Receipt No.</th>
						<th>Name</th>
						<th>Amount Paid</th>
						<th>Fine Amount</th>
						<th>Discount Amount</th>
						<th>Paid Date</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${todaysCollection}" varStatus="loop">
						<tr>
							<td class="center"><font size="2">${list.studentId}</font></td>
							<td class="center"><font size="2">${list.lFno}</font></td>
							<td class="center"><font size="2">${list.recieptNo}</font></td>
							<td class="center"><font size="2">${list.studentName}</font></td>
							<td class="center"><font size="2">${list.paidAmount}</font></td>
							<td class="center"><font size="2">${list.fineAmount}</font></td>
							<td class="center"><font size="2">${list.discount}</font></td>
							<td class="center"><font size="2">${list.feePaidDate}</font></td>
						</tr>
					</c:forEach>
					<%-- <tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><b>Total=${today_fee}</b></td>
						<td><b>Total=${overall_fine}</b></td>
						<td><b>Total=${overall_discount}</b></td>
					</tr> --%>
				</tbody>
			</table>
		</div>
	</div>
		<%-- <div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div class="head blue">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Today's Collections from uniform</h2>
				<ul class="buttons">
					<li><a return false; title="Today Uniform Collections" href="#"><div class="icon">
								<span class="ico-info"></span>
							</div>Export</a></li>
				</ul>
			</div>

			<table class="table table-bordered table-primary"
				style="width: 1059px;">
				<thead>
						<tr>
							<th>Date</th>
							<th>Student Name.</th>
							<th>Student Id</th>
							<th>Class</th>
							<th>Section</th>
							<th>Payment Mode</th>
							<th>Paid Amount</th>
							
						</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${todaysuniform}" varStatus="loop">
						<tr>
								<td class="center"><font size="2">${list.payDate}</font></td>
								<td class="center"><font size="2">${list.fullname}</font></td>
								<td class="center"><font size="2">${list.studentId}</font></td>
								<td class="center"><font size="2">${list.className}</font></td>
								<td class="center"><font size="2">${list.sectionName}</font></td>
								<td class="center"><font size="2">${list.paymentMode}</font></td>
								<td class="center"><font size="2">${list.paidAmount}</font></td>
								
							</tr>
					</c:forEach>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><b>Total=${today_fee}</b></td>
						<td><b>Total=${overall_fine}</b></td>
						<td><b>Total=${overall_discount}</b></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
		<div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div class="head blue">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Today's Collections from books</h2>
				<ul class="buttons">
					<li><a return false; title="Today Book Collections" href="#"><div class="icon">
								<span class="ico-info"></span>
							</div>Export</a></li>
				</ul>
			</div>

			<table class="table table-bordered table-primary"
				style="width: 1059px;">
				<thead>
					<tr>
							<th>Date</th>
							<th>Student Name.</th>
							<th>Student Id</th>
							<th>Class</th>
							<th>Section</th>
							<th>Payment Mode</th>
							<th>Paid Amount</th>
							
						</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${todaysbook}" varStatus="loop">
						<tr>
								<td class="center"><font size="2">${list.payDate}</font></td>
								<td class="center"><font size="2">${list.fullname}</font></td>
								<td class="center"><font size="2">${list.studentId}</font></td>
								<td class="center"><font size="2">${list.className}</font></td>
								<td class="center"><font size="2">${list.sectionName}</font></td>
								<td class="center"><font size="2">${list.paymentMode}</font></td>
								<td class="center"><font size="2">${list.paidAmount}</font></td>
								
							</tr>
					</c:forEach>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><b>Total=${today_fee}</b></td>
						<td><b>Total=${overall_fine}</b></td>
						<td><b>Total=${overall_discount}</b></td>
					</tr>
				</tbody>
			</table>
		</div> --%>
	</div>
</div>

