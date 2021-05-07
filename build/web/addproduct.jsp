<%-- 
    Document   : addproduct
    Created on : Apr 10, 2021, 10:16:07 PM
    Author     : engryankey
--%>

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
        }
     %>
    <body>
    <jsp:include page="navbar.jsp" >
        <jsp:param name="login" value="" />
        <jsp:param name="register" value="" />
        <jsp:param name="home" value="" />
        <jsp:param name="dashboard" value="active" />
    </jsp:include>
        <div class="row">
            <div class="col-sm-4 toggleds" id="leftdash">
                <div align="center" class="dashimage">
                    <img src="img/dp.png" class="al" align="center">
                </div>
                <br>
                <div align="center">
                    <h3 class="head">${admin.getName()}</h3>
                    <span class="admin-badge"><strong>Admin</strong></span><br>
                    <strong>Member since</strong><br>
                    ${admin.getJoined()}
                    <br><br>
                </div>
            </div>
            <div class="col-sm-8" id="rightdash">
                <div class="row">
                        <div class="col-1"></div>
                        <div class="col-10">
                        <div>
                            <center>
                                <h4 class="head">Add a new cake</h4>
                            <form action="Products" method="POST" class="row g-3" enctype="multipart/form-data">
                                <div class="form-floating ">
                                    <input type="text" name="product_title" value="${product_title}" class="form-control ${pti_form}" id="floatingInput" aria-describedby="emailHelp" placeholder="Product title" required>
                                    <label for="floatingInput" id="h">Product title</label>
                                    <div class="error" align="left">
                                        ${pti_message}
                                    </div>
                                </div>
                                <div class="form-floating a col-md-6">
                                    <input type="text" name="price" value="${price}" onkeypress="return (event.charCode !== 8 && event.charCode === 0 || ( event.charCode === 46 || (event.charCode >= 48 && event.charCode <= 57)))" maxlength="7" class="form-control pl" id="floatingInput" aria-describedby="emailHelp" placeholder="Price (&#163;)" required>
                                    <label for="floatingInput" id="h">Price (&#163;)</label>
                                </div>
                                <div class="form-floating col-md-6">
                                    <input type="text" name="product_id" value="${product_id}" onkeypress="return (event.charCode !==8 && event.charCode ===0 || (event.charCode >= 48 && event.charCode <= 57))" maxlength="9" class="form-control ${pid_form}" id="floatingInput" aria-describedby="emailHelp" placeholder="Product ID" required>
                                    <label for="floatingInput" id="h">Product ID</label>
                                    <div class="error" align="left">
                                        ${pid_message}
                                    </div>
                                </div>
                                <div class="form-floating col-md-6">
                                    <select class="form-select" name="category" id="floatingSelect" aria-label="Cake category" required>
                                      <option disabled selected value>Select type of cake</option>
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
                                    <label for="floatingSelect" id="h">Select category</label>
                                </div>
                                <div class="form-floating col-md-6">
                                    <input type="text" name="quantity" onkeypress="return (event.charCode !== 8 && event.charCode === 0 || ( event.charCode === 46 || (event.charCode >= 48 && event.charCode <= 57)))" maxlength="7" class="form-control pl" id="floatingInput" aria-describedby="emailHelp" placeholder="Quantity" required>
                                    <label for="floatingInput" id="h">Total quantity in stock</label>
                                </div>
                                <div class="form-floating">
                                    <textarea class="form-control" name="product_description" placeholder="Product description" id="floatingTextarea" style="height: 100px" required>${product_description}</textarea>
                                    <label for="floatingTextarea" id="h">Product description</label>
                                </div>
                                <div class="mb-3">
                                    <input class="form-control form-control-lg" name="image" type="file" id="formFile" accept="image/png, image/jpeg" required>
                                    <div id="emailHelp" class="form-text" align="left">Upload an image of the product.</div>
                                </div>
                                <div class="form-floating d-grid gap-2">
                                    <!--<div class="d-grid gap-2">-->
                                        <button type="submit" class="btn btn-primary btn-lg"><i class="far fa-plus-square fa-1x"></i> ADD</button>
                                        <input name="action" value="ADD_PRODUCT" type="hidden">
                                    <!--</div>-->
                                </div>
                            </form>
                                <!--<div class="col-md-1"></div>-->
                                <br>
                            <form action="Servlet" method="GET">
                                <div class="form-floating d-grid gap-2">
                                    <!--<div class="d-grid gap-2">-->
                                        <button type="submit" class="btn btn-danger btn-lg"><i class="fas fa-window-close"></i> CANCEL</button>
                                        <input name="action" value="CANCEL_NOW" type="hidden">
                                    <!--</div>-->
                                </div>
                            </form>
                            </center>
                        </div>
                        
                        <div class="col-1"></div>
                    </div>
                </div>
            </div>
        </div>
    <jsp:include page="footer.jsp" />
</html>
