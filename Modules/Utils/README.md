# BasePart.luau

## Имя функции: `GetBasePartBounds(basePart: BasePart)`
Функция возвращает границы базовой части.
### Параметры:
- `basePart`: BasePart, базовая часть, для которой вычисляются границы.
### Возвращает:
- `{Min: Vector3, Max: Vector3}`, границы базовой части.

# CameraCoordinate.luau

## Имя функции: `GetPositionAndAnglesFromCamera(camera: Camera, positionOffset: Vector3?, rotationOffset: Vector3?)`
Функция возвращает позицию и углы камеры.
### Параметры:
- `camera`: Camera, камера, от которой вычисляются позиция и углы.
- `positionOffset`: Vector3, смещение позиции (необязательный параметр).
- `rotationOffset`: Vector3, смещение углов (необязательный параметр).
### Возвращает:
- `{Position: Vector3, Rotation: Vector3, Look: Vector3}`, позиция, углы и вектор взгляда камеры.

## Имя функции: `GetDegrees(rotation: Vector3)`
Функция возвращает углы в градусах.
### Параметры:
- `rotation`: Vector3, углы в радианах.
### Возвращает:
- `Vector3`, углы в градусах.

# CharacterFinder.luau

## Имя функции: `GetHumanoidByPart(part: BasePart, enableExactSearchMethod: boolean?, name: string?)`
Функция возвращает гуманоида, связанного с частью.
### Параметры:
- `part`: BasePart, часть, для которой ищется гуманоид.
- `enableExactSearchMethod`: boolean, включает точный метод поиска (необязательный параметр).
- `name`: string, имя для поиска (необязательный параметр).
### Возвращает:
- `Humanoid?`, гуманоид, связанный с частью, или nil, если гуманоид не найден.

## Имя функции: `GetPlayerByPart(part: BasePart, enableExactSearchMethod: boolean?, name: string?)`
Функция возвращает игрока, связанного с частью.
### Параметры:
- `part`: BasePart, часть, для которой ищется игрок.
- `enableExactSearchMethod`: boolean, включает точный метод поиска (необязательный параметр).
- `name`: string, имя для поиска (необязательный параметр).
### Возвращает:
- `Player?`, игрок, связанный с частью, или nil, если игрок не найден.

# Coordinate.luau

## Имя функции: `GetPositionOnNormal(originCframe: CFrame, originSize: Vector3, normalId: Enum.NormalId, positionOffset: Vector3?)`
Функция возвращает позицию на нормали.
### Параметры:
- `originCframe`: CFrame, исходная система координат.
- `originSize`: Vector3, исходный размер.
- `normalId`: Enum.NormalId, идентификатор нормали.
- `positionOffset`: Vector3, смещение позиции (необязательный параметр).
### Возвращает:
- `Vector3`, позиция на нормали.

## Имя функции: `GetNormalRelativeToPosition(originCFrame: CFrame, originSize: Vector3, position: Vector3)`
Функция возвращает нормаль, относительную к позиции.
### Параметры:
- `originCFrame`: CFrame, исходная система координат.
- `originSize`: Vector3, исходный размер.
- `position`: Vector3, позиция.
### Возвращает:
- `Enum.NormalId?`, нормаль, относительная к позиции, или nil, если нормаль не найдена.

# Path.luau (Deprecated, use :GetFullName and FindFirstChild)

## Имя функции: `GetInstancePath(instance: Instance)`
Функция возвращает путь к экземпляру.
### Параметры:
- `instance`: Instance, экземпляр, для которого ищется путь.
### Возвращает:
- `string?`, путь к экземпляру, или nil, если экземпляр не является потомком игры.

## Имя функции: `GetInstanceFromPath(path: string)`
Функция возвращает экземпляр по пути.
### Параметры:
- `path`: string, путь к экземпляру.
### Возвращает:
- `Instance?`, экземпляр по пути, или nil, если экземпляр не найден.

# Physics.luau

## Имя функции: `ApplyForce(basePart: BasePart, velocity: Vector3, duration: number?)`
Функция применяет силу к базовой части.
### Параметры:
- `basePart`: BasePart, базовая часть, к которой применяется сила.
- `velocity`: Vector3, скорость, с которой применяется сила.
- `duration`: number, продолжительность применения силы (необязательный параметр).

## Имя функции: `ApplyForceFromLook(basePart: BasePart, basePartLook: BasePart, velocity: Vector3, duration: number?)`
Функция применяет силу к базовой части относительно взгляда другой базовой части.
### Параметры:
- `basePart`: BasePart, базовая часть, к которой применяется сила.
- `basePartLook`: BasePart, базовая часть, относительно взгляда которой применяется сила.
- `velocity`: Vector3, скорость, с которой применяется сила.
- `duration`: number, продолжительность применения силы (необязательный параметр).

# Sound.luau

## Имя функции: `Play(originPart: BasePart, id: number, minDistance: number, maxDistance: number, isWait: boolean, looped: boolean?, callback: "function"?)`
Функция воспроизводит звук.
### Параметры:
- `originPart`: BasePart, базовая часть, относительно которой воспроизводится звук.
- `id`: number, идентификатор звука.
- `minDistance`: number, минимальное расстояние для воспроизведения звука.
- `maxDistance`: number, максимальное расстояние для воспроизведения звука.
- `isWait`: boolean, ожидание окончания воспроизведения звука.
- `looped`: boolean, зацикленное воспроизведение звука (необязательный параметр).
- `callback`: "function", функция обратного вызова, вызываемая по окончании воспроизведения звука (необязательный параметр).

# Table.luau

## Имя функции: `GetKeyByIndex(_table: {[string]: any}, index: number)`
Функция возвращает ключ и значение по индексу в таблице.
### Параметры:
- `_table`: {[string]: any}, таблица, в которой ищется ключ и значение.
- `index`: number, индекс, по которому ищется ключ и значение.
### Возвращает:
- `{}?`, ключ и значение по индексу в таблице, или nil, если ключ и значение не найдены.

## Имя функции: `GetKeyIndexByName(_table: {}, name: string)`
Функция возвращает индекс ключа по имени в таблице.
### Параметры:
- `_table`: {}, таблица, в которой ищется индекс ключа.
- `name`: string, имя, по которому ищется индекс ключа.
### Возвращает:
- `number?`, индекс ключа по имени в таблице, или nil, если индекс ключа не найден.

## Имя функции: `GetKeyIndexByValue<a>(_table: {}, value: a)`
Функция возвращает индекс ключа по значению в таблице.
### Параметры:
- `_table`: {}, таблица, в которой ищется индекс ключа.
- `value`: a, значение, по которому ищется индекс ключа.
### Возвращает:
- `number?`, индекс ключа по значению в таблице, или nil, если индекс ключа не найден.

## Имя функции: `ReplaceKeys(_table: {}, keyMappings: {})`
Функция заменяет ключи в таблице.
### Параметры:
- `_table`: {}, таблица, в которой заменяются ключи.
- `keyMappings`: {}, отображение старых ключей на новые.

## Имя функции: `UpdateExistingKeys(_table: {}, fromTable: {})`
Функция обновляет существующие ключи в таблице.
### Параметры:
- `_table`: {}, таблица, в которой обновляются ключи.
- `fromTable`: {}, таблица, из которой берутся новые значения для ключей.
