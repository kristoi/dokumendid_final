package dokumendid

import dokumendid.classificator.DocSubjectRelationType
import dokumendid.classificator.DocSubjectType

class DocSubject {
    Long id
    String note

    Integer subject_fk

    DocSubjectType subject_type
    DocSubjectRelationType type

    Person person
    Enterprise enterprise

    static belongsTo = [document:Document]

    static mapping = {
        table "doc_subject"
        version false
        autoTimestamp(false)

        id column: 'doc_subject', generator: 'sequence', params: [sequence: 'doc_subject_id']
        note column: 'note'
        subject_type column: 'doc_subject_type_fk'
        type column: 'doc_subject_relation_type_fk'
        document column: 'document_fk'
        subject_fk column: 'subject_fk'
        person column: 'subject_fk', insertable: false, updateable: false
        enterprise column: 'subject_fk', insertable: false, updateable: false
    }

    static constraints = {

    }
}