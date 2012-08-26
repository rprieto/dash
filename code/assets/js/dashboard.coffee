window.Dash = window.Dash || {}
window.Dash.Dashboard = ->
             
    getWidgets = (uri) ->
        $.ajax uri, {
            'dataType': 'json'
            'success': (data) ->
                createGrid data
        }

    createGrid = (widgets) ->
        $('.gridster ul').remove()
        $('.gridster').append ich.widgetTemplate {
            widgets: widgets
        }
        $(".gridster ul").gridster {
            widget_margins: [10, 10]
            widget_base_dimensions: [140, 140]
        }

    {
        getWidgets: getWidgets
    }
