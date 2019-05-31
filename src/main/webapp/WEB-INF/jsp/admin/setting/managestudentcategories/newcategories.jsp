<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<script>
	function matchformat(value) {
		$(".successmsg").remove();
		$("#info").empty();
		var regex1 = /^[a-zA-Z]*[a-zA-Z ]+$/;
		if (!regex1.test(value)){
			$("#info").append('<font color="red">Enter only Letters</font>');
			$("#hidebuttn").hide();
		} else {
			$
			.ajax({
				type : "post",
				url : 'checkforstudentcategory',
				data:{"studentCategory":value},
				success : function(data) {
					var obj = JSON.parse(data);
					if(obj==null){
						$("#info").empty();
					    $("#hidebuttn").show();
					}
					else{
					    $("#info").empty();
					    $("#hidebuttn").hide();
						$("#info").append('<font color="red">This Student Category Is Exists</font>');
					}
					$("#stateId").append(content);
				},
				error : function(e) {
					$('#loading').hide();
				}
			});
			
		}
	}
</script>
<body>
	<div class="content">
		<div id="content-header" style="height: 150px;">
			<img alt="Show_settings" src="${img_url}/student_category.jpg"
				style="width: 50px; margin-top: -12px;">
			<h1>Manage Student Categories</h1>
			<h3>Manage Student Categories</h3>
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
		<f:form action="update-student-categories" method="post"
			commandName="StudentCategory">
			<br>
			<table style="width: 1059px;">
				<tr>
					<td style="width: 200px;">New Category Name:</td>
					<td><f:input path="studentCategoriesName" required="required"
							id="category" onkeyup="matchformat(this.value);"
							placeholder="Enter Category Name" style="width: 300px;" />
						<div id="exist"></div></td>
				</tr>
			</table>
			<div class="separator"></div>
			<div id="hidebuttn">
				<button type="submit"
					class="btn btn-icon btn-primary glyphicons no-js play" id="hide"
					style="position: relative; left: 427px; margin-top: 12px; width: 75px;">
					<i></i>Save
				</button>
			</div>
			<f:hidden path="active" value="true" />
			<f:hidden path="studentCategoriesId" />
		</f:form>
		<div id="info"></div>
	</div>
</body>
</html>