#= require_tree widgets

window.Dash = window.Dash || {}
window.Dash.Dashboard = ->

    #
    # Render and refresh all widgets
    #

    Widget = ($elem, widget) ->
        refresh = ->
            setTimeout (->
                if $elem.find('.content').length is 0
                    $elem.spin()
            ), 100
            $.ajax widget.dataUri, {
                dataType: 'json'
                success: (data) ->
                    $elem.empty()
                    $child = ich[widget.view] $.extend(widget, data)
                    $child.addClass(widget.view)
                    $elem.append $child
                    eve widget.view, null, {
                        target: $child
                        widget: widget
                        data: data
                    }
                error: ->
                    $elem.empty()
                    $elem.append ich.widget_no_response widget
            }
        refresh()
        setInterval refresh, (60 * 1000)

    #
    # Dashboard
    #

    dash = []

    getWidgets = (uri) ->
        $.ajax uri, {
            dataType: 'json'
            success: (data) ->
                createGrid data
        }

    createGrid = (widgets) ->
        $('.gridster ul').empty()

        widgets.forEach (widget) ->
            if (widget.view) of ich
                $elem = ich.griditem widget
                dash.push Widget($elem, widget)
            else
                $elem = ich.griditem widget
                $elem.append ich.widget_not_supported widget
            $('.gridster ul').append $elem

        $(".gridster ul").gridster {
            widget_margins: [10, 10]
            widget_base_dimensions: [140, 140]
            extra_rows: 1
            extra_cols: 1
        }

    {
        getWidgets: getWidgets
    }
