/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
/**
 *
 * @author engryankey
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {
    
    List<CartItem> cart = new ArrayList();
    List incart = new ArrayList();
    
    public void clearCart(){
        cart.clear();
        incart.clear();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        String p_quantity = request.getParameter("quantity");
        String total_price = request.getParameter("total_price");
        String total_items = request.getParameter("total_items");
        List products = (ArrayList) request.getSession().getAttribute("products");
        String customer = request.getParameter("customer");
        switch (action) {
            case "ADD_TO_CART":
                {
                    ProductModel product = new ProductModel();
                    for(int i=0; i<products.size(); i++){
                        product = (ProductModel)products.get(i);
                        if(product.getId() == Integer.parseInt(id)){
                            CartItem item = new CartItem();
                            item.setID(Integer.parseInt(id));
                            item.setProduct(product);
                            item.setQuantity(1);
                            cart.add(item);
                            incart.add(Integer.parseInt(id));
                            break;
                        }
                    }       
                    request.setAttribute("detail", product);
                    request.getSession().setAttribute("cart", cart);
                    request.getSession().setAttribute("incart", incart);
                    request.getSession().setAttribute("cart_size", cart.size());
                    RequestDispatcher dispatcher = request.getRequestDispatcher("productDetail.jsp");
                    dispatcher.forward(request, response);
                    break;
                }
            case "UPDATE_QUANTITY":
                {
                    int quantity = Integer.parseInt(p_quantity);
                    for(int i=0; i < cart.size(); i++){
                        CartItem item = (CartItem)cart.get(i);
                        if(item.getId() == Integer.parseInt(id)){
                            item.setQuantity(quantity);
                            break;
                        }
                    }       request.getSession().setAttribute("cart", cart);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("CartPage.jsp");
                    dispatcher.forward(request, response);
                    break;
                }
            case "REMOVE_FROM_CART":
                {
                    for(int i=0; i < cart.size(); i++){
                        CartItem item = (CartItem)cart.get(i);
                        if(item.getId() == Integer.parseInt(id)){
                            cart.remove(item);
                            break;
                        }
                    }       for(int i = 0; i < incart.size(); i++){
                        Object item = incart.get(i);
                        if(item.toString().equals(id)){
                            incart.remove(item);
                        }
                    }       request.getSession().setAttribute("cart", cart);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("CartPage.jsp");
                    dispatcher.forward(request, response);
                    break;
                }
            case "CHECKOUT":
                {
                    request.setAttribute("total_price", Integer.parseInt(total_price));
                    request.setAttribute("total_items", Integer.parseInt(total_items));
                    RequestDispatcher dispatcher = request.getRequestDispatcher("payment.jsp");
                    dispatcher.forward(request, response);
                    break;
                }
            case "PLACE_ORDER":
                String USERNAME = "root";
                String PASSWORD ="Jesse2019";
                String URL = "jdbc:mysql://localhost:3306/onlinestore?autoReconnect=true&useSSL=false";
                DateTimeFormatter dt = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
                DateTimeFormatter dt2 = DateTimeFormatter.ofPattern("MMM d, yyyy 'at' h:mm a");
                LocalDateTime now = LocalDateTime.now();
                String order_date = dt2.format(now);
                List ordered_items = new ArrayList();
                for(int i = 0; i < incart.size(); i++){
                    Object item = incart.get(i);
                    ordered_items.add(item.toString());
                }   
                Connection connect;
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                    Statement stmt = (Statement) connect.createStatement();
                    stmt.executeUpdate("INSERT INTO orders (order_number,items,customer,total_items,order_date,total_amount) VALUES ('"+dt.format(now)+"','"+String.join(", ", ordered_items)+"','"+customer+"','"+Integer.parseInt(total_items)+"','"+order_date+"',"+Integer.parseInt(total_price)+")");
                    for(int i = 0; i < cart.size(); i++){
                        CartItem item = cart.get(i);
                        String locate_command = "SELECT * FROM products WHERE id=?";
                        PreparedStatement pst_locate = (PreparedStatement) connect.prepareStatement(locate_command);
                        pst_locate.setInt(1, item.getId());
                        ResultSet res_locate = pst_locate.executeQuery();
                        if(res_locate.next()){
                            int initial_quantity = 0;
                            initial_quantity = res_locate.getInt("quantity");
                            int final_quantity = initial_quantity - item.getQuantity();
                            String update_command = "UPDATE products SET quantity=? WHERE id=?";
                            PreparedStatement pst_update = (PreparedStatement) connect.prepareStatement(update_command);
                            pst_update.setInt(1, final_quantity);
                            pst_update.setInt(2, item.getId());
                            int res_update = pst_update.executeUpdate();
                        } 
                    }
                    cart.clear();
                    incart.clear();
                    request.getSession().setAttribute("total_price", Integer.parseInt(total_price));
                    request.getSession().setAttribute("total_items", Integer.parseInt(total_items));
                    request.getSession().setAttribute("order_number", dt.format(now));
                    request.getSession().setAttribute("order_date", dt2.format(now));
                    RequestDispatcher dispatcher = request.getRequestDispatcher("thankyou.jsp");
                    dispatcher.forward(request, response);
                }catch (SQLException e){
                    PrintWriter out = response.getWriter();
                    out.println("err");
                    out.println(e);
                } catch (ClassNotFoundException ex) {
                    PrintWriter out = response.getWriter();
                    out.println("err2");
                    out.println(ex);
                }   
                break;
            default:
                break;
        }
    }

}
