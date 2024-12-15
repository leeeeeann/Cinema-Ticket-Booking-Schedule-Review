<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/cinema";
    String dbUsername = "root";
    String dbPassword = "";
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    String query;

    String movieId = request.getParameter("movie");
    HttpSession sessions = request.getSession();
    String userId = (String) sessions.getAttribute("userId");
    boolean isLoggedIn = (userId != null);

    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
        statement = connection.createStatement();

        // Fetch movie details
        query = "SELECT * FROM movie_nowplay WHERE id=" + movieId;
        resultSet = statement.executeQuery(query);
        if (resultSet.next()) {
            String movieTitle = resultSet.getString("title");
            String trailer = resultSet.getString("trailer");
            String duration = resultSet.getString("duration");
            String rating = resultSet.getString("rating");
            String ageRating = resultSet.getString("ageRating");
            String synopsis = resultSet.getString("synopsis");
            // Set movie details in page context
            pageContext.setAttribute("movieTitle", movieTitle);
            pageContext.setAttribute("trailer", trailer);
            pageContext.setAttribute("duration", duration);
            pageContext.setAttribute("rating", rating);
            pageContext.setAttribute("ageRating", ageRating);
            pageContext.setAttribute("synopsis", synopsis);
        }
        resultSet.close();

        // Fetch reviews for this movie
        query = "SELECT reviews.*, users.username FROM reviews JOIN users ON reviews.user_id = users.id WHERE movie_id=" + movieId;
        resultSet = statement.executeQuery(query);
        List<Map<String, String>> reviews = new ArrayList<>();
        while (resultSet.next()) {
            Map<String, String> review = new HashMap<>();
            review.put("username", resultSet.getString("username"));
            review.put("rating", resultSet.getString("rating"));
            review.put("feedback", resultSet.getString("feedback"));
            review.put("created_at", resultSet.getString("created_at"));
            reviews.add(review);
        }
        pageContext.setAttribute("reviews", reviews);
        resultSet.close();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (statement != null) statement.close();
        if (connection != null) connection.close();
    }
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cinema</title>
    <link rel="stylesheet" type="text/css" href="CSS/style.css">
    <link rel="stylesheet" type="text/css" href="CSS/nowplay.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<section id="nowplaydetails">
    <div class="movie-details">
        <div class="movie-box">
            <div class="video-box">
                <iframe src="<%= pageContext.getAttribute("trailer") %>" title="Movie Trailer" frameborder="0" 
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                        allowfullscreen></iframe>
                <div class="bot">
                    <div class="left">
                        <div class="kiri-1">
                            <p id="title"><%= pageContext.getAttribute("movieTitle") %></p>
                            <div class="lefter">
                                <p id="details"><%= pageContext.getAttribute("duration") %> | <%= pageContext.getAttribute("rating") %> | <%= pageContext.getAttribute("ageRating") %></p>
                            </div>
                        </div>
                        <div class="kiri-2">
                            <button id="schedule">Check Schedule</button>
                        </div>
                    </div>
                    <div class="right">
                        <div class="righter">
                            <h2>Synopsis</h2>
                            <p><%= pageContext.getAttribute("synopsis") %></p>
                        </div>
                    </div>
                </div>
            </div>

            <% if (isLoggedIn) { %>
            <form id="reviewForm" method="post" action="submitReview.jsp">
                <input type="hidden" name="movieId" value="<%= movieId %>">
                <input type="hidden" name="userId" value="<%= userId %>">
                <label for="rating">Rating:</label>
                <select id="rating" name="rating" required>
                    <option value="1">1 Star</option>
                    <option value="2">2 Stars</option>
                    <option value="3">3 Stars</option>
                    <option value="4">4 Stars</option>
                    <option value="5">5 Stars</option>
                </select>
                <label for="feedback">Feedback:</label>
                <textarea id="feedback" name="feedback" required></textarea>
                <button type="submit" id="submit-review-button">Submit Review</button>
            </form>
            <% } else { %>
            <p>You need to <a href="login.jsp">log in</a> to submit a review.</p>
            <% } %>

            <div>
                <h2>Reviews</h2>
                <div id="reviews">
    <%
    List<Map<String, String>> reviewList = (List<Map<String, String>>) pageContext.getAttribute("reviews");
    
    reviewList.sort((r1, r2) -> r2.get("created_at").compareTo(r1.get("created_at")));
    
    for (Map<String, String> review : reviewList) {
        String username = review.get("username");
        String rating = review.get("rating");
        String feedback = review.get("feedback");
        String createdAt = review.get("created_at");
        
        out.println("<div class='review'>");
        out.println("<strong>" + username + "</strong> rated <strong>" + rating + "</strong> stars<br>");
        out.println(feedback + "<br>");
        out.println("<small>Reviewed on " + createdAt + "</small>");
        out.println("</div>");
    }
    %>
</div>

            </div>
        </div>
    </div>
</section>

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
