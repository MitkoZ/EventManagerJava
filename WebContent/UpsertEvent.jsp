<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Optional" %>
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
	 <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
	 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	 <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>
<body>

	<% 
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		request.setAttribute("dateTimeFormatter", dateTimeFormatter);
	%>

	<%
		Event currentEvent = null;
		String eventIdString = request.getParameter("id");
		if(eventIdString != null && !eventIdString.equals("")){
			 UsersRepository usersRepository = new UsersRepository();
			 User userDb = usersRepository.findByField("id", (Integer)session.getAttribute("currentUserId"));
			 Optional<Event> currentEventOptional = userDb.getEvents().stream().filter(x->x.getId() == Integer.valueOf(eventIdString)).findFirst();
			 if(!currentEventOptional.isEmpty()){
				 currentEvent = currentEventOptional.get();
				 request.setAttribute("currentEvent", currentEvent);
			 }
		}
	%>
	
	<form action="UpsertEvent.jsp" method="POST">
		<input type="hidden" name="id" value="${currentEvent.getId()}"/>  
	
		<label for="eventName">Event Name:</label>
		<input type="text" name="eventName" id="eventName" value="${currentEvent.getName()}"/>
		<br>
		
		<label for="startDateTime">Start Date Time:</label>
		<input type="text" name="startDateTime" id="startDateTime" value="${currentEvent.getStartDateTime().format(dateTimeFormatter)}"/>
		<br>
		
		<label for="endDateTime">End Date Time:</label>
		<input type="text" name="endDateTime" id="endDateTime" value="${currentEvent.getStartDateTime().format(dateTimeFormatter)}"/>
		<br>
		
		<input type="submit" value="Save"/>
		
		<script>
		    flatpickr.l10ns.default.firstDayOfWeek = 1; // Changing it to Monday, because the default date is Sunday
		    var currentTime = "<%
			    LocalDateTime now = LocalDateTime.now();
		    	DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm"); 
		    	now.format(timeFormatter);
		    %>"
		    var flatpickrConf = {
		        weekNumbers: true,
		        minDate: "today",
		        enableTime: true,
		        time_24hr: true,
		        minTime: currentTime
		    };
		    
		    $("#startDateTime").flatpickr(flatpickrConf);
		    flatpickrConf.minTime="<%
			   	now.plusMinutes(1);
	    	%>";
	    	
		    $("#endDateTime").flatpickr(flatpickrConf);
		</script>
	</form>
	
	<%
	if(request.getParameterMap().size() > 3){
		 UsersRepository usersRepository = new UsersRepository();
		 User userDb = usersRepository.findByField("id", (Integer)session.getAttribute("currentUserId"));
		 
		 String eventName = request.getParameter("eventName");
		 LocalDateTime startDateTime = LocalDateTime.parse(request.getParameter("startDateTime"), dateTimeFormatter);
		 LocalDateTime endDateTime = LocalDateTime.parse(request.getParameter("endDateTime"), dateTimeFormatter);
		 
		 if(eventIdString != null && !eventIdString.equals("")){
			 Event editedEvent = userDb.getEvents().stream().filter(x->x.getId() == Integer.valueOf(eventIdString)).findFirst().get();
			 editedEvent.setName(eventName);
			 editedEvent.setStartDateTime(startDateTime);
			 editedEvent.setEndDateTime(endDateTime);
		 }
		 else {
			 Event eventDb = new Event(eventName, startDateTime, endDateTime);
			 userDb.getEvents().add(eventDb);
			 eventDb.setUser(userDb);
		 }
		  
		 if(usersRepository.Save(userDb) > 0){
			 request.getSession().setAttribute("successMessage", "Event saved successfully!");
			 response.sendRedirect("MyEventsList.jsp");
			 return;
		 }
		 
		 request.getSession().setAttribute("errorMessage", "Ooops something went wrong :(");
		 response.sendRedirect("MyEventsList.jsp");
	}
	%>
</body>
</html>