window.Dash = window.Dash || {}
window.Dash.Dashboard = ->
    
    dash = []
    
    Widget = ($elem, dataUri) ->
        $.ajax dataUri, {
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

    templateName = (widget) ->
        'widget_' + widget.type.replace /\-/g, '_'

    createGrid = (widgets) ->

        $('.gridster ul').empty()

        widgets.forEach (widget) ->
            $elem = ich.griditem widget
            $('.gridster ul').append $elem
            if (templateName widget) of ich        
                dash.push Widget($elem, widget.dataUri)
            else
                $elem.append 'Not supported'
            
        $(".gridster ul").gridster {
            widget_margins: [10, 10]
            widget_base_dimensions: [140, 140]
        }

    {
        getWidgets: getWidgets
    }
