package dokumendid.classificator

class DocSubjectRelationType {
    String type_name;


    static mapping = {
        table "doc_subject_relation_type"
        version false
        autoTimestamp(false)

        id column: 'doc_subject_relation_type'
        type_name column: 'type_name'
    }

    static constraints = {
    }
}
