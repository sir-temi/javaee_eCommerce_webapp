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
public class CartItem {
    private int id;
    private int quantity;
    private ProductModel product;
    
    public CartItem(int id, int quantity, ProductModel product) {
        this.id = id;
        this.quantity = quantity;
        this.product = product;
    }

   public CartItem() {
        
    }
   
   public int getId(){
        return id;
    }
   
   public ProductModel getProduct(){
        return product;
    }
   
   public int getQuantity(){
        return quantity;
    }
   
   
   public void setID(int id){
       this.id = id;
   }
   
   public void setProduct(ProductModel product){
       this.product = product;
   }
   
   public void setQuantity(int n){
       this.quantity = n;
   }
   
   
}
