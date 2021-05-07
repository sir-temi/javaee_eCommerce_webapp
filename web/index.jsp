<%-- 
    Document   : index
    Created on : Apr 7, 2021, 4:33:32 PM
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
        final String USERNAME = "root";
        final String PASSWORD ="Jesse2019";
        final String URL = "jdbc:mysql://localhost:3306/onlinestore?autoReconnect=true&useSSL=false";
        try{
            Connection connect = null;
            Class.forName("com.mysql.cj.jdbc.Driver");
            connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
            String command = "SELECT * FROM products order by id DESC";
            if(request.getAttribute("command") != null){
                command = (String) request.getAttribute("command");
            }
            PreparedStatement admin_pst = (PreparedStatement) connect.prepareStatement(command);
            ResultSet result = admin_pst.executeQuery();

            List<ProductModel> products = new ArrayList();
            while (result.next()) {
                    ProductModel product = new ProductModel();
                    product.setId(result.getInt("id"));
                    product.setPid(result.getInt("product_id"));
                    product.setPrice(result.getInt("price"));
                    product.setPdesc(result.getString("product_description"));
                    product.setPtitle(result.getString("product_title"));
                    product.setCategory(result.getString("category"));
                    product.setImage(result.getString("image"));
                    
                    products.add(product);
                }
            session.setAttribute("products", products);
            }catch (SQLException e){
                PrintWriter write = response.getWriter();
                write.print(e);
            }
     %>
    <body>
    <jsp:include page="navbar.jsp" >
        <jsp:param name="login" value="" />
        <jsp:param name="register" value="" />
        <jsp:param name="home" value="active" />
    </jsp:include>
    
    <div class="container">
        <% if(session.getAttribute("products") !=  null) {%>
        <% List products = (ArrayList) session.getAttribute("products");%>
            <% if (products.size() != 0 ) { %>
                <center>
                    <form action="Products" method="GET" class="row g-3">
                        <div class="col-4">

                        </div>
                        <div cla
                        <div class="col-auto">
                          <select class="form-select" name="category" id="floatingSelect" aria-label="Filter by category" required>
                            <option disabled selected value>Filter by category</option>
                            <option value="all">All cakes</option>
                            <option value="butter_cake">Butter Cake</option>
                            <option value="pound_cake">Pound Cake</option>
                            <option value="sponge_cake">Sponge Cake</option>
                            <option value="genoise_cake">Genoise Cake</option>
                            <option value="biscuit_cake">Biscuit Cake</option>
                            <option value="ange_food_cake">Angel Food Cake</option>
                            <option value="chiffon_cake">Chiffon Cake</option>
                            <option value="baked_flourless_cake">Baked Flourless Cake</option>
                            <option value="unbaked_flourless_cake">Unbaked Flourless Cake</option>
                            <option value="carrot_cake">Carrot Cake</option>
                            <option value="red_valvet_cake">Red Velvet Cake</option>
                          </select>
                        </div>
                        <div class="col-auto">
                          <button type="submit" class="btn btn-primary mb-3">FILTER</button>
                        </div>
                    </form>
                </center>
                <br>
                <% 
                    List incart = new ArrayList();
                            if(session.getAttribute("incart") != null){
                                incart = (ArrayList) session.getAttribute("incart");
                            }
                %>
                <% for(int i=0; i<products.size(); i++) { %>
                <% ProductModel product = (ProductModel)products.get(i); %>
                <div class="home">
                    <div class="row">
                        <div class="col-md-4" align="center">
                            <form action="Products" method="GET">
                            <a href="" style="text-decoration: none;" onclick="this.closest('form').submit();return false;">
                                <img src="img/uploaded/<%= product.getImage()%>" alt="" srcset="" width="200" height="260">
                            </a>
                            <input type="hidden" name="id" value="<%= product.getId() %>">
                            <input type="hidden" name="category" value="detail">
                            </form>
                        </div>
                        <div class="col-md-5">
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
                            <span class="category">
                                <i class="fas fa-layer-group"></i> <%= product.getCategory()%>
                            </span>
                            <br>
                            <span>
                                <i class="fas fa-pen-fancy"></i> <strong><%= product.getPdesc()%></strong>
                            </span>
                        </div>
                        <div class="col-md-3">
                            <div class="">
                                <% if(session.getAttribute("user") == null & session.getAttribute("admin") == null) { %>
                                    <button type="buton" class="btn btn-outline-primary btn-lg" id="bt" disabled>
                                            Please sign in <i class="fas fa-cart-plus"></i>
                                    </button>
                                <% } else { %>
                                    <% if(incart != null & incart.contains(product.getId())) { %>
                                        <button type="buton" class="btn btn-primary btn-lg" id="bt" disabled>
                                            In cart <i class="fas fa-cart-arrow-down"></i>
                                        </button>
                                    <% } else { %>
                                        <form action="CartServlet" method="POST">
                                            <button type="submit" class="btn btn-outline-primary btn-lg" id="bt">
                                                Add to Cart <i class="fas fa-cart-plus"></i>
                                            </button>
                                            <input type="hidden" name="action" value="ADD_TO_CART">
                                            <input type="hidden" name="id" value="<%= product.getId() %>">
                                        </form>
                                    <% } %>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            <% } else { %>
                <% if (request.getAttribute("command") == null) { %>
                    <div align="center">
                        <br>
                        <<br>
                        <br>`
                        <br>
                        <h4 class="head">No products has been added on here, please check back later.</h4>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                    </div>
                <% } else { %>
                    <% String com = (String) request.getAttribute("command") ;%>
                    <% if (com.equals("SELECT * FROM products order by id DESC")) { %>
                        <div align="center">
                            <br>
                            <br>
                            <br>`
                            <br>
                            <h4 class="head">No products has been added on here, please check back later.</h4>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                        </div>
                    <% } else { %>
                        <div align="center">
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <h4 class="head">There is no product in this category</h4>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                        </div>
                    <% } %>
                <% } %>
            <% } %>

        <% } %>
    </div>
   
    <jsp:include page="footer.jsp" />
</html>
