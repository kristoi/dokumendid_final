<%@ page import="dokumendid.Document" %>



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

<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'doc_type', 'error')} required">
	<label for="doc_type">
		<g:message code="document.doc_type.label" default="Doctype" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="doc_type" name="doc_type.id" from="${dokumendid.classificator.DocType.list()}" optionKey="id" optionValue="type_name" required="" value="${documentInstance?.doc_type?.type?.id}" class="many-to-one"/>
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


<fieldset>
    <legend>Attributes</legend>

<g:if test="${documentInstance?.attributes}">
<div class="fieldcontain ${hasErrors(bean: documentInstance, field: 'attributes', 'error')} ">
    <g:each in="${documentInstance.attributes}" var="a">
        <div>
            <label>${a.type_name}</label>
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
                    <!-- TODO: select nimekiri -->
                    <select name="blabla">
                        <g:each in="${a.doc_attribute_type.selections}" var="b">
                            <option value="" <g:if test="${a.atr_type_selection_value == b.id}">selected</g:if>>${b.value_text}</option>
                        </g:each>

                    </select>
                </g:elseif>
            </span>
        </div>
    </g:each>
</div>
</g:if>
<g:else>
    <g:each in="${dokumendid.DocAttributeType.list()}" var="b">
        <div class="fieldcontain">
            <label>${b.type_name}</label>
            <g:if test="${b.data_type_fk == 1}">
                <input type="text" name="attribute.${b.id}" <g:if test="${dokumendid.classificator.DocType.isRequired(b.id) == 1}></g:if> />
            </g:if>
            <g:elseif test="${b.data_type_fk == 2}">
                <input type="text" name="attribute.${b.id}" />
            </g:elseif>
            <g:elseif test="${b.data_type_fk == 3}">
                <input type="text" name="attribute.${b.id}" />
            </g:elseif>
            <g:elseif test="${b.data_type_fk == 4}">
                <!-- TODO: select nimekiri -->
                <select name="attribute.${b.id}">
                    <g:each in="${b.selections}" var="c">
                        <option value="${c.id}" <g:if test="${b.default_selection.id == c.id}">selected</g:if>>${c.value_text}</option>
                    </g:each>
                </select>
            </g:elseif>
        </div>
    </g:each>
</g:else>

</fieldset>