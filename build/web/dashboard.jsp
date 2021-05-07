<%-- 
    Document   : dashboard
    Created on : Apr 9, 2021, 10:40:04 PM
    Author     : engryankey
--%>

<%@page import="src.OrdersModel"%>
<%@page import="src.User"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="src.ProductModel"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp" >
        <jsp:param name="title" value="Dashboard" />
    </jsp:include>
    <%
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
        }else{
            final String USERNAME = "root";
            final String PASSWORD ="Jesse2019";
            final String URL = "jdbc:mysql://localhost:3306/onlinestore?autoReconnect=true&useSSL=false";
            User user = (User) session.getAttribute("user");
            try{
                Connection connect;
                Class.forName("com.mysql.cj.jdbc.Driver");
                connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                String command = "SELECT * FROM orders WHERE customer=? order by id DESC";
                PreparedStatement pst = (PreparedStatement) connect.prepareStatement(command);
                pst.setString(1, user.getUsername());
                ResultSet result = pst.executeQuery();

                List<OrdersModel> orders = new ArrayList();
                while (result.next()) {
                        OrdersModel order = new OrdersModel();
                        order.setId(result.getInt("id"));
                        order.setOrdernumber(result.getString("order_number"));
                        order.setItems(result.getString("items"));
                        order.setTotalitems(result.getInt("total_items"));
                        order.setCustomer(result.getString("customer"));
                        order.setOrderdate(result.getString("order_date"));
                        order.setTotalamount(result.getInt("total_amount"));

                        orders.add(order);
                    }
                request.setAttribute("user_orders", orders);
                request.setAttribute("total_orders", orders.size());
                }catch (SQLException e){
                    PrintWriter write = response.getWriter();
                    write.print(e);
                }
        }
     %>
    <body>
    <jsp:include page="navbar.jsp" >
        <jsp:param name="login" value="" />
        <jsp:param name="register" value="" />
        <jsp:param name="home" value="" />
        <jsp:param name="dashboard" value="active" />
    </jsp:include>
        <div class="container">
        <div class="row">
            <div class="col-sm-4 toggleds" id="leftdash">
                <div align="center" class="dashimage">
                    <img src="img/dp.png" class="al" align="center">
                </div>
                <br>
                <div align="center">
                    <h3 class="head">${user.getName()}</h3>
                    <strong>Member since</strong><br>
                    <p><strong class="head"><em>${user.getJoined()}</em></strong></p>
                    <strong>Username</strong><br>
                    <p><strong class="head"><em>${user.getUsername()}</em></strong></p>
                    <strong>Email</strong><br>
                    <p><strong class="head"><em>${user.getEmail()}</em></strong></p>
                    <strong>Your Purchases</strong><br>
                    <strong class="head"><em>${total_orders}</em></strong>
                    <br>
                </div>
            </div>
            <div class="col-sm-8" id="rightdash">
                <div class="display container">
                    <% if(request.getAttribute("user_orders") !=  null) {%>
                        <% List orders = (ArrayList) request.getAttribute("user_orders");%>
                        <% if (orders.size() != 0) { %>
                            <% for(int i=0; i<orders.size(); i++) { %>
                            <% OrdersModel order = (OrdersModel)orders.get(i); %>
                            <div class="product">
                                <div class="container">
                                    <h4 class='head'>
                                        Order number: <%= order.getOrdernumber()%>
                                    </h4>
                                    <h5 class="price">
                                        Order amount: &#163;<%= order.getTotalamount()%>
                                    </h5>
                                    <h5>
                                        Order date: <%= order.getOrderdate()%>
                                    </h5>
                                    <h5>
                                        Total Items: <%= order.getTotalitems()%>
                                    </h5>
                                </div>
                            </div>
                            <% } %>
                        <% } else { %>
                            <div align="center">
                                <h4 class="head">You haven't placed an order yet</h4>
                                <p><a href="index.jsp"><button class="btn btn-primary btn-lg">GO TO MARKET</button></a></p>
                            </div>
                        <% } %>
                    <% } %>
                </div>
            </div>
        </div>
        </div>
    <jsp:include page="footer.jsp" />
</html>
