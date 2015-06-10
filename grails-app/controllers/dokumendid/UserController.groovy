package dokumendid

class UserController {

    def login = {

    }

    def doLogin = {
        if (request.method == 'POST') {
            def u = User.findByUsernameAndPassword(params.username, params.password)
            if (u) {
                // username and password match -> log in
                session.user = u
                session.employee_id = u.getEmployeeId()
                redirect(controller:'document')
            } else {
                flash.message = "User not found"
                redirect(controller:'document')
            }
        } else if (session.user) {
            // don't allow login while user is logged in
            redirect(controller:'document')
        }
    }

    def logout = {
        session.invalidate()
        redirect(controller:'main')
    }
}