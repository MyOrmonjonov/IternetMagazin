<%@ page import="org.example.demo2.DB" %>
<%@ page import="org.example.demo2.Order" %>
<%@ page import="org.example.demo2.OrderItem" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Oldingi Buyurtmalar</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f9f9f9;
      margin: 0;
      padding: 20px;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .container {
      background-color: #fff;
      max-width: 600px;
      margin: auto;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    h1 {
      font-size: 24px;
      color: #28a745;
      margin-bottom: 20px;
    }

    p {
      font-size: 18px;
      color: #555;
      margin-bottom: 10px;
    }

    .order-item {
      margin: 10px 0;
      padding: 10px;
      background-color: #f1f1f1;
      border-radius: 5px;
      border: 1px solid #ddd;
    }

    .error {
      color: #dc3545;
    }

    a {
      display: inline-block;
      margin-top: 20px;
      padding: 10px 20px;
      font-size: 16px;
      color: #007bff;
      text-decoration: none;
      border: 1px solid #007bff;
      border-radius: 5px;
      transition: all 0.3s ease;
    }

    a:hover {
      background-color: #007bff;
      color: #fff;
    }
  </style>
</head>
<body>
<div class="container">
  <%
    List<Order> orders = DB.orders1; // Get the list of previous orders from DB
    if (orders == null || orders.isEmpty()) {
  %>
  <h1 class="error">Sizda hech qanday oldingi buyurtmalar yo'q!</h1>
  <a href="category.jsp">Kategoriyalarga qaytish</a>
  <%
  } else {
  %>
  <h1>Oldingi Buyurtmalar</h1>
  <ul>
    <% for (Order order : orders) { %>
    <li>
      <p><strong>Buyurtma raqami:</strong> <%= order.getId() %></p>
      <p><strong>Buyurtma sanasi:</strong> <%= order.getOrderDate() %></p>
      <p><strong>Umumiy narx:</strong> <%= order.getTotalPrice() %> UZS</p>
      <h3>Buyurtmadagi mahsulotlar:</h3>
      <ul>
        <% for (OrderItem item : order.getItems()) { %>
        <li class="order-item">
          <%= item.getName() %> - <%= item.getPrice() %> UZS (Soni: <%= item.getQuantity() %>)
        </li>
        <% } %>
      </ul>
    </li>
    <% } %>
  </ul>
  <a href="category.jsp">Kategoriyalarga qaytish</a>
  <%
    }
  %>
</div>
</body>
</html>
