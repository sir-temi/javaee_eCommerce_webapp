<%-- 
    Document   : login
    Created on : Apr 7, 2021, 4:50:17 PM
    Author     : engryankey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp" >
        <jsp:param name="title" value="Login" />
    </jsp:include>
    <body>
    <jsp:include page="navbar.jsp" >
        <jsp:param name="login" value="active" />
        <jsp:param name="register" value="" />
        <jsp:param name="gome" value="" />
    </jsp:include>
        <center>
            <h1 class="head">LOG IN</h1>
        <div class="col-10 col-sm-8 col-md-6">
            <form action="Servlet" method="POST">
                <div class="form-floating mb-3">
                    <input type="text" name="username" class="form-control" id="floatingInput" aria-describedby="emailHelp" placeholder="Username" required>
                    <label for="floatingInput">Username</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Password" required>
                    <label for="floatingPassword">Password</label>
                </div>
                <div class="d-grid gap-2 mb-3">
                    <button type="submit" class="btn btn-primary btn-lg">LOG IN</button>
                    <input name="action" value="LOGIN" type="hidden">
                </div>
            </form>
            <p align="center"><strong>Don't have an account yet? <a href="registration.jsp"><span id="listwords">REGISTER</span></a></strong><br>
             <strong style="color: red;">${error}</strong>
        </div>
        </center>    
        <br>
        <br>
        <br>
        <br>
    <%@include file="footer.jsp" %>
</html>
