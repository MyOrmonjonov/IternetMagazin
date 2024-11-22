package org.example.demo2;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/update")
public class UpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productIdStr = req.getParameter("productId");
        String action = req.getParameter("action");

        if (productIdStr != null && action != null) {
            int productId = Integer.parseInt(productIdStr);
            Product product = null;
            for (Product p : DB.product) {
                if (p.getId() == productId) {
                    product = p;
                    break;
                }
            }

            if (product != null) {
                if ("increase".equals(action)) {
                    product.setCount(product.getCount() + 1);
                } else if ("decrease".equals(action) && product.getCount() > 0) {
                    product.setCount(product.getCount() - 1);
                }
            }
        }

        resp.sendRedirect("cart.jsp");
    }
}
