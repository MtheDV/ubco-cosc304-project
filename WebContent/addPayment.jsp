<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%
    String paymentType = (String)request.getParameter("paymentType");
    String paymentNumber = (String)request.getParameter("paymentNumber");
    String expDate = (String)request.getParameter("expDate");

    // add review to database
    try {
        getConnection();

        String sql = "INSERT INTO paymentmethod " +
                "(paymentType, paymentNumber, paymentExpiryDate)" +
                "VALUES (?, ?, ?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, paymentType); 
        stmt.setString(2, paymentNumber); 
        stmt.setString(3, expDate);
        stmt.executeUpdate();

        closeConnection();

        response.sendRedirect("ship.jsp");

    } catch (SQLException exp) { System.out.println(exp); }
%>