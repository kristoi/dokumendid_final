package dokumendid

class UserController {

    def login = {
        if (request.method == 'POST') {
            def u = User.findByUsernameAndPassword(params.username, params.password)
            if (u) {
                // username and password match -> log in
                session.user = u
                redirect(controller:'main')
            } else {
                flash.message = "User not found"
                redirect(controller:'main')
            }
        } else if (session.user) {
            // don't allow login while user is logged in
            redirect(controller:'main')
        }
    }
}