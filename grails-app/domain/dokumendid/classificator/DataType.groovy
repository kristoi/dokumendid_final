package dokumendid.classificator

import dokumendid.DocAttribute

class DataType {
    String type_name;


    static mapping = {
        table "data_type"
        version false
        autoTimestamp(false)

        id column: 'data_type'
        type_name column: 'type_name'
    }

    static constraints = {
    }
}
