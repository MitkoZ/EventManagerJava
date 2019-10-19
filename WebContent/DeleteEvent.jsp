<%@page import="org.dimitar.eventManager.repositories.EventsRepository"%>
<%@page import="org.dimitar.eventManager.models.Event"%>
<%@page import="org.dimitar.eventManager.models.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete An Event</title>
</head>
<body>
	<%
		EventsRepository eventsRepository = new EventsRepository();
		Event eventDb = eventsRepository.findByField("id", Integer.valueOf(String.valueOf(request.getParameter("id"))));
		if(eventsRepository.Delete(eventDb) > 0){
			request.getSession().setAttribute("successMessage", "Event deleted successfully!");
			response.sendRedirect("MyEventsList.jsp");
			return;
		}
		 
		request.getSession().setAttribute("successMessage", "Ooops something went wrong :(");
		response.sendRedirect("MyEventsList.jsp");
	%>
</body>
</html>