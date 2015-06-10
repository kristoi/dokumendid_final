<%--
  Created by IntelliJ IDEA.
  User: krist_000
  Date: 10.06.2015
  Time: 22:25
--%>

<html>
<head>
    <title>Documents - Login</title>
    <meta name="layout" content="main" />
</head>
<body>
    <g:form class="simpleform" style="width:50%;" url="[controller:'user',action:'login']">
        <fieldset>
            <legend>Login</legend>
            <p>
                <label for="username">Username</label>
                <g:textField name="username" />
            </p>
            <p>
                <label for="password">Password</label>
                <g:passwordField name="password" />
            </p>
            <p class="button">
                <label>&nbsp;</label>
                <g:submitButton class="button" name="submitButton" value="Login" />
            </p>
        </fieldset>
    </g:form>
</body>
</html>