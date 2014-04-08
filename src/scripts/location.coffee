map = undefined
geocoder = undefined
LocationViewModel = undefined
app = this.app = this.app || {}

LocationViewModel = kendo.data.ObservableObject.extend(
    _lastMarker: null
    _isLoading: false

    address: ""
    isGoogleMapsInitialized: false

    onNavigateHome: () ->
        that = this
        position = undefined

        that._isLoading = true
        that.showLoading()

        navigator.geolocation.getCurrentPosition(
            (position) ->
                position = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
                map.panTo(position)
                that._putMarker(position)

                that._isLoading = false
                that.hideLoading()
            (error) ->
                position = new google.maps.LatLng(43.459336, -80.462494)
                map.panTo(position)

                that._isLoading = false
                that.hideLoading()

                navigator.notification.alert(
                    "Unable to determine current location. Cannot connect to GPS satellite."
                    () -> { }
                    "Location failed"
                    'OK'
                )
            {
                timeout: 30000
                enableHighAccuracy: true
            }
        )

    onSearchAddress: () ->
        that = this

        geocoder.geocode(
            { 'address': that.get("address") }
            (results, status) ->
                if (status != google.maps.GeocoderStatus.OK)
                    navigator.notification.alert(
                        "Unable to find address."
                        () -> { }
                        "Search failed"
                        'OK'
                    )
                    return

                map.panTo(results[0].geometry.location)
                that._putMarker(results[0].geometry.location)
        )

    showLoading: () ->
        if (this._isLoading)
            app.application.showLoading()

    hideLoading: () ->
        app.application.hideLoading()

    _putMarker: (position) ->
        that = this

        if (that._lastMarker != null && that._lastMarker != undefined)
            that._lastMarker.setMap(null)

        that._lastMarker = new google.maps.Marker(
            map: map
            position: position
        )
)

app.locationService =
    initLocation: () ->
        if (typeof google == "undefined")
            return

        app.locationService.viewModel.set("isGoogleMapsInitialized", true)

        mapOptions =
            zoom: 15
            mapTypeId: google.maps.MapTypeId.ROADMAP
            zoomControl: true
            zoomControlOptions:
                position: google.maps.ControlPosition.LEFT_BOTTOM
            mapTypeControl: false
            streetViewControl: false

        map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)
        geocoder = new google.maps.Geocoder()
        app.locationService.viewModel.onNavigateHome.apply(app.locationService.viewModel, [])

    show: () ->
        if (!app.locationService.viewModel.get("isGoogleMapsInitialized"))
            return

        app.locationService.viewModel.showLoading()
        google.maps.event.trigger(map, "resize")

    hide: () ->
        app.locationService.viewModel.hideLoading()

    viewModel: new LocationViewModel()
