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
    
<div class="container mt-5">

<%
    String id = request.getParameter("id");

    out.println("<form method='post' action='addUser.jsp?id="+id+"'>");

    out.println("<table class='table'><thead class='thead-dark'><tr><th>Customer Profile</th><th></th><th></th><th></th></thead>");

    //customer data
    %>
   
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
            <td><input class="form-control" type="text" name="fname" size=20 maxlength=40 required></td>
            <td></td><td></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
            <td><input class="form-control" type="text" name="lname" size=20 maxlength="40" required></td>
            <td></td><td></td>
        </tr>

        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
            <td><input class="form-control" type="text" name="email" size=20 maxlength=50 required></td>
            <td></td><td></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
            <td><input class="form-control" type="text" name="pNum" size=20 maxlength="20" required></td>
            <td></td><td></td>
        </tr>

        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
            <td><input class="form-control" type="text" name="email" size=20 maxlength=50 required></td>
            <td></td><td></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
            <td><input class="form-control" type="text" name="city" size=20 maxlength="40" required></td>
        
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
            <td><input class="form-control" type="text" name="sate" size=20 maxlength=20 required></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
            <td><input class="form-control" type="text" name="postCode" size=20 maxlength="20" required></td>

            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
            <td><input class="form-control" type="text" name="country" size=20 maxlength="40" required></td>
        </tr>    
        
        <tr>
            <td></td><td></td><td></td><td></td>
        </tr>

        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">User Name:</font></div></td>
            <td><input class="form-control" type="text" name="userId" size=20 maxlength="20" required></td>

            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
            <td><input class="form-control" type="password" name="pw" size=20 maxlength="30" required></td>
        </tr> 
    
        </table>

        <div class='mt-3 ml-3 text-right'><button type='submit' name=create value=1 class='btn btn-primary mt-3'>Create</button><button type='submit' name=create value=2 class='btn btn-secondary mt-3 ml-3'>Update</button></div>

        </form>
</div>
</body>
</html>