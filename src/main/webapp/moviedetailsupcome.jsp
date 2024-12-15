<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cinema</title>
    <link rel="stylesheet" type="text/css" href="CSS/style.css">
    <link rel="stylesheet" type="text/css" href="CSS/upcome.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<%
    String dbURL = "jdbc:mysql://localhost:3306/cinema";
    String username = "root";
    String password = "";
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    String query;
    String movieId = request.getParameter("movieId");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, username, password);
        statement = connection.createStatement();
        query = "SELECT * FROM movie_upcome WHERE id = " + movieId;
        resultSet = statement.executeQuery(query);
        if (resultSet.next()) {
            String movieTitle = resultSet.getString("title");
            String movieTrailer = resultSet.getString("trailer");
            String releaseDate = resultSet.getString("releaseDate");
            String movieType = resultSet.getString("movieType");
            String production = resultSet.getString("production");
            String casts = resultSet.getString("casts");
            String synopsis = resultSet.getString("synopsis");
            String poster = resultSet.getString("poster");
%>
<section id="upcomedetails">
    <div class="movie-details">
        <div class="movie-box">
            <div class="video-box">
                <iframe src="<%= movieTrailer %>" title="Movie Trailer" frameborder="0" 
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                        allowfullscreen></iframe>
                <div class="bot">
                    <div class="left">
                        <div class="kiri-1">
                            <p id="title"><%= movieTitle %></p>
                            <div class="lefter">
                                <p id="details"><%= releaseDate %> | <%= movieType %> | <%= production %></p>
                            </div>
                            <div class="lefter2">
                                <p id="casts"><%= casts %></p>
                            </div>
                        </div>
                    </div>
                    <div class="right">
                        <div class="righter">
                            <h2>Synopsis</h2>
                            <p><%= synopsis %></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%
        }
        resultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
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
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
