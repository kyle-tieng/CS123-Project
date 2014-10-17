/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Queenie Joy Te
 */
import java.sql.*;
public class CreateConnection {
    // defining driver name, mysql-jdbc driver in this case  
    private String driverName = "com.mysql.jdbc.Driver";  
    public static Connection connection = null;  
    
    // database url string with hostname and port on which db is running  
    private String url = "jdbc:mysql://localhost:3306/";  
    
    public Connection getConnection(String dbName, String username, String password) {
        // creating connection url  
        String connectionUrl = url + dbName;  

        try {  
            // registers the specified driver class into memory  
            Class.forName(driverName);  
        }
        catch (ClassNotFoundException e) {  
            e.printStackTrace();  
        }  

        try {
            // returns a connection objcet by selecting an appropriate driver  
            // for specified connection URL  
            connection = DriverManager.getConnection(connectionUrl, username, password);  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }  
        return connection;
    }  
}
