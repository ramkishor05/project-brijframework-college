<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script type="text/javascript">
	jQuery(document).ready(function($) {
		// Get current url
		// Select an a element that has the matching href and apply a class of 'active'. Also prepend a - to the content of the link
		var url = window.location.href;
		$('.nContainer a[href="' + url + '"]').addClass('active');
		$('.nContainer a[href="' + url + '"]').addClass('"blblue" ');

	});
</script>
<div id="content_wrapper">
	<div id="side_bar">

		<div id="sidebar_news_area"></div>
	</div>
	<div id="content">
<div id="content-header">
			<img alt="Show_settings"
				src="${img_url}/show_settings.png?1409570412">
			<h1>Settings</h1>
			<h3>Settings Dashboard</h3>
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
						<a href="add-employee-role">Add Employee Role</a>
					</div>
					<div class="link-descr">Create|Edit|Delete Employee Role.</div>
				</div>



				<div class="link-box">
					<div class="link-heading">
						<a href="manage-student-categories">Manage Student Category</a>
					</div>
					<div class="link-descr">Create|Edit|Delete Std. Category</div>
				</div>


				<div class="link-box">
					<div class="link-heading">
						<a href="manage-country">Manage Countries</a>
					</div>
					<div class="link-descr">Create|Edit|Delete Country.</div>
				</div>



				<div class="link-box">
					<div class="link-heading">
						<a href="manage-state">Manage States</a>
					</div>
					<div class="link-descr">Create|Edit|Delete States.</div>
				</div>

				<div class="link-box">
					<div class="link-heading">
						<a href="manage-city">Manage City</a>
					</div>
					<div class="link-descr">Create|Edit|Delete City.</div>
				</div>

				<div class="link-box">
					<div class="link-heading">
						<a href="manage-class.html">Manage Class</a>
					</div>
					<div class="link-descr">Create|Edit|Delete Class.</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="manage-section.html">Manage Section</a>
					</div>
					<div class="link-descr">Create|Edit|Delete Section.</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="manage-session.html">Manage Session</a>
					</div>
					<div class="link-descr">Create|Edit|Delete Session.</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="manage-lastdates.html">Manage Due Dates</a>
					</div>
					<div class="link-descr">Update Last Dates for monthly fee
						payment</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="manage-student-subjects">Manage Subjects</a>
					</div>
					<div class="link-descr">Create|Edit|Delete Subjects</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="fine.html">Manage Fine</a>
					</div>
					<div class="link-descr">Create|Update Fine</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="manage-document.html">Manage Documents</a>
					</div>
					<div class="link-descr">Create|Update Document Category</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="restore.html">Restore Database</a>
					</div>
					<div class="link-descr">Restore Database from last backup</div>
				</div>
				<!-- <div class="link-box">
					<div class="link-heading">
						<a href="library.html">Manage Library</a>
					</div>
					<div class="link-descr">Create/Update Library</div>
				</div> -->
				<!-- <div class="link-box">
					<div class="link-heading">
						<a href="school-registration.html">School Registration</a>
					</div>
					<div class="link-descr">Register School</div>
				</div> -->
					
			</div>


		</div>
	</div>

	<div class="extender"></div>
</div>

