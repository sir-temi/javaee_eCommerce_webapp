<%-- 
    Document   : welcome
    Created on : Apr 8, 2021, 2:36:59 PM
    Author     : engryankey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp" >
        <jsp:param name="title" value="Welcome" />
    </jsp:include>
    <body>
    <jsp:include page="navbar.jsp" >
        <jsp:param name="login" value="" />
        <jsp:param name="register" value="active" />
        <jsp:param name="home" value="" />
    </jsp:include>
    <center>
        <h3 class="head">Thank you for creating an account</h3>
        <a href="login.jsp"><h4>LOG IN</h4></a>
    </center>
    </body>
</html>
