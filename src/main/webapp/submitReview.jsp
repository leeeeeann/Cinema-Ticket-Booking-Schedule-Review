<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/cinema";
    String dbUsername = "root";
    String dbPassword = "";
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    String movieId = request.getParameter("movieId");
    String userId = request.getParameter("userId");
    String rating = request.getParameter("rating");
    String feedback = request.getParameter("feedback");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
        String query = "INSERT INTO reviews (movie_id, user_id, rating, feedback) VALUES (?, ?, ?, ?)";
        preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, movieId);
        preparedStatement.setString(2, userId);
        preparedStatement.setString(3, rating);
        preparedStatement.setString(4, feedback);
        preparedStatement.executeUpdate();
        
        // Redirect to movie details page after successful submission
        response.sendRedirect("moviedetailsnowplay.jsp?movie=" + movieId);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (preparedStatement != null) preparedStatement.close();
        if (connection != null) connection.close();
    }
%>
