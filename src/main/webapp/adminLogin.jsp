<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Login</title>
  <style>
    body {
      font-family: Arial, sans-serif;
    }

    .box {
      margin-left: auto;
      margin-right: auto;
      background-color: black;
      width: 300px;
      border-radius: 7px;
      margin-top: 100px;
      padding: 20px;
    }

    .flex-box {
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    input, button {
      margin: 5px;
      padding: 10px;
      width: 100%;
      border-radius: 5px;
    }

    h1 {
      background-color: black;
      color: white;
      text-align: center;
      padding: 10px;
      margin: 0;
      border-radius: 5px 5px 0 0;
    }
  </style>
</head>
<body>

<div class="box">
  <div class="flex-box">
    <h1>Admin Login</h1>

    <form action="/adminLogin" method="post">
      <input type="text" placeholder="Login" name="login" required>
      <br>
      <input type="password" placeholder="Password" name="password" required>
      <br>
      <button type="submit" style="background-color: black; color: white;">Sign In</button>
    </form>
  </div>
</div>

</body>
</html>
