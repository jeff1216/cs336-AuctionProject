<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create ram Auction</title>
</head>
<body>
<%
if ((session.getAttribute("user") == null)) {
	response.sendRedirect("login.jsp");

} else {
%>
<%@ include file="navbar.jsp"%>


	
		<h1>Create Auction</h1>
		<form method="post" action="addAuction.jsp">
		<table>
		<tr>    
			<td>Item Name</td>
		</tr>
		<tr>
			<td>
				<input 
					type="text" 
					name="itemName"
					required = "required">
			</td>
		</tr>
		<tr>
		<td>Condition</td>
		</tr>
		<tr>
			<td>
				<select 
					name="condition"
					required = "required">
					<option value="used">Used</option>
					<option value="new">New</option>
				</select>
			</td>
		</tr>


		<tr><td>Note: Please enter integers.</td> </tr>
		
		<tr><td><h2>RAM Details</h2></td></tr>
		<tr>
		<td>RAM Type</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="ramType" title="NA if not RAM" required="required">
			</td>
		</tr>
		<tr>
		<td>Size in GB</td>
		</tr>
		<tr>
			<td>
				<input type="number" name="ramSize" title="NA if not RAM" required="required">
			</td>
		</tr>
		<tr>
		
		<td>Speed in MHz</td>
		</tr>
		<tr>
			<td>
				<input type="number" name="ramSpeed" title="NA if not RAM" required="required">
			</td>
		</tr>
		
		<tr><td><h2>Auction Details</h2></td></tr>
		<tr>
		<td>Closing Date: Format is YYYY-MM-DD hh:mm:ss</td>
		</tr>
		<tr>
			<td>
				<input 
					type="text" 
					name="closeDate"
					pattern="[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}" 
					required = "required">
			</td>
		</tr>
		<tr>
		<td>Reserve (Minimum Bid)</td>
		</tr>
		<tr>
			<td>
				<input type="number" name="minBid" min="0.00" step="0.01" required="required" >
			</td>
		</tr>
		</table>
		<input type ="hidden" name="itemtype" value ="ram" >
		<input type="submit" value="Create">
		</form>

<%
    }
%>
</body>
</html>