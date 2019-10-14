<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="org.dimitar.eventManager.models.Event"%>
<%@page import="org.dimitar.eventManager.models.User"%>
<%@page import="org.dimitar.eventManager.repositories.UsersRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Upsert Event</title>
</head>
<body>
	<form action="UpsertEvent.jsp" method="POST">
		<label for="eventName">Event Name:</label>
		<input type="text" name="eventName" id="eventName"/>
		<br>
		
		<label for="startDateTime">Start Date Time:</label>
		<input type="datetime-local" name="startDateTime" id="startDateTime">
		<br>
		
		<label for="endDateTime">End Date Time:</label>
		<input type="datetime-local" name="endDateTime" id="endDateTime">
		<br>
		
		<input type="submit" value="Save"/>
	</form>
	
	<%
	if(request.getParameterMap().size() == 3){
		 UsersRepository usersRepository = new UsersRepository();
		 User userDb = usersRepository.findByField("id", (Integer)session.getAttribute("currentUserId"));
		 
		 String eventName = request.getParameter("eventName");
		 LocalDateTime startDateTime = LocalDateTime.parse(request.getParameter("startDateTime"), DateTimeFormatter.ISO_DATE_TIME);
		 LocalDateTime endDateTime = LocalDateTime.parse(request.getParameter("endDateTime"), DateTimeFormatter.ISO_DATE_TIME);
		 
		 Event eventDb = new Event(eventName, startDateTime, endDateTime);
		 userDb.getEvents().add(eventDb);
		 
		 if(usersRepository.Save(userDb) > 0){
			 out.println("<h1>Event saved successfully!</h1>");
			 return;
		 }
		 
		 out.println("<h1>Ooops something went wrong :(</h1>"); 
	
	}
	%>
</body>
</html>