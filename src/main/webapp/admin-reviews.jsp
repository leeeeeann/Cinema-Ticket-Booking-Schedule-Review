<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/cinema";
    String dbUsername = "root";
    String dbPassword = "";
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    String query;
    List<Map<String, String>> reviews = new ArrayList<>();
    int reviewsPerPage = 4;
    int currentPage = 1;
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }
    int offset = (currentPage - 1) * reviewsPerPage;

    String searchQuery = "";
    if (request.getParameter("search") != null) {
        searchQuery = request.getParameter("search").trim();
    }

    // Handle form submission for Add, Edit, and Delete operations
    String action = request.getParameter("action");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

        if (action != null) {
            if (action.equals("add")) {
                String user_id = request.getParameter("user_id");
                String movie_id = request.getParameter("movie_id");
                String rating = request.getParameter("rating");
                String feedback = request.getParameter("feedback");
                String created_at = request.getParameter("created_at");

                query = "INSERT INTO reviews (user_id, movie_id, rating, feedback, created_at) VALUES (?, ?, ?, ?, ?)";
                statement = connection.prepareStatement(query);
                statement.setString(1, user_id);
                statement.setString(2, movie_id);
                statement.setString(3, rating);
                statement.setString(4, feedback);
                statement.setString(5, created_at);
                statement.executeUpdate();
            } else if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                String user_id = request.getParameter("user_id");
                String movie_id = request.getParameter("movie_id");
                String rating = request.getParameter("rating");
                String feedback = request.getParameter("feedback");
                String created_at = request.getParameter("created_at");

                query = "UPDATE reviews SET user_id=?, movie_id=?, rating=?, feedback=?, created_at=? WHERE id=?";
                statement = connection.prepareStatement(query);
                statement.setString(1, user_id);
                statement.setString(2, movie_id);
                statement.setString(3, rating);
                statement.setString(4, feedback);
                statement.setString(5, created_at);
                statement.setInt(6, id);
                statement.executeUpdate();
            } else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                query = "DELETE FROM reviews WHERE id=?";
                statement = connection.prepareStatement(query);
                statement.setInt(1, id);
                statement.executeUpdate();
            }
        }

        // Fetch all reviews to display in the table
        String searchCondition = searchQuery.isEmpty() ? "" : " WHERE rating LIKE ?";
        query = "SELECT * FROM reviews" + searchCondition + " LIMIT ?, ?";
        statement = connection.prepareStatement(query);
        if (!searchQuery.isEmpty()) {
            statement.setString(1, "%" + searchQuery + "%");
            statement.setInt(2, offset);
            statement.setInt(3, reviewsPerPage);
        } else {
            statement.setInt(1, offset);
            statement.setInt(2, reviewsPerPage);
        }
        resultSet = statement.executeQuery();

        while (resultSet.next()) {
            Map<String, String> review = new HashMap<>();
            review.put("id", resultSet.getString("id"));
            review.put("user_id", resultSet.getString("user_id"));
            review.put("movie_id", resultSet.getString("movie_id"));
            review.put("rating", resultSet.getString("rating"));
            review.put("feedback", resultSet.getString("feedback"));
            review.put("created_at", resultSet.getString("created_at"));
            reviews.add(review);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
        if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }

    // Get total number of reviews for pagination
int totalReviews = 0;
String searchCondition = searchQuery.isEmpty() ? "" : " WHERE rating LIKE ?";
try {
    Class.forName("com.mysql.jdbc.Driver");
    connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
    query = "SELECT COUNT(*) AS total FROM reviews" + searchCondition;
    statement = connection.prepareStatement(query);
    if (!searchQuery.isEmpty()) {
        statement.setString(1, "%" + searchQuery + "%");
    }
    resultSet = statement.executeQuery();
    if (resultSet.next()) {
        totalReviews = resultSet.getInt("total");
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
    if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
    if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
}


    int totalPages = (int) Math.ceil((double) totalReviews / reviewsPerPage);
%>
<%
    HttpSession sessions = request.getSession();
    String role = (String) sessions.getAttribute("role");

    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("index.jsp");
    }
