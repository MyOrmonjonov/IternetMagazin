<%@ page import="org.example.demo2.DB" %>
<%@ page import="org.example.demo2.Category" %>
<%@ page import="org.example.demo2.Product" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }
        .container {
            display: flex;
            height: 100vh;
        }
        .sidebar {
            background-color: #333;
            color: white;
            width: 250px;
            padding: 20px;
            height: 100%;
        }
        .gap {
            display: flex;
            gap: 20px;
        }
        .content {
            background-color: #f4f4f4;
            flex-grow: 1;
            padding: 20px;
            height: 100%;
            overflow-y: auto;
        }
        .header {
            position: fixed;
            top: 10px;
            right: 10px;
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            border-radius: 10px;
            cursor: pointer;
            z-index: 10;
        }
        .header:hover {
            background-color: #0056b3;
        }
        .category-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            border-radius: 6px;
            width: 100%;
        }
        .category-button.active {
            background-color: #218838;
        }
        .category-button:hover {
            background-color: #45a049;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }
        .product-card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .product-card img {
            width: 100%;
            max-height: 150px;
            object-fit: cover;
            border-radius: 6px;
        }
        .product-card h3 {
            font-size: 1.2em;
            margin: 10px 0 5px;
        }
        .product-card p {
            margin: 5px 0 15px;
            color: #555;
        }
        .product-button {
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            border-radius: 6px;
            font-size: 1em;
        }
        .product-button.select {
            background-color: #007BFF;
            color: white;
        }
        .product-button.select:hover {
            background-color: #0056b3;
        }
        .product-button.deselect {
            background-color: #FF0000;
            color: white;
        }
        .product-button.deselect:hover {
            background-color: #CC0000;
        }
    </style>
</head>
<body>

<%
    Map<Integer, Boolean> cart = (Map<Integer, Boolean>) session.getAttribute("cart");
    if (cart == null) {
        cart = new HashMap<>();
        session.setAttribute("cart", cart);
    }

    String categoryIdParam = request.getParameter("categoryId");
    String toggleParam = request.getParameter("toggleProductId");

    if (toggleParam != null && toggleParam.matches("\\d+")) {
        int toggleProductId = Integer.parseInt(toggleParam);
        if (cart.containsKey(toggleProductId)) {
            cart.remove(toggleProductId);
        } else {
            cart.put(toggleProductId, true);
        }
        application.setAttribute("cart", cart);
    }
%>

<div class="header">
    <div class="gap">
        <a href="cart.jsp" class="button-link">Savat (<%= cart.size() %>)</a><br>

        <form action="previous_orders.jsp">
            <button class="button-link">Buyurtmalar tarixi</button>
        </form>
    </div>
</div>

<div class="container">
    <div class="sidebar">
        <h2>Kategoriyalar</h2>
        <ul>
            <li>
                <form method="get">
                    <button type="submit"
                            class="category-button <%= (categoryIdParam == null || categoryIdParam.isEmpty()) ? "active" : "" %>"
                            name="categoryId" value="">
                        All
                    </button>
                </form>
                <br><br>
            </li>

            <%
                for (Category category : DB.category) {
                    boolean isActive = false;
                    if (categoryIdParam != null && categoryIdParam.matches("\\d+")) {
                        isActive = Integer.parseInt(categoryIdParam) == category.getId();
                    }
            %>
            <li>
                <form method="get">
                    <button type="submit" class="category-button <%= isActive ? "active" : "" %>" name="categoryId"
                            value="<%= category.getId() %>">
                        <%= category.getName() %>
                    </button>
                </form>
                <br><br>
            </li>
            <%
                }
            %>
        </ul>
    </div>

    <div class="content">
        <h1>Mahsulotlar</h1>
        <div class="product-grid">
            <%
                boolean productFound = false;

                for (Product product : DB.product) {
                    if (categoryIdParam == null || categoryIdParam.isEmpty() ||
                            (categoryIdParam.matches("\\d+") && Integer.parseInt(categoryIdParam) == product.getCategory_Id())) {
                        productFound = true;
            %>
            <div class="product-card">
                <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                <h3><%= product.getName() %></h3>
                <p>Price: $<%= product.getPrice() %></p>
                <form method="get">
                    <input type="hidden" name="categoryId" value="<%= categoryIdParam %>">
                    <button type="submit"
                            class="product-button <%= cart.containsKey(product.getId()) ? "deselect" : "select" %>"
                            name="toggleProductId" value="<%= product.getId() %>">
                        <%= cart.containsKey(product.getId()) ? "X" : "Select" %>
                    </button>
                </form>
            </div>
            <%
                    }
                }

                if (!productFound) {
            %>
            <p>Bu kategoriyada mahsulotlar mavjud emas.</p>
            <%
                }
            %>
        </div>
    </div>
</div>
</body>
</html>

