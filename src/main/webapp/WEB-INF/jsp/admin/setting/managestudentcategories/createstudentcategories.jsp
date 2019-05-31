<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<%-- <link rel="stylesheet" type="text/css" href="${css_url}/admission.css"> --%>
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script>
	function matchformat(value) {
		$(".successmsg").remove();
		$("#info").empty();
		var regex1 = /^[a-zA-Z]*[a-zA-Z ]+$/;
		if (!regex1.test(value)) {
			$("#info").append('<font color="red">Enter only Letters</font>');
			$("#hidebuttn").hide();
		} else {
			$
					.ajax({
						type : "post",
						url : 'checkforstudentcategory',
						data : {
							"studentCategory" : value
						},
						success : function(data) {
							var obj = JSON.parse(data);
							if (obj == null) {
								$("#info").empty();
								$("#hidebuttn").show();
							} else {
								$("#info").empty();
								$("#hidebuttn").hide();
								$("#info")
										.append(
												'<font color="red">This Student Category Is Exists</font>');
							}
							$("#stateId").append(content);
						},
						error : function(e) {
							$('#loading').hide();
						}
					});

		}
	}
	function getstate(countryId) {
		$("#stateId").empty();
		$.ajax({
			type : "post",
			url : 'getstate',
			data : {
				"countryId" : countryId
			},
			success : function(data) {
				var obj = JSON.parse(data);
				var content = '<option value="">Select a state</option>';
				$.each(obj, function(key, value) {
					content += '<option value="'+value.id+'">'
							+ value.stateName + '</option>';
				});
				$("#stateId").append(content);
			},
			error : function(e) {
				$('#loading').hide();
			}
		});
	}
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div class="content">
		<div id="content-header" style="height: 150px;">
			<img alt="Show_settings" src="${img_url}/student_category.jpg"
				style="width: 50px; margin-top: -12px;">
			<h1>Create Categories</h1>
			<h3>Manage Categories</h3>
			<div id="app-back-button">
				<a href="home"><img alt="Back" border="0"
					src="${img_url}/home.png" title="Home"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="javascript:location.reload(true);"><img
					alt="Back" border="0" src="${img_url}/refresh.png" title="Refresh"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="history.back(); return false;"><img
					alt="Back" border="0" src="${img_url}/back.png" title="Back"
					style="margin-top: -6px; height: 40px; width: 40px;"></a>
			</div>
		</div>


		<f:form action="create-student-categories" method="post"
			commandName="StudentCategory">
			<br>
			<table style="width: 1059px;">

				<tr>
					<td style="width: 200px;">Category Name:</td>
					<td><input name="studentCategoriesName" required="required"
						id="category" placeholder="Enter Category Name" type="text"
						style="width: 300px;" onkeyup="matchformat(this.value);"
						maxlength="10"
						class="validate[required,minSize[2],maxSize[15],custom[onlyLetterSp]]" />
						<div id="exist"></div></td>
				</tr>
			</table>
			<div class="separator"></div>
			<div id="hidebuttn">
				<button type="submit"
					class="btn btn-icon btn-primary glyphicons no-js play"
					style="position: relative; left: 427px; margin-top: 12px; width: 75px;">
					<i></i>Save
				</button>
			</div>
			<f:hidden path="active" value="true" />
			<c:if test="${! empty msg}">
				<div class="successmsg">${msg}</div>
			</c:if>

		</f:form>
		<div id="info"></div>
	</div>
</body>
</html>