<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
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
			String posts_Select = "SELECT * FROM posts where Acc_ID= ?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(posts_Select);
	
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, account);
			
			//Run the select query against the DB
			ResultSet postsRS = ps.executeQuery();
			
			//If username is found, list Auction_IDs into a table
			if(postsRS.next()) { %>
				<table>
					<tr>
						<th>Auction</th>
						<th>Seller</th>
					</tr>
					<% do { %>
					<tr>
						<td><%= postsRS.getString("Auction_ID") %></td>
						<td><%= postsRS.getString("Acc_ID") %></td>
					</tr>
					<% } while (postsRS.next()); %>
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