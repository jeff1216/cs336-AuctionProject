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

response.sendRedirect("login.jsp");
} else {
%>
<%@ include file="navbar.jsp"%>

<h2>Welcome <%=session.getAttribute("user")%>! </h2> 
<br>

<h4>Your Notifications</h4>



<%
    }
%>
</body>
</html>