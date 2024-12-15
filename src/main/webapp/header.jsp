<%@ page import="jakarta.servlet.http.*" %> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<% HttpSession sessions = request.getSession(); String username = (String) sessions.getAttribute("username"); boolean isLoggedIn = (username != null); %>
<header class="header">
  <nav>
    <a href="index.jsp" class="logo">Cinema.</a>
    <ul>
      <li>	
        <a href="index.jsp#goToNowPlaying"
          ><i class="fa-solid fa-film"></i>Now Playing</a
        >
      </li>
      <li>
        <a href="index.jsp#upcoming"
          ><i class="fa-regular fa-circle-play"></i>Upcoming</a
        >
      </li>
      <li>
        <a href="index.jsp#theaters"
          ><i class="fa-solid fa-location-dot"></i>Theaters</a
        >
      </li>
      <li class="dropdown">
        <a href="#aboutus" id="aboutus-button"
          ><i class="fa-solid fa-user"></i>About Us</a
        >
        <div class="dropdown-content">
          <a href="#privacy-policy" id="privacy-policy-link">Privacy Policy</a>
          <a href="#contact-us">Contact Us</a>
        </div>
      </li>
    </ul>
    <div class="dropdown2">
      <button id="my-mtix-btn">My M-tix</button>
      <div class="dropdown-content2" id="my-mtix-dropdown">
        <% if (isLoggedIn) { %>
        <a href="#">Welcome, <%= username %></a>
        <a href="logout.jsp">Logout</a>
        <% } else { %>
        <a href="login.jsp" id="login-link">Login</a>
        <% } %>
      </div>
    </div>
  </nav>
</header>
