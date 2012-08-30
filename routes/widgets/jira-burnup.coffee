exports.config = () ->
    ['data-sequence']

# Points per percentage of the iteration
fakeData = [
    {x:0,  y:0}
    {x:10, y:3}
    {x:20, y:9}
    {x:30, y:11}
    {x:40, y:14}
    {x:50, y:14}
    {x:60, y:21}
    {x:60, y:0}
    {x:100, y:0}
]

exports.data = (error, success) ->
    id = Math.floor Math.random() * 100000
    success {
        chartId: 'id' + id,
        totalPoints: 21,
        pointsData: fakeData
    }
