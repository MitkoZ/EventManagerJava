<%@page import="org.dimitar.eventManager.repositories.UnitOfWork"%>
<%@page import="java.util.Set"%>
<%@page import="org.dimitar.eventManager.models.User"%>
<%@page import="org.dimitar.eventManager.models.Event"%>
<%@page import="org.dimitar.eventManager.repositories.UsersRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All my events</title>
</head>
<body>

	<%
		UsersRepository usersRepository = UnitOfWork.getUnitOfWork().getUsersRepository();
		User currentUserDb = usersRepository.findByField("id",	(Integer)session.getAttribute("currentUserId"));
		Set<Event> myEvents = currentUserDb.getEvents();
		request.setAttribute("myEvents", myEvents);
	%>
	
	<h1>My Events</h1>
	<a href="UpsertEvent.jsp">Create</a>
	<table border="1">
		<thead>
			<th>Id</th>
			<th>Name</th>
			<th>StartDateTime</th>
			<th>EndDateTime</th>
			<th></th>
			<th></th>
		</thead>
		<tbody>
			<c:forEach items="${myEvents}" var="myEvent">
				<tr>
					<td>${myEvent.getId()}</td>
					<td>${myEvent.getName()}</td>
					<td>${myEvent.getStartDateTime()}</td>
					<td>${myEvent.getEndDateTime()}</td>
					<td><a href="">Edit</a></td>
					<td><a href="">Delete</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>