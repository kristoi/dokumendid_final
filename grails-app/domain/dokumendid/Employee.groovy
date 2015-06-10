package dokumendid

class Employee {
    String active

    //Document documents;
    static hasMany = [person:Person]

    static mapping = {
        table "employee"
        version false
        autoTimestamp(false)

        id column: 'employee', generator: 'sequence', params: [sequence: 'employee_id']
        active columm: 'active'
        //documents joinTable:[name:'Document', key:'id', column:'created_by']
        //documents column: 'created_by', joinTable: false


    }

    static constraints = {
        //created_by size: 1..10
        //updated_by size: 1..10
    }
}
