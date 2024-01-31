## Описание

Этот проект содержит вспомогательные файлы для **paralax**, *но и для тебя тоже*.
Все скрипты и методы в этом репозитории были использованы на практике!

## Использование (пример)

1. Скопируйте скрипт из файла `Utils/CharacterFinder`.
2. Вставьте в ваш проект `Roblox studio`.
   - В папку `ReplicatedStorage` (Или другие)

## Пример использования

```lua
-- Загрузка скрипта Utils/CharacterFinder
local CharacterFinder = require(path.to.Utils:WaitForChild("CharacterFinder"))

local targetPart = path.to.Part -- путь до вашего парта

-- Получить игрока по парту, в котором, в имени есть строка "Torso"
local player = CharacterFinder.GetPlayerByPart(targetPart, false, "Torso")

-- Выводим имя игрока, если нет, тогда "Не найден игрок"
print(player.Name or "Не найден игрок")
```

## Лицензия

Подробности смотрите в файле [LICENSE](LICENSE) - GNU 3.0.

## Содействие

Если вы хотите помочь улучшить этот проект, будем рады принять ваши предложения изменений (Pull Requests) или сообщения об ошибках (Issues).

### Ссылки
| Имя         | Ссылка                      |
| ----------- | --------------------------- |
| Discord тег | paralax034 - создатель      |
