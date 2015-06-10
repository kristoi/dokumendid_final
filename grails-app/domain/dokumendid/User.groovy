package dokumendid

class User {
    Integer user_account
    Integer subject_type_fk
    Integer subject_type
    String username
    String password
    Integer status
    Date valid_from
    Date valid_to
    Integer created_by
    Date created
    String password_never_expires

    static mapping = {
        table "user_account"
        version false

        user_account column: 'user_account', generator: 'sequence', params: [sequence: 'user_account_id']
        username column: 'username'
        password column: 'passw'
        subject_type column: 'subject_type'
        subject_type_fk column: 'subject_type_fk'
        status column: 'status'
        valid_from column: 'valid_from'
        valid_to column: 'valid_to'
        created_by column: 'created_by'
        password_never_expires column: 'password_never_expires'
    }

    static constraints = {
        username blank: false
        password blank: false
    }
}