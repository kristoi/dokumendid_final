package dokumendid.classificator

import dokumendid.AtrTypeSelectionValue
import dokumendid.DocTypeAttribute

class DocType {
    String type_name;
    Integer level;
    Integer super_type_fk;


    static hasMany = [attributes:DocTypeAttribute]



    static mapping = {
        table "doc_type"
        version false
        autoTimestamp(false)

        id column: 'doc_type'
        type_name column: 'type_name'
        level column: 'level'
        super_type_fk column: 'super_type_fk'
    }

    static constraints = {
    }

}
