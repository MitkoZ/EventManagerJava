<nav class="navbar navbar-dark bg-dark">
	<a class="navbar-brand" href="#">EventManager</a>
	<%
		if (session.getAttribute("currentUsername") != null) {
			out.println(
					"<p style=\"color:green;\">Current User: " + session.getAttribute("currentUsername") + "</p>");
		}
	%>

	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarText" aria-controls="navbarText"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarText">
		<ul class="navbar-nav mr-auto">
			<%
				if (session.getAttribute("currentUserId") == null) {
					out.print(
							"<li class=\"nav-item\"><a class=\"nav-link\" href=\"Register.jsp\">Register</a></li><li class=\"nav-item\"><a class=\"nav-link\" href=\"Login.jsp\">Login</a></li>");
				} else {
					out.print("<li class=\"nav-item\"><a class=\"nav-link\" href=\"Logout.jsp\">Logout</a></li>");
					out.print("<li class=\"nav-item\"><a class=\"nav-link\" href=\"MyEventsList.jsp\">My Events</a></li>");
				}
			%>

		</ul>
	</div>
</nav>