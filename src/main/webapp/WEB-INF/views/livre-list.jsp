<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Livres</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding-bottom: 40px;
        }
        /* Navbar */
        .navbar {
            background-color: #2c3e50; /* Bleu nuit foncé */
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .navbar h1 {
            margin: 0;
            font-size: 24px;
            font-weight: 500;
        }
        .user-info span {
            margin-right: 15px;
            color: #ecf0f1;
        }
        .btn-logout {
            background-color: transparent;
            border: 1px solid rgba(255,255,255,0.5);
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s;
            font-size: 14px;
        }
        .btn-logout:hover {
            background-color: rgba(255,255,255,0.1);
            border-color: white;
        }

        /* Container principal */
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* Barre d'outils (Recherche + Ajout) */
        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .search-form {
            display: flex;
            gap: 10px;
        }
        .search-input {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 250px;
        }
        .search-select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            display: inline-block;
            transition: background 0.3s;
        }
        .btn-search {
            background-color: #3498db;
            color: white;
        }
        .btn-search:hover { background-color: #2980b9; }

        .btn-add {
            background-color: #27ae60; /* Vert émeraude */
            color: white;
        }
        .btn-add:hover { background-color: #219150; }

        /* Table */
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background-color: #34495e; /* Gris bleuté */
            color: white;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.5px;
        }
        tr:last-child td {
            border-bottom: none;
        }
        tr:hover {
            background-color: #f8f9fa;
        }

        /* Actions buttons */
        .actions {
            display: flex;
            gap: 8px;
        }
        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
            border-radius: 3px;
        }
        .btn-edit {
            background-color: #f39c12; /* Orange */
            color: white;
        }
        .btn-edit:hover { background-color: #d35400; }

        .btn-delete {
            background-color: #e74c3c; /* Rouge */
            color: white;
        }
        .btn-delete:hover { background-color: #c0392b; }

        /* Messages */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .alert-success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>
<div class="navbar">
    <h1>📚 Ma Bibliothèque</h1>
    <div class="user-info">
        <span>Connecté en tant que : <strong>${sessionScope.utilisateur.login}</strong> (${sessionScope.utilisateur.role})</span>
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Déconnexion</a>
    </div>
</div>

<div class="container">
    <c:if test="${not empty param.success}">
        <div class="alert alert-success">${param.success}</div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-error">${param.error}</div>
    </c:if>

    <div class="toolbar">
        <form action="${pageContext.request.contextPath}/livre/list" method="get" class="search-form">
            <input type="text" name="search" placeholder="Rechercher..." class="search-input" value="${param.search}">
            <select name="criteria" class="search-select">
                <option value="titre" ${param.criteria == 'titre' ? 'selected' : ''}>Titre</option>
                <option value="nom" ${param.criteria == 'nom' ? 'selected' : ''}>Auteur</option>
            </select>
            <button type="submit" class="btn btn-search">Rechercher</button>
            <c:if test="${not empty param.search}">
                <a href="${pageContext.request.contextPath}/livre/list" class="btn" style="background:#95a5a6; color:white;">Effacer</a>
            </c:if>
        </form>

        <c:if test="${sessionScope.utilisateur.role == 'Admin'}">
            <a href="${pageContext.request.contextPath}/livre/form" class="btn btn-add">+ Nouveau Livre</a>
        </c:if>
    </div>

    <table>
        <thead>
        <tr>
            <th>ISBN</th>
            <th>Titre</th>
            <th>Auteur</th>
            <th>Genre</th>
            <th>Éditeur</th>
            <th>Date Édition</th>
            <c:if test="${sessionScope.utilisateur.role == 'Admin'}">
                <th>Actions</th>
            </c:if>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${livres}" var="livre">
            <tr>
                <td>${livre.isbn}</td>
                <td>${livre.titre}</td>
                <td>${livre.auteur.prenom} ${livre.auteur.nom}</td>
                <td>${livre.auteur.genre}</td>
                <td>${livre.editeur}</td>
                <td>${livre.dateEdition}</td>
                <c:if test="${sessionScope.utilisateur.role == 'Admin'}">
                    <td class="actions">
                        <a href="${pageContext.request.contextPath}/livre/form?isbn=${livre.isbn}" class="btn btn-sm btn-edit">Modifier</a>
                        <a href="${pageContext.request.contextPath}/livre/delete?isbn=${livre.isbn}"
                           class="btn btn-sm btn-delete"
                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce livre ?')">Supprimer</a>
                    </td>
                </c:if>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>