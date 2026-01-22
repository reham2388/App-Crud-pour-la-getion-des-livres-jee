<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Livres - Gestion de Livres</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            color: #333;
        }
        
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .navbar h1 {
            font-size: 24px;
        }
        
        .navbar-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .navbar-right span {
            font-size: 14px;
        }
        
        .navbar-right a {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s;
        }
        
        .navbar-right a:hover {
            background: rgba(255, 255, 255, 0.3);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .header h2 {
            font-size: 28px;
            color: #333;
        }
        
        .btn-add {
            background: #667eea;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background 0.3s;
        }
        
        .btn-add:hover {
            background: #764ba2;
        }
        
        .search-box {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }
        
        .search-box form {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .search-box select,
        .search-box input {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .search-box button {
            background: #667eea;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .search-box button:hover {
            background: #764ba2;
        }
        
        .table-container {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        table thead {
            background: #f8f9fa;
            border-bottom: 2px solid #ddd;
        }
        
        table th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #555;
        }
        
        table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        
        table tbody tr:hover {
            background: #f9f9f9;
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        .btn-small {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
            text-decoration: none;
            display: inline-block;
            transition: opacity 0.3s;
        }
        
        .btn-edit {
            background: #4CAF50;
            color: white;
        }
        
        .btn-delete {
            background: #f44336;
            color: white;
        }
        
        .btn-small:hover {
            opacity: 0.8;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        
        .empty-state p {
            font-size: 18px;
            margin-bottom: 20px;
        }
        
        .success {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #28a745;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>📚 Gestion de Livres</h1>
        <div class="navbar-right">
            <span>Bienvenue, ${utilisateur.login} (${utilisateur.role})</span>
            <a href="${pageContext.request.contextPath}/logout">Déconnexion</a>
        </div>
    </div>
    
    <div class="container">
        <% if (request.getParameter("success") != null) { %>
            <div class="success"><%= request.getParameter("success") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <div class="header">
            <h2>Liste des Livres</h2>
            <c:if test="${utilisateur.role == 'Admin'}">
                <a href="${pageContext.request.contextPath}/livre/form" class="btn-add">+ Ajouter un livre</a>
            </c:if>
        </div>
        
        <div class="search-box">
            <form method="GET" action="${pageContext.request.contextPath}/livre/list">
                <select name="searchType">
                    <option value="">-- Tous les livres --</option>
                    <option value="l.titre">Par titre</option>
                    <option value="a.nom">Par auteur</option>
                    <option value="l.editeur">Par éditeur</option>
                </select>
                <input type="text" name="searchValue" placeholder="Entrez votre recherche...">
                <button type="submit">Rechercher</button>
            </form>
        </div>
        
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty livres}">
                    <table>
                        <thead>
                            <tr>
                                <th>ISBN</th>
                                <th>Titre</th>
                                <th>Auteur</th>
                                <th>Éditeur</th>
                                <th>Date d'édition</th>
                                <c:if test="${utilisateur.role == 'Admin'}">
                                    <th>Actions</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="livre" items="${livres}">
                                <tr>
                                    <td>${livre.isbn}</td>
                                    <td>${livre.titre}</td>
                                    <td>${livre.auteur.prenom} ${livre.auteur.nom}</td>
                                    <td>${livre.editeur}</td>
                                    <td>${livre.dateEdition}</td>
                                    <c:if test="${utilisateur.role == 'Admin'}">
                                        <td>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/livre/form?isbn=${livre.isbn}" class="btn-small btn-edit">Éditer</a>
                                                <a href="${pageContext.request.contextPath}/livre/delete?isbn=${livre.isbn}" class="btn-small btn-delete" onclick="return confirm('Êtes-vous sûr ?')">Supprimer</a>
                                            </div>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <p>Aucun livre trouvé</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
