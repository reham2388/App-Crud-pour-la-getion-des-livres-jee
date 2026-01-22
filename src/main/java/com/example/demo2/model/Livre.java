package com.example.demo2.model;

import java.time.LocalDate;

public class Livre {
    private String isbn;
    private String titre;
    private String description;
    private LocalDate dateEdition;
    private String editeur;
    private int matriculeAuteur;
    private Auteur auteur;

    public Livre() {
    }

    public Livre(String isbn, String titre, String description, LocalDate dateEdition, String editeur, int matriculeAuteur) {
        this.isbn = isbn;
        this.titre = titre;
        this.description = description;
        this.dateEdition = dateEdition;
        this.editeur = editeur;
        this.matriculeAuteur = matriculeAuteur;
    }

    // Getters et Setters
    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
       }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getDateEdition() {
        return dateEdition;
    }

    public void setDateEdition(LocalDate dateEdition) {
        this.dateEdition = dateEdition;
    }

    public String getEditeur() {
        return editeur;
    }

    public void setEditeur(String editeur) {
        this.editeur = editeur;
    }

    public int getMatriculeAuteur() {
        return matriculeAuteur;
    }

    public void setMatriculeAuteur(int matriculeAuteur) {
        this.matriculeAuteur = matriculeAuteur;
    }

    public Auteur getAuteur() {
        return auteur;
    }

    public void setAuteur(Auteur auteur) {
        this.auteur = auteur;
    }

    @Override
    public String toString() {
        return "Livre{" +
                "isbn='" + isbn + '\'' +
                ", titre='" + titre + '\'' +
                ", description='" + description + '\'' +
                ", dateEdition=" + dateEdition +
                ", editeur='" + editeur + '\'' +
                ", matriculeAuteur=" + matriculeAuteur +
                '}';
    }
}
