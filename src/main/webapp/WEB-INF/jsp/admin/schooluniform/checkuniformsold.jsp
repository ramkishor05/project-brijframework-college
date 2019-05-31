<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<script>
function viewcategories(value) {
	$("#" + value).fadeIn(1000);
}
function hidecategories(value) {
	$("#s" + value).fadeOut(1000);
}
function hidename(value) {
	$("#" + value).fadeOut(1000);
}
function getSizeforCategory(count, category, name) {
	$("#s" + count).empty();
	$
			.ajax({
				type : "post",
				url : 'getCategoryWiseSize',
				data : {
					'category' : category,
					'name' : name,
				},
				success : function(data, status) {

					var j = JSON.parse(data);
					var content = '<div class="widget-body" style="padding: 10px 0px 0px; width: 267px; float: left; margin-left: 40px;"><div class="block" style="width: 352px;">'
							+ '<div class="head red" style="margin-left: 0px; width: 146px;"><div class="icon"><span class="ico-pen-2"></span></div><h2>Sizes</h2><ul class="buttons">'
							+ '<li><a href="javascript:hidecategories('
							+ count
							+ ');"><div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div><div class="data-fluid" style="width: 173px;"><table class="table fTable lcnp">'
							+ '<thead></thead><tbody><tr><td><ul>';
					for ( var i = 0; i < j.length; i++) {
						content += '<li><a href=javascript:showdresssold("'
								+ name + '","' + category + '",' + j[i]
								+ '); >' + j[i] + '</a></li>'
					}
					content += '</ul></td></tr></tbody></table></div></div>';
					$("#s" + count).append(content);
					$("#s" + count).fadeIn(1000);
				},
				error : function(e) {

				}
			});

}

function showdresssold(name, category, size) {
	

	$("#dress")
			.append('<center><img src="${img}/loads.gif" alt="Loading" style="width=200px;height=200px;"></center>');
	$
	.ajax({
		type : "post",
		url : 'showdresssold',
		data : {
			'name' : name,
			'category' : category,
			'size' : size,
		},
				success : function(data, status) {
					$("#dress").empty();
					var j = JSON.parse(data);
					var st = "";
					var length = j.length;
					if (length == 0) {
						st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>No student found</b></font></h5></div>';
					} else {

						st = st
								+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
								+ '</div><div class="block"  style="width: 626px; height: 208px; top: 53px;"><div class="head blue"><h4 style="text-align:center">Uniform Sold details</h4></div>'
								+ '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Student Name</th><th>Father Name</th><th>Class</th><th>Section</th><th>Date</th><th>Quantity</th><th>Price</th></tr></thead><tbody>';
						for ( var i = 0; i < length; i++) {
							st += '<tr><td>' + (i + 1) + '. </td><td>'
									+ j[i].firstName + " "
									+ j[i].middleName + " " + j[i].lastName
									+ '</td><td>' + j[i].fatherName
									+ '</td><td>' + j[i].className
									+ '</td><td>' + j[i].sectionName
									+ '</td><td>' + j[i].payDate
									+ '</td><td>' + j[i].quantity
									+ '</td><td>' + j[i].price
									+ '</td></tr>';
						}
						st += '</table>';
					}
					$("#dress").append(st);
				},
				error : function(error, status) {
				}
			});
}
</script>
<div class="content">
	<div id="content-header" style="height: 140px;">
		<img alt="Show_settings" src="${img_url}/uniform.jpg"
			style="width: 50px;">
		<h1>View Sold Uniform Details</h1>
		<h3>View details of uniforms sold</h3>
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
	<div class="span12" style="margin-left: 0px; width: 601px;"></div>
	<div id="datas" style="width: 682px; float: left;">

	
			<div id="dress" style="width: 735px;"></div>
			
	</div>
	<div class="widget-body"
		style="padding: 10px 0px 0px; width: 318px; float: left; margin-left: 40px;">
		<div class="block" style="width: 352px;">
			<div class="head blue" class="head blue"
				style="margin-left: 0px; width: 325px;">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Check Uniforms Sold</h2>
				<ul class="buttons">
					<li><a return false; href="#"><div class="icon">
								<span class="ico-info"></span>
							</div></a></li>
				</ul>
			</div>
			<div class="data-fluid" style="width: 336px;">

				<table class="table fTable lcnp" style="width: 1059px;">
					<thead>
						<tr>
							<th>Uniform Details</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="names" items="${uniform}" varStatus="loop">

							<tr>
								<td>

									<ul>
										<li><a
											href="javascript:viewcategories('${names.uniformName}');">${names.uniformName}</a></li>
										<div id="${names.uniformName}"
											style="width: 270px; margin-left: 25px; display: none;">
											<div class="widget-body"
												style="padding: 10px 0px 0px; width: 251px; float: left; margin-left: 40px;">
												<div class="block" style="width: 352px;">
													<div class="head purple"
														style="margin-left: 0px; width: 234px;">
														<div class="icon">
															<span class="ico-pen-2"></span>
														</div>
														<h2>Categories</h2>
														<ul class="buttons">
															<li><a
																href="javascript:hidename('${names.uniformName}');">
																	<div class="icon">
																		<span class="ico-cancel"></span>
																	</div>
															</a></li>
														</ul>
													</div>
													<div class="data-fluid">
														<table class="table fTable lcnp" style="width: 241px;">

															<tbody>
																<tr>
																	<td><c:forEach var="value"
																			items="${names.categoryList}">
																			<li><a
																				href="javascript:getSizeforCategory('${loop.count}','${value}','${names.uniformName}');">${value}</a>
																				<div id="s${loop.count}"
																					style="width: 225px; margin-left: 25px;"></div></li>
																		</c:forEach></td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>

									</ul>

								</td>

							</tr>
						</c:forEach>

					</tbody>
				</table>
			
			</div>
			
		</div>

	</div>
</div>