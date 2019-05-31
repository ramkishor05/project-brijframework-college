<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="login">
	<h2>Log In</h2>
	<form id="signin" action="j_spring_security_check" method="POST">
		<label>UserName</label>
		<input type="text" name="j_username" tabindex="1"/>
		<label>Password</label>
		<input type="password" name="j_password" tabindex="2"  />
		<button type="submit">Login</button>
	</form>
</div>

