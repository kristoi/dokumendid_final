package dokumendid.classificator

class DocCatalogType {
    Integer doc_catalog_type
    String type_name


    static mapping = {
        table "doc_catalog_type"
        version false
        autoTimestamp(false)

        doc_catalog_type column: 'doc_catalog_type', generator: 'sequence', params: [sequence: 'doc_catalog_type']
        type_name column: 'type_name'
    }
}
