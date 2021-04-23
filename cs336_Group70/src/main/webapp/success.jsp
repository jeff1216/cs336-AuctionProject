<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Homepage</title>
</head>
<body>
<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in.<br/>
<a href="login.jsp">Login here.</a>
<%} else {
%>
Logged in Successfully. 
<br>
Welcome <%=session.getAttribute("user")%>!  
<br>
<form action= "logout.jsp" method = "POST">
	<input type= "submit" value= "Log Out"> 
</form>
<%
    }
%>
</body>
</html>