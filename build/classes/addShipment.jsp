<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%
    String address = (String)request.getParameter("address");
    String city = (String)request.getParameter("city");
    String state = (String)request.getParameter("state");
    String pc = (String)request.getParameter("pc");
    String country = (String)request.getParameter("country");

    // session.setAttribute("address", address);
    // session.setAttribute("city", city);
    // session.setAttribute("state", state);
    // session.setAttribute("pc", pc);
    // session.setAttribute("country", country);

    // add review to database
    try {
        getConnection();

        String sql = "INSERT INTO ordersummary " +
                "(orderDate,shiptoAddress, shiptoCity, shiptoState,shiptoPostalCode,shiptoCountry)" +
                "VALUES (GETDATE(), ?, ?, ?, ?, ?)";
        PreparedStatement stmt = con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
        stmt.setString(1, address); 
        stmt.setString(2, city); 
        stmt.setString(3, state);
        stmt.setString(4, pc);
        stmt.setString(5, country);
        stmt.executeUpdate();

        ResultSet rst = stmt.getGeneratedKeys();
        if(rst.next()){
            int orderId = rst.getInt(1);
            session.setAttribute("orderId",orderId);
        }    
        response.sendRedirect("payment.jsp");

        closeConnection();
    } catch (SQLException exp) { System.out.println(exp); }
   
%>