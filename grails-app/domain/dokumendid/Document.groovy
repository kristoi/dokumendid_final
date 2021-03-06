package dokumendid

import dokumendid.classificator.DocStatus
import dokumendid.classificator.DocType


class Document {
    //Integer document
    String doc_nr
    String name
    String description
    String filename
    Date dateCreated
    Date lastUpdated
    Integer created_by
    Integer updated_by


    Employee creator; // kui on samas tabelis key, siis  sellise seosega
    Employee updater; // kui on samas tabelis key, siis  sellise seosega
    DocumentDocCatalog doc_catalog;



    //DocumentDocType doc_type;


    static belongsTo = [creator:Person,updater:Person]
    static hasMany = [attributes:DocAttribute, doc_status:DocStatus, subjects: DocSubject]
    static hasOne = [doc_type:DocumentDocType, doc_catalog:DocumentDocCatalog]

    static mapping = {
        table "document"
        version false

        id column: 'document', generator: 'sequence', params: [sequence: 'document_id']
        doc_nr column: 'doc_nr'
        name column: 'name'
        description column: 'description'
        filename column: 'filename'

        creator column: 'created_by', insertable: false, updateable: false
        updater column: 'updated_by', insertable: false, updateable: false

        doc_type column: 'document_fk'
        doc_catalog column: 'document_fk'

        attributes sort: 'id', order: 'asc'
        subjects sort: 'id', order: 'asc'
        doc_status sort: 'id', order: 'asc'

        created_by column: 'created_by', insertable: true, updateable: false
        updated_by column: 'updated_by', insertable: false, updateable: true
        dateCreated column: 'created', insertable: true, updateable: false
        lastUpdated column: 'updated', insertable: false, updateable: true
    }

    static constraints = {
        created_by size: 1..10
        updated_by size: 1..10
        name nullable: false, blank: false, size: 1..50
        doc_nr nullable: false, blank: true
        filename nullable: false, blank: true
    }
}
