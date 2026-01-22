package com.example.demo2.servlet;

import com.example.demo2.model.Livre;
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
import java.util.List;

@WebServlet("/livre/list")
public class LivreListServlet extends HttpServlet {
    private LivreDAO livreDAO = new LivreDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        
        try {
            String searchType = request.getParameter("searchType");
            String searchValue = request.getParameter("searchValue");
            
            List<Livre> livres;
            
            if (searchType != null && !searchType.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
                livres = livreDAO.searchLivres(searchType, searchValue);
            } else {
                livres = livreDAO.getAllLivres();
            }
            
            request.setAttribute("livres", livres);
            request.setAttribute("utilisateur", utilisateur);
            request.getRequestDispatcher("/WEB-INF/views/livre-list.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des livres");
            try {
                request.getRequestDispatcher("/WEB-INF/views/livre-list.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                ex.printStackTrace();
            }
        }
    }
}
