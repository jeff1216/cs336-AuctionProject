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
<meta charset="ISO-8859-1">
<title>Search Results</title>
</head>
<body>


<%   if ((session.getAttribute("user") == null)) {
		response.sendRedirect("login.jsp");
	} else {
%>


<%@ include file="navbar.jsp"%>
		<%String Param = "WHERE";
		String currPrice = request.getParameter("current_Price");
		String minPrice = request.getParameter("min_Price"); 
		String endDate = request.getParameter("End_date"); 
		String accId = request.getParameter("Acc_Id"); 
		String name = request.getParameter("Name"); 
		String condition = request.getParameter("Condition");
		String highBid = request.getParameter("HighBid"); 
		String type = request.getParameter("Type");
		String sort = request.getParameter("sort");
		%>
	<% 
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
	
			//Get account username from session
			String account = (String) session.getAttribute("user");
			
			String auctions_Select;
			if(currPrice.equals("") && minPrice.equals("") && endDate.equals("") && accId.equals("") && name.equals("") && condition.equals("") && highBid.equals("") && type.equals(""))
			{
				auctions_Select = "SELECT * FROM auction INNER JOIN posts ON auction.Auction_ID = posts.Auction_ID INNER JOIN has_item ON auction.Auction_ID = has_item.Auction_ID INNER JOIN pc_part ON pc_part.Item_ID = has_item.Item_ID";
			}
			else
			{	
				int count = 0;
				if(!currPrice.equals(""))
				{
					Param += " Current_Price = " + currPrice + "";
					count++;	
				}
				if(!minPrice.equals(""))
				{
					if(count > 1)
						Param += " AND ";
					Param += " Min_Price = " + minPrice + "";
					count++;
				}
				if(!endDate.equals(""))
				{
					if(count > 1)
						Param += " AND ";
					Param += " End_Date = " + endDate + "";
					count++;
				}
				if(!accId.equals(""))
				{
					if(count > 1)
						Param += " AND ";
					Param += " Acc_ID = '" + accId + "'";
					count++;
				}
				if(!name.equals(""))
				{
					if(count > 1)
						Param += " AND ";
					Param += " Name = '" + name + "'";
					count++;
				}
				if(!condition.equals(""))
				{
					if(count > 1)
						Param += " AND ";
					Param += " pc_part.Condition = '" + condition + "'";
					count++;
				}
				if(!highBid.equals(""))
				{
					if(count > 1)
						Param += " AND ";
					Param += " Winner = '" + highBid + "'";
					count++;
				}
				if(!type.equals(""))
				{
					if(count > 1)
						Param += " AND ";
					Param += " pc_part.Type = '" + type + "'";
					count++;
				}
				auctions_Select = "SELECT * FROM auction INNER JOIN posts ON auction.Auction_ID = posts.Auction_ID INNER JOIN has_item ON auction.Auction_ID = has_item.Auction_ID INNER JOIN pc_part ON pc_part.Item_ID = has_item.Item_ID "+Param;
				System.out.println(auctions_Select);
			}
			//Make a select statement for the auctions table:
			if(sort == null)
			{
				auctions_Select += "";
			}
			else
			{
				if(sort.equals("current_Price"))
				{
					auctions_Select += " ORDER BY Current_price Asc";
				}
				if(sort.equals("minPrice"))
				{
					auctions_Select += " ORDER BY Min_price Asc";
				}
				if(sort.equals("End_date"))
				{
					auctions_Select += " ORDER BY End_Date Asc";
				}
				if(sort.equals("Acc_Id"))
				{
					auctions_Select += " ORDER BY Acc_ID Asc";
				}
				if(sort.equals("Name"))
				{
					auctions_Select += " ORDER BY Name Asc";
				}
				if(sort.equals("HighBid"))
				{
					auctions_Select += " ORDER BY Type Asc";
				}
				if(sort.equals("Type"))
				{
					auctions_Select += " ORDER BY Type Asc";
				}
				
			}
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(auctions_Select);
	
			
			//Run the select query against the DB
			ResultSet auctionsRS = ps.executeQuery();
			
			
			//List all results into a table
			if(auctionsRS.next()) { %>

				<table >
					<tr>
						<th>Auction</th>
						<th>Seller</th>
						<th>Current Highest Bid</th>
						<th>Current Highest Bidder</th>
						<th>End DateTime</th>
						<th>Auction Status</th>
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
</body>

