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
	<jsp:include page="_Messages.jsp"/>
	
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
	
	<%!
	
		public boolean isContainAtLeastOneNumber(String string) {
		    String numbersRegex = ".*[0-9].*";
		    return string.matches(numbersRegex);
		}
		
		public boolean isContainAtLeastOneLetter(String string){
			String alphabetRegex = ".*[a-zA-Z].*";
			return string.matches(alphabetRegex);
		}
	
		public Boolean isValid(HttpServletRequest request, HttpServletResponse response) throws IOException{
			 UsersRepository usersRepository = new UsersRepository();
			 
			 if(usersRepository.findByField("username", request.getParameter("username")) != null){
				 request.getSession().setAttribute("errorMessage", "A user with this username already exists");
				 response.sendRedirect("Register.jsp");
				 return false;
			 }
			 
			 String username = request.getParameter("username");
			 if(username == null || username.length() < 6){
				 request.getSession().setAttribute("errorMessage", "Username must be at least 6 symbols!");
				 response.sendRedirect("Register.jsp");
				 return false;
			 }
			 
			 String password = request.getParameter("password");
			 if(password == null || password.length() < 8){
				 request.getSession().setAttribute("errorMessage", "Password must be at least 8 symbols!");
				 response.sendRedirect("Register.jsp");
				 return false;
			 }
			 
			 if(!isContainAtLeastOneNumber(password) || !isContainAtLeastOneLetter(password)){
				 request.getSession().setAttribute("errorMessage", "Password must contain at least one number and one letter!");
				 response.sendRedirect("Register.jsp");
				 return false;
			 }
			 
			 return true;
		}
	%>
	
	<%
		if(request.getParameterMap().size() > 0){
			 User userDb = new User(request.getParameter("username"), request.getParameter("password"));
			 UsersRepository usersRepository = new UsersRepository();
			 
			   if(!isValid(request, response)){
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