#= require_tree widgets

window.Dash = window.Dash || {}
window.Dash.Dashboard = ->

    #
    # Render and refresh all widgets
    #

    Widget = ($elem, widget) ->
        refresh = ->
            $.ajax widget.dataUri, {
                dataType: 'json'
                success: (data) ->
                    $child = ich[widget.view] {data:  $.extend(widget, data) }
                    $('div.widget', $elem).replaceWith($('div.widget', $child))
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
            $elem = ich[widget.view] {options:widget.options}
            $('.gridster ul').append $elem
            dash.push Widget($elem, widget)

        $(".gridster ul").gridster {
            widget_margins: [10, 10]
            widget_base_dimensions: [140, 140]
            extra_rows: 1
            extra_cols: 1
        }

    {
        getWidgets: getWidgets
    }
