package com.example.demo2.model;

import com.example.demo2.util.DatabaseConnection;
import java.sql.*;

public class UtilisateurDAO {

    public Utilisateur authenticate(String login, String password) throws SQLException {
        String sql = "SELECT * FROM UTILISATEUR WHERE login = ? AND password = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, login);
            pstmt.setString(2, password);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Utilisateur utilisateur = new Utilisateur();
                    utilisateur.setId(rs.getInt("id"));
                    utilisateur.setLogin(rs.getString("login"));
                    utilisateur.setPassword(rs.getString("password"));
                    utilisateur.setRole(rs.getString("role"));
                    return utilisateur;
                }
            }
        }
        return null;
    }

    public Utilisateur getUserByLogin(String login) throws SQLException {
        String sql = "SELECT * FROM UTILISATEUR WHERE login = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, login);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Utilisateur utilisateur = new Utilisateur();
                    utilisateur.setId(rs.getInt("id"));
                    utilisateur.setLogin(rs.getString("login"));
                    utilisateur.setPassword(rs.getString("password"));
                    utilisateur.setRole(rs.getString("role"));
                    return utilisateur;
                }
            }
        }
        return null;
    }
}
