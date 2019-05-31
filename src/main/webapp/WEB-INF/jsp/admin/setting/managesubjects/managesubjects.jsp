<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:url value="/style/theme/images" var="imageurl" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<div id="content_wrapper">
	<div id="side_bar">

		<div id="sidebar_news_area"></div>
	</div>
	<div id="content">
	<div id="content-header">
			<img alt="Show_settings" src="${img_url}/subject.png"
				style="height: 70px;">
			<h1>Manage Subjects</h1>
			<h3>Create,Edit and Delete Subjects</h3>
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
						<a href="create-subjects">Create Subjects</a>
					</div>
					<div class="link-descr">Add a new Subject</div>
				</div>



				<div class="link-box">
					<div class="link-heading">
						<a href="update-subjects">Update/Delete Subject</a>
					</div>
					<div class="link-descr">Edit/Delete Subject details.</div>
				</div>
			
			</div>


		</div>
	</div>

	<div class="extender"></div>
</div>
