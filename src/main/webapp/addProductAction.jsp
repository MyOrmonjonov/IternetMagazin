<%@ page import="org.example.demo2.DB" %>
<%@ page import="org.example.demo2.Category" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Add Product</title>
  <style>
    body {
      font-family: Arial, sans-serif;
    }
    .form-container {
      width: 300px;
      margin: 20px auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    input, select, button {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      border-radius: 5px;
      border: 1px solid #ccc;
    }
    button {
      background-color: #4CAF50;
      color: white;
      cursor: pointer;
    }
    button:hover {
      background-color: #45a049;
    }
    .back-button {
      background-color: #f44336; /* Red color */
      color: white;
      cursor: pointer;
      width: auto;
      text-decoration: none;
      display: inline-block;
      padding: 10px 20px;
      text-align: center;
      border-radius: 5px;
    }
    .back-button:hover {
      background-color: #d32f2f;
    }
    .error-message {
      color: red;
      font-size: 14px;
    }
  </style>
</head>
<body>
<div class="form-container">
  <h2>Add Product</h2>
  <!-- Error Message -->
  <%
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
  %>
  <div class="error-message"><%= errorMessage %></div>
  <% } %>

  <form action="addProduct" method="post" enctype="multipart/form-data">
    <label for="category">Category:</label>
    <select name="category" id="category" required>
      <%
        List<Category> categories = DB.getCategories();
        for (Category category : categories) {
      %>
      <option value="<%= category.getId() %>"><%= category.getName() %></option>
      <% } %>
    </select>

    <label for="productName">Product Name:</label>
    <input type="text" id="productName" name="productName" required>

    <label for="productPrice">Product Price:</label>
    <input type="text" id="productPrice" name="productPrice" required>

    <label for="productImage">Product Image:</label>
    <input type="file" id="productImage" name="productImage" required>

    <button type="submit">Add Product</button>
  </form>

  <a href="adminPanel.jsp" class="back-button">Back</a>
</div>
</body>
</html>
