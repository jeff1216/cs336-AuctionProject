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



%>
</body>
