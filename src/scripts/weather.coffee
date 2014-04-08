app = this.app = this.app || {};

WeatherViewModel = kendo.data.ObservableObject.extend(
    weatherDataSource: null

    init: () ->
        kendo.data.ObservableObject.fn.init.apply(this, [])

        dataSource = new kendo.data.DataSource(
            transport: 
                read: 
                    url: "data/weather.json"
                    dataType: "json"
        )

        this.set("weatherDataSource", dataSource)
)

app.weatherService =
    viewModel: new WeatherViewModel()
