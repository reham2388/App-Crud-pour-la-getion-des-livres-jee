package com.example.demo2.model;

import com.example.demo2.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AuteurDAO {

    public List<Auteur> getAllAuteurs() throws SQLException {
        List<Auteur> auteurs = new ArrayList<>();
        String sql = "SELECT * FROM AUTEUR";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Auteur auteur = new Auteur();
                auteur.setMatricule(rs.getInt("matricule"));
                auteur.setNom(rs.getString("nom"));
                auteur.setPrenom(rs.getString("prenom"));
                auteur.setGenre(rs.getString("genre"));
                auteurs.add(auteur);
            }
        }
        return auteurs;
    }

    public Auteur getAuteurByMatricule(int matricule) throws SQLException {
        String sql = "SELECT * FROM AUTEUR WHERE matricule = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, matricule);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Auteur auteur = new Auteur();
                    auteur.setMatricule(rs.getInt("matricule"));
                    auteur.setNom(rs.getString("nom"));
                    auteur.setPrenom(rs.getString("prenom"));
                    auteur.setGenre(rs.getString("genre"));
                    return auteur;
                }
            }
        }
        return null;
    }

    public boolean addAuteur(Auteur auteur) throws SQLException {
        String sql = "INSERT INTO AUTEUR (nom, prenom, genre) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, auteur.getNom());
            pstmt.setString(2, auteur.getPrenom());
            pstmt.setString(3, auteur.getGenre());
            
            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean updateAuteur(Auteur auteur) throws SQLException {
        String sql = "UPDATE AUTEUR SET nom = ?, prenom = ?, genre = ? WHERE matricule = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, auteur.getNom());
            pstmt.setString(2, auteur.getPrenom());
            pstmt.setString(3, auteur.getGenre());
            pstmt.setInt(4, auteur.getMatricule());
            
            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean deleteAuteur(int matricule) throws SQLException {
        String sql = "DELETE FROM AUTEUR WHERE matricule = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, matricule);
            return pstmt.executeUpdate() > 0;
        }
    }
}
