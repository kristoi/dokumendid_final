<%--
  Created by IntelliJ IDEA.
  User: krist_000
  Date: 10.06.2015
  Time: 22:25
--%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>User Login</title>
</head>
<body>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/document/list')}"><g:message code="Dokumentide list"/></a></li>
    </ul>
</div>
<div class="body">
    <g:form action="doLogin" method="post">
        <div class="dialog">
            <table  class="userForm">
                <tr class='prop'>
                    <td valign='top' style='text-align:left;' width='20%'>
                        <label for='username'>Username:</label>
                    </td>
                    <td valign='top' style='text-align:left;' width='80%'>
                        <input id="username" type='text' name='username' value='${user?.username}' />
                    </td>
                </tr>
                <tr class='prop'>
                    <td valign='top' style='text-align:left;' width='20%'>
                        <label for='password'>Password:</label>
                    </td>
                    <td valign='top' style='text-align:left;' width='80%'>
                        <input id="password" type='password' name='password'
                               value='${user?.password}' />
                    </td>
                </tr>
            </table>
        </div>
        <div class="buttons">
            <span class="formButton">
                <input type="submit" value="Login"/>
            </span>
        </div>
    </g:form>
</div>
</body>
</html>