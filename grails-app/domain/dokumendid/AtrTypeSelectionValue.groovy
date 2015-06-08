package dokumendid

class AtrTypeSelectionValue {
    Integer atr_type_selection_value
    String value_text
    Integer order_by

    static belongsTo = [ doc_attribute_type : DocAttribute]

    static mapping = {
        table "atr_type_selection_value"
        version false
        autoTimestamp(false)

        atr_type_selection_value column: 'atr_type_selection_value', generator: 'sequence', params: [sequence: 'atr_type_selection_value_id']
        value_text column: 'value_text'
        order_by column: 'orderby'
        doc_attribute_type column: 'doc_attribute_type_fk'

    }
}
