<%@page import="java.text.MessageFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Messages</title>
</head>
<body>

	<%
		if (session.getAttribute("successMessage") != null) {
			out.println(MessageFormat.format("<h1 class=\"alert alert-success fade show\" role=\"alert\">{0}</h1>",
					session.getAttribute("successMessage")));

		} else if (session.getAttribute("errorMessage") != null) {
			out.println(MessageFormat.format("<h1 class=\"alert alert-danger fade show\" role=\"alert\">{0}</h1>",
					session.getAttribute("errorMessage")));
		}
	%>

	<script>
		setTimeout(function() {
			$(".alert").alert('close')
		}, 3000);
	</script>

	<c:remove var="successMessage" scope="session" />
	<c:remove var="errorMessage" scope="session" />
</body>
</html>