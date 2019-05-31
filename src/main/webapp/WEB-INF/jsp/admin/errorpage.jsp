<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page isErrorPage="true"%>
<spring:url value="/style" var="styleurl" />
<html>
<head>
<title>Show Error Page</title>
<spring:url value="/style" var="styleurl" />
<script type="text/javascript" src="${styleurl}/newhome/js/jquery.js"></script>
<script type="text/javascript"
	src="${styleurl}/newhome/js/jquery.min.js"></script>
<script type="text/javascript">
	if ('${pageContext.errorData.statusCode}' == 405) {
		window.history.back();
	}
	$(function() {
		$.ajax({
			url : "error-message-toadmin",
			type : "post",
			data : {
				ErrorType : '${pageContext.exception}',
				URI : '${pageContext.errorData.requestURI}',
				Statuscode : '${pageContext.errorData.statusCode}',
				lineNumber : '${pageContext.exception.stackTrace[0]}'
			},
			success : function(data, status) {
			},
			error : function(error, status) {
				alert(error);
			}
		});
	});
</script>
</head>
<body>
	<center>

		<img style="" alt="errorimage" src="${styleurl}/images/errorpage.jpg">

	</center>
	<div
		style="height: 150px; width: 700px; overflow: hidden; margin-left: 350px; text-align: center;">
		<a href="javascript:history.back();"> <img alt=""
			src="${styleurl}/images/goback_button4 copy.jpg" height="150px;"
			width="400px;"></a>
	</div>
</body>
</html>