package dokumendid

import dokumendid.classificator.DocType

class DocumentDocType {
    DocType type;
    Document document;

    static belongsTo = [document:Document]

    static mapping = {
        table "document_doc_type"
        version false
        autoTimestamp(false)

        id column: 'document_doc_type', generator: 'sequence', params: [sequence: 'document_doc_type_id']

        type column: 'doc_type_fk'
        document column: 'document_fk'
    }

    static constraints = {
    }
}
