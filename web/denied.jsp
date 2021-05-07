<%-- 
    Document   : denied
    Created on : Apr 10, 2021, 8:44:20 PM
    Author     : engryankey
--%>

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
    <center>
        <br><br><br>
        <h1 class="display-4" style="color:red">You do not have access to this page</h1>
    </center>
    </body>
</html>
