<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.sql.Timestamp" %>
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
	
			//Get account username from session
			String account = (String) session.getAttribute("user");
			
			
			//Make a select statement for the posts table:
			String myAuctionQuery = "SELECT * FROM auction INNER JOIN posts ON auction.Auction_ID = posts.Auction_ID INNER JOIN has_item ON auction.Auction_ID = has_item.Auction_ID INNER JOIN pc_part ON pc_part.Item_ID = has_item.Item_ID WHERE Acc_ID= ? ORDER BY End_Date Asc";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(myAuctionQuery);
	
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, account);
			
			//Run the select query against the DB
			ResultSet myAuctionRS = ps.executeQuery();
			
			//If username is found, list Auction_IDs into a table
			if(myAuctionRS.next()) { %>
				<table>
					<tr>
						<th>[Auction]</th>
						<th>[Minimum Reserve Price]</th>
						<th>[Current Highest Bid]</th>
						<th>[Current Highest Bidder]</th>
						<th>[End DateTime]</th>
						<th>[Auction Status]</th>
					</tr>
					<% do { 
						java.util.Date date = new Date();
						Timestamp currentDate = new java.sql.Timestamp(date.getTime());
						Timestamp endingDate = myAuctionRS.getTimestamp("End_Date");
						boolean timeCheck;
						if(currentDate.before(endingDate)){
							timeCheck = true;
						}
						else {
							timeCheck = false;
						}
						
						String highestBidder = "";
						String highestBidderQuery = "SELECT * FROM auction INNER JOIN bid_on ON auction.Auction_ID= bid_on.Auction_ID INNER JOIN bids ON bids.Bid_ID = bid_on.Bid_ID INNER JOIN makes_bid ON bids.Bid_ID = makes_bid.Bid_ID WHERE auction.Auction_ID = ? ORDER By Bid_amount DESC";
						ps = con.prepareStatement(highestBidderQuery);
						ps.setString(1, myAuctionRS.getString("Auction_ID"));
						ResultSet highestBidderRS = ps.executeQuery();
						if(highestBidderRS.next()) {
							highestBidder = highestBidderRS.getString("makes_bid.Acc_ID");
						}
					
					%>
					<tr>
						<td style='text-align:center'>
							<a href="auction.jsp?auctionId=<%= myAuctionRS.getString("Auction_ID") %>">
							<%= myAuctionRS.getString("Name") %>
							</a>
						</td>
						<td style='text-align:center'><%= myAuctionRS.getString("Min_Price") %></td>
						<td style='text-align:center'><%= myAuctionRS.getString("Current_Price") %></td>
						<td style='text-align:center'><%= highestBidder %></td>
						<td style='text-align:center'><%= myAuctionRS.getString("End_date") %></td>
						<td style='text-align:center'><% if(timeCheck) { %>
							 		Ongoing. 
							<% }
							   else { %>
							   		Closed.
							<% } %>
						</td>	
					</tr>
						
						
					</tr>
					<% } while (myAuctionRS.next()); %>
				</table>
				<%	} 	
	
			//Close the connection. 
			con.close();
			
	 	} catch (Exception ex) {
			out.print(ex);
			out.print(" View My Auctions failed");
		}
 	} %>

</body>
</html>