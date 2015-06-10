package dokumendid

class DocumentDocCatalog {
    DocCatalog catalog;
    Document document;

    static belongsTo = [document:Document]

    static mapping = {
        table "document_doc_catalog"
        version false
        autoTimestamp(false)

        id column: 'document_doc_catalog', generator: 'sequence', params: [sequence: 'document_doc_catalog_id']

        catalog column: 'doc_catalog_fk'
        document column: 'document_fk'
    }

    static constraints = {
    }

    public String getTypeName() {
        return "$type.type_name"
    }

    public String getTypeId() {
        return "$type.id"
    }
}
