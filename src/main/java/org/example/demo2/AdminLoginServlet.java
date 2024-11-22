package org.example.demo2;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
        String login = request.getParameter("login");
        String password = request.getParameter("password");


        boolean isAdmin = DB.checkAdminLogin(login, password);

        if (isAdmin) {
            response.sendRedirect("adminPanel.jsp");
        } else {
            response.sendRedirect("adminLogin.jsp?error=true");
        }
    }
}
