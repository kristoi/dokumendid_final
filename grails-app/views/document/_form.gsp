<%@ page import="dokumendid.Document" %>



<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'created_by', 'error')} required">
	<label for="created_by">
		<g:message code="document.created_by.label" default="Createdby" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="created_by" required="" value="${fieldValue(bean: documentInstance, field: 'created_by')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'updated_by', 'error')} required">
	<label for="updated_by">
		<g:message code="document.updated_by.label" default="Updatedby" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="updated_by" required="" value="${fieldValue(bean: documentInstance, field: 'updated_by')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'attributes', 'error')} ">
	<label for="attributes">
		<g:message code="document.attributes.label" default="Attributes" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${documentInstance?.attributes?}" var="a">
    <li><g:link controller="docAttribute" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="docAttribute" action="create" params="['document.id': documentInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'docAttribute.label', default: 'DocAttribute')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'creator', 'error')} required">
	<label for="creator">
		<g:message code="document.creator.label" default="Creator" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="creator" name="creator.id" from="${dokumendid.Person.list()}" optionKey="id" required="" value="${documentInstance?.creator?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="document.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${documentInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'doc_nr', 'error')} ">
	<label for="doc_nr">
		<g:message code="document.doc_nr.label" default="Docnr" />
		
	</label>
	<g:textField name="doc_nr" value="${documentInstance?.doc_nr}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'filename', 'error')} ">
	<label for="filename">
		<g:message code="document.filename.label" default="Filename" />
		
	</label>
	<g:textField name="filename" value="${documentInstance?.filename}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="document.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${documentInstance?.name}"/>
</div>

