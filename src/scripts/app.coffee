mobileSkin = ""
app = this.app = this.app || {};

document.addEventListener('deviceready', ->
    navigator.splashscreen.hide()
, false)

app.application = new kendo.mobile.Application(document.body, { layout: "tabstrip-layout"})

app.changeSkin = (e) ->
    if (e.sender.element.text() == "Flat")
        e.sender.element.text("Native")
        mobileSkin = "flat"
    else
        e.sender.element.text("Flat")
        mobileSkin = ""

    app.application.skin(mobileSkin)
