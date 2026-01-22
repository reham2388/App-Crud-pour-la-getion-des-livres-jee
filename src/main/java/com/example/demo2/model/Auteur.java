package com.example.demo2.model;

public class Auteur {
    private int matricule;
    private String nom;
    private String prenom;
    private String genre;

    public Auteur() {
    }

    public Auteur(String nom, String prenom, String genre) {
        this.nom = nom;
        this.prenom = prenom;
        this.genre = genre;
    }

    public Auteur(int matricule, String nom, String prenom, String genre) {
        this.matricule = matricule;
        this.nom = nom;
        this.prenom = prenom;
        this.genre = genre;
    }

    // Getters et Setters
    public int getMatricule() {
        return matricule;
    }

    public void setMatricule(int matricule) {
        this.matricule = matricule;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    @Override
    public String toString() {
        return "Auteur{" +
                "matricule=" + matricule +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", genre='" + genre + '\'' +
                '}';
    }
}
