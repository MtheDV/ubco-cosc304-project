<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%
    int productId = Integer.parseInt(request.getParameter("id"));
    int rating = Integer.parseInt(request.getParameter("ratingOption"));
    String review = (String)request.getParameter("review");
    String userName = (String)session.getAttribute("authenticatedUser");

    // add review to database
    try {
        getConnection();

        // get userId
        String sql = "SELECT customerId FROM customer WHERE userid = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, userName);
        ResultSet rst = stmt.executeQuery();
        int userId = -1;
        while(rst.next())
            userId = rst.getInt(1);
        
        // insert to reviews
        sql = "INSERT INTO review VALUES (?, GETDATE(), ?, ?, ?)";
        stmt = con.prepareStatement(sql);
        stmt.setInt(1, rating); stmt.setInt(2, userId); stmt.setInt(3, productId); stmt.setString(4, review);
        stmt.executeUpdate();

        closeConnection();

        response.sendRedirect("product.jsp?id="+productId);
    } catch (SQLException exp) { out.println(exp); }
%>