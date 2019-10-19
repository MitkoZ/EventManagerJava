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
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
	 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	 <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
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
	if(request.getParameterMap().size() == 3){
		 UsersRepository usersRepository = new UsersRepository();
		 User userDb = usersRepository.findByField("id", (Integer)session.getAttribute("currentUserId"));
		 
		 String eventName = request.getParameter("eventName");
		 DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd H:m");
		 LocalDateTime startDateTime = LocalDateTime.parse(request.getParameter("startDateTime"), dateTimeFormatter);
		 LocalDateTime endDateTime = LocalDateTime.parse(request.getParameter("endDateTime"), dateTimeFormatter);
		 
		 Event eventDb = new Event(eventName, startDateTime, endDateTime);
		 userDb.getEvents().add(eventDb);
		 eventDb.setUser(userDb);
		 
		 if(usersRepository.Save(userDb) > 0){
			 out.println("<h1>Event saved successfully!</h1>");
			 return;
		 }
		 
		 out.println("<h1>Ooops something went wrong :(</h1>"); 
	
	}
	%>
</body>
</html>