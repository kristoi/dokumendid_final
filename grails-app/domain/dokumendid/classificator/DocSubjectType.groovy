package dokumendid.classificator

class DocSubjectType {
    Long id
    String type_name;


    static mapping = {
        table "doc_subject_type"
        version false
        autoTimestamp(false)

        id column: 'doc_subject_type'
        type_name column: 'type_name'
    }

    static constraints = {
    }
}
