<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="org.dimitar.eventManager.repositories.UsersRepository" %>
<%@page import="org.dimitar.eventManager.models.User" %>
<%@page import = "java.io.*,java.util.*" %>
<jsp:include page="_FrontEndDependencies.jsp"/>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<jsp:include page="_Navbar.jsp" />
	
	<h1>Login</h1>
		<form action="Login.jsp" method="POST">
			
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
		
		<input type="submit" value="Login" class="btn btn-success"/>
	</form>
	<%
	if(request.getParameterMap().size() == 2){ // username and password are entered
	       UsersRepository usersRepository = new UsersRepository();
	       List<User> usersDb = usersRepository.GetAll();
	       
	       String username = request.getParameter("username");
	       String password = request.getParameter("password");
	       
	       Optional<User> currentUserDb = usersDb.stream().filter(x->x.getUsername().equals(username) && x.getPassword().equals(password)).findFirst();
		   if(currentUserDb.isPresent()){
			  session.setAttribute("currentUsername", currentUserDb.get().getUsername());
			  session.setAttribute("currentUserId", currentUserDb.get().getId());
			  request.getSession().setAttribute("successMessage", "User logged successfully!");
			  response.sendRedirect("MyEventsList.jsp");
			  return;
		   }
		   
		   out.println("<h1>Wrong username or password!</h1>");
	}
	%>
</body>
</html>