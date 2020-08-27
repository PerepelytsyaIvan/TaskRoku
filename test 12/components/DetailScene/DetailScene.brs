    sub init()
        m.titleFilmLabel = m.top.findNode("titleFilmLabel")
        m.descriptionFilmLabel = m.top.findNode("descriptionFilmLabel")
        m.parametersFilmLabel = m.top.findNode("parametersFilmLabel")
        m.mainScene = m.top.findNode("MainScene")
        configurationButton()
        m.top.setFocus(true)
    end sub

    sub actionButton()
        if m.buttonGrup.buttonSelected = 0
            m.top.actionButtonPlay = "play"
        else 
            if m.titleButton = "Add to favorite"
                m.titleButton = "Remove from favorites"
                color = "#cf4017"
            else
                m.titleButton = "Add to favorite"
                color = "#fbede4"
            end if
            m.titleFilmLabel.color = color
            m.buttonGrup.buttons = ["Play", m.titleButton]
            m.titleButtons =  m.titleButton
        end if
        m.top.setFocus(true)
    end sub

    sub transitionBack()
        title = m.titleButtons
        m.top.back = title
    end sub

    sub OnContentChanged()
        content = m.top.content
        itemFocused = m.top.itemFocused
        film = content.getChild(itemFocused)
        m.buttonGrup.visible = film.isHiden
        m.buttonGrup.setFocus(film.focus)
        if film.Color = "#cf4017"
            m.titleButton = "Remove from favorites"
        else
            m.titleButton = "Add to favorite"
        end if
        m.buttonGrup.buttons = ["Play", m.titleButton]
        m.titleFilmLabel.text = film.title
        ? film.Color
        m.titleFilmLabel.color = film.Color
        m.descriptionFilmLabel.text = film.DESCRIPTION
        parameters = film.Rating + "|" + film.ReleaseYear + "|" + content.title + "|" + film.Duration + "m"
        m.parametersFilmLabel.text = parameters
    end sub

    sub configurationButton()
        m.buttonGrup = m.top.findNode("buttonGroup")
        m.buttonGrup.buttons = ["Play", m.titleButton]
        m.buttonGrup.iconUri = ""
        m.buttonGrup.focusFootprintBitmapUri = "pkg:/images/gray.png"
        m.buttonGrup.focusBitmapUri="pkg:/images/pink.png"
        m.buttonGrup.layoutDirection = "horiz"
        m.buttonGrup.translation = [100, 900]
        m.buttonGrup.buttonSelected = 0
        m.buttonGrup.observeField("buttonSelected", "actionButton")
    end sub

    function onKeyEvent(key as String, press as Boolean) as Boolean
        if press 
        if key = "right"
            m.buttonGrup.focusButton = m.buttonGrup.buttonFocused + 1
        end if
        if key = "left"
            m.buttonGrup.focusButton = m.buttonGrup.buttonFocused - 1
        end if
    end if
    if key = "back"
        m.buttonGrup.visible = false
        transitionBack()
      return true
    end if
        return false
    end function