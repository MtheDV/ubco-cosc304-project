<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%
    int productId = Integer.parseInt(request.getParameter("id"));

    String success = "f";

    // add review to database
    try {
        getConnection();

        String sql = "DELETE FROM product WHERE productId = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setInt(1, productId);
        stmt.executeUpdate();

        closeConnection();

        success = "t";

    } catch (SQLException exp) { out.println(exp); }

    response.sendRedirect("admin.jsp?s="+success);
%>