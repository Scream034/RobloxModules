-- Обработчик всех тегов
-- Автор: paralax034

-- Хранение скриптов на стороне сервера
local ServerScriptService = game:GetService("ServerScriptService")

-- Доступ к тегам
local CollectionService = game:GetService("CollectionService")

-- См. Modules/Utils/Path.lua
local PathUtils = require(ServerScriptService.Modules.Utils:WaitForChild("Path"))
-- См. Modules/Utils/CharacterFinder.lua
local CharacterFinder = require(ServerScriptService.Modules.Utils:WaitForChild("CharacterFinder"))
-- См. Modules/Managers/Tags.lua
local TagsManager = require(ServerScriptService.Modules.Managers:WaitForChild("Tag"))


---- Если игрок прикоснулся к парту - смерть

-- Обработчик тега
-- Берёт humanoid у игрока и ставит хп в 0
local function handleKillCharacterOnCollision(affectedPart: BasePart)
	local humanoid = CharacterFinder.GetPlayerHumanoidByPart(affectedPart)
	if not humanoid then return end
	
	humanoid.Health = 0
end

-- Регистрирует наш тег
-- Проверяет явл-я ли BasePart, далее соединяет с обработчиком тега
local function registerKillCharacterOnCollision(object: BasePart)
	if object:IsA("BasePart") then
		object.Touched:Connect(handleKillCharacterOnCollision)
	end
end

-- Создание модуля
local Tags = TagsManager:Initialize()

-- Добавление тега
Tags:Add("KillCharacterOnCollision", registerKillCharacterOnCollision)

-- Привязываем
Tags:Update()