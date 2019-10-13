<%@page import="org.dimitar.eventManager.repositories.UnitOfWork"%>
<%@page import="org.dimitar.eventManager.repositories.UsersRepository" %>
<%@page import="org.dimitar.eventManager.models.User" %>
<%@page import = "java.io.*,java.util.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
</head> 
<body>
	<h1>Register</h1>
	<form action="Register.jsp" method="POST">
		
		<label for="username">Username</label>
		<input type="text" name="username" id="username" required /> 
		
		<br/>
		
		<label for="password">Password</label>
		<input type="password" name="password" id="password" required />
		
		<br/>
		
		<input type="submit" value="Register"/>
	</form>
	
	<%
		if(request.getParameterMap().size()>0){
			 User userDb = new User(request.getParameter("username"), request.getParameter("password"));
			 UsersRepository usersRepository = UnitOfWork.getUnitOfWork().getUsersRepository();
			 
			   if(usersRepository.findByField("username", request.getParameter("username"))!=null){
				   out.println("<h1>A user with this username already exists</h1>");
				   return;
			   }
			   usersRepository.Save(userDb);
			   if(UnitOfWork.getUnitOfWork().commit() > 0){
				    out.println("<h1>User Registered Successfully!</h1>");
			   }
			   else{
				   out.println("<h1>Ooops something went wrong :(</h1>");
			   }
		}
		%>
</body>
</html>