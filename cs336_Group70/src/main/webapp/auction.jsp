<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Auctions</title>
</head>
<body>


<%   if ((session.getAttribute("user") == null)) {

		response.sendRedirect("login.jsp");

	} else {
%>
		<%@ include file="navbar.jsp"%>
	<% 
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
	
			//Get account auction from request
			String auctionID = (String) request.getParameter("auctionId");
			
			
			//select statement auction inner join post
			String select = "SELECT * FROM auction INNER JOIN posts ON auction.Auction_ID = posts.Auction_ID Where auction.Auction_ID= ?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(select);
			ps.setString(1, auctionID);
	
			
			//Run the select query against the DB
			ResultSet auctionRS = ps.executeQuery();
			
			if(auctionRS.next()) { %>
				<table>
					<tr>
						<th>Auction</th>
						<th>Current Bid</th>
						<th>Seller</th>
						<th>Start Date</th>
						<th>End Date</th>
					</tr>
					<% do { %>
					<tr>
						<td><%= auctionRS.getString("Auction_ID") %></td>
						<td><%= auctionRS.getString("Start_price") %></td>
						<td><%= auctionRS.getString("Acc_ID") %></td>
						<td><%= auctionRS.getString("Start_date") %></td>
						<td><%= auctionRS.getString("End_date") %></td>
					</tr>
					<% } while (auctionRS.next()); %>
				</table>
				<%	} 	%>
			
			<form action= "bid.jsp?auctionId=<%= auctionID %>" method = "POST">
				<input type= "number" name= "Bid_Amount" placeholder= "0.00" required>
				<input type= "submit" value= "Place Bid"> 
			</form>
			<form action= "autobid.jsp?auctionId=<%= auctionID %>" method = "POST">
				<input type= "submit" value= "Set Up AutoBid"> 
			</form>
			<% 	
			//Close the connection. 
			con.close();
			
	 	} catch (Exception ex) {
			out.print(ex);
			out.print(" Auction page failed");
		}
 	} %>

</body>
</html>