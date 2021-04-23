<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
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

		//Get parameters from the HTML form at register.jsp
		String name = request.getParameter("Name");
		String email = request.getParameter("Email");
		String address = request.getParameter("Address");
		String phone = request.getParameter("Phone");
		String dobString = request.getParameter("DOB");
		SimpleDateFormat dobFormat = new SimpleDateFormat ("yyyy-MM-dd");
		Date dob = dobFormat.parse(dobString); 
		String username = request.getParameter("Acc_ID");
		String password = request.getParameter("Password");
		
		//Check if username already exists in DB
		String select = "SELECT * FROM accounts where Acc_ID= ?";
		PreparedStatement userCheck = con.prepareStatement(select);
		userCheck.setString(1, username);
		
		ResultSet checkRS = userCheck.executeQuery();
		if(checkRS.next()) {
			out.println("Username already exists. </br>");
			out.println("<a href='register.jsp'>" + "Please choose another username and try again." + "</a>");
			con.close();
			return;
		}
		
		
		//Make a insert statement for the accounts table:
		String insert = "INSERT INTO accounts(Acc_ID, Password, Name, Email, Address, Phone, DOB, Payments, isEmployee, isAdmin)" 
						+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, username);
		ps.setString(2, password);
		ps.setString(3, name);
		ps.setString(4, email);
		ps.setString(5, address);
		ps.setString(6, phone);
		ps.setDate(7, new java.sql.Date(dob.getTime()));
		ps.setString(8, "null");
		ps.setInt(9, 0);
		ps.setInt(10, 0);
		
		//Run the insert query into the DB
		int insertRS = ps.executeUpdate();
		if(insertRS != 0) {
			response.sendRedirect("register_Success.jsp");
		}
		else {
			out.println("There was an error signing up. </br>");
			out.println("<a href='register.jsp'>" + "Try again." + "</a>");
		}
		
		//Close the connection. 
		con.close();
		
	} catch (Exception ex) {
		out.print(ex);
		out.print(" registration failed");
	} 
%>
</body>
</html>