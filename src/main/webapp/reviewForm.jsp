<%@ page import="jakarta.servlet.http.*" %>
<%
    HttpSession sessions = request.getSession();
    boolean isLoggedIn = (sessions.getAttribute("username") != null);
%>
<div class="review-form">
    <% if (isLoggedIn) { %>
        <h4>Leave a Review</h4>
        <form action="submitReview.jsp" method="post">
            <input type="hidden" name="movieId" value="<%= request.getParameter("id") %>">
            <label for="rating">Rating:</label>
            <select name="rating" id="rating" required>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
            <label for="feedback">Feedback:</label>
            <textarea name="feedback" id="feedback" required></textarea>
            <button type="submit">Submit Review</button>
        </form>
    <% } else { %>
        <p>Please <a href="login.jsp">log in</a> to leave a review.</p>
    <% } %>
</div>
