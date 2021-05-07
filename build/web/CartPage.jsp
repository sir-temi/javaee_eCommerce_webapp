<%-- 
    Document   : CartPage
    Created on : Apr 18, 2021, 2:36:30 PM
    Author     : engryankey
--%>

<%@page import="src.CartItem"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp" >
        <jsp:param name="title" value="Dashboard" />
    </jsp:include>
    <%
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
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
                    ${user.getJoined()}
                    <br><br>

                </div>
            </div>
                <div class="col-sm-8" id="rightdash">
                    <div class="row">
                        <div class="col-1"></div>
                        <div class="col-10">
                            <div class="display container">
                                <% if(session.getAttribute("cart") !=  null) {%>
                                <%  
                                    List cart = (ArrayList) session.getAttribute("cart");
                                    int total_price = 0;
                                    int total_items = 0;
                                %>
                                <% if (cart.size() != 0 ) { %> 
                                    <h4 align="center" class="head">Your Shopping Cart</h4>
                                    <br>
                                        <% for(int i=0; i < cart.size(); i++) { %>
                                        <% CartItem product = (CartItem) cart.get(i); %>
                                        <% 
                                            total_price += Integer.parseInt(product.getProduct().getPrice()) * product.getQuantity(); 
                                            total_items += product.getQuantity();
                                        %>
                                        <div class="product">
                                            <div class="row g-3">
                                                <div class="col-md-4" align="center">
                                                        <form action="Products" method="GET">
                                                            <a href="" style="text-decoration: none;" onclick="this.closest('form').submit();return false;"><img src="img/uploaded/<%= product.getProduct().getImage()%>" alt="" srcset=""  width="150" height="200"></a>
                                                            <input type="hidden" name="id" value="<%= product.getId() %>">
                                                        </form>
                                                </div>
                                                <div class="col-md-6">
                                                    <h4>
                                                        <a href="" style="text-decoration: none;" onclick="this.closest('form').submit();return false;"><%= product.getProduct().getPtitle() %></a>
                                          
                                                    </h4>
                                                    <span class="price">
                                                        &#163;<%= product.getProduct().getPrice() %> <span style="color: black">unit price</span>
                                                        <% if(product.getQuantity() > 1) { %>
                                                        <br>   &#163;<%= Integer.parseInt(product.getProduct().getPrice()) * product.getQuantity()  %> <span style="color: black">Total price</span>
                                                        <% } %>    
                                                    </span>
                                                    <br>
                                                    <br>
                                                    <br>
                                                    <center class="row edit_delete">
                                                        <form action="CartServlet" method="POST">
                                                                <div class="row g-3">
                                                                    <div class="col-auto">
                                                                        <input type="text" name="quantity" placeholder="Quantity" value="<%= product.getQuantity() %>" class="form-control" size="3">
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <button type="submit" class="btn btn-outline-success" id="bt">
                                                                        UPDATE <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-check2-circle" viewBox="0 0 16 16">
                                                                        <path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0z"/>
                                                                        <path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l7-7z"/>
                                                                        </svg>
                                                                      </button>
                                                                    </div>
                                                                <input type="hidden" name="action" value="UPDATE_QUANTITY">
                                                                <input type="hidden" name="id" value="<%= product.getId() %>">
                                                                </div>
                                                            </form>
                                                        </center>
                                                 </div>
                                                <div class="col-md-1" align="right">
                                                    <form action="CartServlet" method="POST">
                                                        <a href="" style="text-decoration: none;" onclick="this.closest('form').submit();return false;">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="red" class="bi bi-trash danger" viewBox="0 0 16 16">
                                                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                                            <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                                            </svg>
                                                        </a>
                                                        <input type="hidden" name="action" value="REMOVE_FROM_CART">
                                                        <input type="hidden" name="id" value="<%= product.getId() %>">
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <% } %>
                                            <h4 class="category" align="center">
                                                Total Price <span class="price">&#163;<%= total_price %></span> 
                                            </h4>
                                            <h4 class="category" align="center">
                                                You have <span class="price"><%= total_items %></span> total item(s) in the cart
                                            </h4>
                                            <h4 align="center">
                                                <form action="CartServlet" method="POST">
                                                    <a href="" style="text-decoration: none;" onclick="this.closest('form').submit();return false;">
                                                        <button class="btn btn-primary btn-lg">CHECK OUT</button>
                                                    </a>
                                                    <input type="hidden" name="action" value="CHECKOUT">
                                                    <input type="hidden" name="id" value="6">
                                                    <input type="hidden" name="total_price" value="<%= total_price %>">
                                                    <input type="hidden" name="total_items" value="<%= total_items %>">
                                                </form>
                                            </h4>
                                        <% } else { %>
                                        <center class="head">
                                            <br>
                                            <br>
                                            <br>
                                            <h3>You do not have any item in your cart</h3>
                                            <a href="index.jsp"><button class="btn btn-primary btn-lg">GO TO MARKET</button></a>
                                        </center>
                                        <% } %>
                                    <% } else { %>
                                       <center class="head">
                                            <br>
                                            <br>
                                            <br>
                                            <h3>You do not have any item in your cart</h3>
                                            <a href="index.jsp"><button class="btn btn-primary btn-lg">GO TO MARKET</button></a>
                                        </center>
                                    <% } %>
                                </div>
                            </div>
                        <div class="col-1"></div>
                    </div>
                </div>
            </div>
        </div>
    <jsp:include page="footer.jsp" />
</html>
