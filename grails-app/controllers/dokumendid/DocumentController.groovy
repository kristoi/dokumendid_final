package dokumendid

import dokumendid.classificator.DataType
import dokumendid.classificator.DocStatus
import dokumendid.classificator.DocStatusType
import dokumendid.classificator.DocType
import org.springframework.dao.DataIntegrityViolationException

class DocumentController {
    def beforeInterceptor = [action:this.&checkUser,except:[]]

    def checkUser() {
        if(!session.user) {
        // i.e. user not logged in
            redirect(controller: 'User',action: 'login')
            return false
        }
    }

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    static scaffold = true

    /*

    def index() {
        redirect(action: "list", params: params)
    }*/

    def list() {
        if (!params.catalog_id)
            params.catalog_id = DocCatalog.list().get(0).id;

        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        List<DocumentDocCatalog> catalogList = DocumentDocCatalog.findAllByCatalog(DocCatalog.get(params.catalog_id))

        List<Long> ids = new ArrayList<Long>();

        for (DocumentDocCatalog c : catalogList) {
            ids.push(c.document.id);
        }

        println ids;
        List<Document> dokumendid = Document.findAllByIdInList(ids, params)
        Integer count = Document.findAllByIdInList(ids).size()

        [documentInstanceList: dokumendid ,
         documentInstanceTotal: count]
    }

    def create() {
        //def document = new Document(params);
       // document.setDoc_type(new Doc)

        Document d = new Document(params);

        DocType type = DocType.get(params.doc_type_id)
        DocCatalog catalog = DocCatalog.get(params.catalog_id)


        [documentInstance: d, doc_type: type, doc_catalog: catalog]
    }



