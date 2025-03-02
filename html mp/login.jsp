<%-- Import necessary Java classes --%>
<%@ page import="java.sql.*" %>

<%-- Database connection parameters --%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%!
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/project";
    String dbUsername = "root";
    String dbPassword = "";

    // Method to authenticate user
    boolean authenticateUser(String Email, String Password) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean authenticated = false;
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            
            // Establish connection to the database
            conn = DriverManager.getConnection(url, dbUsername, dbPassword);
            
            // Prepare SQL query to check user credentials
            String sql = "SELECT * FROM self WHERE Email=? AND Password=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1,Email);
            stmt.setString(2, Password);
            
            // Execute query
            rs = stmt.executeQuery();
            
            // If a row is returned, user is authenticated
            if (rs.next()) {
                authenticated = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return authenticated;
    }
%>