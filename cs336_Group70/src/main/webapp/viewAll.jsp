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
			String auctions_Select = "SELECT * FROM auction INNER JOIN posts ON auction.Auction_ID = posts.Auction_ID INNER JOIN has_item ON auction.Auction_ID = has_item.Auction_ID INNER JOIN pc_part ON pc_part.Item_ID = has_item.Item_ID ORDER BY End_Date Asc";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(auctions_Select);
	
			
			//Run the select query against the DB
			ResultSet auctionsRS = ps.executeQuery();
			

			
			//List all results into a table
			if(auctionsRS.next()) { %>
				
				<table>
					<tr>
						<th>[Auction]</th>
						<th>[Seller]</th>
						<th>[Current Highest Bid]</th>
						<th>[Current Highest Bidder]</th>
						<th>[End DateTime]</th>
						<th>[Auction Status]</th>
					</tr>
					<% do {
						java.util.Date date = new Date();
						Timestamp currentDate = new java.sql.Timestamp(date.getTime());
						Timestamp endingDate = auctionsRS.getTimestamp("End_Date");
						boolean timeCheck;
						if(currentDate.before(endingDate)){
							timeCheck = true;
						}
						else {
							timeCheck = false;
						}
						
						String highestBidder = "";
						String highestBidderQuery = "SELECT * FROM auction INNER JOIN bid_on ON auction.Auction_ID= bid_on.Auction_ID INNER JOIN bids ON bids.Bid_ID = bid_on.Bid_ID INNER JOIN makes_bid ON bids.Bid_ID = makes_bid.Bid_ID WHERE auction.Auction_ID = ? ORDER By CAST(Bid_amount AS UNSIGNED) DESC";
						ps = con.prepareStatement(highestBidderQuery);
						ps.setString(1, auctionsRS.getString("Auction_ID"));
						ResultSet highestBidderRS = ps.executeQuery();
						if(highestBidderRS.next()) {
							highestBidder = highestBidderRS.getString("makes_bid.Acc_ID");
						}
						%>
					<tr>
						<td style='text-align:center'>
							<a href="auction.jsp?auctionId=<%= auctionsRS.getString("Auction_ID") %>">
									<%= auctionsRS.getString("Name") %>
							</a>
						</td>
						<td style='text-align:center'><%= auctionsRS.getString("posts.Acc_ID") %></td>
						<td style='text-align:center'><%= auctionsRS.getFloat("Current_price") %></td>
						<td style='text-align:center'><%= highestBidder %></td>
						<td style='text-align:center'><%= auctionsRS.getString("End_date") %></td>
						<td style='text-align:center'><% if(timeCheck) { %>
							 		Ongoing. 
							<% }
							   else { %>
							   		Closed.
							<% } %>
						</td>	
					</tr>
					<% } while (auctionsRS.next()); %>
				</table>
				<%	} 
			else {
				%>There are no auctions in the database. <% 
			}
	
			//Close the connection. 
			con.close();
			
	 	} catch (Exception ex) {
			out.print(ex);
			out.print(" View All Auctions failed");
		}
 	} %>

</body>
</html>