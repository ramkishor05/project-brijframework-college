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
			<img alt="Show_settings" src="${img_url}/book1.jpg"
				style="width: 80px; height: 66px;">
			<h1>Book Menu</h1>
			<h3>Manage Books</h3>
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

		<div id="page-yield">



			<div id="box">


				<div class="link-box">
					<div class="link-heading">
						<a href="book-purchase">Purchase Book</a>
					</div>
					<div class="link-descr">Save purchased books details</div>
				</div>



			 <div class="link-box">
					<div class="link-heading">
						<a href="sell-book">Sell Book</a>
					</div>
					<div class="link-descr">Sell Book to Students</div>
				</div>
		<div class="link-box">
					<div class="link-heading">
						<a href="sold-book-details">View Sold Book Details</a>
					</div>
					<div class="link-descr">View Sold Book details</div>
				</div> 
 <div class="link-box">
					<div class="link-heading">
						<a href="view-book-stock">View Book Stock Details</a>
					</div>
					<div class="link-descr">View Book Stock Details</div>
				</div> 
				<div class="link-box">
					<div class="link-heading">
						<a href="book-purchase-details">Purchased Book Details</a>
					</div>
					<div class="link-descr">View details of books purchased</div>
				</div>
				<!-- <div class="link-box">
					<div class="link-heading">
						<a href="pay-book-dues">Pay Book Dues</a>
					</div>
					<div class="link-descr">Pay Dues of sold books</div>
				</div> -->
					<div class="link-box">
					<div class="link-heading">
						<a href="check-book-sold">Check Sold Book Details</a>
					</div>
					<div class="link-descr">Check Classwise book sold details</div>
				</div>
					<div class="link-box">
					<div class="link-heading">
						<a href="classwise-book-purchased">Check Class Wise Book Purchased Details</a>
					</div>
					<div class="link-descr">Check Classwise book purchased details</div>
				</div>
			</div>


		</div>
	</div>

	<div class="extender"></div>
</div>

