package dokumendid

import dokumendid.classificator.DataType

class DocAttribute {
    String type_name
    String value_text
    Integer value_number
    Date value_date
    String required
    Integer atr_type_selection_value;

    Document document
    DataType data_type
    DocAttributeType doc_attribute_type

    static belongsTo = [document:Document]
    //static hasOne = [doc_attribute_type:DocAttributeType]

    static mapping = {
        table "doc_attribute"
        version false
        autoTimestamp(false)

        id column: 'doc_attribute', generator: 'sequence', params: [sequence: 'doc_attribute_id']

        document column: 'document_fk'
        doc_attribute_type column: 'doc_attribute_type_fk'

        type_name column: 'type_name'
        value_text column: 'value_text'
        value_number column: 'value_number'

        atr_type_selection_value column: 'atr_type_selection_value_fk'

        required column: 'required'
        data_type column: 'data_type'
    }

    static constraints = {
        atr_type_selection_value nullable: true
        value_date nullable: true
        value_number nullable: true
        value_text nullable: true
    }
}
