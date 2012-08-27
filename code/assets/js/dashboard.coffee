window.Dash = window.Dash || {}
window.Dash.Dashboard = ->
    
    dash = []
    
    loadingOpts = {
        lines: 9
        length: 7
        width: 4
        radius: 10
        corners: 1
        rotate: 0
        color: '#000'
        speed: 1
        trail: 35
        shadow: false
        hwaccel: true
        className: 'spinner'
        zIndex: 2e9
        top: 'auto'
        left: 'auto'
    }
    
    Widget = ($elem, widget) ->
        refresh = () ->
            setTimeout ( -> $elem.spin() ), 200
            $.ajax widget.dataUri, {
                dataType: 'json'
                success: (data) ->
                    $elem.empty()
                    $elem.append ich[templateName widget] $.extend(widget, data)
                error: ->
                    $elem.empty()
                    $elem.append ich.widget_no_response widget
            }
        refresh()
        setInterval refresh, (5 * 1000)
    
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
            if (templateName widget) of ich        
                $elem = ich.griditem widget
                $elem.addClass(templateName widget)
                dash.push Widget($elem, widget)
            else
                $elem = ich.griditem widget
                $elem.append ich.widget_not_supported widget
            $('.gridster ul').append $elem
            
        $(".gridster ul").gridster {
            widget_margins: [10, 10]
            widget_base_dimensions: [140, 140]
            extra_rows: 1
        }

    {
        getWidgets: getWidgets
    }