    def save() {
        def documentInstance = new Document(params)

        documentInstance.created_by = session.employee_id
        documentInstance.updated_by = null
        documentInstance.lastUpdated = null
        documentInstance.setDoc_catalog(
                new DocumentDocCatalog(document: documentInstance.getId(), catalog: DocCatalog.findById(params.get('doc_catalog_id'))))

        DocumentDocType type = new DocumentDocType();
        type.document = documentInstance;
        type.type = DocType.findById(params.get('doc_type_id'))
        documentInstance.setDoc_type(type)

        DocStatus status = new DocStatus();
        status.document = documentInstance;
        status.type = DocStatusType.get(params.get('doc_status_type.id'));
        status.status_begin = new Date();
        status.status_end = null;
        status.creator = Employee.findById(session.employee_id)
        documentInstance.addToDoc_status(status);




        println params.list("attribute")
        def attributes = params.list("attribute").toArray()


        attributes[0].each{ k, v ->
            DocAttributeType test = DocAttributeType.findById(k);

            String value_text = null;
            String value_number = null;
            String value_date = null;
            String atr_type_selection_value = null;

            if (test.data_type_fk == 1)
                value_text = v;
            else if (test.data_type_fk == 2)
                value_number = v;
            else if (test.data_type_fk == 3)
                value_date = v;
            else if (test.data_type_fk == 4)
                atr_type_selection_value = v;

            documentInstance.addToAttributes(new DocAttribute(
                    document: documentInstance.getId(),
                    doc_attribute_type: test,
                    data_type: DataType.findById(test.data_type_fk),
                    value_text: value_text,
                    value_number: value_number,
                    value_date: value_date,
                    atr_type_selection_value: atr_type_selection_value,
                    type_name: test.type_name,
                    required: 'Y'
            ))
        }






        if (!documentInstance.save(flush: true)) {
            render(view: "create", model: [
                    documentInstance: documentInstance, doc_type: DocType.findById(params.get('doc_type_id')), doc_catalog: DocCatalog.findById(params.get('doc_catalog_id'))])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'document.label', default: 'Document'), documentInstance.id])
        redirect(action: "show", id: documentInstance.id)
    }

    /*

    def show() {
        def documentInstance = Document.get(params.id)
        if (!documentInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "list")
            return
        }

        [documentInstance: documentInstance]
    }*/

    def edit() {
        def documentInstance = Document.get(params.id)
        def doc_type = documentInstance.doc_type.type;
        def doc_catalog = documentInstance.doc_catalog.catalog;

        if (!documentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "list")
            return
        }

        [documentInstance: documentInstance, doc_type: doc_type, doc_catalog: doc_catalog]
    }



    def update() {
        def documentInstance = Document.get(params.id)


        if (!documentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "list")
            return
        }



        if (params.version) {
            def version = params.version.toLong()
            if (documentInstance.version > version) {
                documentInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'document.label', default: 'Document')] as Object[],
                          "Another user has updated this Document while you were editing")
                render(view: "edit", model: [documentInstance: documentInstance])
                return
            }
        }

        /*
        def doc_catalog = documentInstance.getDoc_catalog()
        println "ID: "+doc_catalog.dump()
        def doc_type = documentInstance.doc_type.type*/

        documentInstance.properties = params
        documentInstance.updated_by = session.employee_id
        documentInstance.lastUpdated = new Date()

        def tmp = []
        tmp.addAll documentInstance.attributes
        tmp.each { DocAttribute attribute ->
            documentInstance.removeFromAttributes(attribute)
            attribute.delete()
        }


        //documentInstance.setDoc_catalog(DocumentDocCatalog.findById(doc_catalog.id))

        //documentInstance.setDoc_catalog(DocumentDocCatalog.get(doc_catalog.id))


        //println documentInstance.dump()


        def attributes = params.list("attribute").toArray()

        attributes[0].each{ k, v ->
            DocAttributeType test = DocAttributeType.findById(k);
            println "Lisan atribuuti"

            String value_text = null;
            String value_number = null;
            String value_date = null;
            String atr_type_selection_value = null;

            if (test.data_type_fk == 1)
                value_text = v;
            else if (test.data_type_fk == 2)
                value_number = v;
            else if (test.data_type_fk == 3)
                value_date = v;
            else if (test.data_type_fk == 4)
                atr_type_selection_value = v;

            DocAttribute attribute_obj = new DocAttribute(
                    document: documentInstance,
                    doc_attribute_type: test,
                    data_type: DataType.findById(test.data_type_fk),
                    value_text: value_text,
                    value_number: value_number,
                    value_date: value_date,
                    atr_type_selection_value: atr_type_selection_value,
                    type_name: test.type_name,
                    required: 'Y'
            ).save(flush: true)

            println "Attribuut:" + attribute_obj

            documentInstance.addToAttributes(attribute_obj)
        }

        def last_id = 0;

        def status_list = documentInstance.doc_status.toList();
        if (status_list.size() > 0)
            last_id = status_list.last().type.id;

        if (params.get('doc_status_type.id') != last_id) {
            if (last_id > 0) {
                DocStatus old_status = DocStatus.get(documentInstance.doc_status.toList().last().id);
                old_status.status_end = new Date();
                old_status.save(flush: true)
            }

            DocStatus status = new DocStatus();
            status.document = documentInstance;
            status.type = DocStatusType.get(params.get('doc_status_type.id'));
            status.status_begin = new Date();
            status.status_end = null;
            status.creator = Employee.findById(session.employee_id)
            documentInstance.addToDoc_status(status);
        }

        def save = documentInstance.save(flush: true)

        if (!save) {
            render(view: "edit", model: [documentInstance: documentInstance, doc_type: documentInstance.doc_type.type, doc_catalog: documentInstance.doc_catalog])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'document.label', default: 'Document'), documentInstance.id])
        redirect(action: "show", id: documentInstance.id)
    }

    def links() {
        def documentInstance = Document.findById(params.get('id'))


        render(view: "links", model: [documentInstance: documentInstance])
        return
    }

    def add_links() {
        def documentInstance = Document.get(params.id)

        if (!documentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "list")
            return
        }

        [documentInstance: documentInstance]
    }

    def save_links() {
        def documentInstance = Document.get(params.id)

        def doc_subject = new DocSubject(params)
        doc_subject.document = documentInstance
        doc_subject.subject_fk = params.getInt("subject_fk")

        if (!doc_subject.save(flush: true)) {
            render(view: "add_links", model: [documentInstance: documentInstance, docSubjectInstance: doc_subject])
            return
        }



        redirect(action: "links", id: params.id)
        return
    }

    def search() {
        def attributes_list = params.list("attribute").toArray()

        def results = Document.withCriteria {
            if (params?.id)
                eq("id", params.getLong('id'))
            if (params?.name)
                ilike("name", '%'+params.get('name')+'%')
            if (params?.description)
                ilike("description", '%'+params.get('description')+'%')

            if (params?.updated_by) {
                updater {
                    'person' {
                        or {
                            ilike("first_name", '%' + params.get('updated_by') + '%')
                            ilike("last_name", '%' + params.get('updated_by') + '%')
                        }
                    }
                }
            }

            if (params?.catalog_name) {
                doc_catalog {
                    'catalog' {
                        ilike("name", '%' + params.get('catalog_name') + '%')
                    }
                }
            }

            if (params?.doc_status_type_id) {
                doc_status {
                    isNull("status_end")
                    'type' {
                        eq("id", params.getLong('doc_status_type_id'))
                    }
                }
            }

            if (params?.doc_type_id) {
                doc_type {
                    'type' {
                        eq("id", params.getLong('doc_type_id'))
                    }
                }

                if (attributes_list.size() > 0) {
                    attributes {
                        or {
                            attributes_list[0].each { k, v ->
                                if (v) {
                                    and {
                                        "doc_attribute_type" {
                                            eq('id', Long.parseLong(k))
                                        }
                                        ilike("value_text", '%' + v + '%')
                                    }
                                }

                            }
                        }
                    }
                }
            } else {
                if (params?.attribute_value) {
                    attributes {
                        or {
                            ilike("value_text", '%' + params.get('attribute_value') + '%')
                            eq("value_number", params.getInt('attribute_value'))
                            //eq("value_date", params.getDate('attribute_value'))
                        }
                    }
                }
            }
            /*
            productSupermarket {
                product {
                    idEq(params.product)
                }
                // or just eq('product', someProduct)
            }*/
            maxResults(10)
            resultTransformer org.hibernate.Criteria.DISTINCT_ROOT_ENTITY
        }

       // def results = criteria.list()

        render(view: "search", model: [results: results])
        return
    }

    def cut() {
        if (!session.cut) {
            session.cut = new ArrayList<Long>()
        }

        def cuts = params.get("id").split(',')


        if (params?.do == 'delete_selected') {
            /*
            cuts.each { v ->
                ArrayList<Long> keep_list = session.cut;

                Iterator<Long> listIterator = keep_list.iterator();
                while (listIterator.hasNext()) {
                    Long v = listIterator.next()
                    if (keep_list.indexOf(Long.parseLong(v))) {
                        keep_list.remove(keep_list.indexOf(Long.parseLong(v)))
                    }
                }

                session.cut = keep_list
            }*/



            cuts.each { v ->
                if (session.cut.indexOf(Long.parseLong(v))) {
                    session.cut.remove(session.cut.indexOf(Long.parseLong(v)))
                }
            }

            //println session.cut

            render(contentType: 'text/json') {
                [
                        'cuts'  : session.cut,
                        'status': session.cut ? "OK" : "Nothing present"
                ]
            }
        } else {

            cuts.each { v ->
                println v
                session.cut.add(Long.parseLong(v))
            }

            //println session.cut

            render(contentType: 'text/json') {
                [
                        'cuts'  : session.cut,
                        'status': session.cut ? "OK" : "Nothing present"
                ]
            }
        }
    }

    def paste() {
        if (session.cut) {
            def documents = Document.findAllByIdInList(session.cut)
            session.cut = null

            def catalog = DocCatalog.findById(params.catalog_id);

            documents.each{document ->
                document.getDoc_catalog().setCatalog(catalog)
                document.save(flush: true)
            }
        }

        redirect(action: "list", params: [catalog_id: params.catalog_id])
    }

    def cuts() {
        println params.do

        if (params?.do == 'delete_all') {
            session.cut = null;
        }

        def documents = null
        if (session.cut)
            documents = Document.findAllByIdInList(session.cut)




        render(view: "cuts", model: [documents: documents])
    }

    def subject_search() {
        def results = Person.findAllByLast_nameIlike('%' + params.get('query').toString() + '%')
        def results_enterprise = Enterprise.findAllByNameIlike('%' + params.get('query').toString() + '%')


        ArrayList<HashMap> results_list = new ArrayList<HashMap>()

        results.each { person ->
            HashMap<Integer, String> item = new HashMap<Integer, String>();

            HashMap<Integer, String> data = new HashMap<Integer, String>();

            data.put("id", String.valueOf(person.id))
            data.put("doc_subject_type_fk", "1")

            item.put("data", data)
            item.put("value", person.name)
            results_list.add(item)
        }

        results_enterprise.each { enterprise ->
            HashMap<Integer, String> item = new HashMap<Integer, String>();

            HashMap<Integer, String> data = new HashMap<Integer, String>();

            data.put("id", String.valueOf(enterprise.id))
            data.put("doc_subject_type_fk", "2")

            item.put("data", data)
            item.put("value", enterprise.name)
            results_list.add(item)
        }

        render(contentType: 'text/json') {
            [
                "suggestions": results_list
            ]
        }
    }

    def delete_link() {
        def doc_subject = DocSubject.findById(params.id).delete(flush: true)

        redirect(uri: request.getHeader('referer'))
    }


    /*

    def delete() {
        def documentInstance = Document.get(params.id)
        if (!documentInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "list")
            return
        }

        try {
            documentInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "show", id: params.id)
        }
    }*/
}
