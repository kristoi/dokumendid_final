package dokumendid

class DocCatalog {
    String name

    DocCatalogType type;

    static mapping = {
        table "doc_catalog"
        version false
        autoTimestamp(false)

        id column: 'document_doc_type', generator: 'sequence', params: [sequence: 'document_doc_type_id']

        type column: 'doc_type_fk'
        document column: 'document_fk'
    }

    static constraints = {
    }
}
