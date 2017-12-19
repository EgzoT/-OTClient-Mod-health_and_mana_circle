mapPanel = modules.game_interface.getMapPanel()
gameRootPanel = modules.game_interface.gameBottomPanel
gameLeftPanel = modules.game_interface.getLeftPanel()

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
    local Yhppc = math.floor(208 * (1 - (g_game.getLocalPlayer():getHealthPercent() / 100)))
    local rect = { x = 0, y = Yhppc, width = 63, height = 208 }
    healthCircleFront:setImageClip(rect)
    if currentViewMode() ~= 2 then
      healthCircleFront:setY(mapPanel:getHeight() / 2 - healthCircle:getHeight() / 2 + 30 + Yhppc)
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
      manaCircleFront:setY(mapPanel:getHeight() / 2 - manaCircle:getHeight() / 2 + 30 + Ymppc)
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
      healthCircleFront:setX(mapPanel:getWidth() / 2 + healthCircle:getWidth() / 2 - 150)
      manaCircleFront:setX(mapPanel:getWidth() / 2 + manaCircle:getWidth() / 2 + 0)

      healthCircle:setX(mapPanel:getWidth() / 2 + healthCircle:getWidth() / 2 - 150)
      manaCircle:setX(mapPanel:getWidth() / 2 + manaCircle:getWidth() / 2 + 0)

      healthCircle:setY(mapPanel:getHeight() / 2 - healthCircle:getHeight() / 2 + 0)
      manaCircle:setY(mapPanel:getHeight() / 2 - manaCircle:getHeight() / 2 + 0)
    elseif gameLeftPanel:isOn() then
      healthCircleFront:setX(mapPanel:getWidth() / 2 + healthCircle:getWidth() / 2 - 150 + gameLeftPanel:getWidth())
      manaCircleFront:setX(mapPanel:getWidth() / 2 + manaCircle:getWidth() / 2 + gameLeftPanel:getWidth())

      healthCircle:setX(mapPanel:getWidth() / 2 + healthCircle:getWidth() / 2 - 150 + gameLeftPanel:getWidth())
      manaCircle:setX(mapPanel:getWidth() / 2 + manaCircle:getWidth() / 2 + gameLeftPanel:getWidth())

      healthCircle:setY(mapPanel:getHeight() / 2 - healthCircle:getHeight() / 2 + 30)
      manaCircle:setY(mapPanel:getHeight() / 2 - manaCircle:getHeight() / 2 + 30)
    else
      healthCircleFront:setX(mapPanel:getWidth() / 2 + healthCircle:getWidth() / 2 - 150)
      manaCircleFront:setX(mapPanel:getWidth() / 2 + manaCircle:getWidth() / 2 + 0)

      healthCircle:setX(mapPanel:getWidth() / 2 + healthCircle:getWidth() / 2 - 150)
      manaCircle:setX(mapPanel:getWidth() / 2 + manaCircle:getWidth() / 2 + 0)

      healthCircle:setY(mapPanel:getHeight() / 2 - healthCircle:getHeight() / 2 + 30)
      manaCircle:setY(mapPanel:getHeight() / 2 - manaCircle:getHeight() / 2 + 30)
    end
  end
end