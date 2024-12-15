	package com.movieapp.servlet;

import com.movieapp.dao.MovieDAO;
import com.movieapp.model.Movie;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class NowPlayingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MovieDAO movieDAO;

    public void init() {
        movieDAO = new MovieDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Movie> movies = movieDAO.getAllNowPlayingMovies();
        String connectionStatus = movieDAO.getConnectionStatus();

        // Debug prints
        System.out.println("Connection Status: " + connectionStatus);
        System.out.println("Movies List: " + (movies != null ? movies.size() : "null"));

        if (movies == null || movies.isEmpty()) {
            System.out.println("No movies found.");
        } else {
            System.out.println("Movies found: " + movies.size());
            for (Movie movie : movies) {
                System.out.println("Movie: " + movie.getTitle());
            }
        }

        request.setAttribute("movies", movies);
        request.setAttribute("connectionStatus", connectionStatus);
        RequestDispatcher dispatcher = request.getRequestDispatcher("views/nowplaying.jsp");
        dispatcher.forward(request, response);
    }
}
