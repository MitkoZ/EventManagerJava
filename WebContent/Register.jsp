<%@page import="org.dimitar.eventManager.repositories.UsersRepository" %>
<%@page import="org.dimitar.eventManager.models.User" %>
<%@page import = "java.io.*,java.util.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<jsp:include page="_FrontEndDependencies.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
</head> 
<body>
	<jsp:include page="_Navbar.jsp" />
	
	<h1>Register</h1>
	<form action="Register.jsp" method="POST">
		
		<label for="username">Username</label>
		<div class="input-group mb-3">
			<input type="text" name="username" id="username" class="form-control" required /> 
		</div>
		
		<br/>
		
		<label for="password">Password</label>
		<div class="input-group mb-3">
			<input type="password" name="password" id="password" class="form-control" required />
		</div>
		
		<br/>
		
		<input type="submit" value="Register" class="btn btn-success"/>
	</form>
	
	<%
		if(request.getParameterMap().size()>0){
			 User userDb = new User(request.getParameter("username"), request.getParameter("password"));
			 UsersRepository usersRepository = new UsersRepository();
			 
			   if(usersRepository.findByField("username", request.getParameter("username")) != null){
				   out.println("<h1>A user with this username already exists</h1>");
				   return;
			   }
			   
			   if(usersRepository.Save(userDb) > 0){
				    request.getSession().setAttribute("successMessage", "User Registered Successfully!");
				    response.sendRedirect("Home.jsp");
			   }
			   else{
				   request.getSession().setAttribute("errorMessage", "Ooops something went wrong :(");
				   response.sendRedirect("Home.jsp");
			   }
		}
		%>
</body>
</html>