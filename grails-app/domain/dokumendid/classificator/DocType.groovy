package dokumendid.classificator

class DocType {
    Long id
    String type_name;



    static mapping = {
        table "doc_type"
        version false
        autoTimestamp(false)

        id column: 'doc_type'
        type_name column: 'type_name'
    }

    static constraints = {
    }
}
