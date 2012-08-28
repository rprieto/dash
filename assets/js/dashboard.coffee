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
    
    createAreaChart = (targetId) ->
        data = [
            {x:0,  y:0},
            {x:10, y:3},
            {x:20, y:9},
            {x:30, y:11},
            {x:40, y:14},
            {x:50, y:14},
            {x:60, y:21},
            {x:60, y:0},
            {x:100, y:0},
        ]
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
                    if widget.type is 'sonar-code-coverage'
                        id = $child.find('.chart').attr 'id'
                        createPercentageChart id, data.value
                    if widget.type is 'jira-burn-up'
                        id = $child.find('.chart').attr 'id'
                        createAreaChart id, data.value
                error: ->
                    $elem.empty()
                    $elem.append ich.widget_no_response widget
            }
        refresh()
        setInterval refresh, (60 * 1000)
    
    getWidgets = (uri) ->
        $.ajax uri, {
            dataType: 'json'
            success: (data) ->
                createGrid data
        }

    className = (widget) ->
        widget.type.replace /\-/g, '_'

    templateName = (widget) ->
        'widget_' + className widget

    createGrid = (widgets) ->

        $('.gridster ul').empty()

        widgets.forEach (widget) ->
            if (templateName widget) of ich        
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
