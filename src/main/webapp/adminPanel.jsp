<%@ page import="org.example.demo2.DB" %>
<%@ page import="org.example.demo2.Category" %>
<%@ page import="org.example.demo2.Product" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Panel</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      display: flex;
      margin: 0;
      padding: 0;
    }

    .sidebar {
      background-color: black;
      color: white;
      width: 200px;
      height: 100vh;
      padding: 20px;
      box-sizing: border-box;
    }

    .sidebar form {
      margin: 0;
    }

    .sidebar button {
      background-color: black;
      color: white;
      width: 100%;
      padding: 10px;
      border: none;
      margin-bottom: 10px;
      cursor: pointer;
    }

    .sidebar button:hover {
      background-color: #555;
    }

    .content {
      flex-grow: 1;
      padding: 20px;
      background-color: #f4f4f4;
      position: relative;
    }

    .list {
      list-style: none;
      padding: 0;
    }

    .list li {
      padding: 10px;
      background-color: #ddd;
      margin-bottom: 5px;
      border-radius: 5px;
    }

    .list li:hover {
      background-color: #bbb;
    }

    .add-button {
      position: absolute;
      top: 10px;
      right: 20px;
      background-color: #007bff;
      color: white;
      border: none;
      padding: 10px 15px;
      border-radius: 4px;
      font-size: 24px;
      cursor: pointer;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
    }

    .add-button:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>

<div class="sidebar">
  <!-- Form to show categories -->
  <form method="get">
    <input type="hidden" name="view" value="categories">
    <button type="submit">Categories</button>
  </form>

  <!-- Form to show products -->
  <form method="get">
    <input type="hidden" name="view" value="products">
    <button type="submit">Products</button>
  </form>
</div>

<div class="content">
  <%
    String view = request.getParameter("view");
    if (view == null || view.equals("categories")) {
      // Agar kategoriya ko'rsatilsa, + tugmasi kategoriya qo'shish sahifasiga olib boradi
  %>
  <button class="add-button" onclick="window.location.href='addCategory.jsp'">+</button>
  <h1>Categories</h1>
  <ul class="list">
    <%
      List<Category> categories = DB.getCategories();
      for (Category category : categories) {
    %>
    <li><%= category.getName() %></li>
    <%
      }
    %>
  </ul>
  <%
  } else if (view.equals("products")) {
    // Agar mahsulotlar ko'rsatilsa, + tugmasi mahsulot qo'shish sahifasiga olib boradi
  %>
  <button class="add-button" onclick="window.location.href='addProduct.jsp'">+</button>
  <h1>Products</h1>
  <ul class="list">
    <%
      List<Product> products = DB.getProduct();
      for (Product product : products) {
    %>
    <li><%= product.getName() %></li>
    <%
      }
    %>
  </ul>
  <% } %>
</div>

</body>
</html>
