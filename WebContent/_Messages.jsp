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
	<h1>${successMessage}</h1>
	<h1>${errorMessage}</h1>
	<c:remove var="successMessage" scope="session" />
	<c:remove var="errorMessage" scope="session" />
</body>
</html>