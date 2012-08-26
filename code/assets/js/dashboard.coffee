window.Dash = window.Dash || {}
window.Dash.Dashboard = ->
    
    dash = []
    
    Ping = ($elem) ->
        $.ajax '/widget/ping/data', {
            dataType: 'json'
            success: (data) ->
                $elem.append data.status
        } 
    
    getWidgets = (uri) ->
        $.ajax uri, {
            dataType: 'json'
            success: (data) ->
                createGrid data
        }

    createGrid = (widgets) ->

        $('.gridster ul').empty()

        widgets.forEach (widget) ->
            $elem = ich.widgetTemplate widget
            dash.push Ping($elem)
            $('.gridster ul').append $elem

        $(".gridster ul").gridster {
            widget_margins: [10, 10]
            widget_base_dimensions: [140, 140]
        }

    {
        getWidgets: getWidgets
    }
