<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create an Auction</title>
</head>
<body>
<%
if ((session.getAttribute("user") == null)) {
	response.sendRedirect("login.jsp");

} else {
%>
<%@ include file="navbar.jsp"%>

<form action="MainPage.jsp">
			<input type="submit" value="Home" />
		</form>
		<br>
	
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
		<tr>
		<td>Item Type</td>
		</tr>
		<tr>
			<td>
			<select 
					name="itemtype"
					required = "required">
					<option value="ram">RAM</option>
					<option value="cpu">CPU</option>
					<option value="psu">Power Supply</option>
				</select>
			</td>
		</tr>
		<tr><td>Note: For entries regarding other types, please fill in with "0".</td> </tr>
		
		<tr>		
		<td>RAM Type (RAM)</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="ramType" title="NA if not RAM" required="required">
			</td>
		</tr>
		<tr>
		<td>Size in GB (RAM)</td>
		</tr>
		<tr>
			<td>
				<input type="number" name="ramSize" title="NA if not RAM" required="required">
			</td>
		</tr>
		<tr>
		
		<td>Speed in MHz (RAM)</td>
		</tr>
		<tr>
			<td>
				<input type="number" name="ramSpeed" title="NA if not RAM" required="required">
			</td>
		</tr>
		<tr>
		<td>Core Count (CPU)</td>
		</tr>
		<tr>
			<td>
				<input type="number" name="cpuCore" title="NA if not CPU" required="required">
			</td>
		</tr>
		<tr>
		
		<td>Core Clock Speed in GHz (CPU)</td>
		</tr>
		<tr>
			<td>
				<input type="number" name="cpuClock" title="NA if not CPU" required="required">
			</td>
		</tr>
		<tr>
		<td>Series (CPU)</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="cpuSeries" title="NA if not CPU" required="required">
			</td>
		</tr>
		<tr>
		<td>Wattage in Watts (Power Supply)</td>
		</tr>
		<tr>
			<td>
				<input type="number" name="psuWattage" title="NA if not Power Supply" required="required">
			</td>
		</tr>
		<tr>
		<td>Modularity (Power Supply)</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="psuModularity" title="NA if not Power Supply" required="required">
			</td>
		</tr>
		<tr>
		<td>Efficiency Rating in % (Power Supply)</td>
		</tr>
		<tr>
			<td>
				<input type="number" name="psuEfficiency" title="NA if not Power Supply" required="required">
			</td>
		</tr>
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
				<input type="number" name="minBid" min="0.01" step="0.01" max="2500" required="required" >
			</td>
		</tr>
		</table>
		<input type="submit" value="Create">
		</form>

<%
    }
%>
</body>
</html>