package dokumendid

import dokumendid.classificator.DataType
import org.springframework.dao.DataIntegrityViolationException

class DocumentController {
    def beforeInterceptor = [action:this.&checkUser,except:['index','list','show']]

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
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [documentInstanceList: Document.list(params), documentInstanceTotal: Document.count()]
    }*/

    def create() {
        //def document = new Document(params);
       // document.setDoc_type(new Doc)

        [documentInstance: new Document(params)]
    }



    def save() {
        def documentInstance = new Document(params)

        documentInstance.created_by = session.employee_id
        documentInstance.updated_by = null
        documentInstance.lastUpdated = null
        documentInstance.setDoc_catalog(
                new DocumentDocCatalog(document: documentInstance.getId(), catalog: DocCatalog.findById(4)))

        def attributes = params.list("attribute").get(0)

        attributes.each{ k, v ->
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




       // DocAttributeType test = DocAttributeType.findById(3);

        String value_text = "tere";
/*
        documentInstance.addToAttributes(new DocAttribute(
            atr_type_selection_value: null,
            doc_attribute_type: test,
            document: documentInstance,
            type_name: test.type_name,
            value_text: value_text
        ))*/

        println params.dump()




        if (!documentInstance.save(flush: true)) {
            render(view: "create", model: [documentInstance: documentInstance])
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
    }

    def edit() {
        def documentInstance = Document.get(params.id)
        if (!documentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])
            redirect(action: "list")
            return
        }

        [documentInstance: documentInstance]
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

        documentInstance.properties = params

        if (!documentInstance.save(flush: true)) {
            render(view: "edit", model: [documentInstance: documentInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'document.label', default: 'Document'), documentInstance.id])
        redirect(action: "show", id: documentInstance.id)
    }

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
