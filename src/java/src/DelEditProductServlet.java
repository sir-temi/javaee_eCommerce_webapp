/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author engryankey
 */
@WebServlet(name = "DelEditProductServlet", urlPatterns = {"/DelEditProductServlet"})
public class DelEditProductServlet extends HttpServlet {
    private final String USERNAME = "root";
    private final String PASSWORD ="Jesse2019";
    private final String URL = "jdbc:mysql://localhost:3306/onlinestore?autoReconnect=true&useSSL=false";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
      
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));
        String product_title = request.getParameter("product_title");
        String p_price = request.getParameter("price");
        String p_id = request.getParameter("product_id");
        String category = request.getParameter("category");
        String product_description = request.getParameter("product_description");
        String p_quantity = request.getParameter("quantity");
        Connection connect;
        switch (action) {
            case "DELETE_PRODUCT":
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                    String command = "DELETE FROM PRODUCTS WHERE id=?";
                    PreparedStatement pst = (PreparedStatement) connect.prepareStatement(command);
                    pst.setInt(1, id);
                    int res = pst.executeUpdate();
                    if(res > 0){
                        request.setAttribute("alert", "yes");
                        request.setAttribute("type", "DELETED");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("admindashboard.jsp");
                        dispatcher.forward(request, response);
                    }else{
                        request.setAttribute("alert", "no");
                        request.setAttribute("type", "DELETING");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("admindashboard.jsp");
                        dispatcher.forward(request, response);
                    }
                    connect.close();
                }catch (SQLException | ClassNotFoundException e){
                    PrintWriter write = response.getWriter();
                    write.print(e);
                }   break;
            case "UPDATE_PRODUCT":
                float price = Float.parseFloat(p_price);
                int quantity = Integer.parseInt(p_quantity);
                int product_id = Integer.parseInt(p_id);
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                    String command = "UPDATE products SET product_title=?, price=?, product_id=?, category=?, quantity=?, product_description=?  WHERE id=?";
                    PreparedStatement pst = (PreparedStatement) connect.prepareStatement(command);
                    pst.setString(1, product_title);
                    pst.setFloat(2, price);
                    pst.setInt(3, product_id);
                    pst.setString(4, category);
                    pst.setInt(5, quantity);
                    pst.setString(6, product_description);
                    pst.setInt(7, id);
                    int res = pst.executeUpdate();
                    if(res > 0){
                        request.setAttribute("alert", "yes");
                        request.setAttribute("type", "UPDATED");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("admindashboard.jsp");
                        dispatcher.forward(request, response);
                    }else{
                        request.setAttribute("alert", "no");
                        request.setAttribute("type", "UPDATING");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("admindashboard.jsp");
                        dispatcher.forward(request, response);                }
                    connect.close();
                }catch (SQLException | ClassNotFoundException e){
                    PrintWriter write = response.getWriter();
                    write.print(e);
                }   break;
            case "UPDATE_FORM":
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                    String command = "SELECT * FROM products WHERE id=?";
                    PreparedStatement pst = (PreparedStatement) connect.prepareStatement(command);
                    pst.setInt(1, id);
                    ResultSet res = pst.executeQuery();
                    if(res.next()){
                        request.setAttribute("id", id);
                        request.setAttribute("product_title", res.getString("product_title"));
                        request.setAttribute("product_id", res.getString("product_id"));
                        request.setAttribute("price", res.getInt("price"));
                        request.setAttribute("category", res.getString("category"));
                        request.setAttribute("product_description", res.getString("product_description"));
                        request.setAttribute("quantity", res.getString("quantity"));
                        RequestDispatcher dispatcher = request.getRequestDispatcher("updateproduct.jsp");
                        dispatcher.forward(request, response);
                    }
                    connect.close();
                }catch (SQLException | ClassNotFoundException e){
                    PrintWriter write = response.getWriter();
                    write.print(e);
                }   break;
            default:
                break;
        }
    }
}
