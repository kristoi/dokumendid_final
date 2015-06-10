package dokumendid.classificator

import dokumendid.AtrTypeSelectionValue
import dokumendid.DocTypeAttribute

class DocType {
    Long id
    String type_name;

    DocTypeAttribute attributes;

    static hasMany = [attributes:DocTypeAttribute]



    static mapping = {
        table "doc_type"
        version false
        autoTimestamp(false)

        id column: 'doc_type'
        type_name column: 'type_name'

        attributes column: 'document_fk'
    }

    static constraints = {
    }

    static int isRequired(long l) {

        return 0;
    }
}
