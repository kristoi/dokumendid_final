package dokumendid

class Enterprise {
    Long id
    String name


    static mapping = {
        table "enterprise"
        version false
        autoTimestamp(false)

        id column: 'enterprise', generator: 'sequence', params: [sequence: 'enterprise_id']
        name columm: 'name'
    }

    static constraints = {

    }
}
