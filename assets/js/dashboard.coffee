#= require widgets

window.Dash = window.Dash || {}
window.Dash.Dashboard = ->

    #
    # Loading animation
    #

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

    #
    # Sonar code coverage
    #

    eve.on 'sonar-code-coverage', (evt) ->
        id = evt.target.find('.chart').attr 'id'
        createPercentageChart id, evt.data.value

    createPercentageChart = (targetId, percentage) ->
        new pv.Panel()
            .canvas(targetId)
            .width(110)
            .height(50)
            .add(pv.Bar)
            .data([100, percentage])
            .top(10)
            .left(0)
            .width((d) -> d)
            .height(40)
            .fillStyle(pv.colors('#999', '#181'))
            .root.render()

    #
    # Jira burn up
    #

    eve.on 'jira-burn-up', (evt) ->
        id = evt.target.find('.chart').attr 'id'
        createAreaChart id, evt.data.pointsData

    createAreaChart = (targetId, data) ->
        w = 410
        h = 90
        x = pv.Scale.linear(data, (d) -> d.x).range(0, w)
        y = pv.Scale.linear(data, (d) -> d.y).range(0, h - 20)

        vis = new pv.Panel()
            .canvas(targetId)
            .width(w)
            .height(h)
            .add(pv.Area)
            .data(data)
            .bottom(0)
            .right(0)
            .left((d) -> x(d.x))
            .height((d) -> y(d.y))
            .fillStyle("rgb(121,173,210)")
            .anchor("top").add(pv.Line)
            .lineWidth(1)
            .root.render()


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
                    $child = ich[templateName widget] $.extend(widget, data)
                    $child.addClass(className widget)
                    $elem.append $child
                    eve widget.type, null, {
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
            if (widget.type) of ich
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
