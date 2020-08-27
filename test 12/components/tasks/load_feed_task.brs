sub init()
    m.top.functionname = "request"
  end sub  
 
  function request(async = true as boolean)
    url = m.top.url
    res = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    res.SetPort(port)
    res.setURL(url)
    res.EnableEncodings(true)
    res.SetCertificatesFile("common:/certs/ca-bundle.crt")
    res.InitClientCertificates()

    if res.AsyncGetToString()
        while true
            msg = Wait (0, port)
            if Type(msg) = "roUrlEvent"
                resJson = invalid
                if msg.GetResponseCode() = 200
                    resJson = ParseJson(msg.GetString())
                    onFeed(resJson)
                end if
                exit while
            else if Type (msg) = "Invalid"
                res.AsyncCancel()
                exit while
            end if
        end while
    end if
end function

function onFeed(obj)
    m.content = createObject("roSGNode", "category_node")
    for each item in obj
        m.sectionContent = m.content.createChild("category_node")
        m.sectionContent.TITLE = item.header
        for each i in item.results
        data = m.sectionContent.createChild("category_node")
          name = i.title
          data.title = name.llTitle
          data.HDPosterUrl = name.llLsPosterURL
          data.FHDPosterUrl = name.llHeroPosterURL
          data.Description = name.llDescription
          data.ReleaseYear = name.llReleaseYear
          data.Categories = item.header
          data.Duration = str(name.llDuration)
          data.Rating = name.llRating
          data.TrailerURL = name.llTrailerURL
          data.VideoHLSURL = name.llVideoHLSURL
          data.Id = name.id
        end for 
    end for
    m.top.content = m.content
  end function