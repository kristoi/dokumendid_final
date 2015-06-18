
<%@ page import="dokumendid.Document" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
<a href="#show-document" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/document/list')}"><g:message code="Dokumentide list"/></a></li>
        <li><a class="search" href="${createLink(uri: '/document/search')}"><g:message code="Otsi dokumente"/></a></li>
        <li>
        </li>
    </ul>
</div>
<div id="show-document" class="content scaffold-show" role="main">
    <h1>Dokumendi seosed</h1>
    <h2>Dokument: <g:link action="show" id="${documentInstance.id}" name="${documentInstance.name}">${documentInstance.name}</g:link></h2>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <br />

    <table>
        <thead>
        <tr>

            <th>Subjekt</th>
            <th>Tüüp</th>
            <th>Märkus</th>
            <th></th>


        </tr>
        </thead>
        <tbody>
        <g:each in="${documentInstance.subjects}" status="i" var="documentSubjectList">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td>
                    <g:if test="${documentSubjectList.subject_type.id == 1}">
                        ${documentSubjectList.person.name}
                    </g:if>
                    <g:else>
                        ${documentSubjectList.enterprise.name}
                    </g:else>

                </td>
                <td>${documentSubjectList.type.type_name}</td>
                <td>${documentSubjectList.note}</td>
                <td><g:link action="delete_link" id="${documentSubjectList.id}">Kustuta</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <fieldset class="buttons">
        <g:link class="links" action="add_links" id="${documentInstance?.id}"><g:message code="default.button.edit.links" default="Lisa uus seos" /></g:link>
    </fieldset>
</div>
</body>
</html>
