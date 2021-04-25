<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>All Auctions</title>
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
	
			//Get account username from session
			String account = (String) session.getAttribute("user");
			
			
			//Make a select statement for the auctions table:
			String auctions_Select = "SELECT * FROM auction INNER JOIN posts ON auction.Auction_ID = posts.Auction_ID";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(auctions_Select);
	
			
			//Run the select query against the DB
			ResultSet auctionsRS = ps.executeQuery();
			
			//List all results into a table
			if(auctionsRS.next()) { %>
				<table>
					<tr>
						<th>Auction</th>
						<th>Current Bid</th>
						<th>Seller</th>
						<th>End Date</th>
					</tr>
					<% do { %>
					<tr>
						<td>
							<a href="auction.jsp?auctionId=<%= auctionsRS.getString("Auction_ID") %>">
									<%= auctionsRS.getString("Auction_ID") %>
							</a>
						</td>
						<td><%= auctionsRS.getString("Current_price") %></td>
						<td><%= auctionsRS.getString("Acc_ID") %></td>
						<td><%= auctionsRS.getString("End_date") %></td>
					</tr>
					<% } while (auctionsRS.next()); %>
				</table>
				<%	} 	
	
			//Close the connection. 
			con.close();
			
	 	} catch (Exception ex) {
			out.print(ex);
			out.print(" View All Auctions failed");
		}
 	} %>

</body>
</html>