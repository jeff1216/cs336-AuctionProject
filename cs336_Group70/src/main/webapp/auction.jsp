<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View An Auction</title>
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
	
			//Get account auction from url
			String auctionID = (String) request.getParameter("auctionId");
			
			
			
			//select statement auction inner join post
			String select = "SELECT * FROM auction INNER JOIN posts ON auction.Auction_ID = posts.Auction_ID INNER JOIN has_item ON auction.Auction_ID = has_item.Auction_ID INNER JOIN pc_part ON pc_part.Item_ID = has_item.Item_ID Where auction.Auction_ID= ?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(select);
			ps.setString(1, auctionID);
	
			
			//Run the select query against the DB
			ResultSet auctionRS = ps.executeQuery();
			boolean timeCheck;
			
			if(auctionRS.next()) { 
				java.util.Date date = new Date();
				Timestamp currentDate = new java.sql.Timestamp(date.getTime());
				Timestamp endingDate = auctionRS.getTimestamp("End_Date");
				if(currentDate.before(endingDate)){
					timeCheck = true;
				}
				else {
					timeCheck = false;
				}
				String name = auctionRS.getString("Name");
				Float reservePrice = auctionRS.getFloat("Min_price");
				Float currentBid = auctionRS.getFloat("Current_price");
				
				String highestBidder = "";
				String highestBidderQuery = "SELECT * FROM auction INNER JOIN bid_on ON auction.Auction_ID= bid_on.Auction_ID INNER JOIN bids ON bids.Bid_ID = bid_on.Bid_ID INNER JOIN makes_bid ON bids.Bid_ID = makes_bid.Bid_ID WHERE auction.Auction_ID = ? ORDER By Bid_amount DESC";
				ps = con.prepareStatement(highestBidderQuery);
				ps.setString(1, auctionRS.getString("Auction_ID"));
				ResultSet highestBidderRS = ps.executeQuery();
				if(highestBidderRS.first()) {
					highestBidder = highestBidderRS.getString("makes_bid.Acc_ID");
				}
			%>
				<table>
					<tr>
						<th>Auction</th>
						<th>Seller</th>
						<th>Current Highest Bid</th>
						<th>Current Highest Bidder</th>
						<th>End Date</th>
						<th>Status</th>
						<th>Winner</th>
					</tr>
					<% do { %>
					<tr>
						<td><%= auctionRS.getString("Name") %></td>
						<td><%= auctionRS.getString("posts.Acc_ID") %></td>
						<td><%= auctionRS.getString("Current_price") %></td>
						<td><%= highestBidder %></td>
						<td><%= auctionRS.getString("End_date") %></td>
						<td><% if(timeCheck) { %>
							 		Ongoing 
							<% }
							   else { %>
							   		Closed
							<% } %>
						</td>
						<td><% if(!timeCheck && currentBid > reservePrice) { %>
							 		 <%= highestBidder %>
							<% } 
							   else if(!timeCheck) { %> 
								--No Winner-- 
								<% } 
									else {
								%>    <% 
								}
							%>
						</td>
					</tr>
					<% } while (auctionRS.next()); %>
				</table>
		  <%} 	
				
			auctionRS.first();
			String partType = auctionRS.getString("Type");
			String itemID = auctionRS.getString("Item_ID");
			String itemName = auctionRS.getString("Name");
			%>
			
			<br>
			<h3><u>Details</u></h3>
			Item name: <%= itemName %>
			<br>
			Condition:	<%= auctionRS.getString("Condition") %>
			<br>
			Part type:	<%= partType %>
			<br>
			<%
			String partsQuery;
			if(partType.equals("ram")) {
				partsQuery = "SELECT * FROM pc_part INNER JOIN ram ON pc_part.Item_ID = ram.Item_ID Where pc_part.Item_ID = ?";
				ps = con.prepareStatement(partsQuery);
				ps.setString(1, itemID);
				ResultSet ramRS = ps.executeQuery();
				ramRS.next();
			%> 
				Ram Type: <%= ramRS.getString("Type") %>
				<br>
				Ram Size: <%= ramRS.getString("Size") %>
				<br>
				Ram Speed: <%= ramRS.getString("Speed") %>
				<br>
		<%	} 
			else if(partType.equals("cpu")) {
				partsQuery = "SELECT * FROM pc_part INNER JOIN cpu ON pc_part.Item_ID = cpu.Item_ID Where pc_part.Item_ID = ?";
				PreparedStatement ps2 = con.prepareStatement(partsQuery);
				ps2.setString(1, itemID);
				ResultSet cpuRS = ps2.executeQuery();
				cpuRS.next();
			%> 
				CPU Series: <%= cpuRS.getString("Series") %>
				<br>
				CPU Core Count: <%= cpuRS.getString("Core_Count") %>
				<br>
				CPU Clock Speed: <%= cpuRS.getString("Core_Clock") %>
				<br>
		<%	}
			else {
				partsQuery = "SELECT * FROM pc_part INNER JOIN psu ON pc_part.Item_ID = psu.Item_ID Where pc_part.Item_ID = ?";
				PreparedStatement ps3 = con.prepareStatement(partsQuery);
				ps3.setString(1, itemID);
				ResultSet psuRS = ps3.executeQuery();
				psuRS.next();
			%> 
				PSU Wattage: <%= psuRS.getString("Wattage") %>
				<br>
				PSU Efficiency Rating: <%= psuRS.getString("Efficiency_Rating") %>
				<br>
				PSU Modularity: <%= psuRS.getString("Modularity") %>
				<br>
		 <% } %>	
		
			
			<h1>Manual Bid:</h1>
			<form action= "bid.jsp?auctionId=<%= auctionID %>" method = "POST">
				<table>
					<tr>
						<td>Bid Amount</td>
						<td>
							<input type= "float" name= "Bid_Amount" placeholder= "0.00" required>
							<input type ="hidden" name= "Item_Name" value = <%= itemName %> >
						</td>
					</tr>
					<tr>
						<td>
							<input type= "submit" value= "Place Bid"> 
						</td>
					</tr>
				</table>
			</form><br>
			<h1>Autobid:</h1>

			<form action= "autobid.jsp?auctionId=<%= auctionID %>" method = "POST">
				<table>
					<tr>
						<td>Increment Amount</td>
						<td>
							<input type= "number" name= "increment" placeholder= "0.00" required>
						</td>
					</tr>
					<tr>
						<td>Upper Limit Amount</td>
						<td>
							<input type= "number" name= "upperLimit" placeholder= "0.00" required>	
						</td>
					</tr>	
					<tr>
						<td>
							<input type= "submit" value= "Set Up AutoBid"> 
						</td>
					</tr>
				</table>
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