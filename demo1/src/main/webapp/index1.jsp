<html>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
<body>
<h2>Hello World!</h2>
</body>
    <a href="${APP_PATH }/emps">emps</a>
    <a href="${APP_PATH }/empsJason">empsJason</a>
</html>
