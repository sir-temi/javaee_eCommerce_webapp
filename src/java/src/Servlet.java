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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

/**
 *
 * @author engryankey
 */
@WebServlet(name = "Servlet", urlPatterns = {"/Servlet"})
public class Servlet extends HttpServlet {
    private final String USERNAME = "root";
    private final String PASSWORD ="Jesse2019";
    private final String URL = "jdbc:mysql://localhost:3306/onlinestore?autoReconnect=true&useSSL=false";

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action.equals("ADD_PRODUCT")){
            response.sendRedirect("addproduct.jsp");
        }else if(action.equals("CANCEL_NOW")){
            response.sendRedirect("admindashboard.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        if(action.equals("LOGIN")){
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            try{
                Connection connect;
                Class.forName("com.mysql.cj.jdbc.Driver");
                connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                String command = "SELECT * FROM users WHERE username=? and password=?";
                PreparedStatement pst = (PreparedStatement) connect.prepareStatement(command);
                pst.setString(1, username.toLowerCase());
                pst.setString(2, password);
                ResultSet res = pst.executeQuery();
                if (res.next()) {
                    User user;
                    user = new User();
                    user.setFname(res.getString("fname"));
                    user.setLname(res.getString("lname"));
                    user.setEmail(res.getString("email"));
                    user.setUsername(username);
                    user.setAdmin(res.getInt("admin"));
                    user.setJoined(res.getTimestamp("joined"));
                    HttpSession session = request.getSession();
                    if(user.getStatus()){
                        session.setAttribute("admin", user);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("admindashboard.jsp");
                        dispatcher.forward(request, response);
                    }else{
                        List<CartItem> cart = new ArrayList();
                        List incart = new ArrayList();
                        session.setAttribute("user", user);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
                        dispatcher.forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Your username and password combination is incorrect");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                    dispatcher.forward(request, response);
                }
                connect.close();
                }catch (SQLException e){
                    out.println("err");
                    out.println(e);
                } catch (ClassNotFoundException ex) {
                    out.println("err2");
                    out.println(ex);
                }
        }else if(action.equals("REGISTER")){
                String fname = request.getParameter("fname");
                String lname = request.getParameter("lname");
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password1");
                String password2 = request.getParameter("password2");
                Date dt = new Date();
                Timestamp joined = new Timestamp(dt.getTime()); 
                String adm = request.getParameter("admin");
                int ad = 0;
                if(adm != null && adm.equals("Jesse2019")){
                    ad = 1;
                }
//                myDB dB = new myDB();
//                Connection connect = dB;
                if(!password.equals(password2)){
                    request.setAttribute("fname", fname);
                    request.setAttribute("lname", lname);
                    request.setAttribute("username", username);
                    request.setAttribute("email", email);
                    request.setAttribute("p_form", "red");
                    request.setAttribute("p2_message", "Passwords don't match");
                    request.setAttribute("p2_form", "red");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("registration.jsp");
                    dispatcher.forward(request, response);
                }else{
                    Connection connect;
                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                        String command_username = "SELECT * FROM users WHERE username=?";
                        String command_email = "SELECT * FROM users WHERE email=?";
                        PreparedStatement pst_username = (PreparedStatement) connect.prepareStatement(command_username);
                        PreparedStatement pst_email = (PreparedStatement) connect.prepareStatement(command_email);
                        pst_username.setString(1, username.toLowerCase());
                        pst_email.setString(1, email);
                        ResultSet res_username = pst_username.executeQuery();
                        ResultSet res_email = pst_email.executeQuery();
                        if (res_email.next() & res_username.next()) {
                            request.setAttribute("e_message", "The email has been used on here.");
                            request.setAttribute("e_form", "red");
                            request.setAttribute("u_message", "The username is not available, please choose another.");
                            request.setAttribute("u_form", "red");
                            RequestDispatcher dispatcher = request.getRequestDispatcher("registration.jsp");
                            dispatcher.forward(request, response);
                        }else if(res_username.next()){
                            request.setAttribute("u_message", "The username is not available, please choose another.");
                            request.setAttribute("u_form", "red");
                            RequestDispatcher dispatcher = request.getRequestDispatcher("registration.jsp");
                            dispatcher.forward(request, response);
                        }else if(res_email.next() ){
                            request.setAttribute("e_message", "The email has been used on here.");
                            request.setAttribute("e_form", "red");
                            RequestDispatcher dispatcher = request.getRequestDispatcher("registration.jsp");
                            dispatcher.forward(request, response);
                        }else{
                            Statement stmt = (Statement) connect.createStatement();
                            stmt.executeUpdate("INSERT INTO users (fname,lname,username,email,password,admin,joined) VALUES ('"+fname+"','"+lname+"','"+username+"','"+email+"','"+password+"',"+ad+",'"+joined+"')");
                            response.sendRedirect("welcome.jsp");
                        }
                    }catch (SQLException e){
                        out.println("err");
                        out.println(e);
                    } catch (ClassNotFoundException ex) {
                        out.println("err2");
                        out.println(ex);
                    }
                }
                
            }
        }
    }
