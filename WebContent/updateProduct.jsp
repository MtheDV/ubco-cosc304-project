<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%
    int id = Integer.parseInt(request.getParameter("1"));
    double price = Double.parseDouble(request.getParameter("2"));
    String imageURL = (String)request.getParameter("3");
    String brand = (String)request.getParameter("4");
    String evType = (String)request.getParameter("5");
    String brandId = (String)request.getParameter("6");
    String model = (String)request.getParameter("7");
    int releaseYear = Integer.parseInt(request.getParameter("8"));
    String variant = (String)request.getParameter("9");
    double batterySize = Double.parseDouble(request.getParameter("10"));

    String success = "f";

    // add review to database
    try {
        getConnection();

        String sql = "UPDATE product SET " +
                "productPrice=?, productImageURL=?, productBrand=?, productEVType=?, productBrandId=?, productModel=?, productReleaseYear=?, productVariant=?, productBatterySize=? " +
                "WHERE productId = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setDouble(1, price); stmt.setString(2, imageURL); stmt.setString(3, brand);
        stmt.setString(4, evType); stmt.setString(5, brandId); stmt.setString(6, model);
        stmt.setInt(7, releaseYear); stmt.setString(8, variant); stmt.setDouble(9, batterySize);
        stmt.setInt(10, id);
        stmt.executeUpdate();

        closeConnection();

        success = "t";

    } catch (SQLException exp) { out.println(exp); }

    response.sendRedirect("admin.jsp?s="+success);
%>