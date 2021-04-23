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
<select id ="pcPart" onchange="partFunction()">
	<option value="RAM">RAM Storage</option>
	<option value="CPU">Computer Processor Units</option>
	<option value="PSU">Power Supplies</option>
</select>

<select id ="subAtt">
	<option value="selectpls">--- Please select ---</option>
</select>


 <script>
function partFunction() {
	var ddl = document.getElementById("pcPart");
	var selectedValue = ddl.options[ddl.selectedIndex].value;
	if(selectedValue == "CPU"){
		var sub = document.getElementById("subAtt");
		var option = document.createElement("option");
		option.text = "hi";
		sub.add(option);
	}
}
</script>

<%
    }
%>
</body>
</html>