<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%
    String first = (String)request.getParameter("fn");
    String last = (String)request.getParameter("ln");
    String email = (String)request.getParameter("em");
    String phonenum = (String)request.getParameter("pn");
    String address = (String)request.getParameter("ad");
    String city = (String)request.getParameter("ci");
    String state = (String)request.getParameter("st");
    String postalCode = (String)request.getParameter("pc");
    String country = (String)request.getParameter("co");
    String userid = (String)request.getParameter("id");
    String password = (String)request.getParameter("ps");

    String success = "f";

    // add review to database
    try {
        getConnection();

        String sql = "INSERT INTO customer " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, first); stmt.setString(2, last); stmt.setString(3, email);
        stmt.setString(4, phonenum); stmt.setString(5, address); stmt.setString(6, city);
        stmt.setString(7, state); stmt.setString(8, postalCode); stmt.setString(9, country);
        stmt.setString(10, userid); stmt.setString(11, password);
        stmt.executeUpdate();

        closeConnection();

        success = "t";

    } catch (SQLException exp) { out.println(exp); }

    response.sendRedirect("admin.jsp?s="+success);
%>