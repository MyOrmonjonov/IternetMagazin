<%@ page import="org.example.demo2.DB" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String categoryName = request.getParameter("categoryName");
    DB.addCategory(categoryName); // DB.addCategory() metodini qo'shing
    response.sendRedirect("adminPanel.jsp?view=categories"); // Kategoriyalar ro'yxatiga qaytish
%>
