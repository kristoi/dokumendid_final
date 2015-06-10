
<%@ page import="dokumendid.Document" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-document" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>

    <div style="float: left; width: 20%">
        <ul class="menu">
            <g:each in="${dokumendid.DocCatalog.list()}" var="c">
                <g:if test="${c.level == 1}">
                    <li>${c.name}</li>
                </g:if>
            </g:each>
        </ul>
    </div>
    <div style="float: left; width:80%">

		<div id="list-document" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="created_by" title="${message(code: 'document.created_by.label', default: 'Createdby')}" />
					
						<g:sortableColumn property="updated_by" title="${message(code: 'document.updated_by.label', default: 'Updatedby')}" />
					
						<th><g:message code="document.creator.label" default="Creator" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'document.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'document.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="doc_nr" title="${message(code: 'document.doc_nr.label', default: 'Docnr')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${documentInstanceList}" status="i" var="documentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${documentInstance.id}">${fieldValue(bean: documentInstance, field: "created_by")}</g:link></td>
					
						<td>${fieldValue(bean: documentInstance, field: "updated_by")}</td>
					
						<td>${fieldValue(bean: documentInstance, field: "creator")}</td>
					
						<td><g:formatDate date="${documentInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: documentInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: documentInstance, field: "doc_nr")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${documentInstanceTotal}" />
			</div>
		</div>
    </div>
	</body>
</html>
