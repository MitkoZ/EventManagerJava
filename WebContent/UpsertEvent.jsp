<%@page import="java.util.function.Supplier"%>
<%@page import="java.util.stream.Stream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.text.MessageFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Optional" %>
<%@page import="org.dimitar.eventManager.models.Event"%>
<%@page import="org.dimitar.eventManager.models.User"%>
<%@page import="org.dimitar.eventManager.repositories.UsersRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<jsp:include page="_FrontEndDependencies.jsp"/>
<jsp:include page="_Messages.jsp"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<% 
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		request.setAttribute("dateTimeFormatter", dateTimeFormatter);
	%>
</head>
<body>
	<jsp:include page="_Navbar.jsp" />
	
	<%
		Event currentEvent = null;
		String eventIdString = request.getParameter("id");
		String pageHeading = "";
		if(isEdit(eventIdString)){ // edit
			pageHeading = "Edit Event";
			 UsersRepository usersRepository = new UsersRepository();
			 User userDb = usersRepository.findByField("id", (Integer)session.getAttribute("currentUserId"));
			 Optional<Event> currentEventOptional = userDb.getEvents().stream().filter(x->x.getId() == Integer.valueOf(eventIdString)).findFirst();
			 if(!currentEventOptional.isEmpty()){
				 currentEvent = currentEventOptional.get();
				 request.setAttribute("currentEvent", currentEvent);
			 }
		}
		else { // create
			pageHeading = "Create Event";
		}
		out.println(MessageFormat.format("<title>{0}</title>", pageHeading));
		out.println(MessageFormat.format("<h1>{0}</h1>", pageHeading));
	%>
	
	<form action="UpsertEvent.jsp" method="POST">
		<input type="hidden" name="id" value="${currentEvent.getId()}"/>  
		
		<div class="form-group row">
			<label for="eventName" class="col-sm-2 col-form-label">Event Name:</label>
			
			<div class="col-sm-10">
				<input type="text" name="eventName" id="eventName" class="form-control" value="${currentEvent.getName()}" required/>
			</div>
		</div>
		
		<div class="form-group row">
			<label for="location" class="col-sm-2 col-form-label">Location:</label>
			
			<div class="col-sm-10">
				<input type="text" name="location" id="location" class="form-control" value="${currentEvent.getLocation()}" required/>
			</div>
		</div>
		
		<div class="form-group row">
			<label for="startDateTime" class="col-sm-2 col-form-label">Start Date Time:</label>
		
			<div class="col-sm-10">
				<input type="text" name="startDateTime" id="startDateTime" class="form-control" value="${currentEvent.getStartDateTime().format(dateTimeFormatter)}"/>
			</div>
		</div>
		
		<div class="form-group row">
			<label for="endDateTime" class="col-sm-2 col-form-label">End Date Time:</label>
			
			 <div class="col-sm-10">
				<input type="text" name="endDateTime" id="endDateTime" class="form-control" value="${currentEvent.getStartDateTime().format(dateTimeFormatter)}"/>
			</div>
		</div>
		
		<input type="submit" value="Save" class="btn btn-success"/>
		
		<script>
		    flatpickr.l10ns.default.firstDayOfWeek = 1; // Changing it to Monday, because the default date is Sunday
		    var currentTime = "<%
			    LocalDateTime now = LocalDateTime.now();
		    	DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm"); 
		    	out.print(now.format(timeFormatter));
		    %>";
		    	
		    var flatpickrConf = {
		        weekNumbers: true,
		        minDate: "today",
		        enableTime: true,
		        time_24hr: true,
		        minTime: currentTime
		    };
		    
		    $("#startDateTime").flatpickr(flatpickrConf);
		    flatpickrConf.minTime="<%=now.plusMinutes(1).format(timeFormatter)%>";
	    	
		    $("#endDateTime").flatpickr(flatpickrConf);
		</script>
	</form>
	
	<%!
	
		public Boolean isEdit(String eventIdString){
			if(eventIdString != null && !eventIdString.equals("")){
				return true;
			}
			
			return false;
		}
		
		public void redirectToUpsertPage(HttpServletRequest request, HttpServletResponse response, String eventIdString) throws IOException{
			if(isEdit(eventIdString)){
				String eventId = request.getParameter("id");
				response.sendRedirect("UpsertEvent.jsp?id=" + eventId);		
			}
		}
	
		public Boolean isValid(String eventIdString, String eventName, String location, String startDateTimeString, String endDateTimeString, DateTimeFormatter dateTimeFormatter, HttpServletRequest request, HttpServletResponse response) throws IOException{
			
			if(eventName.isBlank()){
				request.getSession().setAttribute("errorMessage", "Event Name cannot be blank!");
				redirectToUpsertPage(request, response, eventIdString);
				return false;
			}
			
			if(eventName.isBlank()){
				request.getSession().setAttribute("errorMessage", "Location cannot be blank!");
				redirectToUpsertPage(request, response, eventIdString);
				return false;
			}
			
			if(startDateTimeString.isBlank()){
				request.getSession().setAttribute("errorMessage", "Start Date Time cannot be blank!");
				redirectToUpsertPage(request, response, eventIdString);
				return false;
			}
			
			if(endDateTimeString.isBlank()){
				request.getSession().setAttribute("errorMessage", "End Date Time cannot be blank!");
				redirectToUpsertPage(request, response, eventIdString);
				return false;
			}
			
			 
			 LocalDateTime startDateTime = LocalDateTime.parse(startDateTimeString, dateTimeFormatter);
			 LocalDateTime endDateTime = LocalDateTime.parse(endDateTimeString, dateTimeFormatter);
			 
			if(startDateTime.isAfter(endDateTime)){
				request.getSession().setAttribute("errorMessage", "Start Date Time cannot be after End Date Time!");
				redirectToUpsertPage(request, response, eventIdString);
				return false;
			}
			
			UsersRepository usersRepository = new UsersRepository();
			
			User currentUserDb = usersRepository.findByField("id", (Integer)request.getSession().getAttribute("currentUserId"));
			
			Supplier<Stream<Event>> currentEventDbStreamSupplier = () -> currentUserDb.getEvents().stream().filter(x->x.getName().equals(eventName));
			
			if(isEdit(eventIdString) && currentEventDbStreamSupplier.get().count() >= 1 && currentEventDbStreamSupplier.get().findFirst().get().getId() != Integer.valueOf(String.valueOf(eventIdString))){ // it's edit and he is trying to edit an event with the same name of a different event
				request.getSession().setAttribute("errorMessage", "An event with this name already exists!");
				response.sendRedirect("UpsertEvent.jsp");
				return false;
			}
			else if(!isEdit(eventIdString) && currentEventDbStreamSupplier.get().count() >= 1){ // it's create and he is trying to create an event with the same name
				request.getSession().setAttribute("errorMessage", "An event with this name already exists!");
				response.sendRedirect("UpsertEvent.jsp");
				return false;
			}
			
			return true;
		}
	
	 %>
	 
	<%
	if(request.getParameterMap().size() > 3){
		 UsersRepository usersRepository = new UsersRepository();
		 User userDb = usersRepository.findByField("id", (Integer)session.getAttribute("currentUserId"));
		 
		 String eventName = request.getParameter("eventName");
		 String location = request.getParameter("location");
		 String startDateTimeString = request.getParameter("startDateTime");
		 String endDateTimeString = request.getParameter("endDateTime");
		 
		 if(!isValid(eventIdString, eventName, location, startDateTimeString, endDateTimeString, dateTimeFormatter, request, response)){
			 return;
		 }
		 
		 LocalDateTime startDateTime = LocalDateTime.parse(startDateTimeString, dateTimeFormatter);
		 LocalDateTime endDateTime = LocalDateTime.parse(endDateTimeString, dateTimeFormatter);
		 
		 if(isEdit(eventIdString)){ //edit
			 Event editedEvent = userDb.getEvents().stream().filter(x->x.getId() == Integer.valueOf(eventIdString)).findFirst().get();
			 editedEvent.setName(eventName);
			 editedEvent.setLocation(location);
			 editedEvent.setStartDateTime(startDateTime);
			 editedEvent.setEndDateTime(endDateTime);
		 }
		 else { //create
			 Event eventDb = new Event(eventName,location, startDateTime, endDateTime);
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