package com.movieapp.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.movieapp.model.Movie;

public class MovieDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/cinema";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    public String getConnectionStatus() {
        String message;
        try (Connection connection = getConnection()) {
            if (connection != null) {
                message = "Database connected successfully.";
            } else {
                message = "Database connection failed.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            message = "Database connection failed: " + e.getMessage();
        }
        return message;
    }

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            System.out.println("Database connection established.");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("Error: " + e.getMessage());
        }
        return connection;
    }

    public List<Movie> getAllNowPlayingMovies() {
        List<Movie> movies = new ArrayList<>();
        String query = "SELECT * FROM movie_nowplay";
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet rs = preparedStatement.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String trailer = rs.getString("trailer");
                String duration = rs.getString("duration");
                String rating = rs.getString("rating");
                String ageRating = rs.getString("ageRating");
                String synopsis = rs.getString("synopsis");
                movies.add(new Movie(id, title, trailer, duration, rating, ageRating, synopsis));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movies;
    }
}
