<%-- 
    Document   : navbar
    Created on : Apr 7, 2021, 5:25:40 PM
    Author     : TemiTope Yankey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<nav class="navbar sticky-top navbar-expand-lg navbar-light" style="background-color: white;">
  <div class="container">
    <a class="navbar-brand mb-0 h1" href="index.jsp">
        <span class="mb-0 h2"><img src="img/vg_1.png" alt="" class="navlogo" width="200px" height="auto"></span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
            <a class="nav-link ${param.home}" aria-current="page" href="index.jsp"><span id="${param.home}"><strong>MARKET PLACE</strong></span></a>
        </li>
        
      </ul>
      <ul class="navbar-nav ml-auto">   
        <!--{% if user.is_authenticated %}-->
            <!--{% if user.is_staff or user.is_superuser %}-->
<!--                <li class="nav-item">
                    <a class="nav-link" href="{% url 'admindashboard' %}"><strong>DASHBOARD</strong></a>
                </li>-->
            <!--{% else %}-->
<!--                <li class="nav-item">
                    <a class="nav-link" href="{% url 'dashboard' %}"><strong>DASHBOARD</strong></a>
                </li> -->
            <!--{% endif %}-->
<!--            <li class="nav-item">
                <a class="nav-link" href="{% url 'logout' %}"><strong>LOG OUT</strong></a>
            </li>-->
            <% 
                Object user = session.getAttribute("user"); 
                Object admin = session.getAttribute("admin");
            %>
            <% if (user != null) { %>
                <li class="nav-item">
                        <a class="nav-link ${param.dashboard}" href="dashboard.jsp"><span id="${param.dashboard}"><strong>DASHBOARD</strong></span></a>
                    </li>
                <li class="nav-item">
                    <a class="nav-link ${param.cart}" href="CartPage.jsp"><span id="${param.cart}"><i class="fas fa-shopping-cart fa-lg"> <span class="badge bg-danger" style="font-family:Arial">${cart.size()}</span></i></span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.register}" href="Logout"><span id="${param.logout}"><strong>LOG OUT</strong></span></a>
                </li>
            <% } else if(admin != null) { %>
                <li class="nav-item">
                        <a class="nav-link ${param.dashboard}" href="admindashboard.jsp"><span id="${param.dashboard}"><strong>DASHBOARD</strong></span></a>
                    </li>
                <li class="nav-item">
                    <a class="nav-link ${param.cus_orders}" href="customerorders.jsp"><span id="${param.cus_orders}"><strong>CUSTOMER ORDERS</strong></span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.register}" href="Logout"><span id="${param.logout}"><strong>LOG OUT</strong></span></a>
                </li>
            <% } else { %>
                <li class="nav-item">
                    <a class="nav-link ${param.login}" href="login.jsp"><span id="${param.login}"><strong>LOG IN</strong></span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.register}" href="registration.jsp"><span id="${param.register}"><strong>REGISTER</strong></span></a>
                </li>
            <% } %>
        </ul>
    </div>
  </div>
</nav><br>
<% String alert = (String) request.getAttribute("alert"); %>
<% if (alert != null & alert == "yes") { %>
    <div class="alert alert-success alert-dismissible fade show container" role="alert">
        <strong>WELL DONE</strong> You have successfully <strong>${type}</strong> the product.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<% } else if(alert != null & alert == "no") { %>
    <div class="alert alert-danger alert-dismissible fade show container" role="alert">
        <strong>ERROR</strong> There was an error in <strong>${type}</strong> the product.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<% }  %>        
<br>