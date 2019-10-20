<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home page</title>
</head>
<jsp:include page="_FrontEndDependencies.jsp" />
<body>

	<nav class="navbar navbar-dark bg-dark">
		<a class="navbar-brand" href="#">EventManager</a>
		<div>			<%
			if(session.getAttribute("currentUsername") != null){
				out.println("Hello " + session.getAttribute("currentUsername"));	
			}
			%>
		</div>
		
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarText" aria-controls="navbarText"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarText">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item">
					<a class="nav-link" href="Register.jsp">Register</a>
				</li>
				
				<li class="nav-item">
					<a class="nav-link" href="Login.jsp">Login</a>
				</li>
			</ul>
		</div>
	</nav>

	<jsp:include page="_Messages.jsp" />
</body>
</html>