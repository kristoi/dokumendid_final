<%@ page import="dokumendid.Document" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#edit-document" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
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
		<div id="edit-document" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${documentInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${documentInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" >
				<g:hiddenField name="id" value="${documentInstance?.id}" />
				<g:hiddenField name="version" value="${documentInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
