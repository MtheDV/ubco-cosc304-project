<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="jdbc.jsp" %>

<!-- Checking whether user is logged in -->
<%@ include file="auth.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Administrator Page</title>
    </head>
    <body style="padding-top: 45px">
        <%@include file="header.jsp"%>
        <div class="container mt-5">

            <%
                // Array data for chart
                List<Double> chartList = new ArrayList<>();
                List<String> chartListTitle = new ArrayList<>();

                try {
                    // Setup connection
                    getConnection();

                    // User Id for getting order data
                    String userid = (String)session.getAttribute("authenticatedUser");
                    NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en","US"));
                    String success = request.getParameter("s");
                    if (success != null) {
                        if (success.equals("t"))
                            out.println("<div class='alert alert-success' role=alert>Success!</div>");
                        else
                            out.println("<div class='alert alert-warning' role=alert>There was a problem performing that action!</div>");
                    }

                    // title
                    out.println("<h2 class='mb-3'><strong>Administrator Settings</strong></h2>");
                    // tabs
                    out.println(
                        "<ul class='nav nav-tabs'>" +
                            "<li style='cursor:pointer' class='nav-item'>" +
                            "<a class='nav-link tab-nav active' onclick=openTab(event,'orderInfo') id='originalOpen' checked>Order Info</a>" +
                            "</li>" +
                            "<li style='cursor:pointer' class='nav-item ml-2'>" +
                            "<a class='nav-link tab-nav' onclick=openTab(event,'orderList')>Order List</a>" +
                            "</li>" +
                            "<li style='cursor:pointer' class='nav-item ml-2'>" +
                            "<a class='nav-link tab-nav' onclick=openTab(event,'customers')>Customers</a>" +
                            "</li>" +
                            "<li style='cursor:pointer' class='nav-item ml-2'>" +
                            "<a class='nav-link tab-nav' onclick=openTab(event,'products')>Products</a>" +
                            "</li>" +
                            "<li style='cursor:pointer' class='nav-item ml-2'>" +
                            "<a class='nav-link tab-nav' onclick=openTab(event,'warehouse')>Warehouse Inventory</a>" +
                            "</li>" +
                        "</ul>"
                    );

                    //Order Info tab
                    out.println("<div id='orderInfo' class='tabDetails mt-3'>");
                    out.println("<h3 class='mb-2'>Administrator sales report by day</h3>");
                    // Write SQL query that prints out total order amount by day
                    String sql = "SELECT max(orderDate), sum(totalAmount) FROM ordersummary GROUP BY YEAR(orderDate), MONTH(orderDate), DAY(orderDate)";
                    // Create SQL statement with userid
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    ResultSet rst = pstmt.executeQuery();
                    // Array data for chart
                    chartList = new ArrayList<>();
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
                    // Start drawing table data
                    out.println("<table class='table table-striped'><thead class='thead-dark'><tr><td>Order Date</td><td>Total Order Amount</td></tr></thead>");
                    while(rst.next()) {
                        // Each row shows order date and total order amount from results
                        out.println("<tr><td>" + rst.getDate(1) + "</td><td>" + currFormat.format(rst.getDouble(2)) + "</td></tr>");
                        chartListTitle.add(dateFormat.format(rst.getDate(1)));
                        chartList.add(rst.getDouble(2));
                    }
                    out.println("</table>");
                    out.println("<canvas class='pl-5 pr-5 pb-5' id='myChart' width='400' height='400'>Unable to load graph.</canvas>");
                    out.println("</div>");

                    //Order List Tab
                    out.println("<div id='orderList' class='tabDetails mt-3'>");
                    out.println("<h3>List of All Orders</h3>");
                    sql = "SELECT OS.orderId,OS.orderDate,C.customerId,C.firstName,C.lastName, OS.totalAmount" +
                    " FROM ordersummary AS OS JOIN customer AS C ON OS.customerId = C.customerId";
                    PreparedStatement stmt = con.prepareStatement(sql);
                    rst = stmt.executeQuery();
                    String sql2 = "SELECT productId, quantity, price"+
                    " FROM orderproduct AS OP JOIN ordersummary AS OS ON OP.orderId = OS.orderId"+
                    " WHERE OS.orderId = ?";
                    pstmt = con.prepareStatement(sql2);
                    out.println("<table class='table'><thead class='thead-dark'><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>Customer Name</th><th>Total Amount</th></tr></thead>");
                    while(rst.next()){
                        out.println("<tr><td>"+rst.getInt(1)+"</td><td>"+rst.getDate(2)+ " "
                        +rst.getTime(2)+"</td><td>"+ rst.getInt(3)+
                        "</td><td>"+ rst.getString(4) + " " + rst.getString(5)+ "</td><td>"
                        +currFormat.format(rst.getDouble(6))+ "</td></tr>");
                        pstmt.setInt(1,rst.getInt(1));
                        ResultSet rst2 = pstmt.executeQuery();
                        out.println("<tr align='right'><td colspan=5><table class='table table-bordered table-sm'><thead class='thead-light'><tr><th>Product ID</th><th>Quantity</th><th>Price</th></tr></thead>");
                        while(rst2.next()){
                            out.println("<tr><td>" + rst2.getInt(1)+ "</td><td>" + rst2.getInt(2)+ "</td><td>" + currFormat.format(rst2.getDouble(3)) + "</td></tr>");
                        }
                        rst2.close();
                        out.println("</table></td></tr>");
                    }
                    out.println("</table>");
                    out.println("</div>");

                    //Customer Tab
                    out.println("<div id='customers' class='tabDetails mt-3'>");
                    // Add new customer
                    out.println("<form method='post' action='addCustomer.jsp?' class='bg-light p-4 rounded'>" +
                                    "<h5>Add a customer:</h5>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='fn' placeholder='First Name'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='ln' placeholder='Last Name'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='em' placeholder='email'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='pn' placeholder='Phone Number'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='ad' placeholder='Address'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='ci' placeholder='City'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='st' placeholder='State'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='pc' placeholder='Postal Code'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='co' placeholder='Country'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='id' placeholder='User ID'>" +
                                    "<input type='password' class='form-control form-control-sm mt-2' name='ps' placeholder='User Password'>" +
                                    "<div class='text-right'><button type='submit' class='btn btn-warning mt-3'>Add Customer</button></div>" +
                                "</form>");
                    // Get customer data
                    sql = "SELECT * FROM customer ORDER BY customerId DESC";
                    pstmt = con.prepareStatement(sql);
                    rst = pstmt.executeQuery();
                    while (rst.next()) {
                        out.println("<div class='bg-light p-4 mt-3 mb-3 rounded'>");
                        out.println("<address>" +
                                    "<strong>"+rst.getString(2)+" "+rst.getString(3)+"</strong><br>" +
                                    ""+rst.getString(6)+"</br>" +
                                    ""+rst.getString(7)+", "+rst.getString(8)+" "+rst.getString(9)+"<br>" +
                                    ""+rst.getString(10)+"<br>" +
                                    "P: "+rst.getString(5)+"<br><br>" +
                                    ""+rst.getString(4)+"<br>"
                                    );
                        out.println("</div>");
                    }
                    out.println("</div>");
                    

                    out.println("<div id='products' class='tabDetails mt-3'>");
                    // Add new product
                    out.println("<form method='post' action='addProduct.jsp?' class='bg-light p-4 rounded'>" +
                                    "<h5>Add a product:</h5>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='pr' placeholder='Price'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='url' placeholder='Image URL'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='br' placeholder='Brand'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='evt' placeholder='EV Type'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='bid' placeholder='Brand Id'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='m' placeholder='Model'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='ry' placeholder='Release Year'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='v' placeholder='Variant'>" +
                                    "<input type='text' class='form-control form-control-sm mt-2' name='bs' placeholder='Battery Size'>" +
                                    "<h4>...</h4>" +
                                    "<div class='text-right'><button type='submit' class='btn btn-warning mt-3'>Add Product</button></div>" +
                                "</form>");
                    
                    // Get product columns
                    sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'product'";
                    pstmt = con.prepareStatement(sql);
                    rst = pstmt.executeQuery();
                    List<String> tableNames = new ArrayList<>();
                    while (rst.next()) {
                        tableNames.add(rst.getString(1));
                    }
                    // Get product data
                    sql = "SELECT * FROM product ORDER BY productId DESC";
                    pstmt = con.prepareStatement(sql);
                    rst = pstmt.executeQuery();
                    out.println("<div class='table-responsive mt-3'>");
                    out.println("<h4 class='ml-4'>Products:</h4>");
                    out.println("<form method='post' action='updateProduct.jsp' id='productUpdate'></form>");
                    out.println("<table class='table table-striped'><thead class='thead-dark'><tr>");
                    out.println("<td></td><td></td>");
                    for(int i = 1; i < tableNames.size(); i++) {
                        out.println("<td>"+tableNames.get(i-1)+"</td>");
                    }
                    out.println("</tr></thead>");
                    while (rst.next()) {
                        out.println("<tr><td><a class='btn btn-danger' href='removeProduct.jsp?id="+rst.getString(1)+"'>Delete</a></td>");
                        out.println("<td><button form='productUpdate' type='submit' class='btn btn-warning'>Update Product</button></td>");
                        for(int i = 1; i < tableNames.size(); i++) {
                            if (i > 1 && i <= 10)
                                out.println("<td><input form='productUpdate' type='text' class='form-control form-control-sm' name='"+i+"' value='"+
                                            rst.getString(i)+"'></td>");
                            else
                                out.println("<td><input form='productUpdate' type='text' class='form-control form-control-sm' name='"+i+"' value='"+
                                            rst.getString(i)+"' readonly></td>");
                        }
                        out.println("</tr>");
                    }
                    out.println("</table>");
                    out.println("</div>");

                    out.println("<div class='text-right'><a class='btn btn-sm btn-danger' href='loaddata.jsp'><strong>Restore Database</strong></a></div>");

                    out.println("</div>");
                    out.println("<div class='mb-5'></div>");

                    //Warehouse tab
                    out.println("<div id='warehouse' class='tabDetails mt-3'>");

                    // Get inventory data
                    sql = "SELECT * FROM warehouse";
                    pstmt = con.prepareStatement(sql);
                    rst = pstmt.executeQuery();
                    while (rst.next()) {
                        out.println("<div class='bg-light p-4 mt-3 mb-3 rounded'>");
                        out.println("<address>" + "<strong>"+rst.getString(2)+"</strong><br>");
                        sql2 = "SELECT PI.productId, PI.quantity, productBrand, productModel "+
                        "FROM productinventory AS PI JOIN product AS P ON PI.productId = P.productId " +
                        "WHERE PI.warehouseId = ?";
                        PreparedStatement stmt2 = con.prepareStatement(sql2);
                        stmt2.setInt(1,rst.getInt(1));
                        ResultSet rst2 = stmt2.executeQuery();
                        out.println("<table class='table table-striped mt-3'><thead class='thead-dark'><tr><th>Product ID</th><th>Product Model</th><th>Quantity in Stock</th></tr></thead>");
                        while(rst2.next()){
                            out.println("<tr><td>"+rst2.getInt(1)+"</td>"+"<td>"+rst2.getString(3)+" " +rst2.getString(4)+"</td><td>"+rst2.getInt(2)+"</td></tr>");
                        }
                        out.println("</table>");
                    out.println("</div>");
                    }
                    out.println("</div>");


                    // Close connection
                    closeConnection();
                } catch(SQLException ex) {
                    out.println(ex);
                }
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js" integrity="sha512-hZf9Qhp3rlDJBvAKvmiG+goaaKRZA6LKUO35oK6EsM0/kjPK32Yw7URqrq3Q+Nvbbt8Usss+IekL7CRn83dYmw==" crossorigin="anonymous"></script>
    <script>
        var dataSet = "<%= chartList%>";
        var dataTitle = "<%= chartListTitle%>";

        var titles = new Array();
        var str = "";
        for (i = 1; i < dataTitle.length-1; i++) {
            if (!dataTitle[i].localeCompare(",")) {
                titles.push(str);
                str = "";
                i++;
                continue;
            }
            str += dataTitle[i];
        }
        titles.push(str);

        var values = new Array();
        str = "";
        for (i = 1; i < dataSet.length-1; i++) {
            if (!dataSet[i].localeCompare(",")) {
                values.push(parseFloat(str));
                str = "";
                i++;
                continue;
            }
            str += dataSet[i];
        }
        values.push(parseFloat(str));

        var ctx = document.getElementById('myChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: titles,
                datasets: [{
                    label: 'Sales Reports by Day',
                    data: values,
                    borderWidth: 3
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });
    </script>
</html>

