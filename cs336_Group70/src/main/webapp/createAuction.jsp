<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create an Auction</title>
</head>
<body>
<%
if ((session.getAttribute("user") == null)) {
	response.sendRedirect("login.jsp");

} else {
%>
<%@ include file="navbar.jsp"%>

	
		<h1>Create Auction</h1>
		
		<form action="pcpart.jsp">
		  <p>Please select your pc part:</p>
		  <input type="radio" id="ram" name="pc_part" value="ram">
		  <label for="ram">RAM</label><br>
		  <input type="radio" id="cpu" name="pc_part" value="cpu">
		  <label for="cpu">CPU</label><br>
		  <input type="radio" id="psu" name="pc_part" value="psu">
		  <label for="psu">Power Supply</label>
		  <br>  
		  <input type="submit" value="Submit">
		</form>
		
		
<%
    }
%>
</body>
</html>