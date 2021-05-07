<%-- 
    Document   : thankyou
    Created on : Apr 20, 2021, 9:48:48 AM
    Author     : engryankey
--%>

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
        <jsp:param name="title" value="Home" />
    </jsp:include>
    <%  
        
     %>
    <body>
    <jsp:include page="navbar.jsp" >
        <jsp:param name="login" value="" />
        <jsp:param name="register" value="" />
        <jsp:param name="home" value="active" />
    </jsp:include>
        <br>
        <br>
    <div class="container">
        <div class="row">
            <div class="col-1"></div>
            <center class="col-10">
                <h1 class="head"><svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-check2-square" viewBox="0 0 16 16">
                    <path d="M3 14.5A1.5 1.5 0 0 1 1.5 13V3A1.5 1.5 0 0 1 3 1.5h8a.5.5 0 0 1 0 1H3a.5.5 0 0 0-.5.5v10a.5.5 0 0 0 .5.5h10a.5.5 0 0 0 .5-.5V8a.5.5 0 0 1 1 0v5a1.5 1.5 0 0 1-1.5 1.5H3z"/>
                    <path d="m8.354 10.354 7-7a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0z"/>
                    </svg></h1>
                <h3 class="head">Thank you for shopping with us.</h3>
                <h4>Order number: <span class="price_small"><%= session.getAttribute("order_number") %></span></h4>
                <h4>Order date: <span class="price_small"><%= session.getAttribute("order_date") %></span></h4>
                <h4>Order amount: <span class="price_small">&#163;<%= session.getAttribute("total_price") %></span></h4>
                <h4>Items bought: <span class="price_small"><%= session.getAttribute("total_items") %></span></h4>
            </center>
            <div class="col-1"></div>
        </div>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
    </div>
   
    <jsp:include page="footer.jsp" />
</html>
