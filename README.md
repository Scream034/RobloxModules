## Описание

Этот проект содержит вспомогательные файлы для команды **paralax**.

## Содержимое

1. Helper:
   - DataStore - Легкая работа с DataStore в Roblox.
   - General - Общие полезные функции.
2. Utils:
   - BasePart - Математика с `Part`.
   - Vector - Удобная математика с `Vector3` и `Vector2`.

## Использование (пример)

1. Скопируйте скрипт из файла `Helper/General`.
2. Вставьте в ваш проект `Roblox studio`.
   - В папку `ReplicatedStorage` (Или другие)

## Пример использования

```lua
-- Загрузка скрипта Helper/General
local HelperGeneral = require(path.to.Helper:WaitForChild("General"))

local hit = path.to.hit -- Парт хита

-- Получить игрока по парту UpperTorso
local player = HelperGeneral.GetPlayerByPart(hit, "UpperTorso")
```

## Лицензия

Подробности смотрите в файле [LICENSE](LICENSE) - GNU 3.0.

## Содействие

Если вы хотите помочь улучшить этот проект, будем рады принять ваши предложения изменений (Pull Requests) или сообщения об ошибках (Issues).

### Ссылки
| Имя         | Ссылка                      |
| ----------- | --------------------------- |
| Discord     | https://discord.gg/huzWF82w |
| Discord тег | paralax034 - создатель      |
