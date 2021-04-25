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
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Place a Bid</title>
</head>
<body>


<%   if ((session.getAttribute("user") == null)) {

		response.sendRedirect("login.jsp");

	} else {
%>
		<%@ include file="navbar.jsp"%>
	<% 
		try {
			
			//Check if user is seller, if yes dont allow bid
			  //Check by querying post where auction_Id= auctionId
			//if not, create/insert a new bid with a generate a bid_ID, get bid_amount from text field, get current date from datesimpleformat
			//insert into bid on, using the newly generated bid_ID and the auctionid
			//Check if user has a current bid with the auction.  makes_bid join bid on where auction_ID = auctionid.
			  //if not null(exists) then create an update query, otherwise use an insert query for first bid
			  
			  
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
	
			//Get user ID 
			String user = (String) session.getAttribute("user");
			//Get auction ID from url
			String auctionID = (String) request.getParameter("auctionId");
			
			//Query to find seller's id using auction_ID
			String seller; 
			float bidAmount = Float.parseFloat(request.getParameter("Bid_Amount"));
			String postQuery = "SELECT * FROM posts WHERE Auction_ID = ?";
			PreparedStatement ps = con.prepareStatement(postQuery);
			ps.setString(1, auctionID);	
			ResultSet postRS = ps.executeQuery();
			postRS.next();
			seller = postRS.getString("Acc_ID");
			
			//Query to find currentPrice of the auction_ID
			Float currentPrice;
			String priceQuery = "SELECT * FROM auction WHERE Auction_ID = ?";
			ps = con.prepareStatement(priceQuery);
			ps.setString(1, auctionID);
			ResultSet priceRS = ps.executeQuery();
			priceRS.next();
			currentPrice = priceRS.getFloat("Current_price");
			
			if(user.equals(seller)) { %>
				 You cannot bid on your own auction!  
				<% return; 
			 }
			if(bidAmount <= currentPrice) { %>
				Please place a bid higher than the current bid price.
				<% return;
			}
			
			//Create new bid_ID, obtain bid amount, obtain current date
			String bid_ID = UUID.randomUUID().toString();
			java.util.Date date = new Date();
			Object currentDate = new java.sql.Timestamp(date.getTime());
			DateTimeFormatter formatDate = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

			
			//insert a new bid into bids table
			String insertQuery = "INSERT INTO bids VALUES(?, ?, ?)";
			PreparedStatement ps2 = con.prepareStatement(insertQuery);
			ps2.setString(1, bid_ID);
			ps2.setFloat(2, bidAmount);
			ps2.setObject(3, currentDate);
			ps2.executeUpdate();
			
			//insert the new bid into bid_on
			String insertQuery2 = "INSERT INTO bid_on VALUES(?, ?)";
			PreparedStatement ps3 = con.prepareStatement(insertQuery2);
			ps3.setString(1, auctionID);
			ps3.setString(2, bid_ID);
			ps3.executeUpdate();
			
			//insert or update into makes_bid
			String selectQuery = "SELECT * FROM makes_bid INNER JOIN bid_on ON makes_bid.Bid_ID = bid_on.Bid_ID where Auction_ID = ?";
			PreparedStatement ps4 = con.prepareStatement(selectQuery);
			ps4.setString(1, auctionID);
			ResultSet selectRS = ps4.executeQuery();
			boolean exists = false;
			while(selectRS.next()) {
				String currentAcc = selectRS.getString("Acc_ID");
				if (currentAcc.equals(user)) {
					exists = true;
				}
			}
			if(exists) {
				String updateQuery = "UPDATE makes_bid SET Bid_ID = ? WHERE Acc_ID = ?";
				PreparedStatement ps5 = con.prepareStatement(updateQuery);
				ps5.setString(1, bid_ID);
				ps5.setString(2, user);
				ps5.executeUpdate();
				%> You've updated your bid!<%
			} else {
				String insertQuery3 = "INSERT INTO makes_bid VALUES(?,?,?,?);";
				PreparedStatement ps6 = con.prepareStatement(insertQuery3);
				ps6.setString(1, user);
				ps6.setString(2, bid_ID);
				ps6.setString(3, null);
				ps6.setString(4, null);
				ps6.executeUpdate();
				%> You've placed a first bid<% 
			}
			
			//Update current price in Auction Table
			String updateQuery2 = "UPDATE auction SET Current_price = ? WHERE Auction_ID = ?";
			PreparedStatement ps7 = con.prepareStatement(updateQuery2);
			ps7.setFloat(1, bidAmount);
			ps7.setString(2, auctionID);
			ps7.executeUpdate();
			//Close the connection. 
			con.close();
			
	 	} catch (Exception ex) {
			out.print(ex);
			out.print(" Place bid failed");
		}
 	} %>

</body>
</html>