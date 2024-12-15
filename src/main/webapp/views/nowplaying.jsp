<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.movieapp.model.*, com.movieapp.servlet.*, com.movieapp.dao.*, com.mysql.jdbc.Driver" %>
<!DOCTYPE html>
<html>
<head>
    <title>Now Playing Movies</title>
</head>
<body>
<h1>Now Playing Movies</h1>
<%
    String connectionStatus = (String) request.getAttribute("connectionStatus");
    out.println("<p>Connection Status: " + connectionStatus + "</p>");

    @SuppressWarnings("unchecked")
    List<Movie> movies = (List<Movie>) request.getAttribute("movies");
    if (movies != null && !movies.isEmpty()) {
        out.println("Movies List Size: " + movies.size() + "<br>");
        for (Movie movie : movies) {
%>
    <h2><%= movie.getTitle() %></h2>
    <p>Duration: <%= movie.getDuration() %></p>
    <p>Rating: <%= movie.getRating() %></p>
    <p>Age Rating: <%= movie.getAgeRating() %></p>
    <p>Synopsis: <%= movie.getSynopsis() %></p>
<%
        }
    } else {
        out.println("No movies are currently playing.<br>");
    }
%>
</body>
</html>
