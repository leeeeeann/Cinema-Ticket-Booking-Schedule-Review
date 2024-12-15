<%@ page import="jakarta.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sessions = request.getSession();
    sessions.invalidate();
    response.sendRedirect("index.jsp");
%>
