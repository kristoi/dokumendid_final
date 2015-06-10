package dokumendid.classificator

import dokumendid.Document

class DocStatus {
    Long id
    Date status_begin;
    Date status_end;

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
    }

    static constraints = {
    }
}
