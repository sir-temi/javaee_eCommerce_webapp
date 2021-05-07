/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import static com.sun.xml.internal.ws.spi.db.BindingContextFactory.LOGGER;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author engryankey
 */
@WebServlet(name = "Products", urlPatterns = {"/Products"})
@MultipartConfig
public class Products extends HttpServlet {
    private final String USERNAME = "root";
    private final String PASSWORD ="Jesse2019";
    private final String URL = "jdbc:mysql://localhost:3306/onlinestore?autoReconnect=true&useSSL=false";
    
protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        String id = request.getParameter("id");
        switch (category) {
            case "detail":
                Connection connect;
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                    String command = "SELECT * FROM products WHERE id=?";
                    PreparedStatement pst = (PreparedStatement) connect.prepareStatement(command);
                    pst.setInt(1, Integer.parseInt(id));
                    ResultSet result = pst.executeQuery();
                    if (result.next()){
                        ProductModel product = new ProductModel();
                        product.setId(result.getInt("id"));
                        product.setPid(result.getInt("product_id"));
                        product.setPrice(result.getInt("price"));
                        product.setPdesc(result.getString("product_description"));
                        product.setPtitle(result.getString("product_title"));
                        product.setCategory(result.getString("category"));
                        product.setImage(result.getString("image"));
                        product.setQuantity(result.getInt("quantity"));
                        
                        request.setAttribute("detail", product);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("productDetail.jsp");
                        dispatcher.forward(request, response);
                    }
                    else{
                        PrintWriter write = response.getWriter();
                        write.print("No such product");
                    }
                }catch (SQLException | ClassNotFoundException e){
                    PrintWriter write = response.getWriter();
                    write.print(e);
                }
                break;
            case "all":
                {
                    request.setAttribute("command", "SELECT * FROM products order by id DESC");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
                    dispatcher.forward(request, response);
                    break;
                }
            default:
                {
                    String command = categoryCommand(category);
                    request.setAttribute("command", command);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
                    dispatcher.forward(request, response);
                    break;
                }
            }
        }
    
    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
    
    private String categoryCommand(final String command){
        return String.format("SELECT * FROM products WHERE category='%s' order by id DESC", command);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        String product_title = request.getParameter("product_title");
        float price = Float.parseFloat(request.getParameter("price"));
        int product_id = Integer.parseInt(request.getParameter("product_id"));
        String category = request.getParameter("category");
        String product_description = request.getParameter("product_description");
        final Part filePart = request.getPart("image");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        if(action.equals("ADD_PRODUCT")){
            DateTimeFormatter dt = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");  
            LocalDateTime now = LocalDateTime.now();  
            String path = "C:/Users/sirto/OneDrive/Documents/NetBeansProjects/OnlineStore/web/img/uploaded";
            String filename = (String) getFileName(filePart);
            String fileName;
            if(filename.length()<1){
                fileName = null;
            }else{
               fileName = dt.format(now)+filename;
            }
            OutputStream out;
            InputStream filecontent;
            
            out = new FileOutputStream(new File(path + File.separator
                + fileName));
            filecontent = filePart.getInputStream();
//
            int read = 0;
            final byte[] bytes = new byte[1024];

            while ((read = filecontent.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
            
            Connection connect;
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                String command_pid = "SELECT * FROM products WHERE product_id=?";
                String command_pti = "SELECT * FROM products WHERE product_title=?";
                PreparedStatement pst_pid = (PreparedStatement) connect.prepareStatement(command_pid);
                PreparedStatement pst_pti = (PreparedStatement) connect.prepareStatement(command_pti);
                pst_pid.setInt(1, product_id);
                pst_pti.setString(1, product_title);
                ResultSet res_pid = pst_pid.executeQuery();
                ResultSet res_pti = pst_pti.executeQuery();
                if(res_pid.next()){
                    request.setAttribute("product_title", product_title);
                    request.setAttribute("product_id", product_id);
                    request.setAttribute("price", price);
                    request.setAttribute("category", category);
                    request.setAttribute("product_description", product_description);
                    request.setAttribute("pid_message", "Product ID exists, choose another.");
                    request.setAttribute("pid_form", "red");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("addproduct.jsp");
                    dispatcher.forward(request, response);
                }else if(res_pti.next() ){
                    request.setAttribute("product_title", product_title);
                    request.setAttribute("product_id", product_id);
                    request.setAttribute("price", price);
                    request.setAttribute("category", category);
                    request.setAttribute("product_description", product_description);
                    request.setAttribute("pti_message", "There's already a product with this title.");
                    request.setAttribute("pti_form", "red");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("addproduct.jsp");
                    dispatcher.forward(request, response);
                }else{
                    Statement stmt = (Statement) connect.createStatement();
                    stmt.executeUpdate("INSERT INTO products (product_id,product_title,price,category,product_description,image,quantity) VALUES ('"+product_id+"','"+product_title+"','"+price+"','"+category+"','"+product_description+"','"+fileName+"','"+quantity+"')");
                    request.setAttribute("alert", "yes");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("admindashboard.jsp");
                    dispatcher.forward(request, response);
                }
                connect.close();
            }catch (SQLException | ClassNotFoundException e){
                PrintWriter write = response.getWriter();
                write.print(e);
            }
        }
    }
}
