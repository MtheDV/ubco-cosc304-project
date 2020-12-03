<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
    <head>
        <title>Rays Grocery - Product Information</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body style="padding-top: 45px">
    <%@ include file="header.jsp" %>
    
        <div class="container mt-5">
            <h1>Write a review for:</h1>
            <%
                String productId = request.getParameter("id");
                try {
                    getConnection();

                    String sql = "SELECT productImageUrl, productReleaseYear, productBrand, productModel FROM product WHERE productId = ?";
                    PreparedStatement stmt = con.prepareStatement(sql);
                    stmt.setInt(1, Integer.parseInt(productId));
                    ResultSet rst = stmt.executeQuery();
                    while(rst.next()) {
                        out.println(
                            "<div class='d-flex justify-content-left'>" +
                                "<img style='width: 200px;height: auto' class='mr-3' src="+rst.getString(1)+" alt='"+rst.getString(3)+" image'>" +
                                "<h5><a href='product.jsp?id="+productId+"'>" +
                                ""+rst.getInt(2)+" "+rst.getString(3)+" "+rst.getString(4)+"" +
                                "</a></h5>" +
                            "</div>"
                        );
                    }

                    closeConnection();
                } catch(Exception e) { out.println(e); }

                out.println(
                    "<div id='reviews' class='tabDetails'>" +
                        "<form method='post' action='authReview.jsp?id="+productId+"'>" +
                            "<div class='form-group'>" +
                                "<div class='form-check form-check-inline'>" +
                                    "<input class='form-check-input' type='radio' name='ratingOption' id='rating1' value='1'>" +
                                    "<label class='form-check-label' for='rating1'>1 Star</label>" +
                            "</div>" +
                            "<div class='form-check form-check-inline'>" +
                                "<input class='form-check-input' type='radio' name='ratingOption' id='rating2' value='2'>" +
                                "<label class='form-check-label' for='rating2'>2 Stars</label>" +
                            "</div>" +
                            "<div class='form-check form-check-inline'>" +
                                "<input class='form-check-input' type='radio' name='ratingOption' id='rating3' value='3'>" +
                                "<label class='form-check-label' for='rating3'>3 Stars</label>" +
                            "</div>" +
                            "<div class='form-check form-check-inline'>" +
                                "<input class='form-check-input' type='radio' name='ratingOption' id='rating4' value='4'>" +
                                "<label class='form-check-label' for='rating4'>4 Stars</label>" +
                            "</div>" +
                            "<div class='form-check form-check-inline'>" +
                                "<input class='form-check-input' type='radio' name='ratingOption' id='rating5' value='5'>" +
                                "<label class='form-check-label' for='rating5'>5 Stars</label>" +
                            "</div>" +
                            "<label for='review'></label>" +
                            "<textarea class='form-control' name='review' rows=4></textarea>" +
                            "<button type='submit' class='btn btn-primary'>Submit</button>" +
                            "</div>" +
                        "</form>" +
                    "</div>"
                );
            %>
        </div>
    </body>
</html>