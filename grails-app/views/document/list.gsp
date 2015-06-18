
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
		<div class="nav" role="navigation" >
			<ul>
				<li><a class="home" href="${createLink(uri: '/document/list')}"><g:message code="Dokumentide list"/></a></li>
                <li><a class="search" href="${createLink(uri: '/document/search')}"><g:message code="Otsi dokumente"/></a></li>
                <li> <form action="create" method="get" >

                    <input type="hidden" name="catalog_id" value="${params.catalog_id}" />
                    <select name="doc_type_id">
                        <g:each in="${dokumendid.classificator.DocType.list()}" var="d">
                            <g:if test="${d.level == 1}">
                                <option value="${d.id}">${d.type_name}</option>
                                <g:each in="${dokumendid.classificator.DocType.list()}" var="e">
                                    <g:if test="${e.level == 2 && e.super_type_fk == d.id}">
                                        <option value="${e.id}">  - - ${e.type_name}</option>
                                        <g:each in="${dokumendid.classificator.DocType.list()}" var="f">
                                            <g:if test="${f.level == 3 && f.super_type_fk == e.id}">
                                                <option value="${f.id}">  - - - - ${f.type_name}</option>
                                            </g:if>
                                        </g:each>
                                    </g:if>
                                </g:each>
                            </g:if>
                        </g:each>
                    </select>

                    <button type="submit" class="btn">Lisa uus</button>

                </form>
                </li>
			</ul>
		</div>

    <div style="float: left; width: 20%">
        <h1>Kaustad</h1>
        <ul class="folder-menu">
            <g:each in="${dokumendid.DocCatalog.list()}" var="c">
                <g:if test="${c.level == 1}">
                    <li>
                        <a href="?catalog_id=${c.id}">${c.name}</a>
                        <g:each in="${dokumendid.DocCatalog.list()}" var="d">
                            <g:if test="${d.level == 2 && d.upper_catalog_fk == c.id}">
                                <li style="padding-left: 30px;">
                                    <a href="?catalog_id=${d.id}">${d.name}</a>
                                    <g:each in="${dokumendid.DocCatalog.list()}" var="e">
                                        <g:if test="${e.level == 3 && e.upper_catalog_fk == d.id}">
                                            <li style="padding-left: 30px;">
                                                <a href="?catalog_id=${e.id}">${e.name}</a>
                                            </li>
                                        </g:if>
                                    </g:each>
                                </li>
                            </g:if>
                        </g:each>
                    </li>
                </g:if>
            </g:each>
        </ul>
    </div>
    <div style="float: left; width:80%">

		<div id="list-document" class="content scaffold-list" role="main">
            <div style="float: left; width: 50%;">
			    <h1><g:message code="Dokumentide list" args="[entityName]" /></h1>

                <g:if test="${session.cut}">
                    <button onclick="window.location.href='paste?catalog_id=${params.catalog_id}'">Liiguta puhver siia</button>
                    <button onclick="window.location.href='cuts'">Vaata puhvrit</button>
                </g:if>
            </div>

            <div style="float: left; width: 50%; padding-top: 10px; text-align: right;">
                <button onclick="cutDocuments()">Cut</button>

            </div>
            <div style="clear: both"></div>

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
                        <th></th>

					</tr>
				</thead>
				<tbody>
				<g:each in="${documentInstanceList}" status="i" var="documentInstance">
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
			<div class="pagination">
				<g:paginate total="${documentInstanceTotal}" max="50" params="${[catalog_id:params.get("catalog_id")]}" />
			</div>
		</div>
    </div>
    <script type="text/javascript">
    function cutDocuments() {
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
            data: {id: cuts.join(',')},
            success: function(ret) {

            }
        })

    }
    </script>
	</body>
</html>