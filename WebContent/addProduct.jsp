<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%
    double price = Double.parseDouble(request.getParameter("pr"));
    String imageURL = (String)request.getParameter("url");
    String brand = (String)request.getParameter("br");
    String evType = (String)request.getParameter("evt");
    String brandId = (String)request.getParameter("bid");
    String model = (String)request.getParameter("m");
    int releaseYear = Integer.parseInt(request.getParameter("ry"));
    String variant = (String)request.getParameter("v");
    double batterySize = Double.parseDouble(request.getParameter("bs"));

    String success = "f";

    // add review to database
    try {
        getConnection();

        String sql = "INSERT INTO product " +
                "(productPrice, productImageURL, productBrand, productEVType, productBrandId, productModel, productReleaseYear, productVariant, productBatterySize) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setDouble(1, price); stmt.setString(2, imageURL); stmt.setString(3, brand);
        stmt.setString(4, evType); stmt.setString(5, brandId); stmt.setString(6, model);
        stmt.setInt(7, releaseYear); stmt.setString(8, variant); stmt.setDouble(9, batterySize);
        stmt.executeUpdate();

        closeConnection();

        success = "t";

    } catch (SQLException exp) { out.println(exp); }

    response.sendRedirect("admin.jsp?s="+success);
%>