%>
	<!DOCTYPE html>
	<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Nowplaying - Manage</title>
	    <style>
	        :root {
	            --primary-color: rgb(255, 0, 85);
	            --secondary-color: rgb(105, 18, 47);
	            --accent-color: #00adb5;
	            --neutral-color: #ffffff;
	            --neutral-color-50: rgba(255, 255, 255, 0.5);
	          }
	          
	          * {
	            padding: 0;
	            margin: 0;
	            box-sizing: border-box;
	            scroll-behavior: smooth;
	            outline: none;
	            border: none;
	            text-decoration: none;
	            font-family: "Poppins", sans-serif;
	          }
	          
	          ::-webkit-scrollbar {
	            height: 0;
	            width: 0;
	          }
	          
	          /* Navbar */
	          .navbar {
	            display: flex;
	            justify-content: space-between;
	            align-items: center;
	            padding: 2rem 2%;
	            background-color: var(--primary-color);
	            border-bottom: 1px solid var(--secondary-color);
	            position: fixed;
	            top: 0;
	            left: 0;
	            right: 0;
	            z-index: 9999;
	            color: var(--neutral-color);
	          }
	          
	          .navbar-logo a {
	            font-family: "Playfair Display", serif;
	            font-size: 2.6rem;
	            font-weight: 700;
	            color: var(--neutral-color);
	            font-style: italic;
	          }
	          
	          .navbar-logo a span {
	            font-weight: normal;
	            margin: auto 0;
	          }
	          
	          .navbar > div:last-child {
	            font-size: 1.4rem;
	            font-weight: normal;
	            cursor: pointer;
	          }
	          
	          aside {
	            bottom: 0;
	            min-height: 100vh;
	            width: 15%;
	            position: absolute;
	            padding: 10rem 2% 2rem;
	            background-color: var(--secondary-color);
	            position: fixed;
	          }
	          
	          .aside-inner {
	            padding: 1rem 0;
	          }
	          
	          .aside-inner a {
	            font-size: 1.6rem;
	            color: var(--neutral-color);
	          }
	
	          section {
	            min-height: 100vh;
	            width: 100%;
	            padding: 10rem 2% 6rem 17%;
	            background-color: var(--neutral-color);
	          } 
	          
	          .container {
	            width: 100%;
	            margin: 0 auto;
	            padding: 2rem;
	            background-color: #fff;
	            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	        }
	        h1, h2 {
	            text-align: center;
	        }
	        table {
	            width: 100%;
	            border-collapse: collapse;
	            margin-bottom: 20px;
	        }
	        table, th, td {
	            border: 1px solid #ddd;
	        }
	        th, td {
	            padding: 10px;
	            text-align: center;
	        }
	        th {
	            background-color: #f2f2f2;
	        }
	        button {
	            padding: 10px 15px;
	            background-color: #5cb85c;
	            color: #fff;
	            border: none;
	            cursor: pointer;
	        }
	        button:hover {
	            background-color: #4cae4c;
	        }
	        #formContainer {
	            display: none;
	            background-color: #f9f9f9;
	            padding: 20px;
	            border: 1px solid #ddd;
	            margin-top: 20px;
	        }
	        label {
	            display: block;
	            margin-bottom: 5px;
	        }
	        input, textarea {
	            width: 100%;
	            padding: 10px;
	            margin-bottom: 10px;
	            border: 1px solid #ddd;
	            border-radius: 5px;
	        }
	        .pagination {
	            text-align: center;
	            margin-top: 20px;
	        }
	        .pagination a {
	            color: #333;
	            padding: 10px 15px;
	            text-decoration: none;
	            border: 1px solid #ddd;
	            margin: 0 2px;
	        }
	        .pagination a.active {
	            background-color: #5cb85c;
	            color: #fff;
	            border: 1px solid #5cb85c;
	        }
	        .pagination a:hover {
	            background-color: #4cae4c;
	            color: #fff;
	        }
	    </style>
	</head>
	<body>
	    <header>
	        <nav class="navbar">
	          <div class="navbar-logo">
	            <a href=".admin.jsp#">Cinema Dashboard</a>
	          </div>
	  
	          <div>
		          <p>Welcome, <%= sessions.getAttribute("username") %>!</p>
		        </div>
	        </nav>
	        <aside>
	          <div class="aside-wrap">
	            <div class="aside-inner">
	              <a href="admin.jsp">Main Dashboard</a>
	            </div>
	            <div class="aside-inner">
	              <a href="admin-nowplay.jsp">Nowplay Movies</a>
	            </div>
	            <div class="aside-inner">
	              <a href="admin-upcome.jsp">Upcoming Movies</a>
	            </div>
	            <div class="aside-inner">
	              <a href="admin-reviews.jsp">Movie Reviews</a>
	            </div>
	            <div class="aside-inner">
	              <a href="admin-theaters.jsp">Theaters</a>
	            </div>
	            <div class="aside-inner">
	              <a href="admin-user.jsp">User Management</a>
	            </div>
	          </div>
	        </aside>
	      </header>
	       <main>
	        <section>
	<div class="container">
	                <h1>Reviews Table</h1>
	                <form method="get" action="">
	                    <input type="text" name="search" placeholder="Search by rating" value="<%= searchQuery %>" />
	                    <button type="submit">Search</button>
	                </form>
	                <table id="movieTable">
	                    <thead>
	                        <tr>
	                            <th>ID</th>
	                            <th>User ID</th>
	                            <th>Movie ID</th>
	                            <th>Rating</th>
	                            <th>Feedback</th>
	                            <th>Created At</th>
	                            <th>Actions</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <% for (Map<String, String> review : reviews) { %>
	                            <tr>
	                                <td><%= review.get("id") %></td>
	                                <td><%= review.get("user_id") %></td>
	                                <td><%= review.get("movie_id") %></td>
	                                <td><%= review.get("rating") %></td>
	                                <td><%= review.get("feedback") %></td>
	                                <td><%= review.get("created_at") %></td>
	                                <td>
	                                    <button onclick="editMovie('<%= review.get("id") %>', '<%= review.get("user_id") %>', '<%= review.get("movie_id") %>', '<%= review.get("rating") %>', '<%= review.get("feedback") %>', '<%= review.get("created_at") %>')">Edit</button>
	                                    <button onclick="deleteMovie('<%= review.get("id") %>')">Delete</button>
	                                </td>
	                            </tr>
	                        <% } %>
	                    </tbody>
	                </table>
	                <button onclick="showAddForm()">Manage Review</button>
	                <button type="button" onclick="hideForm()">Cancel</button>
	                
	                <!-- Pagination Controls -->
	                <div class="pagination">
	                    <% for (int i = 1; i <= totalPages; i++) { %>
	                        <a href="?page=<%= i %><%= searchQuery.isEmpty() ? "" : "&search=" + searchQuery %>" class="<%= (i == currentPage) ? "active" : "" %>"><%= i %></a>
	                    <% } %>
	                </div>
	
	                <div id="formContainer">
	                    <h2 id="formTitle">Handling Review Form</h2>
	                    <form id="movieForm" method="post" action="">
	                        <input type="hidden" id="id" name="id" />
	                        <input type="hidden" id="action" name="action" />
	                        <label for="user_id">User_ID:</label>
	                        <input type="number" id="user_id" name="user_id" required />
	                        <label for="movie_id">Movie_ID:</label>
	                        <input type="number" id="movie_id" name="movie_id" />
	                        <label for="rating">Rating:</label>
	                        <input type="number" id="rating" name="rating" />
	                        <label for="feedback">Feedback:</label>
	                        <input type="text" id="feedback" name="feedback" />
	                        <label for="created_at">Created At:</label>
	                        <input type="date" id="created_at" name="created_at" />
	                        <button type="submit">Submit</button>
	                    </form>
	                </div>
	            </div>
	        </section>
	      </main>
	      <script>
	        function showAddForm() {
	            document.getElementById("formTitle").innerText = "Manage Reviews";
	            document.getElementById("movieForm").reset();
	            document.getElementById("formContainer").style.display = "block";
	            document.getElementById("action").value = "add";
	        }
	
	        function editMovie(id, user_id, movie_id, rating, feedback, created_at) {
	            document.getElementById("formTitle").innerText = "Edit Review";
	            document.getElementById("id").value = id;
	            document.getElementById("user_id").value = user_id;
	            document.getElementById("movie_id").value = movie_id;
	            document.getElementById("rating").value = rating;
	            document.getElementById("feedback").value = feedback;
	            document.getElementById("created_at").value = created_at;
	            document.getElementById("formContainer").style.display = "block";
	            document.getElementById("action").value = "edit";
	        }

	
	        function deleteMovie(id) {
	            if (confirm("Are you sure you want to delete this review?")) {
	                document.getElementById("id").value = id;
	                document.getElementById("action").value = "delete";
	                document.getElementById("movieForm").submit();
	            }
	        }
	
	        function hideForm() {
	            document.getElementById("formContainer").style.display = "none";
	        }
	    </script>
	</body>
	</html>