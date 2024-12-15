<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String city = request.getParameter("city");
    String isAjax = request.getParameter("ajax");

    if (city != null && !city.isEmpty() && "true".equals(isAjax)) {
        String dbURL = "jdbc:mysql://localhost:3306/cinema";
        String username = "root";
        String password = "";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbURL, username, password);
            statement = connection.createStatement();

            String query = "SELECT cinema FROM theaters WHERE city = '" + city + "'";
            resultSet = statement.executeQuery(query);

            out.println("<table class='cinema-table'>");
            out.println("<tr><th>Cinema</th></tr>");
            while (resultSet.next()) {
                String cinema = resultSet.getString("cinema");
                out.println("<tr><td><a href='cinemaschedule.jsp?cinema=" + java.net.URLEncoder.encode(cinema, "UTF-8") + "'>" + cinema + "</a></td></tr>");
            }
            out.println("</table>");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return; // Ensure the response is returned here
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Theaters</title>
    <style>
        .cinema-table {
            width: 100%;
            border-collapse: collapse;
        }
        .cinema-table th, .cinema-table td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>
    <section id="theaters">
        <div class="texttheater">
            <h2>THEATER</h2>
        </div>
        <div class="theater">
            <div class="dropdown">
                <select id="city-select" onchange="showCinemas()">
                    <option value="">Select City</option>
                    <option value="JAKARTA">JAKARTA</option>
                    <option value="BOGOR">BOGOR</option>
                    <option value="DEPOK">DEPOK</option>
                    <option value="TANGERANG">TANGERANG</option>
                    <option value="BEKASI">BEKASI</option>
                </select>
            </div>
            <div id="cinema-list" class="cinema-list">
                <%-- The cinema list will be dynamically populated here --%>
            </div>
        </div>
    </section>
</body>
</html>
