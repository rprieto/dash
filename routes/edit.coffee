exports.page = (req, res) ->
    res.render 'edit'

parse_multipart = (req) ->
    parser = multipart.parser()
    parser.headers = req.headers
    req.addListener "data", (chunk) ->
        parser.write chunk
    req.addListener "end", () ->
        parser.close()
    parser


exports.upload_file = (req, res) ->

    req.setBodyEncoding "binary"
    stream = parse_multipart req
    fileName = null
    fileStream = null

    stream.onPartBegin = (part) ->
        sys.debug "Started part, name = " + part.name + ", filename = " + part.filename
        fileName = "./uploads/" + stream.part.filename
        fileStream = fs.createWriteStream fileName
        fileStream.addListener "error", (err) ->
            sys.debug "Got error while writing to file '" + fileName + "': ", err
        fileStream.addListener "drain", () ->
            req.resume()

    stream.onData = (chunk) ->
        req.pause()
        sys.debug "Writing chunk"
        fileStream.write chunk, "binary"

    stream.onEnd = () ->
        fileStream.addListener "drain", () ->
            fileStream.end()
            upload_complete res


upload_complete = (res) ->
    sys.debug "Request complete"
    res.send 'Cool'
    sys.puts "\n=> Done"
