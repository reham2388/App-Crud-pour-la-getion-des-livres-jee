package com.example.demo2.servlet;

import com.example.demo2.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/livre/form")
public class LivreFormServlet extends HttpServlet {
    private LivreDAO livreDAO = new LivreDAO();
    private AuteurDAO auteurDAO = new AuteurDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String isbn = request.getParameter("isbn");
            List<Auteur> auteurs = auteurDAO.getAllAuteurs();
            request.setAttribute("auteurs", auteurs);
            
            if (isbn != null && !isbn.isEmpty()) {
                Livre livre = livreDAO.getLivreByIsbn(isbn);
                request.setAttribute("livre", livre);
            }
            
            request.getRequestDispatcher("/WEB-INF/views/livre-form.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement du formulaire");
            try {
                request.getRequestDispatcher("/WEB-INF/views/livre-form.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                addLivre(request, response);
            } else if ("update".equals(action)) {
                updateLivre(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de l'opération");
            try {
                request.getRequestDispatcher("/WEB-INF/views/livre-form.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    private void addLivre(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        Livre livre = new Livre();
        livre.setIsbn(request.getParameter("isbn"));
        livre.setTitre(request.getParameter("titre"));
        livre.setDescription(request.getParameter("description"));
        livre.setDateEdition(LocalDate.parse(request.getParameter("dateEdition")));
        livre.setEditeur(request.getParameter("editeur"));
        livre.setMatriculeAuteur(Integer.parseInt(request.getParameter("matricule")));
        
        if (livreDAO.addLivre(livre)) {
            response.sendRedirect(request.getContextPath() + "/livre/list");
        } else {
            request.setAttribute("error", "Erreur lors de l'ajout du livre");
            request.getRequestDispatcher("/WEB-INF/views/livre-form.jsp").forward(request, response);
        }
    }

    private void updateLivre(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        Livre livre = new Livre();
        livre.setIsbn(request.getParameter("isbn"));
        livre.setTitre(request.getParameter("titre"));
        livre.setDescription(request.getParameter("description"));
        livre.setDateEdition(LocalDate.parse(request.getParameter("dateEdition")));
        livre.setEditeur(request.getParameter("editeur"));
        livre.setMatriculeAuteur(Integer.parseInt(request.getParameter("matricule")));
        
        if (livreDAO.updateLivre(livre)) {
            response.sendRedirect(request.getContextPath() + "/livre/list");
        } else {
            request.setAttribute("error", "Erreur lors de la mise à jour du livre");
            request.getRequestDispatcher("/WEB-INF/views/livre-form.jsp").forward(request, response);
        }
    }
}
