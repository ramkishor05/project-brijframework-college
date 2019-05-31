<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />

<div class="content">
	<div class="page-header">
		<div class="icon">
			<div class="ico-arrow-right"
				style="padding-top: 4px; color: #999999; font-size: 24px;"></div>
		</div>
		<h1>
			Fee Manage <small>Fee management</small>
		</h1>
	</div>

	<div class="row-fluid">
		<div class="span12">
			<div class="widgets">
				<a href="create-edit-view-fee-category">
					<div class="widget green icon">
						<div class="left">
							<div class="icon">
								<span class="ico-pencil"></span>
							</div>
						</div>
						<div style="font-size: 22px; height: 50px; margin-top: 28px;"
							class="right">
							Create Edit View Fee Category <br>
						</div>
						<div class="bottom" style="color: white;">
							Create Edit View Fee Category<a></a>
						</div>
					</div>
				</a> <a href="fee-allotment-menu.html">
					<div class="widget blue icon">
						<div class="left">
							<div class="icon">
								<div class="ico-dollar-2" style="padding-top: 12px;"></div>
							</div>
						</div>
						<div style="font-size: 22px; height: 50px; margin-top: 28px;"
							class="right">
							Fee Allotment To Student<br>
						</div>
						<div class="bottom" style="color: white;">Fee Allotment To
							Student</div>
					</div>

				</a> <a href="view-alloted-fee.html">
					<div class="widget red icon">
						<div class="left">
							<div class="icon">
								<span class="ico-money-bag"></span>
							</div>
						</div>
						<div class="right" style="font-size: 22px;">
							<div style="margin-top: 20px;">Collect Fee</div>
						</div>
						<div class="bottom" style="color: white;">Collect Fee/Add Discount</div>
					</div>
				</a>
			</div>
		</div>

	</div>
	<div class="row-fluid">
		<div class="span12">
			<div class="widgets">
				<a href="search-students-fee-details">
					<div class="widget yellow icon">
						<div class="left">
							<div class="icon">
								<span class="ico-briefcase"></span>
							</div>
						</div>
						<div style="font-size: 22px; height: 50px; margin-top: 28px;"
							class="right">
							Fee Details <br>
						</div>
						<div class="bottom" style="color: white;">Search Fee
							Submission Details</div>
					</div>
				</a><a href="fee-submission-details">
					<div class="widget dblue icon">
						<div class="left">
							<div class="icon">
								<span class="ico-briefcase"></span>
							</div>
						</div>
						<div style="font-size: 22px; height: 50px; margin-top: 28px;"
							class="right">
							Fee Submission Record<br>

						</div>
						<div class="bottom" style="color: white;">Fee Submission
							Details
				</a>
			</div>
		</div>
	</div>

</div>