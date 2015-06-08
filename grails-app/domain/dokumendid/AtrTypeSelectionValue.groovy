package dokumendid

class AtrTypeSelectionValue {
    String value_text
    Integer order_by

    static belongsTo = [ doc_attribute_type : DocAttributeType ]

    static mapping = {
        table "atr_type_selection_value"
        version false
        autoTimestamp(false)

        id column: 'atr_type_selection_value', generator: 'sequence', params: [sequence: 'atr_type_selection_value_id']
        value_text column: 'value_text'
        order_by column: 'orderby'
        doc_attribute_type column: 'doc_attribute_type_fk'
        //doc_attribute_type_2 column: 'atr_type_selection_value'

    }
}
