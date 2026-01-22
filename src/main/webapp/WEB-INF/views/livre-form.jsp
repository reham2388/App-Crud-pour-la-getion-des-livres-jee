<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire Livre - Gestion de Livres</title>
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
        
        .container {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
        }
        
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }
        
        .form-container h2 {
            margin-bottom: 30px;
            color: #333;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            font-family: inherit;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.1);
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        
        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: opacity 0.3s;
        }
        
        .btn-submit {
            background: #667eea;
            color: white;
        }
        
        .btn-cancel {
            background: #ddd;
            color: #333;
        }
        
        .btn:hover {
            opacity: 0.8;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #f5c6cb;
        }
        
        .readonly-field {
            background: #f5f5f5;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>📚 Gestion de Livres</h1>
    </div>
    
    <div class="container">
        <div class="form-container">
            <c:choose>
                <c:when test="${not empty livre}">
                    <h2>Modifier un livre</h2>
                </c:when>
                <c:otherwise>
                    <h2>Ajouter un nouveau livre</h2>
                </c:otherwise>
            </c:choose>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>
            
            <form method="POST" action="${pageContext.request.contextPath}/livre/form">
                <c:choose>
                    <c:when test="${not empty livre}">
                        <input type="hidden" name="action" value="update">
                        <div class="form-group">
                            <label for="isbn">ISBN:</label>
                            <input type="text" id="isbn" name="isbn" value="${livre.isbn}" class="readonly-field" readonly>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="action" value="add">
                        <div class="form-group">
                            <label for="isbn">ISBN:</label>
                            <input type="text" id="isbn" name="isbn" required>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <div class="form-group">
                    <label for="titre">Titre:</label>
                    <input type="text" id="titre" name="titre" value="${livre.titre}" required>
                </div>
                
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description">${livre.description}</textarea>
                </div>
                
                <div class="form-group">
                    <label for="dateEdition">Date d'édition:</label>
                    <input type="date" id="dateEdition" name="dateEdition" value="${livre.dateEdition}" required>
                </div>
                
                <div class="form-group">
                    <label for="editeur">Éditeur:</label>
                    <select id="editeur" name="editeur" required>
                        <option value="">-- Sélectionner --</option>
                        <option value="ENI" <c:if test="${livre.editeur == 'ENI'}">selected</c:if>>ENI</option>
                        <option value="DUNOD" <c:if test="${livre.editeur == 'DUNOD'}">selected</c:if>>DUNOD</option>
                        <option value="FIRST" <c:if test="${livre.editeur == 'FIRST'}">selected</c:if>>FIRST</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="matricule">Auteur:</label>
                    <select id="matricule" name="matricule" required>
                        <option value="">-- Sélectionner --</option>
                        <c:forEach var="auteur" items="${auteurs}">
                            <option value="${auteur.matricule}" <c:if test="${livre.matriculeAuteur == auteur.matricule}">selected</c:if>>
                                ${auteur.prenom} ${auteur.nom}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-submit">Enregistrer</button>
                    <a href="${pageContext.request.contextPath}/livre/list" class="btn btn-cancel" style="text-decoration: none; display: flex; align-items: center; justify-content: center;">Annuler</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
