DAY = 1000 * 60 * 60  * 24

difference = (date1, date2) ->
    Math.round (date2.getTime() - date1.getTime()) / DAY

exports.countdown = (error, success) ->
    targetDate = new Date '07-Sep-2012'
    success {
        days: difference new Date, targetDate
    }
