package com.movieapp.model;

public class Movie {
    private int id;
    private String title;
    private String trailer;
    private String duration;
    private String rating;
    private String ageRating;
    private String synopsis;

    public Movie(int id, String title, String trailer, String duration, String rating, String ageRating, String synopsis) {
        this.id = id;
        this.title = title;
        this.trailer = trailer;
        this.duration = duration;
        this.rating = rating;
        this.ageRating = ageRating;
        this.synopsis = synopsis;
    }

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTrailer() {
        return trailer;
    }

    public void setTrailer(String trailer) {
        this.trailer = trailer;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getAgeRating() {
        return ageRating;
    }

    public void setAgeRating(String ageRating) {
        this.ageRating = ageRating;
    }

    public String getSynopsis() {
        return synopsis;
    }

    public void setSynopsis(String synopsis) {
        this.synopsis = synopsis;
    }
}
