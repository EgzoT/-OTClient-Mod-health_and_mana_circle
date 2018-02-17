mapPanel = modules.game_interface.getMapPanel()
gameRootPanel = modules.game_interface.gameBottomPanel
gameLeftPanel = modules.game_interface.getLeftPanel()
gameTopMenu = modules.client_topmenu.getTopMenu()

function currentViewMode()
  return modules.game_interface.currentViewMode
end

healthCircle = nil
manaCircle = nil

g_ui.loadUI('game_healthcircle')

healthCircleFront = nil
manaCircleFront = nil

function init()
  healthCircle = g_ui.createWidget('HealthCircle', mapPanel)
  manaCircle = g_ui.createWidget('ManaCircle', mapPanel)

  healthCircleFront = g_ui.createWidget('HealthCircleFront', mapPanel)
  manaCircleFront = g_ui.createWidget('ManaCircleFront', mapPanel)

  whenMapResizeChange()
  initOnHpAndMpChange()
  initOnGeometryChange()
  initOnLoginChange()
end

function terminate()
  healthCircle:destroy()
  manaCircle:destroy()
  healthCircleFront:destroy()
  manaCircleFront:destroy()

  terminateOnHpAndMpChange()
  terminateOnGeometryChange()
  terminateOnLoginChange()
end

-------------------------------------------------
--Scripts----------------------------------------
-------------------------------------------------

function initOnHpAndMpChange()
  connect(LocalPlayer, { onHealthChange = whenHealthChange,
                         onManaChange = whenManaChange })
end

function terminateOnHpAndMpChange()
  disconnect(LocalPlayer, { onHealthChange = whenHealthChange,
                            onManaChange = whenManaChange })
end

function initOnGeometryChange()
  connect(gameRootPanel, { onGeometryChange = whenMapResizeChange })
end

function terminateOnGeometryChange()
  disconnect(gameRootPanel, { onGeometryChange = whenMapResizeChange })
end

function initOnLoginChange()
  connect(g_game, { onGameStart = whenMapResizeChange })
end

function terminateOnLoginChange()
  disconnect(g_game, { onGameStart = whenMapResizeChange })
end

function whenHealthChange()
  if g_game.isOnline() then
    local healthPercent = math.floor(g_game.getLocalPlayer():getHealthPercent())
    local Yhppc = math.floor(208 * (1 - (healthPercent/ 100)))
    local rect = { x = 0, y = Yhppc, width = 63, height = 208 }
    healthCircleFront:setImageClip(rect)

    if healthPercent > 92 then
      healthCircleFront:setImageColor("#00BC00")
    elseif healthPercent > 60 then
      healthCircleFront:setImageColor("#50A150")
    elseif healthPercent > 30 then
      healthCircleFront:setImageColor("#A1A100")
    elseif healthPercent > 8 then
      healthCircleFront:setImageColor("#BF0A0A")
    elseif healthPercent > 3 then
      healthCircleFront:setImageColor("#910F0F")
    else
      healthCircleFront:setImageColor("#850C0C")
    end

    if currentViewMode() ~= 2 then
      healthCircleFront:setY(mapPanel:getHeight() / 2 - healthCircle:getHeight() / 2 + gameTopMenu:getHeight() + Yhppc)
    else
      healthCircleFront:setY(mapPanel:getHeight() / 2 - healthCircle:getHeight() / 2 + 0 + Yhppc)
    end
  end
end

function whenManaChange()
  if g_game.isOnline() then
    local Ymppc = math.floor(208 * (1 - (math.floor((g_game.getLocalPlayer():getMaxMana() - (g_game.getLocalPlayer():getMaxMana() - g_game.getLocalPlayer():getMana())) * 100 / g_game.getLocalPlayer():getMaxMana()) / 100)))
    local rect = { x = 0, y = Ymppc, width = 63, height = 208 }
    manaCircleFront:setImageClip(rect)
    if currentViewMode() ~= 2 then
      manaCircleFront:setY(mapPanel:getHeight() / 2 - manaCircle:getHeight() / 2 + gameTopMenu:getHeight() + Ymppc)
    else
      manaCircleFront:setY(mapPanel:getHeight() / 2 - manaCircle:getHeight() / 2 + 0 + Ymppc)
    end
  end
end

function whenMapResizeChange()
  if g_game.isOnline() then
    whenHealthChange()
    whenManaChange()

    if currentViewMode() == 2 then
      healthCircleFront:setX(math.floor((mapPanel:getWidth() / 2 + healthCircle:getWidth() / 2 - 150)) * 0.92)
      manaCircleFront:setX(math.floor((mapPanel:getWidth() / 2 + manaCircle:getWidth() / 2 + 0)) * 1.08)

      healthCircle:setX(math.floor((mapPanel:getWidth() / 2 + healthCircle:getWidth() / 2 - 150)) * 0.92)
      manaCircle:setX(math.floor((mapPanel:getWidth() / 2 + manaCircle:getWidth() / 2 + 0)) * 1.08)

      healthCircle:setY(mapPanel:getHeight() / 2 - healthCircle:getHeight() / 2 + 0)
      manaCircle:setY(mapPanel:getHeight() / 2 - manaCircle:getHeight() / 2 + 0)
    elseif gameLeftPanel:isOn() then
      healthCircleFront:setX(math.floor((mapPanel:getWidth() / 2 + healthCircle:getWidth() / 2 - 150 + gameLeftPanel:getWidth())) * 0.92)
      manaCircleFront:setX(math.floor((mapPanel:getWidth() / 2 + manaCircle:getWidth() / 2 + gameLeftPanel:getWidth())) * 1.08)

      healthCircle:setX(math.floor((mapPanel:getWidth() / 2 + healthCircle:getWidth() / 2 - 150 + gameLeftPanel:getWidth())) * 0.92)
      manaCircle:setX(math.floor((mapPanel:getWidth() / 2 + manaCircle:getWidth() / 2 + gameLeftPanel:getWidth())) * 1.08)

      healthCircle:setY(mapPanel:getHeight() / 2 - healthCircle:getHeight() / 2 + gameTopMenu:getHeight())
      manaCircle:setY(mapPanel:getHeight() / 2 - manaCircle:getHeight() / 2 + gameTopMenu:getHeight())
    else
      healthCircleFront:setX(math.floor((mapPanel:getWidth() / 2 + healthCircle:getWidth() / 2 - 150)) * 0.92)
      manaCircleFront:setX(math.floor((mapPanel:getWidth() / 2 + manaCircle:getWidth() / 2 + 0)) * 1.08)

      healthCircle:setX(math.floor((mapPanel:getWidth() / 2 + healthCircle:getWidth() / 2 - 150)) * 0.92)
      manaCircle:setX(math.floor((mapPanel:getWidth() / 2 + manaCircle:getWidth() / 2 + 0)) * 1.08)

      healthCircle:setY(mapPanel:getHeight() / 2 - healthCircle:getHeight() / 2 + gameTopMenu:getHeight())
      manaCircle:setY(mapPanel:getHeight() / 2 - manaCircle:getHeight() / 2 + gameTopMenu:getHeight())
    end
  end
end