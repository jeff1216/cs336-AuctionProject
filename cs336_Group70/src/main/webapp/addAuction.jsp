<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336_Group70.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.sql.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.temporal.TemporalAdjusters.*"%>  
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.UUID" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get parameters from the HTML form at the RegisterPage.jsp
		String userID = (String) session.getAttribute("user");
		
		String itemName = request.getParameter("itemName");
		String cond = request.getParameter("condition");
		String itemType = request.getParameter("itemtype");
		
		String ramType = request.getParameter("ramType");
		int ramSize = Integer.parseInt(request.getParameter("ramSize"));
		int ramSpeed = Integer.parseInt(request.getParameter("ramSpeed"));
		int cpuCore = Integer.parseInt(request.getParameter("cpuCore"));
		int cpuClock = Integer.parseInt(request.getParameter("cpuClock"));
		String cpuSeries = request.getParameter("cpuSeries");
		int psuWattage = Integer.parseInt(request.getParameter("psuWattage"));
		String psuModularity = request.getParameter("psuModularity");
		int psuEfficiency = Integer.parseInt(request.getParameter("psuEfficiency"));
		
		String closeDate = request.getParameter("closeDate");
		int minBid = Integer.parseInt(request.getParameter("minBid"));
		
		//create Date from input
		int year = Integer.parseInt(closeDate.substring(0,4)) - 1900;
		int month = Integer.parseInt(closeDate.substring(5,7)) - 1;
		int day = Integer.parseInt(closeDate.substring(8,10));
		int hours = Integer.parseInt(closeDate.substring(11,13));
		int minutes = Integer.parseInt(closeDate.substring(14,16));
		int seconds = Integer.parseInt(closeDate.substring(17,19));
		
		java.util.Date cDate = new java.util.Date(year,month,day, hours,minutes,seconds);
		
		//insert into auction
		String aucID = UUID.randomUUID().toString();
		String insert = "INSERT INTO auction(Auction_ID, Current_price, Min_price, End_date, Winner)" 
				+ "VALUES (?, ?, ?, ?, ?);";
		
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, aucID);
		ps.setFloat(2, 0);
		ps.setFloat(3, minBid);
		ps.setObject(4, cDate);
		ps.setNull(5, java.sql.Types.NULL);
		ps.executeUpdate();
		
		
		//insert into pc_part
		String itemID = UUID.randomUUID().toString();
		String q = "INSERT INTO pc_part VALUES ('" + itemID + "','" + itemName + "', '" + cond + "');";
		con.prepareStatement(q).executeUpdate();
		
		
		//insert into ram/cpu/psu table
		if (itemType.equals("ram")){
			String ins = "INSERT INTO ram VALUES ('" + itemID + "','" + ramType + "', " + ramSize + "," + ramSpeed + ");";
			con.prepareStatement(ins).executeUpdate();
		} else if (itemType.equals("cpu")){
			String ins = "INSERT INTO cpu VALUES ('" + itemID + "'," + cpuCore + ", " + cpuClock + ",'" + cpuSeries + "');";
			con.prepareStatement(ins).executeUpdate();
		} else {
			String ins = "INSERT INTO psu VALUES ('" + itemID + "'," + psuWattage + ", '" + psuModularity + "', " + psuEfficiency + ");";
			con.prepareStatement(ins).executeUpdate();
		}
		
		//insert into post table
		insert = "INSERT INTO posts(Auction_ID, Acc_ID)"
				+ "VALUES (?, ?)";
		PreparedStatement post = con.prepareStatement(insert);
		post.setString(1, aucID);
		post.setString(2, userID);
		post.executeUpdate();

		//insert into has_item
		insert = "INSERT INTO has_item(Auction_ID, Item_ID)"
				+ "VALUES (?, ?)";
		PreparedStatement has_item = con.prepareStatement(insert);
		has_item.setString(1, aucID);
		has_item.setString(2, itemID);
		has_item.executeUpdate();
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Insert success");
		response.sendRedirect("index.jsp");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed");
	}
%>
</body>
</html>