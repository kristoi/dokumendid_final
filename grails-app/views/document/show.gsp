<%@ page import="dokumendid.Document" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-document" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                               default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-document" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list document">

        <g:if test="${documentInstance?.created_by}">
            <li class="fieldcontain">
                <span id="created_by-label" class="property-label"><g:message code="document.created_by.label"
                                                                              default="Createdby"/></span>

                <span class="property-value" aria-labelledby="created_by-label"><g:fieldValue bean="${documentInstance}"
                                                                                              field="created_by"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.updated_by}">
            <li class="fieldcontain">
                <span id="updated_by-label" class="property-label"><g:message code="document.updated_by.label"
                                                                              default="Updatedby"/></span>

                <span class="property-value" aria-labelledby="updated_by-label"><g:fieldValue bean="${documentInstance}"
                                                                                              field="updated_by"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.dateCreated}">
            <li class="fieldcontain">
                <span id="dateCreated-label" class="property-label"><g:message code="document.dateCreated.label"
                                                                               default="Date Created"/></span>

                <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                        date="${documentInstance?.dateCreated}"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.description}">
            <li class="fieldcontain">
                <span id="description-label" class="property-label"><g:message code="document.description.label"
                                                                               default="Description"/></span>

                <span class="property-value" aria-labelledby="description-label"><g:fieldValue
                        bean="${documentInstance}" field="description"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.doc_nr}">
            <li class="fieldcontain">
                <span id="doc_nr-label" class="property-label"><g:message code="document.doc_nr.label"
                                                                          default="Docnr"/></span>

                <span class="property-value" aria-labelledby="doc_nr-label"><g:fieldValue bean="${documentInstance}"
                                                                                          field="doc_nr"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.filename}">
            <li class="fieldcontain">
                <span id="filename-label" class="property-label"><g:message code="document.filename.label"
                                                                            default="Filename"/></span>

                <span class="property-value" aria-labelledby="filename-label"><g:fieldValue bean="${documentInstance}"
                                                                                            field="filename"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.lastUpdated}">
            <li class="fieldcontain">
                <span id="lastUpdated-label" class="property-label"><g:message code="document.lastUpdated.label"
                                                                               default="Last Updated"/></span>

                <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                        date="${documentInstance?.lastUpdated}"/></span>

            </li>
        </g:if>

        <g:if test="${documentInstance?.name}">
            <li class="fieldcontain">
                <span id="name-label" class="property-label"><g:message code="document.name.label"
                                                                        default="Name"/></span>

                <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${documentInstance}"
                                                                                        field="name"/></span>

            </li>
        </g:if>

    </ol>
    <g:form>
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${documentInstance?.id}"/>
            <g:link class="edit" action="edit" id="${documentInstance?.id}"><g:message code="default.button.edit.label"
                                                                                       default="Edit"/></g:link>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
