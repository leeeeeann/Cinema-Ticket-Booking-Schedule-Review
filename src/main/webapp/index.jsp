<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/cinema";
    String username = "root";
    String password = "";
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    String query;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, username, password);
        statement = connection.createStatement();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cinema</title>
    <link rel="stylesheet" type="text/css" href="CSS/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="JS/script.js" defer></script>
</head>
<body>
    <jsp:include page="header.jsp" />
   <jsp:include page="views/slider.jsp" />
    <section id="nowplaying">
        <div class="textnowplay">
            <h2>NOW PLAYING IN CINEMA</h2>
        </div>
        <div class="movieplaying">
            <%
                query = "SELECT * FROM movie_nowplay";
                resultSet = statement.executeQuery(query);
                while (resultSet.next()) {
                    String movieId = resultSet.getString("id");
                    String movieTitle = resultSet.getString("title");
                    String movieImage = resultSet.getString("poster");
            %>
            <div class="movie" data-movie="<%= movieId %>">
                <a href="moviedetailsnowplay.jsp?movie=<%= movieId %>" class="movie-link"><img src="<%= movieImage %>" alt="<%= movieTitle %>"></a>
                <p><%= movieTitle %></p>
            </div>
            <%
                }
                resultSet.close();
            %>
        </div>
    </section>
    
    <section id="upcoming">
        <div class="textupcome">
            <h2>COMING SOON IN CINEMA</h2>
        </div>
        <div class="upcoming">
            <%
                query = "SELECT * FROM movie_upcome";
                resultSet = statement.executeQuery(query);
                while (resultSet.next()) {
                    String movieId = resultSet.getString("id");
                    String movieTitle = resultSet.getString("title");
                    String movieImage = resultSet.getString("poster");
            %>
            <div class="movie" data-movie="<%= movieId %>">
                <a href="moviedetailsupcome.jsp?movieId=<%= movieId %>" class="movie-link"><img src="<%= movieImage %>" alt="<%= movieTitle %>"></a>
                <p><%= movieTitle %></p>
            </div>
            <%
                }
                resultSet.close();
            %>
        </div>
    </section>

    <jsp:include page="views/theaters.jsp" />

    <section id="privacy-policy" class="popup-form hide">
        <div class="popup-content">
            <span class="close-btn">&times;</span>
            <h2>Privacy Policy</h2>
            <h4>INFORMATION WE COLLECT
                PERSONAL INFORMATION
                Personal Information may be submitted to NSR for the purposes of <br>
                (a) receiving information from us;<br>
                (b) buy movie ticket through Site; and <br>
                (c) other purposes to support Service through Site. 
                </h4>
        </div>
    </section>

    <section id="contact-us">
        <div class="contact-us">
        <p>Cinema</p>
        <p>Best Web For Movie Lovers In Indonesia! Movie Entertainment Platform From Cinema To Online Movie Streaming Selections. - For more information, Please support us with follow this link bellow:</p>
        <div class="social">
            <a href="#"><i class="fa-brands fa-linkedin"></i></a>
            <a href="#"><i class="fa-brands fa-instagram"></i></a>
            <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
        </div>
    </div>
    </section>
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>