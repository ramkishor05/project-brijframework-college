<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<div id="content_wrapper">
	<div id="side_bar">

		<div id="sidebar_news_area"></div>
	</div>
	<div id="content">
		<div id="content-header">
			<img alt="Show_settings" src="${img_url}/sfees.jpg"
				style="width: 50px;">
			<h1>Fees Section</h1>
			<h3>Fees Management Dashboard</h3>
			<div id="app-back-button">
				<a href="home"><img alt="Back" border="0"
					src="${img_url}/home.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="javascript:location.reload(true);"><img
					alt="Back" border="0" src="${img_url}/refresh.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="history.back(); return false;"><img
					alt="Back" border="0" src="${img_url}/back.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a>
			</div>
		</div>

		<div id="page-yield">

			<div id="box">


				<div class="link-box">
					<div class="link-heading">
						<a href="create-edit-view-fees-categories">Create/Edit/View
							Fee Category</a>
					</div>
					<div class="link-descr">Create/Edit/View Fee Category.</div>
				</div>



				<div class="link-box">
					<div class="link-heading">
						<a href="allot-fees-menu">Allot Fees</a>
					</div>
					<div class="link-descr">Allot Fees ClassWise,SectionWise or
						StudentWise</div>
				</div>

				<div class="link-box">
					<div class="link-heading">
						<a href="fee-payment-tally.html">Fee Payment</a>
					</div>
					<div class="link-descr">View and Pay fee.</div>
				</div>
				<!-- <div class="link-box">
					<div class="link-heading">
						<a href="fee-payment">Fee Payment</a>
					</div>
					<div class="link-descr">Collect Fee/Add Discount.</div>
				</div> -->



				<div class="link-box">
					<div class="link-heading">
						<a href="search-students-fee-details">Check Fee Payment Status</a>
					</div>
					<div class="link-descr">Check Datewise Fee Payment Status.</div>
				</div>

				<div class="link-box">
					<div class="link-heading">
						<a href="fee-submission-details">Fee Submission Record</a>
					</div>
					<div class="link-descr">Check Fee Submission Record.</div>
				</div>

				<!-- <div class="link-box">
					<div class="link-heading">
						<a href="view-feedefaulter-list">Fee Defaulter's List</a>
					</div>
					<div class="link-descr">View Fee Defaulter's List.</div>
				</div> -->
				<!-- <div class="link-box">
					<div class="link-heading">
						<a href="fee-defaulter-menu">Fee Defaulter's List</a>
					</div>
					<div class="link-descr">View Fee Defaulter's List.</div>
				</div> -->
				<div class="link-box">
					<div class="link-heading">
						<a href="cheque-inprogress.html">Inprogress Cheque List</a>
					</div>
					<div class="link-descr">View Inprogress Cheque List.</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="view-student-alloted-fee.html">View Alloted Fees To
							Student</a>
					</div>
					<div class="link-descr">View Alloted Fees To Student.</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="fee-defaulter-menu">Fee Dues</a>
					</div>
					<div class="link-descr">View Dues Menu.</div>
				</div>
			</div>


		</div>
	</div>

	<div class="extender"></div>
</div>
