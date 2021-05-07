/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

/**
 *
 * @author engryankey
 */
public class OrdersModel {
    private int id;
    private String order_number;
    private String items;
    private int total_items;
    private String customer;
    private String order_date;
    private int total_amount;
    
    
    public OrdersModel(int id, String order_number, String items, int total_items, String customer, String order_date, int total_amount) {
        this.id = id;
        this.order_number = order_number;
        this.items = items;
        this.total_items = total_items;
        this.customer = customer;
        this.order_date = order_date;
        this.total_amount = total_amount;
    }
    
    public OrdersModel() {
        
    }
    
    public int getId() {
        return id;
    }
    
    public String getOrdernumber() {
        return order_number;
    }
    
    public String getItems() {
        return items;
    }
    
    public int getTotalitems() {
        return total_items;
    }
    
    public String getCustomer() {
        return customer;
    }
    
    
    public String getOrderdate() {
        return order_date;
    }
    
    public int getTotalamount() {
        return total_amount;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public void setOrdernumber(String order_number) {
        this.order_number = order_number;
    }
    
    public void setItems(String items) {
        this.items = items;
    }
    
    public void setTotalitems(int total_items) {
        this.total_items = total_items;
    }
    
    public void setCustomer(String customer) {
        this.customer = customer;
    }
    
    public void setOrderdate(String order_date) {
        this.order_date = order_date;
    }
    
    public void setTotalamount(int total_amount) {
        this.total_amount = total_amount;
    }
}
