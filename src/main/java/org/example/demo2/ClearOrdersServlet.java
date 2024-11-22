package org.example.demo2;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ClearOrdersServlet")
public class ClearOrdersServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Buyurtmalar ro'yxatini tozalash
        DB.orders1.clear();
        // Asosiy sahifaga qaytarish
        response.sendRedirect("placeOrder.jsp");
    }
}
