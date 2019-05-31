<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/login.css">

<script type="text/javascript">
	featuredcontentslider.init({
		id : "slider2",
		contentsource : [ "inline", "" ],
		toc : "markup",
		nextprev : [ "Previous", "Next" ],
		revealtype : "click",
		enablefade : [ true, 0.2 ],
		autorotate : [ true, 3000 ],
		onChange : function(previndex, curindex) {
		}
	});
	</script>
	<script type="text/javascript">
 history.pushState(null, null, 'login');
	    window.addEventListener('popstate', function(event) {
	    history.pushState(null, null, 'login');
	    });
	 </script>  
</head>

<div id="wrap" style="margin-left: -270px;">
	<div id="top_logo">
		<img alt="App_fedena_logo" src="${img_url}/bluediamond-logo.jpg" style="height: 129px; width: 143px;">
	</div>

	<div id="login_area_bg" style="margin-top: 20px;">

		<form action="${baseurl}j_spring_security_check" method="post">
			<div style="margin: 0; padding: 0; display: inline">
				<input name="category" type="hidden" value="ROLE_USER">
			</div>

			<div id="login_area">
			<c:if test="${not empty loginerror}">
				<div class="error">User name and password you enter is invalid</div>
			</c:if>
		
				<label for="username">Username</label>
				<div id="username_textbox_bg">
					<input id="user_username" maxlength="40" name="j_username"
						size="40" type="text"
						value='<c:if test="${not empty param.login_error}"><c:out value="${SPRING_SECURITY_LAST_USERNAME}"/></c:if>'>
				</div>

				<label for="password">Password</label>
				<div id="password_textbox_bg">
					<input id="user_password" name="j_password" size="30"
						type="password">
				</div>

				<div id="notice-box"></div>

				<div id="submit_area">
					<input class="submit" name="commit" type="submit" value="Login">
				</div>
			</div>
		</form>
		<div id="footer" style="margin-top: 55px;">
			<div id="footer_logo">
				<div id="powered_by">
					Powered by <a target="_blank" href="http://www.fadsan.com">Fadsan
						Technologies</a>
				</div>
			</div>
		</div>
	</div>

	<div id="help_forgot_pw"></div>
	<div class="clearfooter"></div>
</div>
