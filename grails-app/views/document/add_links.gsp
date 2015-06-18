<%@ page import="dokumendid.Document" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script src="https://raw.githubusercontent.com/devbridge/jQuery-Autocomplete/master/dist/jquery.autocomplete.min.js"></script>

    <style>
        .autocomplete-suggestions {
            background: #fff;
        }
        .autocomplete-suggestion {
            padding: 2px;
            cursor: pointer;
            border-bottom: 1px solid #eee;
        }

        .autocomplete-suggestion:hover {
            background: #eee;
        }
    </style>
</head>
<body>
<a href="#create-document" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/document/list')}"><g:message code="default.home.label"/></a></li>
        <li><a class="search" href="${createLink(uri: '/document/search')}"><g:message code="Otsi dokumente"/></a></li>
    </ul>
</div>
<div id="create-document" class="content scaffold-create" role="main">
    <h1>Lisa uus seos</h1>

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

    <g:hasErrors bean="${docSubjectInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${docSubjectInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>

    <g:form action="save_links" >

        <input type="hidden" name="id" value="${documentInstance.id}" />
        <input id="subject_fk" type="hidden" name="subject_fk" value="" />
        <input id="type_id" type="hidden" name="subject_type.id" value="" />

        <fieldset>

        <h3>Sujekti otsing</h3>
        <div class="fieldcontain ${hasErrors(bean: documentInstance.subjects, field: 'subject_fk', 'error')} ">
            <label for="description">
                <g:message code="document.description.label" default="Nimi" />

            </label>
            <g:textField id="subject_search" name="t" value=""/>
        </div>

            <h3>Seos</h3>

        <div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'doc_nr', 'error')} ">
            <label for="doc_nr">
                <g:message code="document.doc_nr.label" default="Seose tüüp" />

            </label>
            <select name="type.id">
                <g:each in="${dokumendid.classificator.DocSubjectRelationType.findAll()}" var="d">
                    <option value="${d.id}">${d.type_name}</option>
                </g:each>
            </select>
        </div>


        <div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'filename', 'error')} ">
            <label for="filename">
                <g:message code="document.filename.label" default="Märkus" />

            </label>
            <g:textArea name="note" value="${documentInstance?.filename}"/>
        </div>

        </fieldset>

        <input type="submit" value="Lisa seos" />
    </g:form>
</div>
<script type="text/javascript">
    $('#subject_search').autocomplete({
        serviceUrl: '../subject_search',
        onSelect: function (suggestion) {
            $('#subject_fk').val(suggestion.data.id);
            $('#type_id').val(suggestion.data.doc_subject_type_fk);

            alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
        }
    });
</script>
</body>
</html>
