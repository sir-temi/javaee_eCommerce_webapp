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
public class ProductModel {
    private int id;
    private int product_id;
    private String product_title;
    private int price;
    private String category;
    private String product_description;
    private String image;
    private int quantity;


    public ProductModel(int id, int product_id, String product_title, int price, String category, String product_description, String image, int quantity) {
        this.id = id;
        this.product_id = product_id;
        this.product_title = product_title;
        this.price = price;
        this.category = category;
        this.product_description = product_description;
        this.image = image;
        this.quantity = quantity;
    }

   public ProductModel() {
        
    }

    public int getId() {
        return id;
    }
    
    public int getPid() {
        return product_id;
    }
    
    public String getPtitle() {
        return product_title;
    }
    
    public String getPrice() {
        return Integer.toString(price);
    }
    
    
    public String getCategory() {
        return category;
    }
    
    public String getPdesc() {
        return product_description;
    }
    
    public String getShortPdesc(){
        if(product_description.length() > 100){
            return product_description.substring(0, 99)+" ... ";
        }else{
            return product_description;
        }
    }
    
    public String getImage() {
        return image;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public void setPid(int product_id) {
        this.product_id = product_id;
    }
    
    public void setPtitle(String product_title) {
        this.product_title = product_title;
    }
    
    public void setPrice(int price) {
        this.price = price;
    }
    
    public void setCategory(String category) {
        switch (category) {
            case "butter_cake":
                this.category = "Butter Cake";
                break;
            case "pound_cake":
                this.category = "Pound Cake";
                break;
            case "sponge_cake":
                this.category = "Sponge Cake";
                break;
            case "genoise_cake":
                this.category = "Genoise Cake";
                break;
            case "biscuit_cake":
                this.category = "Biscuit Cake";
                break;
            case "ange_food_cake":
                this.category = "Angel Food Cake";
                break;
            case "chiffon_cake":
                this.category = "Chiffon Cake";
                break;
            case "baked_flourless_cake":
                this.category = "Baked Flourless Cake";
                break;
            case "unbaked_flourless_cake":
                this.category = "Unbaked Flourless Cake";
                break;
            case "carrot_cake":
                this.category = "Carrot Cake";
                break;
            case "red_valvet_cake":
                this.category = "Red Velvet Cake";
                break;
            default:
                break;
        }
    }
    
    public void setPdesc(String product_description) {
        this.product_description = product_description;
    }
    
    public void setImage(String image) {
        this.image = image;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}
