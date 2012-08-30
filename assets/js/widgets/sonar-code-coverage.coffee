
eve.on 'sonar_code_coverage', (evt) ->
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
