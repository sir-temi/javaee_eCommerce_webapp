<%-- 
    Document   : customerorders
    Created on : Apr 20, 2021, 3:18:06 PM
    Author     : engryankey
--%>

<%@page import="src.OrdersModel"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="src.ProductModel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp" >
        <jsp:param name="title" value="Custoer Orders" />
    </jsp:include>
    <%
        if (session.getAttribute("user") != null) {
            response.sendRedirect("denied.jsp");
        }else if(session.getAttribute("user") == null & session.getAttribute("admin") == null){
            response.sendRedirect("login.jsp");
        }
     %>
    <body>
    <jsp:include page="navbar.jsp" >
        <jsp:param name="login" value="" />
        <jsp:param name="register" value="" />
        <jsp:param name="home" value="" />
        <jsp:param name="dashboard" value="" />
        <jsp:param name="cus_orders" value="active" />
    </jsp:include>
        <div class="container">
        <div class="row">
            <div class="col-md-4" id="leftdash">
                <div align="center" class="dashimage">
                    <img src="img/dp.png" class="al" align="center">
                </div>
                <br>
                <div align="center">
                    <h3 class="head">${admin.getName()}</h3>
                    <span class="admin-badge"><strong>Admin</strong></span><br>
                    <strong>Member since</strong><br>
                    <strong class="head"><em>${admin.getJoined()}</em></strong><br><br>
                    <strong>Email</strong><br>
                    <strong class="head"><em>${admin.getEmail()}</em></strong><br><br>
                    <strong>Total cakes in database</strong><br>
                    <strong class="head"><em>${total_products}</em></strong>
                    <br>
                    <strong>Total quantity of cakes in stock</strong><br>
                    <strong class="head"><em>${total_cakes}</em></strong>
                    <br>
                    <strong>Total orders placed by customers</strong><br>
                    <strong class="head"><em>${total_orders}</em></strong>
                    <br><br>
                    <form action="Servlet" method="GET">
                        <button class="btn btn-primary btn-lg"><i class="far fa-plus-square fa-1x"></i> <strong>ADD PRODUCT</strong></button>
                        <input type="hidden" name="action" value="ADD_PRODUCT">
                    </form>
                </div>
            </div>
            <div class="col-sm-8" id="rightdash">
                
                        <div class="display container">
                        <% if(session.getAttribute("total_orders") !=  null) {%>
                            <% if (session.getAttribute("total_orders") != "0") { %>
                                <% List orders = (ArrayList) session.getAttribute("orders");%>
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
                                        <br>
                                        <h5 class="category">
                                            Customer username:  <%= order.getCustomer()%>
                                        </h5>
                                    </div>
                                </div>
                                <% } %>
                            <% } else { %>
                                <div align="center">
                                    <h4 class="head">No customer has placed orders yet.</h4>
                                </div>
                            <% } %>
                        <% } %>
                </div>
            </div>
        </div>
        </div>
    <jsp:include page="footer.jsp" />
</html>