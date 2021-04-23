<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
<form action= "loginHandler.jsp" method = "POST">
	<input type= "text" name= "Acc_ID" placeholder= "Account ID" required> <br>
	<input type= "password" name= "Password" placeholder= "Password" required> <br>
	<input type= "submit" value= "Login"> 
</form>
<br>
 <a href="register.jsp">Register here.</a>
 
</body>
</html>