package dokumendid

import dokumendid.classificator.DataType

class DocAttribute {
    String type_name;
    String value_text;
    Integer value_number;
    Date value_date;
    Boolean required;

    Document document;
    DataType data_type;

    static belongsTo = [document:Document]
    //static hasOne = [data_type:DataType]

    static mapping = {
        table "doc_attribute"
        version false
        autoTimestamp(false)

        id column: 'doc_attribute', generator: 'sequence', params: [sequence: 'doc_attribute_id']

        document column: 'document_fk'


        type_name column: 'type_name'
        value_text column: 'value_text'

        data_type column: 'data_type'
    }

    static constraints = {
    }
}