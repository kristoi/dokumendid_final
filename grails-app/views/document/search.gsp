
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
        <li><a class="home" href="${createLink(uri: '/document/list')}"><g:message code="Dokumentide list"/></a></li>
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


    <div id="list-document" class="content scaffold-list" role="main">
        <div >
            <h1>Dokumentide otsing</h1>
        </div>



        <div style="padding: 30px;">
            <form id="search_form" action="" method="get">
                <div>
                    <label>ID</label>
                    <input type="text" name="id" value="${params?.id}" />
                </div>
                <div>
                    <label>Nimi</label>
                    <input type="text" name="name" value="${params?.name}" />
                </div>
                <div>
                    <label>Kirjeldus</label>
                    <input type="text" name="description" value="${params?.description}" />
                </div>

                <div>
                    <label>Viimane muutja</label>
                    <input type="text" name="updated_by" value="${params?.updated_by}" />
                </div>

                <div>
                    <label>Kataloogi nimi</label>
                    <input type="text" name="catalog_name" value="${params?.catalog_name}" />
                </div>


                <div>
                    <label>Staatus</label>
                    <select name="doc_status_type_id">
                        <option value=""></option>
                        <g:each in="${dokumendid.classificator.DocStatusType.list()}" var="s">
                            <option value="${s.id}" <g:if test="${s.id == params?.getLong('doc_status_type_id')}">selected</g:if>>${s.type_name}</option>
                        </g:each>
                    </select>
                </div>


                <g:if test="${params?.doc_type_id}">
                    <g:each in="${dokumendid.DocAttributeType.list()}" var="b">
                        <div class="fieldcontain ">
                            <label>${b.type_name}</label>
                            <g:if test="${b.data_type_fk == 1}">
                                <input type="text" name="attribute.${b.id}" value="${params.get('attribute.' + b.id)}"  />
                            </g:if>
                            <g:elseif test="${b.data_type_fk == 2}">
                                <input type="text" name="attribute.${b.id}" value="${params.get('attribute.' + b.id)}" />
                            </g:elseif>
                            <g:elseif test="${b.data_type_fk == 3}">
                                <input type="text" name="attribute.${b.id} value="${params.get('attribute.' + b.id)}" />
                            </g:elseif>
                            <g:elseif test="${b.data_type_fk == 4}">
                                <!-- TODO: select nimekiri -->
                                <select name="attribute.${b.id}">
                                    <option value=""></option>
                                    <g:each in="${b.selections}" var="c">
                                        <option value="${c.id}" <g:if test="${params?.getLong('attribute.' + b.id) == c.id}">selected</g:if>>${c.value_text}</option>
                                    </g:each>
                                </select>
                            </g:elseif>
                        </div>
                    </g:each>
                </g:if>
                <g:else>
                    <div>
                        <label>Atribuudi väärtus</label>
                        <input type="text" name="attribute_value" value="${params?.attribute_value}" />
                    </div>
                </g:else>


                <div>
                    <label>Tüüp</label>
                    <select name="doc_type_id" onchange="document.getElementById('search_form').submit();">
                        <option value=""></option>
                        <g:each in="${dokumendid.classificator.DocType.list()}" var="d">
                            <g:if test="${d.level == 1}">
                                <option value="${d.id}" <g:if test="${d.id == params?.getLong('doc_type_id')}">selected</g:if>>${d.type_name}</option>
                                <g:each in="${dokumendid.classificator.DocType.list()}" var="e">
                                    <g:if test="${e.level == 2 && e.super_type_fk == d.id}">
                                        <option value="${e.id}" <g:if test="${e.id == params?.getLong('doc_type_id')}">selected</g:if>>  - - ${e.type_name}</option>
                                        <g:each in="${dokumendid.classificator.DocType.list()}" var="f">
                                            <g:if test="${f.level == 3 && f.super_type_fk == e.id}">
                                                <option value="${f.id}" <g:if test="${f.id == params?.getLong('doc_type_id')}">selected</g:if>>  - - - - ${f.type_name}</option>
                                            </g:if>
                                        </g:each>
                                    </g:if>
                                </g:each>
                            </g:if>
                        </g:each>
                    </select>
                </div>

                <div>
                    <input type="submit" value="Otsi" />
                </div>
            </form>
        </div>

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
            <g:each in="${results}" status="i" var="documentInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                    <td><g:link action="show" id="${documentInstance.id}">${documentInstance.doc_nr}</g:link></td>

                    <td><g:link action="show" id="${documentInstance.id}">${fieldValue(bean: documentInstance, field: "name")}</g:link></td>

                    <td>${documentInstance.creator.person.last_name}</td>

                    <td><g:formatDate date="${documentInstance.dateCreated}" /></td>

                    <td>${fieldValue(bean: documentInstance, field: "description")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
        <div class="pagination">
            <g:paginate total="5" max="50" params="${[catalog_id:params.get("catalog_id")]}" />
        </div>
    </div>
</body>
</html>
