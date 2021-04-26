<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>Search Results</title>
</head>
<body>


<%   if ((session.getAttribute("user") == null)) {

		response.sendRedirect("login.jsp");

	} else {
%>

<%@ include file="navbar.jsp"%>
		
		<h3>Search by these parameters:</h3>
   		<form action="searchParam.jsp" method="post">
  			<label for="current_Price">Current Price:</label>
 			<input type="text" name="current_Price"><br/>
 			<label for="min_Price">Minimum Price:</label>
 			<input type="text" name="min_Price"><br/>
 			<label for="End_date">End Date:</label>
 			<input type="text" name="End_date"><br/>
 			<label for="Acc_ID">Seller:</label>
 			<input type="text" name="Acc_Id"><br/>
 			<label for="Name">Name of Auction:</label>
 			<input type="text" name="Name"><br/>
 			<label for="Condition">Condition:</label>
 			<input type="text" name="Condition"><br/>
 			<label for="HighBid">Highest Bidder:</label>
 			<input type="text" name="HighBid"><br/>
 			<label for="Type">Type:</label>
 			<input type="text" name="Type"><br/>
 			<input type="submit" name = "Submit"><br/>
 			<p></p>
 			<h3> Sort by Submit </h3>
 			<p></p>
  			<input type="submit" name = sort value="current_Price"><br/>	
 			<input type="submit" name = sort value="min_Price"><br/>		
 			<input type="submit" name = sort value="End_date"><br/>		
 			<input type="submit" name = sort value="Acc_Id"><br/>		
 			<input type="submit" name = sort value="Name"><br/>		
 			<input type="submit" name = sort value="HighBid"><br/>
 			<input type="submit" name = sort value="Type"><br/>
		</form>
<%
    }
%>

</body>
</html>
