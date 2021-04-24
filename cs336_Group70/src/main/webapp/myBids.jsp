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
			String auctions_Select = "SELECT * FROM makes_bid INNER JOIN bids ON makes_bid.Bid_ID = bids.Bid_ID INNER JOIN bid_on ON bids.Bid_ID = bid_on.Bid_ID WHERE Acc_ID = ?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(auctions_Select);
			ps.setString(1, account);
			
			//Run the select query against the DB
			ResultSet rs = ps.executeQuery();
			
			//List all results into a table
			if(rs.next()) { %>
				<table>
					<tr>
						<th>Auction</th>
					</tr>
					<% do { %>
					<tr>
						<td>
							<a href="auction.jsp?auctionId=<%= rs.getString("Auction_ID") %>">
									<%= rs.getString("Auction_ID") %>
							</a>
						</td>
					</tr>
					<% } while (rs.next()); %>
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