package org.example.demo2;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/remove")
public class RemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Map<Integer, Boolean> cart = (Map<Integer, Boolean>) getServletContext().getAttribute("cart");

        String productIdParam = request.getParameter("productId");
        if (cart != null && productIdParam != null) {
            int productId = Integer.parseInt(productIdParam);

            cart.remove(productId);
        }


        response.sendRedirect("cart.jsp");
    }
}
