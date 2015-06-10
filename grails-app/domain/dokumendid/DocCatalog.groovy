package dokumendid

import dokumendid.classificator.DocCatalogType

class DocCatalog {
    String name

    DocCatalogType type;
    Integer level;

    static hasMany = [childs:DocCatalog]

    static mapping = {
        table "doc_catalog"
        version false
        autoTimestamp(false)

        id column: 'doc_catalog', generator: 'sequence', params: [sequence: 'doc_catalog_id']

        type column: 'doc_catalog_type_fk'
        level column: 'level'
        childs column: 'upper_catalog_fk'
        //document column: 'document_fk'
    }

    static constraints = {
    }
}
