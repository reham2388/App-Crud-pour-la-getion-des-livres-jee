package com.example.demo2.servlet;

import com.example.demo2.model.LivreDAO;
import com.example.demo2.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/livre/delete")
public class LivreDeleteServlet extends HttpServlet {
    private LivreDAO livreDAO = new LivreDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        
        // Vérifier que l'utilisateur est Admin
        if (!"Admin".equals(utilisateur.getRole())) {
            response.sendRedirect(request.getContextPath() + "/livre/list");
            return;
        }
        
        String isbn = request.getParameter("isbn");
        
        try {
            if (livreDAO.deleteLivre(isbn)) {
                response.sendRedirect(request.getContextPath() + "/livre/list?success=Livre supprimé");
            } else {
                response.sendRedirect(request.getContextPath() + "/livre/list?error=Erreur lors de la suppression");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/livre/list?error=Erreur base de données");
        }
    }
}
