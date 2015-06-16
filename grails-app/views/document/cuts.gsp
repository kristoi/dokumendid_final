
<%@ page import="dokumendid.Document" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
</head>
<body>
<a href="#list-document" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
    </ul>
</div>

<div style="float: left; width:100%">

    <div id="list-document" class="content scaffold-list" role="main">
        <h1><g:message code="default.list.label" args="[entityName]" /></h1>


        <button onclick="window.location.href='?do=delete_all'">Kustuta puhvrist kõik</button>
        <button onclick="deleteSelected()">Kustuta puhvrist valitud</button>


        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <table>
            <thead>
            <tr>

                <g:sortableColumn property="Dok_nr" title="${message(code: 'document.created_by.label', default: 'Dok nr')}" />

                <g:sortableColumn property="failinimi" title="${message(code: 'document.doc_nr.label', default: 'Nimi')}" />

                <th><g:message code="document.creator.label" default="Autor" /></th>

                <g:sortableColumn property="dateCreated" title="${message(code: 'document.dateCreated.label', default: 'Fail Loodud')}" />

                <g:sortableColumn property="description" title="${message(code: 'document.description.label', default: 'Kirjeldus')}" />

            </tr>
            </thead>
            <tbody>
            <g:each in="${documents}" status="i" var="documentInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                    <td><g:link action="show" id="${documentInstance.id}">${documentInstance.doc_nr}</g:link></td>

                    <td><g:link action="show" id="${documentInstance.id}">${fieldValue(bean: documentInstance, field: "name")}</g:link></td>

                    <td>${documentInstance.creator.person.last_name}</td>

                    <td><g:formatDate date="${documentInstance.dateCreated}" /></td>

                    <td>${fieldValue(bean: documentInstance, field: "description")}</td>

                    <td>
                        <input class="cut" type="checkbox" name="cut" value="${documentInstance.id}" />
                    </td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript">
    function deleteSelected() {
        //$('.cut').prop('checked', false);

        var cuts = [];
        $('.cut:checked').each(function() {
            cuts.push($(this).val());
        });
        $('.cut').prop('checked', false);

        $.ajax({
            url: "cut",
            type: "POST",
            dataType: "json",
            data: {id: cuts.join(','), do: 'delete_selected'},
            success: function(ret) {
                window.location.href = window.location.href;
            }
        })

    }
</script>
</body>
</html>