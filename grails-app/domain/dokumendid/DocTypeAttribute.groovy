package dokumendid

import dokumendid.classificator.DocType

class DocTypeAttribute {
    DocAttributeType attribute_type;
    DocType doc_type;

    Integer orderby
    String required
    String created_by_default

    static belongsTo = [doc_type:DocType]

    static mapping = {
        table "doc_type_attribute"
        version false

        id column: 'doc_type_attribute', generator: 'sequence', params: [sequence: 'doc_type_attribute_id']
        attribute_type column: 'doc_attribute_type_fk'
        doc_type column: 'doc_type_fk'
        orderby colum: 'orderby'
        created_by_default colum: 'created_by_default'
    }

    static constraints = {
    }
}
