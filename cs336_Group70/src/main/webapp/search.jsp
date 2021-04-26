<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Auctions</title>
</head>
<body>
<%
if ((session.getAttribute("user") == null)) {
	response.sendRedirect("login.jsp");

} else {
%>
<%@ include file="navbar.jsp"%>
<p>Not yet implemented</p>

<%
    }
%>

</body>
</html>