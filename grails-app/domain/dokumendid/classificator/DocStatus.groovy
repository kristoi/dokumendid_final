package dokumendid.classificator

import dokumendid.Document
import dokumendid.Employee

class DocStatus {
    Long id
    Date status_begin;
    Date status_end;

    Employee creator;

    DocStatusType type;

    static belongsTo = [document:Document]

    static mapping = {
        table "doc_status"
        version false
        autoTimestamp(false)

        id column: 'doc_status', generator: 'sequence', params: [sequence: 'doc_status_id']
        status_begin column: 'status_begin'
        status_end column: 'status_end'

        type column: 'doc_status_type_fk'
        document column: 'document_fk'
        creator column: 'created_by'
    }

    static constraints = {
        status_end nullable: true
    }
}
