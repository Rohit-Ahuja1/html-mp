<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration Result</title>
</head>
<body>

    <%
        String Name = request.getParameter("Name");
        String Email = request.getParameter("Email");
        String Password = request.getParameter("Password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if(Password!=null){
            if(Password.equals(confirmPassword)){

            String jdbcUrl = "jdbc:mysql://localhost:3306/project";
            String dbUser = "root";
            String dbPassword = "";

            Connection connection = null;
            PreparedStatement preparedStatement = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                String query = "INSERT INTO self (Name, Email, Password) VALUES (?, ?, ?)";
                preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, Name);
                preparedStatement.setString(2, Email);
                preparedStatement.setString(3, Password);

                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<p>Registration successful! Welcome, " + Name + ".</p>");
                } else {
                    out.println("<p>Registration failed. Please try again later.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Database error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (preparedStatement != null) preparedStatement.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            out.println("<p>Passwords do not match. Please try again.</p>");
        }
        }
        
    %>

    <p>Return to <a href="index.html">Login Page</a></p>
</body>
</html>