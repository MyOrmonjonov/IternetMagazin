package org.example.demo2;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
public static User currentUser=null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        Optional<User> OptionalUser = DB.user.stream().filter(item -> item.getPassword().equals(password) && item.getPhoneNumber().equals(phone)).findFirst();



        if (OptionalUser.isPresent()) {
            resp.addCookie(new Cookie("token","sirlikalit"));
            currentUser=OptionalUser.get();
            resp.sendRedirect("category.jsp");
        } else {
            resp.sendRedirect("index.jsp");
        }
    }
}
