app = this.app = this.app || {}

LoginViewModel = kendo.data.ObservableObject.extend(
    isLoggedIn: false
    username: ""
    password: ""

    onLogin: () ->
        username = this.get("username").trim()
        password = this.get("password").trim()

        if (username == "" || password == "")
            navigator.notification.alert(
                "Both fields are required!"
                () -> { }
                "Login failed"
                'OK'
            )

            return

        this.set("isLoggedIn", true)

    onLogout: () ->
        this.clearForm()
        this.set("isLoggedIn", false)

    clearForm: () ->
        this.set("username", "")
        this.set("password", "")

    checkEnter: (e) ->
        if (e.keyCode == 13)
            $(e.target).blur()
            this.onLogin()
)

app.loginService =
    viewModel: new LoginViewModel()
