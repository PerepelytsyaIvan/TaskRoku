sub init()
    m.imageFilm = m.top.findNode("imageFilm")
end sub

sub itemContentChanged()
   content = m.top.itemContent
   m.imageFilm.uri = content.HDPOSTERURL
end sub

sub showfocus()
    scale = 1 + (m.top.focusPercent * 0.08)
      m.imageFilm.scale = [scale, scale]
     ' m.imageFilm.opacity = 0.75 - (m.top.focusPercent * 0.75)
  end sub