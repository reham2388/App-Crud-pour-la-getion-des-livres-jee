package com.example.demo2.servlet;

import com.example.demo2.model.Utilisateur;
import com.example.demo2.model.UtilisateurDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        
        try {
            Utilisateur utilisateur = utilisateurDAO.authenticate(login, password);
            
            if (utilisateur != null) {
                HttpSession session = request.getSession();
                session.setAttribute("utilisateur", utilisateur);
                response.sendRedirect(request.getContextPath() + "/livre/list");
            } else {
                request.setAttribute("error", "Login ou mot de passe incorrect");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur base de données");
            try {
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                ex.printStackTrace();
            }
        }
    }
}
