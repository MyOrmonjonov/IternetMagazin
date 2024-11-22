<%@ page import="org.example.demo2.DB" %>
<%@ page import="org.example.demo2.Product" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="org.example.demo2.Order" %>
<%@ page import="org.example.demo2.OrderItem" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Savat</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f9f9f9;
      padding: 20px;
    }

    .container {
      max-width: 800px;
      margin: auto;
      padding: 20px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    h1 {
      text-align: center;
      margin-bottom: 20px;
      font-size: 24px;
      color: #333;
    }

    .product-card {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px;
      margin-bottom: 15px;
      border: 1px solid #ddd;
      border-radius: 8px;
      background-color: #fafafa;
    }

    .product-info {
      display: flex;
      gap: 20px;
      align-items: center;
    }

    .product-image {
      width: 60px;
      height: 60px;
      object-fit: cover;
      border-radius: 5px;
      border: 1px solid #ddd;
    }

    .product-name {
      font-size: 18px;
      font-weight: bold;
      color: #333;
    }

    .product-price {
      font-size: 16px;
      color: #777;
    }

    .product-actions {
      display: flex;
      gap: 10px;
      align-items: center;
    }

    .product-actions a, .remove-button {
      font-size: 16px;
      text-decoration: none;
      padding: 5px 10px;
      border: 1px solid #007BFF;
      border-radius: 5px;
      color: #007BFF;
      background-color: #fff;
      cursor: pointer;
    }

    .product-actions a:hover, .remove-button:hover {
      background-color: #007BFF;
      color: #fff;
    }

    .total {
      text-align: center;
      font-size: 20px;
      font-weight: bold;
      margin-top: 20px;
    }

    .order-button {
      display: block;
      width: 100%;
      padding: 10px 0;
      margin-top: 20px;
      font-size: 18px;
      text-align: center;
      border: none;
      background-color: #28a745;
      color: #fff;
      border-radius: 5px;
      cursor: pointer;
    }

    .order-button:hover {
      background-color: #218838;
    }

    .back-button {
      display: block;
      margin-top: 20px;
      padding: 10px 0;
      text-align: center;
      font-size: 18px;
      color: #007BFF;
      background-color: #fff;
      border: 1px solid #007BFF;
      border-radius: 5px;
      text-decoration: none;
      cursor: pointer;
    }

    .back-button:hover {
      background-color: #f1f1f1;
    }
  </style>
</head>
<body>
<%
  Cookie[] cookies = request.getCookies();
  boolean isLoggedIn = false;

  if (cookies != null) {
    for (Cookie cookie : cookies) {
      if ("token".equals(cookie.getName())) {
        isLoggedIn = true;
        break;
      }
    }
  }

  if (!isLoggedIn) {
    response.sendRedirect("index.jsp");
    return;
  }
%>
<div class="container">
  <h1>Savat</h1>
  <%
    Map<Integer, Boolean> cart = (Map<Integer, Boolean>) application.getAttribute("cart");
    int total = 0;
    ArrayList<OrderItem> orderItems = new ArrayList<>();
    if (cart != null && !cart.isEmpty()) {
      for (Map.Entry<Integer, Boolean> entry : cart.entrySet()) {
        int productId = entry.getKey();
        Product product = null;
        for (Product p : DB.product) {
          if (p.getId() == productId) {
            product = p;
            break;
          }
        }
        if (product != null) {
          total += product.getPrice() * product.getCount();
          orderItems.add(new OrderItem(productId, product.getName(), product.getPrice(), product.getCount()));
  %>
  <div class="product-card">
    <div class="product-info">
      <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>" class="product-image">
      <div>
        <div class="product-name"><%= product.getName() %></div>
        <div class="product-price">Price: <%= product.getPrice() %> UZS</div>
      </div>
    </div>
    <div class="product-actions">
      <a href="updateCart.jsp?productId=<%= product.getId() %>&action=decrease">-</a>
      <span><%= product.getCount() %></span>
      <a href="updateCart.jsp?productId=<%= product.getId() %>&action=increase">+</a>
      <a href="updateCart.jsp?productId=<%= product.getId() %>&action=remove" class="remove-button">Remove</a>
    </div>
  </div>
  <%
      }
    }
  %>
  <div class="total">Umumiy narx: <%= total %> UZS</div>
  <form action="placeOrder.jsp" method="post">
    <input type="hidden" name="total" value="<%= total %>">
    <button type="submit" class="order-button">Buyurtma berish</button>
  </form>
  <%
    // Removed the order creation logic from here
  } else {
  %>
  <p>Savatda hech qanday mahsulot mavjud emas.</p>
  <% } %>
  <a href="category.jsp" class="back-button">Orqaga</a>
</div>
</body>
</html>

