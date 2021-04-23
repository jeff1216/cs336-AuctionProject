<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account Registration</title>
</head>
<body>
<form method="get" action="registerHandler.jsp">
	<table>
		<tr>
			<td>Name</td><td><input type="text" name="Name" required></td>
		</tr>
		<tr>    
			<td>Email</td><td><input type="text" name="Email" required></td>
		</tr>
		<tr>    
			<td>Address</td><td><input type="text" name="Address" required></td>
		</tr>
		<tr>    
			<td>Phone</td><td><input type="tel" name="Phone" 
				pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" 
				required>
				<small>Format: 123-456-7890</small></td>
		</tr>
		<tr>    
			<td>Date of Birth</td><td><input type="date" name="DOB" 
			pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" 
			required>
			<small>Format: yyyy-MM-dd</small></td>
		</tr>
				<tr>    
			<td>Account Username</td><td><input type="text" name="Acc_ID" required></td>
		</tr>
		<tr>
			<td>Password</td><td><input type="password" name="Password" required></td>
		</tr>
	</table>
	<input type="submit" value="Create Account!">
</form>
<br>
<a href="login.jsp">Cancel registration.</a>       
</body>
</html>