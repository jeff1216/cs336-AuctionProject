<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	

<p>Select a type of PC part to sell. </p>
<select id ="PC Part" onchange="partFunction()">
<option value="Ram">RAM Storage</option>
<option value="CPU">Computer Processor Units</option>
<option value="PSU">Power Supplies</option>
</select>

<p id ="demo"></p>
 <script>
function partFunction() {
	var temp = document.getElementById("PC Part").value;
	if(temp.equals("Power Supplies")){
		document.getElementById("demo").innerHTML = 
		<select id = "dropdown_two">
		<option value="Ram">TEST2</option>
		<option value="CPU">TEST2</option>
		<option value="PSU">TEST2</option></select>;
	}
}
</script>
</form>

<%
    }
%>
</body>
</html>