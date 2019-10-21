<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="org.dimitar.eventManager.models.User"%>
<%@page import="org.dimitar.eventManager.models.Event"%>
<%@page import="org.dimitar.eventManager.repositories.UsersRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All my events</title>
</head>
<body>
	<jsp:include page="_FrontEndDependencies.jsp" />
	<jsp:include page="_Navbar.jsp" />
	<jsp:include page="_Messages.jsp" />
	<%
		UsersRepository usersRepository = new UsersRepository();
		User currentUserDb = usersRepository.findByField("id", (Integer) session.getAttribute("currentUserId"));
		List<Event> myEvents = currentUserDb.getEvents();
		request.setAttribute("myEvents", myEvents);
	%>

	<h1>My Events</h1>
	<a href="UpsertEvent.jsp">Create</a>
	<table border="1" class="table table-hover">
		<thead>
			<th scope="col">Id</th>
			<th scope="col">Name</th>
			<th scope="col">Location</th>
			<th scope="col">StartDateTime</th>
			<th scope="col">EndDateTime</th>
			<th></th>
			<th></th>
		</thead>
		<tbody>
			<c:forEach items="${myEvents}" var="myEvent">
				<tr>
					<th scope="row">${myEvent.getId()}</th>
					<td>${myEvent.getName()}</td>
					<td>${myEvent.getLocation()}</td>
					<td>${myEvent.getStartDateTime()}</td>
					<td>${myEvent.getEndDateTime()}</td>
					<td><a href="UpsertEvent.jsp?id=${myEvent.getId()}"
						class="btn btn-warning">Edit</a></td>
					<td>
						<!-- Button trigger the delete modal -->
						<button type="button" class="btn btn-danger" data-toggle="modal"
							data-target="#deleteEventModal${myEvent.getId()}">Delete</button> 
						
						<!-- Modal -->
						<div class="modal fade" id="deleteEventModal${myEvent.getId()}" tabindex="-1"
							role="dialog" aria-labelledby="deleteEventModalLabel${myEvent.getId()}"
							aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="deleteEventModalLabel${myEvent.getId()}">Delete
											Event</h5>
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>

									<div class="modal-body">Are you sure that you want to
										delete the event with Id ${myEvent.getId()}?</div>

									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Close</button>

										<a class="btn btn-danger"
											href="DeleteEvent.jsp?id=${myEvent.getId()}">Delete</a>
									</div>
								</div>
							</div>
						</div>
					</td>

				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>