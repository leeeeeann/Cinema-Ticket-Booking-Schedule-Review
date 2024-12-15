	<%@ page import="java.sql.*, java.util.*" %>
	<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<%
	    String dbURL = "jdbc:mysql://localhost:3306/cinema";
	    String dbUsername = "root";
	    String dbPassword = "";
	    Connection connection = null;
	    Statement statement = null;
	    ResultSet resultSet = null;
	    String query;
	    List<Map<String, String>> movies = new ArrayList<>();
	    int moviesPerPage = 4;
	    int currentPage = 1;
	    if (request.getParameter("page") != null) {
	        currentPage = Integer.parseInt(request.getParameter("page"));
	    }
	    int offset = (currentPage - 1) * moviesPerPage;
	
	    String searchQuery = "";
	    if (request.getParameter("search") != null) {
	        searchQuery = request.getParameter("search").trim();
	    }
	
	    // Handle form submission for Add, Edit, and Delete operations
	    String action = request.getParameter("action");
	    if (action != null) {
	        try {
	            Class.forName("com.mysql.jdbc.Driver");
	            connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
	            statement = connection.createStatement();
	
	            if (action.equals("add")) {
	                String title = request.getParameter("title");
	                String trailer = request.getParameter("trailer");
	                String releaseDate = request.getParameter("releaseDate");
	                String movieType = request.getParameter("movieType");
	                String production = request.getParameter("production");
	                String casts = request.getParameter("casts");
	                String synopsis = request.getParameter("synopsis");
	                String poster = request.getParameter("poster");
	
	                query = "INSERT INTO movie_upcome (title, trailer, releaseDate, movieType, production, casts, synopsis, poster) VALUES ('"
	                        + title + "', '" + trailer + "', '" + releaseDate + "', '" + movieType + "', '" + production + "', '" + casts + "', '" + synopsis + "', '" + poster + "')";
	                statement.executeUpdate(query);
	            } else if (action.equals("edit")) {
	                int id = Integer.parseInt(request.getParameter("id"));
	                String title = request.getParameter("title");
	                String trailer = request.getParameter("trailer");
	                String releaseDate = request.getParameter("releaseDate");
	                String movieType = request.getParameter("movieType");
	                String production = request.getParameter("production");
	                String casts = request.getParameter("casts");
	                String synopsis = request.getParameter("synopsis");
	                String poster = request.getParameter("poster");
	
	                query = "UPDATE movie_upcome SET title='" + title + "', trailer='" + trailer + "', releaseDate='"
	                        + releaseDate + "', movieType='" + movieType + "', production='" + production + "', casts='"
	                        + casts + "', synopsis='" + synopsis + "', poster='" + poster + "' WHERE id=" + id;
	                statement.executeUpdate(query);
	            } else if (action.equals("delete")) {
	                int id = Integer.parseInt(request.getParameter("id"));
	                query = "DELETE FROM movie_upcome WHERE id=" + id;
	                statement.executeUpdate(query);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (statement != null) statement.close();
	            if (connection != null) connection.close();
	        }
	    }
	
	    // Fetch all movies to display in the table
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
	        statement = connection.createStatement();
	        String searchCondition = searchQuery.isEmpty() ? "" : " WHERE title LIKE '%" + searchQuery + "%'";
	        query = "SELECT * FROM movie_upcome" + searchCondition + " LIMIT " + offset + ", " + moviesPerPage;
	        resultSet = statement.executeQuery(query);
	        while (resultSet.next()) {
	            Map<String, String> movie = new HashMap<>();
	            movie.put("id", resultSet.getString("id"));
	            movie.put("title", resultSet.getString("title"));
	            movie.put("trailer", resultSet.getString("trailer"));
	            movie.put("releaseDate", resultSet.getString("releaseDate"));
	            movie.put("movieType", resultSet.getString("movieType"));
	            movie.put("production", resultSet.getString("production"));
	            movie.put("casts", resultSet.getString("casts"));
	            movie.put("synopsis", resultSet.getString("synopsis"));
	            movie.put("poster", resultSet.getString("poster"));
	            movies.add(movie);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (resultSet != null) resultSet.close();
	        if (statement != null) statement.close();
	        if (connection != null) connection.close();
	    }
	
	    // Get total number of movies for pagination
	    int totalMovies = 0;
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
	        statement = connection.createStatement();
	        String searchCondition = searchQuery.isEmpty() ? "" : " WHERE title LIKE '%" + searchQuery + "%'";
	        query = "SELECT COUNT(*) AS total FROM movie_upcome" + searchCondition;
	        resultSet = statement.executeQuery(query);
	        if (resultSet.next()) {
	            totalMovies = resultSet.getInt("total");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (resultSet != null) resultSet.close();
	        if (statement != null) statement.close();
	        if (connection != null) connection.close();
	    }
	
	    int totalPages = (int) Math.ceil((double) totalMovies / moviesPerPage);
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
	                <h1>Movie Table</h1>
	                <form method="get" action="">
	                    <input type="text" name="search" placeholder="Search by title" value="<%= searchQuery %>" />
	                    <button type="submit">Search</button>
	                </form>
	                <table id="movieTable">
	                    <thead>
	                        <tr>
	                            <th>ID</th>
	                            <th>Title</th>
	                            <th>Trailer</th>
	                            <th>Release Date</th>
	                            <th>Movie Type</th>
	                            <th>Production</th>
	                            <th>Casts</th>
	                            <th>Synopsis</th>
	                            <th>Poster</th>
	                            <th>Actions</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <% for (Map<String, String> movie : movies) { %>
	                            <tr>
	                                <td><%= movie.get("id") %></td>
	                                <td><%= movie.get("title") %></td>
	                                <td><%= movie.get("trailer") %></td>
	                                <td><%= movie.get("releaseDate") %></td>
	                                <td><%= movie.get("movieType") %></td>
	                                <td><%= movie.get("production") %></td>
	                                <td><%= movie.get("casts") %></td>
	                                <td><%= movie.get("synopsis") %></td>
	                                <td><%= movie.get("poster") %></td>
	                                <td>
	                                    <button onclick="editMovie('<%= movie.get("id") %>', '<%= movie.get("title") %>', '<%= movie.get("trailer") %>', '<%= movie.get("releaseDate") %>', '<%= movie.get("movieType") %>', '<%= movie.get("production") %>', '<%= movie.get("casts") %>', '<%= movie.get("synopsis") %>', '<%= movie.get("poster") %>')">Edit</button>
	                                    <button onclick="deleteMovie('<%= movie.get("id") %>')">Delete</button>
	                                </td>
	                            </tr>
	                        <% } %>
	                    </tbody>
	                </table>
	                <button onclick="showAddForm()">Add New Movie</button>
	                
	                <!-- Pagination Controls -->
	                <div class="pagination">
	                    <% for (int i = 1; i <= totalPages; i++) { %>
	                        <a href="?page=<%= i %><%= searchQuery.isEmpty() ? "" : "&search=" + searchQuery %>" class="<%= (i == currentPage) ? "active" : "" %>"><%= i %></a>
	                    <% } %>
	                </div>
	
	                <div id="formContainer">
	                    <h2 id="formTitle">New Movie Form</h2>
	                    <form id="movieForm" method="post" action="">
	                        <input type="hidden" id="id" name="id" />
	                        <input type="hidden" id="action" name="action" />
	                        <label for="title">Title:</label>
	                        <input type="text" id="title" name="title" required />
	                        <label for="trailer">Trailer:</label>
	                        <input type="text" id="trailer" name="trailer" />
	                        <label for="releaseDate">Release Date:</label>
	                        <input type="date" id="releaseDate" name="releaseDate" />
	                        <label for="movieType">Movie Type:</label>
	                        <input type="text" id="movieType" name="movieType" />
	                        <label for="production">Production:</label>
	                        <input type="text" id="production" name="production" />
	                        <label for="casts">Casts:</label>
	                        <input type="text" id="casts" name="casts" />
	                        <label for="synopsis">Synopsis:</label>
	                        <textarea id="synopsis" name="synopsis"></textarea>
	                        <label for="poster">Poster:</label>
	                        <input type="text" id="poster" name="poster" />
	                        <button type="submit">Submit</button>
	                        <button type="button" onclick="hideForm()">Cancel</button>
	                    </form>
	                </div>
	            </div>
	        </section>
	      </main>
	      <script>
	        function showAddForm() {
	            document.getElementById("formTitle").innerText = "Add New Movie";
	            document.getElementById("movieForm").reset();
	            document.getElementById("formContainer").style.display = "block";
	            document.getElementById("action").value = "add";
	        }
	
	        function editMovie(id, title, trailer, duration, rating, ageRating, synopsis, poster) {
	            document.getElementById("formTitle").innerText = "Edit Movie";
	            document.getElementById("id").value = id;
	            document.getElementById("title").value = title;
	            document.getElementById("trailer").value = trailer;
	            document.getElementById("duration").value = duration;
	            document.getElementById("rating").value = rating;
	            document.getElementById("ageRating").value = ageRating;
	            document.getElementById("synopsis").value = synopsis;
	            document.getElementById("poster").value = poster;
	            document.getElementById("formContainer").style.display = "block";
	            document.getElementById("action").value = "edit";
	        }
	
	        function deleteMovie(id) {
	            if (confirm("Are you sure you want to delete this movie?")) {
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