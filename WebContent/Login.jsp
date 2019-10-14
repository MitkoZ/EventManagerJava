<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="org.dimitar.eventManager.repositories.UsersRepository" %>
<%@page import="org.dimitar.eventManager.models.User" %>
<%@page import = "java.io.*,java.util.*" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<h1>Login</h1>
		<form action="Login.jsp" method="POST">
		
		<label for="username">Username</label>
		<input type="text" name="username" id="username" required /> 
		
		<br/>
		
		<label for="password">Password</label>
		<input type="password" name="password" id="password" required />
		
		<br/>
		
		<input type="submit" value="Login"/>
	</form>
	<%
	if(request.getParameterMap().size() == 2){ // username and password are entered
	       UsersRepository usersRepository = new UsersRepository();
	       List<User> usersDb = usersRepository.GetAll();
	       
	       String username = request.getParameter("username");
	       String password = request.getParameter("password");
	       
	       Optional<User> currentUserDb = usersDb.stream().filter(x->x.getUsername().equals(username) && x.getPassword().equals(password)).findFirst();
		   if(currentUserDb.isPresent()){
			  out.println("<h1>User logged successfully!</h1>");
			  session.setAttribute("currentUsername", currentUserDb.get().getUsername());
			  session.setAttribute("currentUserId", currentUserDb.get().getId());
			  return;
		   }
			out.println("<h1>Wrong username or password!</h1>");
	}
	%>
</body>
</html>