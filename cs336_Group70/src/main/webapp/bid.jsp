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
			//Get auction Item name
			String itemName = (String) request.getParameter("Item_Name");
			
			
			//Query posts table to find seller's id using auction_ID
			String seller; 
			float bidAmount = Float.parseFloat(request.getParameter("Bid_Amount"));
			String postQuery = "SELECT * FROM posts WHERE Auction_ID = ?";
			PreparedStatement ps = con.prepareStatement(postQuery);
			ps.setString(1, auctionID);	
			ResultSet postRS = ps.executeQuery();
			postRS.next();
			seller = postRS.getString("Acc_ID");
			
			//Query auction table to find currentPrice and ending date
			Float currentPrice;
			String auctionQuery = "SELECT * FROM auction WHERE Auction_ID = ?";
			ps = con.prepareStatement(auctionQuery);
			ps.setString(1, auctionID);
			ResultSet auctionRS = ps.executeQuery();
			auctionRS.next();
			currentPrice = auctionRS.getFloat("Current_price");
			java.util.Date date = new Date();
			Timestamp currentDate = new java.sql.Timestamp(date.getTime());
			Timestamp endingDate = auctionRS.getTimestamp("End_Date");
			boolean timeCheck;
			if(currentDate.before(endingDate)){
				timeCheck = true;
			}
			else {
				timeCheck = false;
			}
			
			//Query auction join bid_on join bids, to find current highest bid
			String highestBidder;
			String highestBidQuery = "SELECT * FROM auction INNER JOIN bid_on ON auction.Auction_ID= bid_on.Auction_ID INNER JOIN bids ON bids.Bid_ID = bid_on.Bid_ID INNER JOIN makes_bid ON bids.Bid_ID = makes_bid.Bid_ID WHERE auction.Auction_ID = ? ORDER By CAST(Bid_amount AS UNSIGNED) DESC";
			ps = con.prepareStatement(highestBidQuery);
			ps.setString(1, auctionID);
			ResultSet highestBidRS = ps.executeQuery();
			if(highestBidRS.first()) {
				highestBidder = highestBidRS.getString("makes_bid.Acc_ID");
			}
			else  {
				highestBidder = null;
			}
			
			if(!timeCheck) { %>
			Auction is closed.
			<% return;	
			}
			if(user.equals(seller)) { %>
				 You cannot bid on your own auction!  
				<% return; 
			 }
			if(highestBidder!= null && highestBidder.equals(user)) { %>
			 Bid fail. You are currently the highest bidder.
			<% return; 
			}
			if(bidAmount <= currentPrice) { %>
				Please place a bid higher than the current bid price.
				<% return;
			}

			
			//Create new bid_ID, obtain bid amount, obtain current date
			String bid_ID = UUID.randomUUID().toString();

			
			//insert a new bid into bids table
			String insertQuery = "INSERT INTO bids VALUES(?, ?, ?)";
			PreparedStatement ps2 = con.prepareStatement(insertQuery);
			ps2.setString(1, bid_ID);
			ps2.setFloat(2, bidAmount);
			ps2.setTimestamp(3, currentDate);
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
			
			//FIND OLD BIDID
			String oldBidQuery = "Select * FROM makes_bid inner join bid_on ON makes_bid.bid_id = bid_on.bid_id inner join auction ON auction.auction_Id = bid_on.auction_Id WHERE bid_on.auction_id = ? and acc_id = ? ORDER BY current_price desc";
			PreparedStatement psOldBid = con.prepareStatement(oldBidQuery);
			psOldBid.setString(1, auctionID);
			psOldBid.setString(2, user);
			ResultSet oldBidRS = psOldBid.executeQuery();
			String oldBid ="";
			if(oldBidRS.first()) {
				oldBid = oldBidRS.getString("Bid_ID");
			}
			if(exists) {
				String updateQuery = "UPDATE makes_bid SET Bid_ID = ? WHERE Acc_ID = ? and Bid_ID = ?";
				PreparedStatement ps5 = con.prepareStatement(updateQuery);
				ps5.setString(1, bid_ID);
				ps5.setString(2, user);
				ps5.setString(3, oldBid);
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
			
			
			String queryAutobid = "select * from auction " +
					"inner join bid_on on auction.Auction_ID = bid_on.Auction_ID " +
					"inner join makes_bid on bid_on.Bid_ID = makes_bid.Bid_ID " +
					"where auction.Auction_ID = '" + auctionID + "' ORDER By CAST(Upper_limit AS UNSIGNED) DESC;";
					
			ResultSet autoBidders = stmt.executeQuery(queryAutobid);
			ArrayList<String[]> autoBids = new ArrayList<String[]>();
			while(autoBidders.next()){
				if(autoBidders.getString("Increment") != null){
					autoBids.add(new String[]{autoBidders.getString("Acc_ID"), 
							Float.toString(autoBidders.getFloat("Increment")), 
							Float.toString(autoBidders.getFloat("Upper_limit"))});
				}
				
			}
			
			String prevBidder = user;
			float prevBidAmount = bidAmount;
			
			while(autoBids.size() > 0){
				for(int i = 0; i < autoBids.size(); i++) {
					String autoUsername = autoBids.get(i)[0];
					if(autoUsername.equals(prevBidder)){
						continue;
					}
					
					float lastBid = prevBidAmount;
					float autoIncrement = Float.parseFloat(autoBids.get(i)[1]);
					float autoUpperLimit = Float.parseFloat(autoBids.get(i)[2]);
					float newAmount = lastBid+autoIncrement;
					if(newAmount > autoUpperLimit) {
						autoBids.remove(i);
					}
					else {
						prevBidder = autoUsername;
						prevBidAmount = newAmount;
					}
				}
				if(autoBids.size() == 1) {
					break;
				}
			}
			
			//Create new bid_ID, obtain bid amount, obtain current date
			String autoBid_ID = UUID.randomUUID().toString();
			
			String insertQuery3 = "INSERT INTO bids VALUES(?, ?, ?)";
			PreparedStatement ps8 = con.prepareStatement(insertQuery3);
			ps8.setString(1, autoBid_ID);
			ps8.setFloat(2, prevBidAmount);
			ps8.setTimestamp(3, currentDate);
			ps8.executeUpdate();
			
			//insert the new bid into bid_on
			String insertQuery4 = "INSERT INTO bid_on VALUES(?, ?)";
			PreparedStatement ps9 = con.prepareStatement(insertQuery4);
			ps9.setString(1, auctionID);
			ps9.setString(2, autoBid_ID);
			ps9.executeUpdate();
			
			
			//FIND OLD BIDID
			String oldBidQuery2 = "Select * FROM makes_bid inner join bid_on ON makes_bid.bid_id = bid_on.bid_id inner join auction ON auction.auction_Id = bid_on.auction_Id WHERE bid_on.auction_id = ? and acc_id = ? ORDER BY current_price desc";
			PreparedStatement psOldBid2 = con.prepareStatement(oldBidQuery2);
			psOldBid2.setString(1, auctionID);
			psOldBid2.setString(2, prevBidder);
			ResultSet oldBidRS2 = psOldBid2.executeQuery();
			String oldBid2 ="";
			if(oldBidRS2.first()) {
				oldBid2 = oldBidRS2.getString("Bid_ID");
			}
			
			//update
			String updateQuery3 = "UPDATE makes_bid SET Bid_ID = ? WHERE Acc_ID = ? and Bid_ID = ?";
			PreparedStatement ps10 = con.prepareStatement(updateQuery3);
			ps10.setString(1, autoBid_ID);
			ps10.setString(2, prevBidder);
			ps10.setString(3, oldBid2);
			ps10.executeUpdate();
			
			//Update current price in Auction Table
			String updateQuery4 = "UPDATE auction SET Current_price = ? WHERE Auction_ID = ?";
			PreparedStatement ps11 = con.prepareStatement(updateQuery4);
			ps11.setFloat(1, prevBidAmount);
			ps11.setString(2, auctionID);
			ps11.executeUpdate();
			
			
			
			//Send alerts to other bidders.
			String otherBidderQuery = "Select DISTINCT * From makes_bid inner join bid_on ON makes_bid.bid_id = bid_on.bid_id  Where auction_id = ? and NOT acc_id=?";
			PreparedStatement ps12 = con.prepareStatement(otherBidderQuery);
			ps12.setString(1, auctionID);
			ps12.setString(2, prevBidder);
			ResultSet otherBidderRS = ps12.executeQuery();
			while(otherBidderRS.next()) {
				String alertID = String.valueOf( (long) (Math.random() * 100000l));
				String msg;
				if(otherBidderRS.getString("Upper_limit") != null){
					msg = "Your upper limit has been outbidded.";
				}else{
					msg = "You have been outbidded.";
				}
				String msgQuery = "INSERT INTO alerts VALUES(?, ?, ?, ?, ?);";
				PreparedStatement ps13 = con.prepareStatement(msgQuery);
				ps13.setString(1, alertID);
				ps13.setString(2, auctionID);
				ps13.setString(3, otherBidderRS.getString("Acc_ID"));
				ps13.setString(4, msg);
				ps13.setTimestamp(5,currentDate);
				ps13.executeUpdate();				
			}
			
			
			//Close the connection. 
			con.close();
			
	 	} catch (Exception ex) {
			out.print(ex);
			out.print(" Place bid failed");
		}
 	} %>

</body>
</html>