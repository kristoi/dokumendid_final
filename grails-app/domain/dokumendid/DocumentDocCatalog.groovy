package dokumendid

class DocumentDocCatalog {
    Long id
    DocCatalog catalog;
    Document document;

    Date dateCreated
    Date lastUpdated

    static belongsTo = [document:Document]

    static mapping = {
        table "document_doc_catalog"
        version false

        id column: 'document_doc_catalog', generator: 'sequence', params: [sequence: 'document_doc_catalog_id']

        catalog column: 'doc_catalog_fk'
        document column: 'document_fk'

        dateCreated column: 'catalog_time', insertable: true, updateable: false
        lastUpdated column: 'catalog_time', insertable: false, updateable: false
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
