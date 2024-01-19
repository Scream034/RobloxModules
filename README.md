## Описание

Этот проект содержит вспомогательные файлы для команды **paralax**.
Все скрипты и методы в этом репозитории были использованы на практике!
Поэтому я не пишу много, так как репозиторий будет обновлятся и пополнятся по-мере моего опыта.

## Использование (пример)

1. Скопируйте скрипт из файла `Utils/LivingEntity`.
2. Вставьте в ваш проект `Roblox studio`.
   - В папку `ReplicatedStorage` (Или другие)

## Пример использования

```lua
-- Загрузка скрипта Utils/LivingEntity
local ToolsLivingEntity = require(path.to.Utils:WaitForChild("LivingEntity"))

local hit = path.to.hit -- Парт хита

-- Получить игрока по парту UpperTorso
local player = ToolsLivingEntity.GetPlayerByPart(hit, true, "Torso")
print(player)
```

## Лицензия

Подробности смотрите в файле [LICENSE](LICENSE) - GNU 3.0.

## Содействие

Если вы хотите помочь улучшить этот проект, будем рады принять ваши предложения изменений (Pull Requests) или сообщения об ошибках (Issues).

### Ссылки
| Имя         | Ссылка                      |
| ----------- | --------------------------- |
| Discord тег | paralax034 - создатель      |
