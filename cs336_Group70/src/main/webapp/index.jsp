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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/kognise/water.css@latest/dist/light.min.css">
		<style>
		body {
		margin: 0 !important;
		}
		</style>
<title>Homepage</title>
</head>
<body>
<%
    if ((session.getAttribute("user") == null)) {

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
			
			%> <h2>Welcome <%=session.getAttribute("user")%>! </h2> 
			<br>

			<h4>Your Notifications</h4>
			<%
			String alertQuery = "SELECT * FROM alerts INNER JOIN has_item ON alerts.Auction_ID = has_item.Auction_ID INNER JOIN pc_part ON has_item.Item_ID = pc_part.Item_ID WHERE acc_ID = ? ORDER BY time ASC";
			PreparedStatement ps = con.prepareStatement(alertQuery);
			ps.setString(1, (String) session.getAttribute("user"));
			ResultSet rs = ps.executeQuery();
			String alertID = "";
			if(rs.next()) { 
			 %>
			<table>
				<tr>
					<th>Alert ID</th>
					<th>Message</th>
					<th>Item</th>
					<th>View Auction</th>
					<th>Date Time</th>
					<th>Delete Message</th>
				</tr>
				<% do {
					alertID = rs.getString("Alert_ID");
					%>
				<tr>
					<td style='text-align:center'><%= alertID %></td>
					<td style='text-align:center'><%= rs.getString("Message") %></td>
					<td style='text-align:center'><%= rs.getString("Name") %></td>
					<td style='text-align:center'><a href="auction.jsp?auctionId=<%= rs.getString("Auction_ID") %>">
													View
												 </a>
					</td>
					<td style='text-align:right'><%= rs.getTimestamp("Time") %></td>
					<td style='text-align:center'><a href="deleteAlert.jsp?alertid=<%= alertID %>">X</a></td>

				</tr>
				<% } while (rs.next()); %>
			</table>
			<%	} 
			
			//Close the connection. 
			con.close();
			
	 	} catch (Exception ex) {
			out.print(ex);
			out.print(" Index page failed");
		}
%>

<%
    }
%>
</body>
</html>