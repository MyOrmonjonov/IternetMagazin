<%@ page import="org.example.demo2.DB" %>
<%@ page import="org.example.demo2.Order" %>
<%@ page import="org.example.demo2.OrderItem" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.example.demo2.Product" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buyurtma</title>
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

        .error {
            color: #dc3545;
        }

        .order-item {
            margin: 10px 0;
            padding: 10px;
            background-color: #f1f1f1;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
<div class="container">
    <%

        String userId = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    userId = cookie.getValue();
                    break;
                }
            }
        }

        if (userId == null) {
    %>
    <h1 class="error">Foydalanuvchi tizimga !</h1>hali kirmagan
    <a href="index.jsp">Tizimga kirish</a>
    <%
            return;
        }


        Map<Integer, Boolean> cart = (Map<Integer, Boolean>) application.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
    <h1 class="error">Savat bo'sh!</h1>
    <a href="cart.jsp">Savatga qaytish</a>
    <%
            return;
        }

        int total = 0;
        ArrayList<OrderItem> orderItems = new ArrayList<>();


        for (Map.Entry<Integer, Boolean> entry : cart.entrySet()) {
            int productId = entry.getKey();
            int quantity = entry.getValue() ? 1 : 0;

            Product product = null;

            for (Product p : DB.product) {
                if (p.getId() == productId) {
                    product = p;
                    break;
                }
            }

            if (product != null) {
                total += product.getPrice() * quantity;
                orderItems.add(new OrderItem(productId, product.getName(), product.getPrice(), quantity));
            }
        }


        if (!orderItems.isEmpty()) {
            Random random = new Random();
            int orderId = random.nextInt(1000) + 1;


            boolean isDuplicate = false;
            for (Order existingOrder : DB.orders1) {
                if (existingOrder.getId() == orderId) {
                    isDuplicate = true;
                    break;
                }
            }

            if (!isDuplicate) {
                Order order = new Order(orderId, LocalDateTime.now(), total);
                for (OrderItem item : orderItems) {
                    order.addItem(item);
                }

                DB.orders1.add(order);
                cart.clear();

    %>
    <h1>Buyurtma muvaffaqiyatli bajarildi!</h1>
    <p>Buyurtma raqami: <%= order.getId() %></p>
    <p>Umumiy narx: <%= order.getTotalPrice() %> UZS</p>

    <h2>Buyurtmadagi mahsulotlar:</h2>
    <ul>
        <% for (OrderItem item : order.getItems()) { %>
        <li class="order-item">
            <%= item.getName() %> - <%= item.getPrice() %> UZS (Soni: <%= item.getQuantity() %>)
        </li>
        <% } %>
    </ul>

    <a href="category.jsp">Kategoriyalarga qaytish</a>
    <br>
    <a href="previous_orders.jsp">Oldingi buyurtmalarni ko'rish</a>

    <%
    } else {
    %>
    <h1 class="error">Bu buyurtma identifikatori bilan buyurtma allaqachon mavjud!</h1>
    <a href="cart.jsp">Savatga qaytish</a>
    <%
        }
    } else {
    %>
    <h1 class="error">Buyurtma yaratishda xatolik yuz berdi!</h1>
    <a href="cart.jsp">Savatga qaytish</a>
    <%
        }
    %>
</div>
</body>
</html>
