<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />

<script type="text/javascript">
$('#date').val(new Date);
</script>

<div class="content">
	<div class="page-header">
		<div class="icon">
			<span class="ico-dollar"></span>
		</div>
		<h1>
			Collections <small>Show Available Collections</small>
		</h1>
	</div>


	<div id="date"></div>

	<div class="row-form">
		<div class="span2">
			Total Collections &nbsp;&nbsp;&nbsp;&nbsp;:
		</div>
		<div class="span4">${totalCollections}</div>
	</div>

	<div class="row-form">
		<div class="span2">
			Total Expensions &nbsp;&nbsp;&nbsp;&nbsp;:
		</div>
		<div class="span4">${totalExpenses}</div>
	</div>

	<div class="row-form">
		<div class="span2">
			Available Balance &nbsp;&nbsp;&nbsp;&nbsp;:
		</div>
		<div class="span4">${availableBalance}</div>
	</div>
</div>

