-- Обработчик всех тегов
-- Автор: paralax034

-- Хранение скриптов на стороне сервера
local ServerScriptService = game:GetService("ServerScriptService")

-- Доступ к тегам
local CollectionService = game:GetService("CollectionService")

-- См. Modules/Utils/Instance.lua
local ToolsInstance = require(ServerScriptService.Modules.Tools:WaitForChild("Instance"))
-- См. Modules/Utils/Player.lua
local ToolsPlayer = require(ServerScriptService.Modules.Tools:WaitForChild("Player"))
-- См. Modules/Utils/Tags.lua
local ToolsTags = require(ServerScriptService.Modules.Tools:WaitForChild("Tags"))


---- Если игрок прикоснулся к парту - смерть

-- Обработчик тега
-- Берёт humanoid у игрока и ставит хп в 0
local function handlePlayerDeadWhenCollidePart(affectedPart: BasePart)
	local humanoid = ToolsPlayer.GetPlayerHumanoidByPart(affectedPart)
	if not humanoid then return end
	
	humanoid.Health = 0
end

-- Инициализирует наш тег
-- Проверяет явл-я ли BasePart, далее соединяет с обработчиком тега
local function initPlayerDeadWhenCollidePart(object: BasePart)
	if object:IsA("BasePart") then
		object.Touched:Connect(handlePlayerDeadWhenCollidePart)
	end
end

-- Создание модуля
ToolsTags:Initialize()

-- Добавление тега
ToolsTags:Add("PlayerDeadWhenCollidePart", handlePlayerDeadWhenCollidePart, initPlayerDeadWhenCollidePart)

-- Привязываем
ToolsTags:Update()
