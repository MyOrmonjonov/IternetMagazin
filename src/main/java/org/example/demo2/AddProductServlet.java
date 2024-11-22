package org.example.demo2;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.Random;
import java.util.UUID;

@WebServlet("/addProduct")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");
        String productPriceStr = request.getParameter("productPrice");
        String categoryStr = request.getParameter("category");
        Part filePart = request.getPart("productImage");


        if (productName == null || productName.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please enter a product name.");
            request.getRequestDispatcher("addProduct.jsp").forward(request, response);
            return;
        }

        double productPrice;
        try {
            productPrice = Double.parseDouble(productPriceStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Please enter a valid product price.");
            request.getRequestDispatcher("addProduct.jsp").forward(request, response);
            return;
        }


        int categoryId;
        try {
            categoryId = Integer.parseInt(categoryStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid category selected.");
            request.getRequestDispatcher("addProduct.jsp").forward(request, response);
            return;
        }

        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("errorMessage", "Please upload a product image.");
            request.getRequestDispatcher("addProduct.jsp").forward(request, response);
            return;
        }


        String originalFileName = filePart.getSubmittedFileName();
        String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFileName;
        String uploadDir = getServletContext().getRealPath("/files");
        File filesDir = new File(uploadDir);

        if (!filesDir.exists() && !filesDir.mkdirs()) {
            throw new ServletException("Failed to create directory: " + uploadDir);
        }

        String filePath = uploadDir + File.separator + uniqueFileName;


        try {
            filePart.write(filePath);
        } catch (IOException e) {
            request.setAttribute("errorMessage", "Error while saving the file: " + e.getMessage());
            request.getRequestDispatcher("addProduct.jsp").forward(request, response);
            return;
        }


        Category category = DB.getCategoryById(categoryId);
        Random random = new Random();
        int productId = random.nextInt(51) + 50;

        Product newProduct = new Product(productId, productName, productPrice, category.getId(), "files/" + uniqueFileName);
        DB.addProduct(newProduct);


        response.sendRedirect("adminPanel.jsp");
    }
}
