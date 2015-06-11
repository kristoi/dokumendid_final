package dokumendid.classificator

class DocStatusType {
    Long id
    String type_name


    static mapping = {
        table "doc_status_type"
        version false
        autoTimestamp(false)

        id column: 'doc_status_type', generator: 'sequence', params: [sequence: 'doc_status_type_id']
        type_name column: 'type_name'
    }

}
