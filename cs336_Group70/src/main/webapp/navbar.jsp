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
<style>
li {
	float: left;
	padding: 10px;
}
ul {
	list-style-type: none;
	background-color: LightSkyBlue;
	overflow: hidden;
}
</style>

<div class="navbar">
	<ul>
		<li><a href="index.jsp">Home</a></li>
        <li><a href="search.jsp">Search Auctions</a></li>      
		<li><a href="createAuction.jsp">Create Auction</a></li>
		<li><a href="myAuction.jsp">View My Auctions</a></li>  
		<li><a href="viewAll.jsp">View All Auctions</a></li>
		<li><a href="myBids.jsp">View My Bids</a></li>  
		<li style="float:right"><a href="logout.jsp">Log Out</a></li>
		<li style="float:right"><a href="account.jsp">My Account</a></li>
	</ul>
</div>

<body>
<%
try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String auctions_Select = "SELECT * FROM makes_bid INNER JOIN bids ON makes_bid.Bid_ID = bids.Bid_ID INNER JOIN bid_on ON bids.Bid_ID = bid_on.Bid_ID INNER JOIN has_item ON bid_on.Auction_ID = has_item.Auction_ID INNER JOIN auction ON auction.Auction_ID = has_item.Auction_ID INNER JOIN posts ON has_item.Auction_ID = posts.Auction_ID INNER JOIN pc_part ON pc_part.Item_ID = has_item.Item_ID ORDER BY End_Date ASC";
		PreparedStatement ps = con.prepareStatement(auctions_Select);
		ResultSet rs = ps.executeQuery();
	
		java.util.Date date = new Date();
		Timestamp currentDate = new java.sql.Timestamp(date.getTime());
		while(rs.next()) {
			Timestamp endingDate = rs.getTimestamp("End_Date");
			boolean timeCheck;
			if(currentDate.after(endingDate)){
				timeCheck = true;
			}
			else {
				timeCheck = false;
			}
			if(timeCheck) {
				//Set winner in auction
				String winner = rs.getString("makes_bid.Acc_ID");
				String auctionID = rs.getString("bid_on.Auction_ID");
				Float reservePrice = rs.getFloat("auction.Min_price");
				Float currentPrice = rs.getFloat("auction.Current_price");
				String auctionWinner = rs.getString("auction.Winner");
				if(currentPrice >= reservePrice && auctionWinner == null) {
					//Send alert to winner
					String alertID = String.valueOf( (long) (Math.random() * 1000001));
					String msg = "You have won an auction.";
					String msgQuery = "INSERT INTO alerts VALUES(?, ?, ?, ?,?);";
					PreparedStatement ps3 = con.prepareStatement(msgQuery);
					ps3.setString(1, alertID);
					ps3.setString(2, auctionID);
					ps3.setString(3, winner);
					ps3.setString(4, msg);
					ps3.setTimestamp(5, currentDate);
					ps3.executeUpdate();
					
					String updateWinnerQuery = "UPDATE auction SET Winner = ? WHERE Auction_ID = ?";
					PreparedStatement ps2 = con.prepareStatement(updateWinnerQuery);
					ps2.setString(1, winner);
					ps2.setString(2, auctionID);
					ps2.executeUpdate();
				}

			}
		}

	} catch (Exception ex) {
	out.print(ex);
	out.print(" NavBar Refresh failed");
}
		


%>
</body>
