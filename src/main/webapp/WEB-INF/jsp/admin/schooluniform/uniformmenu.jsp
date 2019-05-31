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
			<img alt="Show_settings" src="${img_url}/uniform.jpg"
				style="width: 80px; height: 66px;">
			<h1>Uniform Menu</h1>
			<h3>Manage Uniform</h3>
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
						<a href="uniform-purchase">Purchase Uniform</a>
					</div>
					<div class="link-descr">View dress types,categories and manage prices</div>
				</div>



			 <div class="link-box">
					<div class="link-heading">
						<a href="sell-uniform">Sell Uniform</a>
					</div>
					<div class="link-descr">Sell Dress to Students</div>
				</div>
		<div class="link-box">
					<div class="link-heading">
						<a href="sold-uniform-details">View Sold Uniform Details</a>
					</div>
					<div class="link-descr">View Sold Uniform details</div>
				</div> 
<div class="link-box">
					<div class="link-heading">
						<a href="view-uniform-stock">View Uniform Stock Details</a>
					</div>
					<div class="link-descr">View Uniform Stock Details</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="purchased-uniform-details">Purchased Uniform Details</a>
					</div>
					<div class="link-descr">Purchased Uniform Details</div>
				</div>
					<div class="link-box">
					<div class="link-heading">
						<a href="check-uniform-purchased">Search Purchased Uniforms by size</a>
					</div>
					<div class="link-descr">Size Wise Uniform Purchased details</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="check-uniform-sold">View Sold Uniforms</a>
					</div>
					<div class="link-descr">View details of sold uniforms</div>
				</div>
					<div class="link-box">
					<div class="link-heading">
						<a href="class-wise-solddetails">View ClassWise Sold Uniform Details</a>
					</div>
					<div class="link-descr">View details of sold uniforms by class</div>
				</div>
			</div>


		</div>
	</div>

	<div class="extender"></div>
</div>

