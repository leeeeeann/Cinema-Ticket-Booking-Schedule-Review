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
    HttpSession sessions = request.getSession();
    String loggedInUsername = (String) sessions.getAttribute("username");
    boolean accountDeleted = false;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

        if (action != null) {
            if (action.equals("add")) {
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                query = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
                statement = connection.prepareStatement(query);
                statement.setString(1, username);
                statement.setString(2, email);
                statement.setString(3, password);
                statement.setString(4, role);
                statement.executeUpdate();
            } else if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                query = "UPDATE users SET username=?, email=?, password=?, role=? WHERE id=?";
                statement = connection.prepareStatement(query);
                statement.setString(1, username);
                statement.setString(2, email);
                statement.setString(3, password);
                statement.setString(4, role);
                statement.setInt(5, id);
                statement.executeUpdate();
            } else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));

                // Check if the account being deleted is the currently logged-in user's account
                query = "SELECT username FROM users WHERE id=?";
                statement = connection.prepareStatement(query);
                statement.setInt(1, id);
                resultSet = statement.executeQuery();
                if (resultSet.next()) {
                    String usernameToDelete = resultSet.getString("username");
                    if (loggedInUsername != null && loggedInUsername.equals(usernameToDelete)) {
                        accountDeleted = true;
                    }
                }

                query = "DELETE FROM users WHERE id=?";
                statement = connection.prepareStatement(query);
                statement.setInt(1, id);
                statement.executeUpdate();
            }
        }

        // Fetch all reviews to display in the table
        String searchCondition = searchQuery.isEmpty() ? "" : " WHERE email LIKE ?";
        query = "SELECT * FROM users" + searchCondition + " LIMIT ?, ?";
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
            review.put("username", resultSet.getString("username"));
            review.put("email", resultSet.getString("email"));
            review.put("password", resultSet.getString("password"));
            review.put("role", resultSet.getString("role"));
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
    String searchCondition = searchQuery.isEmpty() ? "" : " WHERE email LIKE ?";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
        query = "SELECT COUNT(*) AS total FROM users" + searchCondition;
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
	                    <input type="text" name="search" placeholder="Search by password" value="<%= searchQuery %>" />
	                    <button type="submit">Search</button>
	                </form>
	                <table id="movieTable">
	                    <thead>
	                        <tr>
	                            <th>ID</th>
	                            <th>Username</th>
	                            <th>Email</th>
	                            <th>password</th>
	                            <th>role</th>
	                            <th>Actions</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <% for (Map<String, String> review : reviews) { %>
	                            <tr>
	                                <td><%= review.get("id") %></td>
	                                <td><%= review.get("username") %></td>
	                                <td><%= review.get("email") %></td>
	                                <td><%= review.get("password") %></td>
	                                <td><%= review.get("role") %></td>
	                                <td>
	                                    <button onclick="editMovie('<%= review.get("id") %>', '<%= review.get("username") %>', '<%= review.get("email") %>', '<%= review.get("password") %>', '<%= review.get("role") %>', '<%= review.get("created_at") %>')">Edit</button>
	                                    <button onclick="deleteMovie('<%= review.get("id") %>')">Delete</button>
	                                </td>
	                            </tr>
	                        <% } %>
	                    </tbody>
	                </table>
	                <button onclick="showAddForm()">Manage User</button>
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
	                        <label for="username">Username:</label>
	                        <input type="text" id="username" name="username" required />
	                        <label for="email">Email:</label>
	                        <input type="email" id="email" name="email" />
	                        <label for="password">Password:</label>
	                        <input type="password" id="password" name="password" />
	                        <label for="role">Role:</label>
	                        <input type="text" id="role" name="role" />
	                        <button type="submit">Submit</button>
	                    </form>
	                </div>
	            </div>
	        </section>
	      </main>
	      <script>
	        function showAddForm() {
	            document.getElementById("formTitle").innerText = "Manage Users";
	            document.getElementById("movieForm").reset();
	            document.getElementById("formContainer").style.display = "block";
	            document.getElementById("action").value = "add";
	        }
	
	        function editMovie(id, username, email, password, role) {
	            document.getElementById("formTitle").innerText = "Edit Users";
	            document.getElementById("id").value = id;
	            document.getElementById("username").value = username;
	            document.getElementById("email").value = email;
	            document.getElementById("password").value = password;
	            document.getElementById("role").value = role;
	            document.getElementById("formContainer").style.display = "block";
	            document.getElementById("action").value = "edit";
	        }

	
	        function deleteMovie(id) {
	            if (confirm("Are you sure you want to delete this user?")) {
	            	document.getElementById("id").value = id;
	                document.getElementById("action").value = "delete";
	                document.getElementById("movieForm").submit();
	                window.location.href = "?action=delete&id=" + id;
	            }
	        }
	        
	
	        function hideForm() {
	            document.getElementById("formContainer").style.display = "none";
	        }
	    </script>
	</body>
	</html>