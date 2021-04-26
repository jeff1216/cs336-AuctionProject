<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Redirect</title>
</head>
<body>
<%
	String type = request.getParameter("pc_part");
	if(type.equals("ram")) {
		response.sendRedirect("ram.jsp");

	}
	else if(type.equals("cpu")) {
		response.sendRedirect("cpu.jsp");

	}
	else {
		response.sendRedirect("psu.jsp");

	}
%>

</body>
</html>