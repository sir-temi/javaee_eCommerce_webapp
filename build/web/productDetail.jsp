<%-- 
    Document   : productDetail
    Created on : Apr 13, 2021, 5:07:59 PM
    Author     : engryankey
--%>

<%@page import="src.ProductModel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp" >
        <jsp:param name="title" value="Dashboard" />
    </jsp:include>
    <body>
    <jsp:include page="navbar.jsp" >
        <jsp:param name="login" value="" />
        <jsp:param name="register" value="" />
        <jsp:param name="home" value="" />
        <jsp:param name="dashboard" value="active" />
    </jsp:include>
        <div class="container">
            <div class="row display" id="rightdash">
                      <% if(request.getAttribute("detail") !=  null) {%>
                        <% 
                            ProductModel detail = (ProductModel)request.getAttribute("detail");
                            List incart = new ArrayList();
                            if(session.getAttribute("incart") != null){
                                incart = (ArrayList) session.getAttribute("incart");
                            }
                        %>
                        <div class="col-md-6" id="rightdash">
                            <center class="">
                                <img src="img/uploaded/<%= detail.getImage() %>" alt="alt" class="pic" width="300" height="450"/>
                            </center>
                            <br>
                        </div>
                        <div class="col-md-6 rightdetail">
                            <h2 class="head"><%= detail.getPtitle() %></h2>
                            <h4><span class="price">&#163 <%= detail.getPrice() %></span></h4>
                            <h5>
                                Quantity in stock:
                                    <span><%= detail.getQuantity()%></span>
                            </h5>
                            <span class="pid">
                                <i class="fas fa-tags"></i> ${detail.getPid()}
                            </span>
                            <br>
                            <span class="category">
                                <i class="fas fa-layer-group"></i> <%= detail.getCategory() %>
                            </span>
                            <br>
                            <br>
                            <div class="note">
                                <h5 class="welcome">Product Description</h5>
                                <%= detail.getPdesc()%>
                            </div>
                            <br>
                            <% if(session.getAttribute("admin") !=  null) {%>
                            <div class="row" align="center">
                                <div class="col-6">
                                <form action="DelEditProductServlet" method="POST">
                                    <button type="submit" class="btn btn-outline-secondary btn-lg" id="bt">
                                        EDIT <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-tools" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M0 1l1-1 3.081 2.2a1 1 0 0 1 .419.815v.07a1 1 0 0 0 .293.708L10.5 9.5l.914-.305a1 1 0 0 1 1.023.242l3.356 3.356a1 1 0 0 1 0 1.414l-1.586 1.586a1 1 0 0 1-1.414 0l-3.356-3.356a1 1 0 0 1-.242-1.023L9.5 10.5 3.793 4.793a1 1 0 0 0-.707-.293h-.071a1 1 0 0 1-.814-.419L0 1zm11.354 9.646a.5.5 0 0 0-.708.708l3 3a.5.5 0 0 0 .708-.708l-3-3z"/>
                                            <path fill-rule="evenodd" d="M15.898 2.223a3.003 3.003 0 0 1-3.679 3.674L5.878 12.15a3 3 0 1 1-2.027-2.027l6.252-6.341A3 3 0 0 1 13.778.1l-2.142 2.142L12 4l1.757.364 2.141-2.141zm-13.37 9.019L3.001 11l.471.242.529.026.287.445.445.287.026.529L5 13l-.242.471-.026.529-.445.287-.287.445-.529.026L3 15l-.471-.242L2 14.732l-.287-.445L1.268 14l-.026-.529L1 13l.242-.471.026-.529.445-.287.287-.445.529-.026z"/>
                                          </svg>
                                    </button>
                                    <input type="hidden" name="action" value="UPDATE_FORM">
                                    <input type="hidden" name="id" value="<%= detail.getId() %>">
                                </form>
                                </div>
                                <div class="col-6">
                                <button type="button" class="btn btn-outline-danger btn-lg" id="bt" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                    DELETE <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M2.5 1a1 1 0 0 0-1 1v1a1 1 0 0 0 1 1H3v9a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V4h.5a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1H2.5zm3 4a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5zM8 5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7A.5.5 0 0 1 8 5zm3 .5a.5.5 0 0 0-1 0v7a.5.5 0 0 0 1 0v-7z"/>
                                  </svg>
                                </button>
                                </div>
                            </div>
                            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                  <div class="modal-content">
                                    <div class="modal-header">
                                      <h5 class="modal-title" id="exampleModalLabel"><%= detail.getPtitle()%></h5>
                                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        Do you want to proceed and delete this <%= detail.getPtitle()%>?
                                    </div>
                                    <div class="modal-footer">
                                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">NO</button>
                                      <form action="DelEditProductServlet" method="POST">
                                          <input type="submit" value="DELETE" class="btn btn-danger">
                                          <input type="hidden" name="action" value="DELETE_PRODUCT">
                                          <input type="hidden" name="id" value="<%= detail.getId() %>">
                                      </form>
                                    </div>
                                  </div>
                                </div>
                            </div>
                            <% } else { %>
                            <div class="edit_delete" align="center">
                                <% if(session.getAttribute("user") == null & session.getAttribute("admin") == null) { %>
                                    <button type="buton" class="btn btn-outline-primary btn-lg" id="bt" disabled>
                                            Please sign in <i class="fas fa-cart-plus"></i>
                                    </button>
                                <% } else { %>
                                    <% if(incart != null & incart.contains(detail.getId())) { %>
                                    <p><button type="buton" class="btn btn-primary btn-lg" id="bt" disabled>
                                            Already in cart <i class="fas fa-cart-arrow-down"></i>
                                        </button></p>
                                    <a href="index.jsp" style="text-decoration: none;" onclick="this.closest('form').submit();return false;">
                                        <button type="buton" class="btn btn-warning btn-lg" id="bt">
                                            CONTINUE SHOPPING <i class="fab fa-shopify"></i>
                                        </button>
                                    </a>
                                    <a href="CartPage.jsp" style="text-decoration: none;" onclick="this.closest('form').submit();return false;">
                                        <button type="buton" class="btn btn-success btn-lg" id="bt">
                                            CHECKOUT <i class="far fa-credit-card"></i>
                                        </button>
                                    </a>
                                        
                                    <% } else { %>
                                    <form action="CartServlet" method="POST">
                                        <button type="submit" class="btn btn-outline-primary btn-lg" id="bt">
                                            Add to Cart <i class="fas fa-cart-plus"></i>
                                        </button>
                                        <input type="hidden" name="action" value="ADD_TO_CART">
                                        <input type="hidden" name="id" value="<%= detail.getId() %>">
                                    </form>
                                    <% } %>
                                <% } %>
                            </div>
                            <% } %>
                        <% } %>
                        </div>
                    <!--</div>-->
                
            </div>
        </div>
    <jsp:include page="footer.jsp" />
</html>
