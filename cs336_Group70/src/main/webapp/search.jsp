<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/kognise/water.css@latest/dist/light.min.css">
		<style>
		body {
		margin: 0 !important;
		}
		</style>
<title>Search Results</title>
</head>
<body>



<%   if ((session.getAttribute("user") == null)) {

		response.sendRedirect("login.jsp");

	} else {

%><%@ include file="navbar.jsp"%>
		
		<h3>Search by these parameters:</h3>
		<h5> Not All values are required to be filled to search</h5>
   		<form action="searchParam.jsp" method="post">
  			<label for="current_Price">Current Price:</label>
 			<input type="text" name="current_Price"><br/>
 			<label for="min_Price">Minimum Price:</label>
 			<input type="text" name="min_Price"><br/>
 			<label for="End_date">End Date:</label>
 			<input type="text" name="End_date"><br/>
 			<label for="Acc_ID">Account ID:</label>
 			<input type="text" name="Acc_Id"><br/>
 			<label for="Name">Name:</label>
 			<input type="text" name="Name"><br/>
 			<label for="Condition">Condition:</label>
 			<input type="text" name="Condition"><br/>
 			<label for="HighBid">Highest Bidder:</label>
 			<input type="text" name="HighBid"><br/>
 			<label for="Type">Type:</label>
 			<input type="text" name="Type"><br/>
 			<label for="AuctionStatus">Auction Status:</label>
 			<select class="form-control" name="AuctionStatus">
                  <option selected="selected" value="Ongoing.">Ongoing</option>
                  <option value="Closed.">Closed</option>
    		</select>
  			<input type="submit" value="Submit">
		</form>
<%

	} %>
</body>
</html>