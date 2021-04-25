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
		<title>Delete Alert</title>
	</head>
	<body>
		<% 		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String userID = (String) session.getAttribute("user");
		String alertID = request.getParameter("alertid");
		
		String deletequery = "DELETE FROM alerts where Alert_ID=?";
		PreparedStatement ps = con.prepareStatement(deletequery);
		ps.setString(1, alertID);
		ps.executeUpdate();
	
		response.sendRedirect("index.jsp");
		
		%> 
	</body>
</html>