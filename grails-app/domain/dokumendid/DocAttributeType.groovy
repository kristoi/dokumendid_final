package dokumendid

class DocAttributeType {
    String type_name;


    static hasMany = [selections:AtrTypeSelectionValue]
    AtrTypeSelectionValue default_selection;



    static mapping = {
        table "doc_attribute_type"
        version false
        autoTimestamp(false)

        id column: 'doc_attribute_type', generator: 'sequence', params: [sequence: 'doc_attribute_type_id']

        type_name column: 'type_name'
        //selections column: 'default_selection_id_fk'
        default_selection column: 'default_selection_id_fk'
    }

    static constraints = {
    }
}
