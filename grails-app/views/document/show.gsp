
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

                <g:if test="${documentInstance?.updater}">
                    <li class="fieldcontain">
                        <span id="lastUpdate-label" class="property-label"><g:message code="document.lastUpdated.label" default="Viimane uuendaja" /></span>

                        <span class="property-value" aria-labelledby="lastUpdate-label">${documentInstance.updater.person.first_name + ' '  + documentInstance.updater.person.last_name}</span>

                    </li>
                </g:if>

				<g:if test="${documentInstance?.doc_catalog.catalog.name}">
					<li class="fieldcontain">
						<span id="catalog-label" class="property-label"><g:message code="document.lastUpdated.label" default="Kataloog" /></span>

						<span class="property-value" aria-labelledby="lastUpdate-label">${documentInstance.doc_catalog.catalog.name}</span>

					</li>
				</g:if>

			    <hr />
                <g:if test="${documentInstance?.attributes}">
                    <g:each in="${documentInstance.attributes}" var="a">
                        <li class="fieldcontain ${hasErrors(bean: documentInstance, field: 'attributes', 'error')} ">
                            <span id="catalog-label" class="property-label">${a.type_name}</span>
                            <span class="property-value" aria-labelledby="attributes-label">
                                <g:if test="${a.data_type.id == 1}">
                                   ${a.value_text}
                                </g:if>
                                <g:elseif test="${a.data_type.id == 2}">
                                    ${a.value_number}
                                </g:elseif>
                                <g:elseif test="${a.data_type.id == 3}">
                                  ${a.value_date.toGMTString()}
                                </g:elseif>
                                <g:elseif test="${a.data_type.id == 4}">
                                        <g:each in="${a.doc_attribute_type.selections}" var="b">
                                            <g:if test="${a.atr_type_selection_value == b.id}">${b.value_text}</g:if>
                                        </g:each>
                                </g:elseif>
                            </span>
                        </li>
                    </g:each>
                </g:if>
                </ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${documentInstance?.id}" />
                    <g:link class="edit" action="edit" id="${documentInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <g:link class="links" action="links" id="${documentInstance?.id}"><g:message code="default.button.edit.links" default="Seosed" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
