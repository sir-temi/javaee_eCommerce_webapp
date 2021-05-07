/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
/**
 *
 * @author engryankey
 */
public class User {
    private int id;
    private String fname;
    private String lname;
    private String username;
    private String email;
    private int admin;
    private Timestamp joined;

    public User() {
    }

    public User(
            int id, String fname, String lname, String username, 
            String email, int admin, Timestamp joined) {
        this.id = id;
        this.fname = fname;
        this.lname = lname;
        this.username = username;
        this.email = email;
        this.admin = admin;
        this.joined = joined;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFname() {
        return fname;
    }
    
    public String getLname() {
        return lname;
    }
    
    public String getName() {
        String f1 = Character.toString(
                Character.toUpperCase(fname.toLowerCase().charAt(0))
        );
        String l1 = Character.toString(
                Character.toUpperCase(lname.toLowerCase().charAt(0))
        );
        
        return f1+fname.toLowerCase().substring(1)+" "+l1+lname.toLowerCase().substring(1);
    }
    
    public String getUsername() {
        return username;
    }
    
    public String getEmail() {
        return email;
    }
    
    public boolean getStatus() {
        if (admin == 1) {
            return true;
        } else {
            return false;
        }
    }
    
    public String getJoined() {
        return new SimpleDateFormat("MMMMM d, yyyy").format(joined);
    }
    
    public void setFname(String fname) {
        this.fname = fname;
    }
    
    public void setLname(String lname) {
        this.lname = lname;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }

    public void setAdmin(int admin) {
        this.admin = admin;
    }
    
    public void setJoined(Timestamp joined) {
        this.joined = joined;
    } 
}