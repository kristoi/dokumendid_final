package dokumendid

import dokumendid.classificator.DocCatalogType

class DocCatalog {
    String name

    DocCatalogType type;

    static mapping = {
        table "doc_catalog"
        version false
        autoTimestamp(false)

        id column: 'doc_catalog', generator: 'sequence', params: [sequence: 'doc_catalog_id']

        //type column: 'doc_type_fk'
        //document column: 'document_fk'
    }

    static constraints = {
    }
}
