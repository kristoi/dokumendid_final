package dokumendid

class DocAttributeType {
    String type_name;

    static mapping = {
        table "doc_attribute_type"
        version false
        autoTimestamp(false)

        id column: 'doc_attribute_type', generator: 'sequence', params: [sequence: 'doc_attribute_type_id']

        type_name column: 'type_name'
    }

    static constraints = {
    }
}
