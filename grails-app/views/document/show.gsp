
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
		<div id="show-document" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list document">

				<g:if test="${documentInstance?.name}">
					<li class="fieldcontain">
						<span id="file_name-label" class="property-label"><g:message code="document.filename.label" default="Faili nimi" /></span>

						<span class="property-value" aria-labelledby="file_name-label">${documentInstance.name}</span>

					</li>
				</g:if>

				<g:if test="${documentInstance?.doc_nr}">
					<li class="fieldcontain">
						<span id="doc_nr-label" class="property-label"><g:message code="document.lastUpdated.label" default="Dokument number" /></span>

						<span class="property-value" aria-labelledby="lastUpdate-label">${documentInstance.doc_nr}</span>

					</li>
				</g:if>
			
				<g:if test="${documentInstance?.creator.person}">
				<li class="fieldcontain">
					<span id="created_by-label" class="property-label"><g:message code="document.created_by.label" default="Dokumendi looja" /></span>
					
						<span class="property-value" aria-labelledby="created_by-label">${documentInstance.creator.person.getName()}</span>
					
				</li>
				</g:if>

				<g:if test="${documentInstance?.description}">
					<li class="fieldcontain">
						<span id="description-label" class="property-label"><g:message code="document.description.label" default="Kirjeldus" /></span>

						<span class="property-value" aria-labelledby="created_by-label">${documentInstance.description}</span>

					</li>
				</g:if>

				<g:if test="${documentInstance?.dateCreated}">
					<li class="fieldcontain">
						<span id="date_created-label" class="property-label"><g:message code="document.date_created.label" default="Fail loodud" /></span>

						<span class="property-value" aria-labelledby="created_by-label">${documentInstance.dateCreated}</span>

					</li>
				</g:if>

				<g:if test="${documentInstance?.lastUpdated}">
					<li class="fieldcontain">
						<span id="lastUpdate-label" class="property-label"><g:message code="document.lastUpdated.label" default="Viimane uuendus failile" /></span>

						<span class="property-value" aria-labelledby="lastUpdate-label">${documentInstance.lastUpdated}</span>

					</li>
				</g:if>

				<g:if test="${documentInstance?.doc_catalog.catalog.name}">
					<li class="fieldcontain">
						<span id="lastUpdate-label" class="property-label"><g:message code="document.lastUpdated.label" default="Viimane uuendus failile" /></span>

						<span class="property-value" aria-labelledby="lastUpdate-label">${documentInstance.doc_catalog.catalog.name}</span>

					</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<!-- <g:hiddenField name="id" value="${documentInstance?.created_by}" /> --!>
					<g:link class="edit" action="edit" id="${documentInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
