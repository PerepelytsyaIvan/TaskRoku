' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********  

function init()
	  m.category_screen = m.top.findNode("category_screen")
    m.rowList = m.top.findNode("rowList")
    m.detailScene = m.top.findNode("DetailScene")
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.rowList.observeField("itemSelected","onItemSelected")
    configurationTimer()
    m.url = "http://hip-fusion-235118.appspot.com/api/v1/feed/group/home?nsTags=ga&appversion=1.0.68&platform=roku"
    loadFeed(m.url)
    m.rowList.setFocus(true)
end function
sub onItemSelected()
      m.detailScene.itemFocused = m.rowList.rowItemFocused[1]
         m.section.getChild(m.rowList.rowItemFocused[1]).isHiden = true
         m.section.getChild(m.rowList.rowItemFocused[1]).focus = true
         m.detailScene.content = m.section
         m.rowList.visible = false
         m.videoPlayer.visible = false
         m.videoPlayer.control = "stop"
         m.detailScene.setFocus(true)
end sub

sub returnToTheHomeScreen()
    m.rowList.setFocus(true)
    m.rowList.visible = true
    title = m.top.pressBack
    launchTheMovie(title)
    m.timer.control = "start"
 
end sub

sub OnItemFocused()
    m.section = m.networking.content.getChild(m.rowList.rowItemFocused[0])
    m.film = m.section.getChild(m.rowList.rowItemFocused[1])
    m.top.content = m.film
    m.videoContent = createObject("RoSGNode", "ContentNode")
    m.videoContent.url = m.film.TrailerURL
    m.detailScene.itemFocused = m.rowList.rowItemFocused[1]
    film = m.section.getChild(m.rowList.rowItemFocused[1])
    m.section.getChild(m.rowList.rowItemFocused[1]).isHiden = false
    m.section.getChild(m.rowList.rowItemFocused[1]).focus = false
    color = getAuthData(film.Id)
    m.section.getChild(m.rowList.rowItemFocused[1]).color = color
    
    m.detailScene.content = m.section
    m.detailScene.visible = true
    m.videoContent.streamformat = "hls"
    m.timer.control = "start"
    m.videoPlayer.content = m.videoContent
    m.videoPlayer.visible = false
    m.videoPlayer.control = "play"
    m.top.backgroundURI = m.film.FHDPosterUrl
end sub

function getAuthData(id as string) as string
    reg = CreateObject("roRegistry")
    sec = CreateObject("roRegistrySection", "Authentication")
    if sec.Exists(id)
      return sec.Read(id)
    end if
      return "#f7f7f7"
    end Function

sub playFilm()
  m.timer.control = "stop"
  m.detailScene.visible = false
  m.videoContent.url = m.film.VideoHLSURL
  m.videoPlayer.content = m.videoContent
  m.videoPlayer.visible = true
  m.videoPlayer.control = "play"
end sub

sub launchTheMovie(title)
    ' if title = "Play"

    ' else
      idFilm = m.film.id
      reg = CreateObject("roRegistry")
      sec = CreateObject("roRegistrySection", "Authentication")
      id = m.top.focusButton
      color = ""
    
    if title = "Add to favorite"
      color = "#fbede4" 
    else
      color = "#cf4017"
    end if

    sec.Delete(idFilm)
    sec.Write(idFilm, color)
    sec.Flush()
    m.detailScene.setFocus(true)
  'end if
end sub

  'fix
sub configurationTimer()
    m.timer = m.top.findNode("timer")
    m.timer.duration = "1"
    m.timer.observeField("fire", "videoLaunch")
    m.timer.repeat = true
end sub

sub videoLaunch()
    if m.videoPlayer.state = "playing"
      m.timer.control = "stop"
      m.videoPlayer.visible = true
    end if
end sub

sub loadFeed(url)
    m.networking = createObject("roSGNode", "Networking")
    m.networking.observeField("content", "onFeedResponse")
    m.networking.url = url
    m.networking.control = "RUN"
end sub  
  
sub onFeedResponse(obj)
    m.rowList.content = m.networking.content
end sub

'fix
function onKeyEvent(key, press) as Boolean
    if key = "OK"
      
      ' if m.rowList.visible = true 
      '    m.detailScene.itemFocused = m.rowList.rowItemFocused[1]
      '    m.section.getChild(m.rowList.rowItemFocused[1]).isHiden = true
      '    m.section.getChild(m.rowList.rowItemFocused[1]).focus = true
      '    m.detailScene.content = m.section
      '    m.rowList.visible = false
      '    m.videoPlayer.visible = false
      '    m.videoPlayer.control = "stop"
      '    m.detailScene.setFocus(true)
      ' end if
    end if
    if key <> "OK"
      if m.rowList.visible = true
        m.rowList.setFocus(true)
      end if
    end if

  return false
end function
    
