package com.example.demo2.model;

import com.example.demo2.util.DatabaseConnection;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class LivreDAO {

    public List<Livre> getAllLivres() throws SQLException {
        List<Livre> livres = new ArrayList<>();
        String sql = "SELECT l.*, a.nom, a.prenom, a.genre FROM LIVRE l " +
                     "JOIN AUTEUR a ON l.matricule = a.matricule";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Livre livre = new Livre();
                livre.setIsbn(rs.getString("ISBN"));
                livre.setTitre(rs.getString("titre"));
                livre.setDescription(rs.getString("description"));
                livre.setDateEdition(rs.getDate("date_edition").toLocalDate());
                livre.setEditeur(rs.getString("editeur"));
                livre.setMatriculeAuteur(rs.getInt("matricule"));
                
                Auteur auteur = new Auteur();
                auteur.setMatricule(rs.getInt("matricule"));
                auteur.setNom(rs.getString("nom"));
                auteur.setPrenom(rs.getString("prenom"));
                auteur.setGenre(rs.getString("genre"));
                livre.setAuteur(auteur);
                
                livres.add(livre);
            }
        }
        return livres;
    }

    public Livre getLivreByIsbn(String isbn) throws SQLException {
        String sql = "SELECT l.*, a.nom, a.prenom, a.genre FROM LIVRE l " +
                     "JOIN AUTEUR a ON l.matricule = a.matricule WHERE l.ISBN = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, isbn);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Livre livre = new Livre();
                    livre.setIsbn(rs.getString("ISBN"));
                    livre.setTitre(rs.getString("titre"));
                    livre.setDescription(rs.getString("description"));
                    livre.setDateEdition(rs.getDate("date_edition").toLocalDate());
                    livre.setEditeur(rs.getString("editeur"));
                    livre.setMatriculeAuteur(rs.getInt("matricule"));
                    
                    Auteur auteur = new Auteur();
                    auteur.setMatricule(rs.getInt("matricule"));
                    auteur.setNom(rs.getString("nom"));
                    auteur.setPrenom(rs.getString("prenom"));
                    auteur.setGenre(rs.getString("genre"));
                    livre.setAuteur(auteur);
                    
                    return livre;
                }
            }
        }
        return null;
    }

    public List<Livre> searchLivres(String criteria, String value) throws SQLException {
        List<Livre> livres = new ArrayList<>();
        String sql = "SELECT l.*, a.nom, a.prenom, a.genre FROM LIVRE l " +
                     "JOIN AUTEUR a ON l.matricule = a.matricule WHERE " + criteria + " LIKE ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + value + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Livre livre = new Livre();
                    livre.setIsbn(rs.getString("ISBN"));
                    livre.setTitre(rs.getString("titre"));
                    livre.setDescription(rs.getString("description"));
                    livre.setDateEdition(rs.getDate("date_edition").toLocalDate());
                    livre.setEditeur(rs.getString("editeur"));
                    livre.setMatriculeAuteur(rs.getInt("matricule"));
                    
                    Auteur auteur = new Auteur();
                    auteur.setMatricule(rs.getInt("matricule"));
                    auteur.setNom(rs.getString("nom"));
                    auteur.setPrenom(rs.getString("prenom"));
                    auteur.setGenre(rs.getString("genre"));
                    livre.setAuteur(auteur);
                    
                    livres.add(livre);
                }
            }
        }
        return livres;
    }

    public boolean addLivre(Livre livre) throws SQLException {
        String sql = "INSERT INTO LIVRE (ISBN, titre, description, date_edition, editeur, matricule) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, livre.getIsbn());
            pstmt.setString(2, livre.getTitre());
            pstmt.setString(3, livre.getDescription());
            pstmt.setDate(4, Date.valueOf(livre.getDateEdition()));
            pstmt.setString(5, livre.getEditeur());
            pstmt.setInt(6, livre.getMatriculeAuteur());
            
            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean updateLivre(Livre livre) throws SQLException {
        String sql = "UPDATE LIVRE SET titre = ?, description = ?, date_edition = ?, " +
                     "editeur = ?, matricule = ? WHERE ISBN = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, livre.getTitre());
            pstmt.setString(2, livre.getDescription());
            pstmt.setDate(3, Date.valueOf(livre.getDateEdition()));
            pstmt.setString(4, livre.getEditeur());
            pstmt.setInt(5, livre.getMatriculeAuteur());
            pstmt.setString(6, livre.getIsbn());
            
            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean deleteLivre(String isbn) throws SQLException {
        String sql = "DELETE FROM LIVRE WHERE ISBN = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, isbn);
            return pstmt.executeUpdate() > 0;
        }
    }
}
