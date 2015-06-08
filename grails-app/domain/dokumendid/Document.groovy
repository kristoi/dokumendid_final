package dokumendid


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

    Person creator; // kui on samas tabelis key, siis  sellise seosega

    //DocumentDocType doc_type;

    static belongsTo = [creator:Person]
    static hasMany = [attributes:DocAttribute]
    static hasOne = [doc_type:DocumentDocType]

    static mapping = {
        table "document"
        version false

        id column: 'document', generator: 'sequence', params: [sequence: 'document_id']
        doc_nr column: 'doc_nr'
        name column: 'name'
        description column: 'description'
        filename column: 'filename'

        creator column: 'created_by', insertable: false, updateable: false

        doc_type column: 'document_fk'

        created_by column: 'created_by'
        updated_by column: 'updated_by'
        dateCreated column: 'created'
        lastUpdated column: 'updated'
    }

    static constraints = {
        created_by size: 1..10
        updated_by size: 1..10
    }
}
