
sub init()
    m.imageFilm = m.top.findNode("imageFilm")
end sub

sub itemContentChanged()
   content = m.top.itemContent
   m.imageFilm.uri = content.HDPOSTERURL
end sub

sub showFocus()
    scale = 1 + (m.top.focusPercent * 0.1)
    m.imageFilm.scale = [scale, scale]
  end sub