
eve.on 'jira_burnup', (evt) ->
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

