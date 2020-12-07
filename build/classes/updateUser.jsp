<!DOCTYPE html>
<html>
<head>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"  rel="stylesheet">
	<title>Customer Page</title>
</head>
<body style="padding-top: 45px">

<%@ include file="header.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
    
<div class="container mt-5"></div>


<%

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
    
// Make connection
try (Connection con = DriverManager.getConnection(url,uid,pw);){

    //Get values
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    String phoneNum = request.getParameter("pNum");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String pCode = request.getParameter("postCode");
    String country = request.getParameter("country");
    String uname = request.getParameter("userId");
    String passw = request.getParameter("pw");

    PreparedStatement stmt=null;
    ResultSet rst = null;
    
    //sql query
	String sql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

    //inserting in values
	stmt = con.prepareStatement(sql);
    stmt.setString(1, fname);
    stmt.setString(2, lname);
    stmt.setString(3, email);
    stmt.setString(4, phoneNum);
    stmt.setString(5, address);
    stmt.setString(6, city);
    stmt.setString(7, state);
    stmt.setString(8, pCode);
    stmt.setString(9, country);
    stmt.setString(10, uname);
    stmt.setString(11, passw);

    rst = stmt.executeQuery();


    // Make sure to close connection
    con.close();

} catch (SQLException ex) { out.println(ex); }

%>
<jsp:forward page="customer.jsp" />
