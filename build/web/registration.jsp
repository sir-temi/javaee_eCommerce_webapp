<%-- 
    Document   : registeration
    Created on : Apr 7, 2021, 4:50:08 PM
    Author     : engryankey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp" >
        <jsp:param name="title" value="Register" />
    </jsp:include>
    <body>
    <jsp:include page="navbar.jsp" >
        <jsp:param name="login" value="" />
        <jsp:param name="register" value="active" />
        <jsp:param name="home" value="" />
    </jsp:include>
    <center>
        <h1 class="head">REGISTER</h1>
        <div class="col-10 col-sm-8 col-md-6">
            <form action="Servlet" method="POST" class="row g-3">
                <div class="form-floating a col-md-6">
                    <input type="text" name="fname" value="${fname}" pattern="[A-Za-z]+" class="form-control pl" id="floatingInput" aria-describedby="emailHelp" placeholder="First Name" required>
                    <label for="floatingInput" id="h">First Name</label>
                </div>
                <div class="form-floating col-md-6">
                    <input type="text" name="lname" value="${lname}" pattern="[A-Za-z]+" class="form-control" id="floatingInput" aria-describedby="emailHelp" placeholder="Last Name" required>
                    <label for="floatingInput" id="h">Last Name</label>
                </div>
                <div class="form-floating ">
                    <input type="text" name="username" value="${username}" class="form-control ${u_form}" id="floatingInput" aria-describedby="emailHelp" placeholder="Username" required>
                    <label for="floatingInput" id="h">Choose Username</label>
                    <div class="error" align="left">
                        ${u_message}
                    </div>
                </div>
                <div class="form-floating ">
                    <input type="email" name="email" value="${email}" class="form-control ${e_form}" id="floatingInput" aria-describedby="emailHelp" placeholder="Email addresss" required>
                    <label for="floatingInput" id="h">Email Address</label>
                    <div class="error" align="left">
                        ${e_message}
                    </div>
                </div>
                <div class="form-floating col-md-6">
                    <input type="password" name="password1" class="form-control ${p_form}" id="floatingInput" aria-describedby="emailHelp" placeholder="Username" required>
                    <label for="floatingInput" id="h">Password</label>
                </div>
                <div class="form-floating col-md-6">
                    <input type="password" name="password2" class="form-control ${p2_form}" id="floatingPassword" placeholder="Password" required>
                    <label for="floatingPassword" id="h">Confirm Password</label>
                    <div class="error" align="left">
                        ${p2_message}
                    </div>
                </div>
                <div class="form-floating a col-md-2">
<!--                    <input type="text" name="fname" class="form-control pl" id="floatingInput" aria-describedby="emailHelp" placeholder="First Name" required>
                    <label for="floatingInput" id="h">First Name</label>-->
                </div>
                <div class="form-floating col-md-8">
                    <input type="password" name="admin" class="form-control" id="floatingInput" aria-describedby="emailHelp" placeholder="Admin">
                    <label for="floatingInput" id="h">Admin secret code</label>
                    <div id="passwordHelpBlock" class="form-text">
                        Leave empty if you're not an Administrator
                    </div>
                </div>
                <div class="form-floating a col-md-2">
<!--                    <input type="text" name="fname" class="form-control pl" id="floatingInput" aria-describedby="emailHelp" placeholder="First Name" required>
                    <label for="floatingInput" id="h">First Name</label>-->
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">REGISTER</button>
                    <input name="action" value="REGISTER" type="hidden">
                </div>
            </form>
        </div>
    </center>    
    <%@include file="footer.jsp" %>
</html>
