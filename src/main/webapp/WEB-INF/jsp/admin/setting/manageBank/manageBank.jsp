<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:url value="/style/theme/images" var="imageurl" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/fee.css">
<script type="text/javascript">
	jQuery(document).ready(function($) {
		// Get current url
		// Select an a element that has the matching href and apply a class of 'active'. Also prepend a - to the content of the link
		var url = window.location.href;
		$('.menu a[href="' + url + '"]').addClass('active');
	});
</script>
<div id="content_wrapper">
	<div id="side_bar">

		<div id="sidebar_news_area"></div>
	</div>
	<div id="content">





		<div id="content-header">
			<img alt="Show_settings" src="${img_url}/state.jpg"
				style="height: 70px;">
			<h1>Manage Bank</h1>
			<h3>Create,Edit and delete Bank</h3>
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
						<a href="create-Bank">Create new Bank</a>
					</div>
					<div class="link-descr">Add a new Bank.</div>
				</div>



				<div class="link-box">
					<div class="link-heading">
						<a href="update-state">Update new Bank</a>
					</div>
					<div class="link-descr">Update Bank.</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="delete-state">Delete new Bank</a>
					</div>
					<div class="link-descr">Delete Bank.</div>
				</div>

			</div>


		</div>
	</div>

	<div class="extender"></div>
</div>
