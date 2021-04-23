<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>login Handler</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at login.jsp
		String account = request.getParameter("Acc_ID");
		String password = request.getParameter("Password");
		
		//Make a select statement for the accounts table:
		String select = "SELECT * FROM accounts where Acc_ID= ?";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(select);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, account);
		
		//Run the select query against the DB
		ResultSet acctRS = ps.executeQuery();
		
		//If username is found, match password to DB
		if(acctRS.next()) {
			String dbPW = acctRS.getString("Password");
			if(password.equals(dbPW)) {
				session.setAttribute("user", account);
				response.sendRedirect("index.jsp");
			}
			else {
				out.println("Password was entered incorrectly. </br>");
				out.println("<a href='login.jsp'>" + "Try again." + "</a>");
			}
		}
		else {
			out.println("Account ID was entered incorrectly or does not exist. . </br>");
			out.println("<a href='login.jsp'>" + "Try again." + "</a></br>");
			out.println("<a href='register.jsp'>" + "Register here." + "</a>");
		}
		
		//Close the connection. 
		con.close();
		
	} catch (Exception ex) {
		out.print(ex);
		out.print(" login failed");
	}
%>
</body>
</html>