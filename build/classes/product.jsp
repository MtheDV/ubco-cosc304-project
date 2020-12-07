<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@include file="header.jsp" %> 
<%@ page import="java.util.Locale" %>

<html>
<head>
<title>Rays Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="padding-top: 45px">


<div class="container mt-5">
<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");
String alreadyReviewed = request.getParameter("rv");
if (alreadyReviewed != null) {
    if (alreadyReviewed.equals("t"))
        out.println("<div class='alert alert-success' role=alert>Review placed successfully!</div>");
    else
        out.println("<div class='alert alert-warning' role=alert>You have already placed a review for this product!</div>");
}

try {
    getConnection();

    /*String sql = "SELECT productReleaseYear, productBrand, productModel, productImageURL, productId, productPrice FROM product WHERE productId = ? ";
    PreparedStatement stmt = con.prepareStatement(sql);
    stmt.setInt(1, Integer.parseInt(productId));
    ResultSet rst = stmt.executeQuery();
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en","US"));*/

    // get the table names
    String sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'product'";
    PreparedStatement stmt = con.prepareStatement(sql);
    ResultSet rst = stmt.executeQuery();
    List<String> tableNames = new ArrayList<>();
    while (rst.next()) {
        tableNames.add(rst.getString(1));
    }

    // get the data in the row
    sql = "SELECT * FROM product WHERE productId = ? ";
    stmt = con.prepareStatement(sql);
    stmt.setInt(1, Integer.parseInt(productId));
    rst = stmt.executeQuery();
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en","US"));

    // display the data
    while(rst.next()) {
        out.println("<div class='d-flex justify-content-between'>");
            out.println("<div>");
                out.println("<h1 class='mb-3'><strong>"+rst.getInt(8)+" "+rst.getString(4)+" "+rst.getString(7)+"</strong></h1>");
                if(rst.getString(3) != null)
                    out.println("<img style='width: 40rem;height: auto' src="+rst.getString(3)+" alt='"+rst.getString(7)+" image'>");
            out.println("</div>");
            out.println("<div>");
                out.println("<h4 class='mt-4'>Price: "+currFormat.format(rst.getDouble(2))+"</h4>");
                out.println(
                    "<div>"+
                        "<a class='btn btn-warning mr-3' href='addcart.jsp?id="+rst.getInt(1)+"&brand="+rst.getString(4)+"&model="+rst.getString(7).replaceAll(" ","+")+"&price="+rst.getDouble(2)+"&qty=1'>Add To Cart</a>"+
                        "<a class='btn btn-primary' href='listprod.jsp'>Continue Shopping</a>"+
                    "</div>"
                );
            out.println("</div>");
        out.println("</div>");

        // tabs
        out.println(
            "<ul class='nav nav-tabs mt-5'>" +
                "<li style='cursor:pointer' class='nav-item'>" +
                "<a class='nav-link tab-nav active' onclick=openTab(event,'carData') id='originalOpen' checked>Car Details</a>" +
                "</li>" +
                "<li style='cursor:pointer' class='nav-item ml-2'>" +
                "<a class='nav-link tab-nav' onclick=openTab(event,'reviews')>Reviews</a>" +
                "</li>" +
            "</ul>"
        );
        
        // display table of car data
        out.println("<table id='carData' class='table table-striped tabDetails mt-3'>" +
                    "<thead><tr><th>Type</th><th>Description</th></tr></thead>");
        for(int i = 5; i < tableNames.size(); i++) {
            out.println("<tr><td>"+tableNames.get(i-1)+"</td><td>"+rst.getString(i)+"</td></tr>");
        }
        out.println("</table>");

        // start review section
        out.println("<div id='reviews' class='tabDetails mt-3'>" +
                    "<a class='btn btn-outline-primary float-right' href='addReview.jsp?id="+productId+"'>Add a Review</a>" +
                    "<h2 class='mt-3'>Reviews:</h2>");

        // get the reviews
        sql = "SELECT userid, reviewRating, reviewDate, reviewComment FROM review r JOIN customer c on r.customerId = c.customerId WHERE productId = ? ";
        stmt = con.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(productId));
        rst = stmt.executeQuery();
        while (rst.next()) {
            // display the reviews
            out.println(
                "<div class='bg-light rounded mt-4 p-3'>" +
                    "<h5>"+rst.getInt(2)+" Stars</h4>" +
                    "<h6>"+rst.getString(1)+" on "+rst.getDate(3)+" says:</h2>" +
                    "<h5 class='bg-white rounded mt-4 p-2'>"+rst.getString(4)+"</h5>" +
                "</div>"
            );
        }
        out.println("</div>");
        out.println("<div class='mb-5'></div>");
    }

    closeConnection();

} catch (SQLException ex) { out.println(ex); }
%>
</div>

</body>
<script>
    document.getElementById("originalOpen").click();

    function openTab(evt, tab) {
        var i, tabs, tabNavs;

        tabs = document.getElementsByClassName("tabDetails");
        for (i = 0; i < tabs.length; i++)
            tabs[i].style.display = "none";

        tabNavs = document.getElementsByClassName("tab-nav");
        for (i = 0; i < tabNavs.length; i++)
            tabNavs[i].className = tabNavs[i].className.replace(" active", "");

        clickTab = document.getElementById(tab);
        clickTab.style.display = "block";
        evt.currentTarget.className += " active";
    }
</script>
</html>

