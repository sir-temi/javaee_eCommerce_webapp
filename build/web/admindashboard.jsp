<%-- 
    Document   : admindashboard
    Created on : Apr 10, 2021, 8:37:51 PM
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
        <jsp:param name="title" value="Dashboard" />
    </jsp:include>
    <%
        if (session.getAttribute("user") != null) {
            response.sendRedirect("denied.jsp");
        }else if(session.getAttribute("user") == null & session.getAttribute("admin") == null){
            response.sendRedirect("login.jsp");
        }else{
            final String USERNAME = "root";
            final String PASSWORD ="Jesse2019";
            final String URL = "jdbc:mysql://localhost:3306/onlinestore?autoReconnect=true&useSSL=false";
            int total_cakes = 0;
            try{
                Connection connect = null;
                Class.forName("com.mysql.cj.jdbc.Driver");
                connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                String admin_command = "SELECT * FROM products order by id DESC";
                String orders_command = "SELECT * FROM orders order by id DESC";
                PreparedStatement admin_pst = (PreparedStatement) connect.prepareStatement(admin_command);
                ResultSet result = admin_pst.executeQuery();
                PreparedStatement orders_pst = (PreparedStatement) connect.prepareStatement(orders_command);
                ResultSet result_command = orders_pst.executeQuery();
                List<ProductModel> products = new ArrayList();
                List<OrdersModel> orders = new ArrayList();
                while (result.next()) {
                        ProductModel product = new ProductModel();
                        product.setId(result.getInt("id"));
                        product.setPid(result.getInt("product_id"));
                        product.setPrice(result.getInt("price"));
                        product.setPdesc(result.getString("product_description"));
                        product.setPtitle(result.getString("product_title"));
                        product.setCategory(result.getString("category"));
                        product.setImage(result.getString("image"));
                        product.setQuantity(result.getInt("quantity"));

                        products.add(product);
                        total_cakes += result.getInt("quantity");
                    }
                while (result_command.next()) {
                        OrdersModel order = new OrdersModel();
                        order.setId(result_command.getInt("id"));
                        order.setOrdernumber(result_command.getString("order_number"));
                        order.setItems(result_command.getString("items"));
                        order.setTotalitems(result_command.getInt("total_items"));
                        order.setCustomer(result_command.getString("customer"));
                        order.setOrderdate(result_command.getString("order_date"));
                        order.setTotalamount(result_command.getInt("total_amount"));

                        orders.add(order);
                    }
                session.setAttribute("products", products);
                session.setAttribute("total_products", products.size());
                session.setAttribute("orders", orders);
                session.setAttribute("total_orders", orders.size());
                session.setAttribute("total_cakes", total_cakes);
                connect.close();
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
                        <button class="btn btn-primary btn-lg"><i class="far fa-plus-square fa-1x"></i> <strong>ADD A CAKE</strong></button>
                        <input type="hidden" name="action" value="ADD_PRODUCT">
                    </form>
                </div>
            </div>
            <div class="col-sm-8" id="rightdash">
                
                        <div class="display container">
                        <% if(session.getAttribute("total_products") !=  null) {%>
                        <% List products = (ArrayList) session.getAttribute("products");%>
                        <% if (products.size() != 0) { %>
                                <% for(int i=0; i<products.size(); i++) { %>
                                <% ProductModel product = (ProductModel)products.get(i); %>
                                <div class="product">
                                    <div class="row">
                                        <div class="col-md-5" align="center">
                                                <form action="Products" method="GET">
                                                    <a href="" style="text-decoration: none;" onclick="this.closest('form').submit();return false;">
                                                        <img src="img/uploaded/<%= product.getImage()%>" alt="<%= product.getPtitle() %>" srcset=""  width="200" height="280">
                                                    </a>
                                                    <input type="hidden" name="id" value="<%= product.getId() %>">
                                                    <input type="hidden" name="category" value="detail">
                                                </form>
                                        </div>
                                        <div class="col-md-7">
                                            <h4>
                                                <form action="Products" method="GET">
                                                    <a href="" style="text-decoration: none;" onclick="this.closest('form').submit();return false;"><%= product.getPtitle() %></a>
                                                    <input type="hidden" name="id" value="<%= product.getId() %>">
                                                    <input type="hidden" name="category" value="detail">
                                                </form>
                                            </h4>
                                            <span class="price">
                                                &#163;<%= product.getPrice() %>
                                            </span>
                                            <br>
                                            <span class="pid">
                                                <i class="fas fa-tags"></i> <%= product.getPid()%>
                                            </span>
                                            <br>
                                            <span class="instock">
                                                <i class="fas fa-list-ol"></i> <%= product.getQuantity()%> pieces in stock
                                            </span>
                                            <br>
                                            <span class="category">
                                                <i class="fas fa-layer-group"></i> <%= product.getCategory()%>
                                            </span>
                                            <br>
                                            <span class="desc">
                                                <i class="fas fa-pen-fancy"></i> <%= product.getPdesc()%>
                                            </span>
                                            <div class="row edit_delete" align="center">
                                                <div class="col-6">
                                                <form action="DelEditProductServlet" method="POST">
                                                    <button type="submit" class="btn btn-outline-secondary btn-lg" id="bt">
                                                        EDIT <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-tools" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                            <path fill-rule="evenodd" d="M0 1l1-1 3.081 2.2a1 1 0 0 1 .419.815v.07a1 1 0 0 0 .293.708L10.5 9.5l.914-.305a1 1 0 0 1 1.023.242l3.356 3.356a1 1 0 0 1 0 1.414l-1.586 1.586a1 1 0 0 1-1.414 0l-3.356-3.356a1 1 0 0 1-.242-1.023L9.5 10.5 3.793 4.793a1 1 0 0 0-.707-.293h-.071a1 1 0 0 1-.814-.419L0 1zm11.354 9.646a.5.5 0 0 0-.708.708l3 3a.5.5 0 0 0 .708-.708l-3-3z"/>
                                                            <path fill-rule="evenodd" d="M15.898 2.223a3.003 3.003 0 0 1-3.679 3.674L5.878 12.15a3 3 0 1 1-2.027-2.027l6.252-6.341A3 3 0 0 1 13.778.1l-2.142 2.142L12 4l1.757.364 2.141-2.141zm-13.37 9.019L3.001 11l.471.242.529.026.287.445.445.287.026.529L5 13l-.242.471-.026.529-.445.287-.287.445-.529.026L3 15l-.471-.242L2 14.732l-.287-.445L1.268 14l-.026-.529L1 13l.242-.471.026-.529.445-.287.287-.445.529-.026z"/>
                                                          </svg>
                                                    </button>
                                                    <input type="hidden" name="action" value="UPDATE_FORM">
                                                    <input type="hidden" name="id" value="<%= product.getId() %>">
                                                </form>
                                                </div>
                                                <div class="col-6">
                                                <form action="DelEditProductServlet" method="POST">
                                                <button type="submit" class="btn btn-outline-danger btn-lg" id="bt" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                                    DELETE <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd" d="M2.5 1a1 1 0 0 0-1 1v1a1 1 0 0 0 1 1H3v9a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V4h.5a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1H2.5zm3 4a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5zM8 5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7A.5.5 0 0 1 8 5zm3 .5a.5.5 0 0 0-1 0v7a.5.5 0 0 0 1 0v-7z"/>
                                                  </svg>
                                                </button>
                                                <input type="hidden" name="action" value="DELETE_PRODUCT">
                                                <input type="hidden" name="id" value="<%= product.getId() %>">
                                                </form>
                                            </div>
                                        </div>
                                            
                                        </div>
                                    </div>
                                </div>
                                <% } %>
                            <% } else { %>
                                <div align="center">
                                    <br>
                                    <br>
                                    <br>
                                    <br>
                                    <h4 class="head">You have not added any cake.</h4>
                                    <form action="Servlet" method="GET">
                                    <button class="btn btn-primary btn-lg"><i class="far fa-plus-square fa-1x"></i> <strong>ADD A CAKE</strong></button>
                                    <input type="hidden" name="action" value="ADD_PRODUCT">
                                </form>
                                </div>
                            <% } %>
                        <% } %>
                </div>
            </div>
        </div>
        </div>
    <jsp:include page="footer.jsp" />
</html>