package dokumendid

class Person {
    String first_name
    String last_name

    Date dateCreated
    Date lastUpdated
    Integer created_by
    Integer updated_by


    static mapping = {
        table "person"
        version false

        id column: 'person', generator: 'sequence', params: [sequence: 'person_id']
        first_name column: 'first_name'
        last_name column: 'last_name'



        created_by column: 'created_by'
        updated_by column: 'updated_by'
        dateCreated column: 'created'
        lastUpdated column: 'updated'
    }

    static constraints = {
        created_by size: 1..10
        updated_by size: 1..10
    }
}
