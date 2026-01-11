# Modular Car System Implementation Plan 

## A) Current architecture summary

### Project structure
- `lib/game` contains the Flame game loop (`RaceGame`) and HUD controller.
- `lib/components` contains the Flame `Car` component.
- `lib/screens` contains older UI screens (GameScreen, MainMenu).
- `lib/features` contains newer clean-architecture modules using Riverpod (garage, nitro, shop, account).
- `assets/` contains full car PNGs, mock data JSON, and an unused `assets/cars/` modular set not listed in `pubspec.yaml`.

### Game loop
- `GameScreen` creates a `RaceGame` and hosts it via `GameWidget`.
- `RaceGame` drives update/tap/key input, moves player/AI cars, and updates HUD via `RaceHudController`.

### Race gameplay logic (current)
- Scene setup: `RaceGame.onLoad` builds sky/ground/road layers, lane divider, road markers, and a finish line at ~90% screen width.
- Car spawn: `playerCar` (bottom lane) and `aiCar` (top lane) are created with fixed sprite paths and sizes.
- Player input: tap/space starts the race and triggers acceleration; releasing stops acceleration and applies brake. Gear shifts are handled via arrow keys or UI buttons (`RaceHud` → `RaceControls` → `RaceGame` callbacks).
- Countdown flow: starting a race sets a 3-second countdown, shows "GO!" briefly, then clears it.
- Update loop: AI acceleration is randomized each frame; car positions advance by speed; road markers scroll based on average car speed.
- HUD updates: `RaceHudController` broadcasts speed, gear, progress, countdown, and winner text to the Flutter overlay.
- Finish/reset: first car to cross the finish line wins (tie supported); state becomes `finished`, cars stop, and a tap/space resets positions and state.

### Car movement model (current)
- `lib/components/car.dart` applies acceleration, braking, and natural deceleration per frame.
- Effective max speed is derived from `baseMaxSpeed * gearRatios[currentGear - 1]`.
- Gear count and ratios can be adjusted via `CarModel` stats when provided.
- Tire rotation is driven by speed and applied to wheel sprites.

### Asset loading
- Flame car sprites are loaded in `lib/components/car.dart` via `Sprite.load`.
- Race uses hard-coded sprite paths in `lib/game/race_game.dart`.
- UI screens use `Image.asset` with `assets/full_cars/` or `assets/images/main_screen/car.png`.
- `assets/cars/` exists with base/skins/wheels but is not in `pubspec.yaml`, so it is not currently loaded.

### Selected car flow (current)
- `GameProgress` can persist `selectedCar` in SharedPreferences, but it is not referenced by UI or game.
- Garage uses mock JSON and local state; RaceGame ignores selection and uses hard-coded sprites.
- There is no end-to-end flow from a selected car in Garage to the car rendered in Race.

### Relevant files (current behavior)
- `lib/main.dart` - App entry; routes for old screens and new feature pages.
- `lib/screens/game_screen.dart` - Hosts `GameWidget` and wires HUD controls.
- `lib/game/race_game.dart` - Flame game loop; instantiates two `Car` components with hard-coded sprite paths.
- `lib/components/car.dart` - Flame `PositionComponent` that loads body + tire sprites and handles speed/gear logic.
- `lib/data/cars.dart` - Static list of `CarModel` definitions (paths + stats); currently unused by UI/game.
- `lib/models/car_model.dart` - Car model schema used by `Car` component for stats (optional).
- `lib/models/game_progress.dart` - SharedPreferences persistence with `selectedCar`; unused.
- `lib/features/garage/presentation/pages/garage_page.dart` - Riverpod garage UI; renders `Image.asset` via `CarDisplaySection`.
- `lib/features/garage/presentation/widgets/car_display_section.dart` - Garage preview widget with `Image.asset(car.imagePath)`.
- `lib/screens/garage_screen.dart` - Older garage screen with hard-coded car + `Image.asset`.
- `lib/features/nitro/presentation/pages/nitro_page.dart` - Nitro UI with static full car image.
- `lib/screens/nitro_screen.dart` - Older nitro screen with static full car image.
- `lib/screens/main_menu_screen.dart` - Main menu shows static car image.
- `lib/screens/race_mode_screen.dart` - Background car image from network (decorative).
- `assets/mock_data/garage_cars.json` - Garage car list with `imagePath` to full car PNGs.
- `assets/mock_data/nitro_levels.json` - Nitro levels keyed by `carId` (currently fixed to "1").
- `assets/cars/` - Existing modular car assets (base + color variants + wheels); not referenced in code or pubspec.
- `pubspec.yaml` - Assets list does not include `assets/cars/`.

## B) Inventory: all car-related touchpoints

| Location/Feature | File path(s) | What it currently renders/does | What must change later |
| --- | --- | --- | --- |
| Race gameplay | `lib/game/race_game.dart` | Spawns `Car` components with hard-coded body/tire sprites | Accept `CarConfig` and use shared modular renderer |
| Flame car renderer | `lib/components/car.dart` | Loads body + tire sprites; rotates tires | Extend/replace to layer body + wheels + helmet using shared anchors |
| Game host | `lib/screens/game_screen.dart` | Creates `RaceGame` without selection | Inject selected `CarConfig` (player and AI) |
| Garage (new) | `lib/features/garage/presentation/pages/garage_page.dart` | Loads garage cars from Riverpod; shows `CarDisplaySection` | Use modular preview widget and selection state |
| Garage preview widget | `lib/features/garage/presentation/widgets/car_display_section.dart` | `Image.asset(car.imagePath)` | Swap to modular preview using `CarConfig` |
| Garage (old) | `lib/screens/garage_screen.dart` | Hard-coded car image + stats | Update to modular preview or retire |
| Nitro (new/old) | `lib/features/nitro/presentation/pages/nitro_page.dart`<br>`lib/screens/nitro_screen.dart` | Static `assets/full_cars/toyota.png` preview | Use same modular preview for the current car |
| Main menu | `lib/screens/main_menu_screen.dart` | Static hero car image | Optional: replace with modular preview to stay consistent |
| Race mode background | `lib/screens/race_mode_screen.dart` | Network car image for background | Optional: swap to local modular preview or keep decorative |
| Car data | `lib/data/cars.dart` | Static car defs with body/tire paths | Convert to catalog with cosmetics + anchors |
| Selection storage | `lib/models/game_progress.dart` | Persists `selectedCar` only | Expand to store `CarConfig` or add new repository/provider |
| Garage data source | `assets/mock_data/garage_cars.json` | Uses `imagePath` for full car PNGs | Add `carId` + default cosmetics or migrate away from `imagePath` |
| Assets | `assets/full_cars/`<br>`assets/cars/` | Full car PNGs and modular parts | Standardize `assets/cars` and include in `pubspec.yaml` |

## C) Proposed target design (NO code)

### CarConfig (selection)
- `carId`: stable identifier (e.g., `car_01`)
- `skinId`: body color/skin (`base`, `red`, `blue`)
- `wheelId`: wheel variant (`type_1`, `type_2`)
- `helmetId`: helmet variant (`helmet_01`) or `none`

### Catalog + anchors
- Central `CarCatalog` (or similar) maps `carId` to:
  - available skins and default skin
  - base stats (if used for gameplay)
  - shared anchor positions (MVP: same for all cars)
- Anchor positions stored in Dart as normalized coordinates (0-1) relative to body canvas:
  - `rearWheelCenter`: (0.23, 0.72)
  - `frontWheelCenter`: (0.77, 0.72)
  - `helmetAnchor`: (0.54, 0.28)
- Use one canonical body canvas size across all cars; transparent padding is allowed.

### Shared renderer
- Create a shared `CarRenderSpec` resolver that converts `CarConfig` into asset paths + anchors.
- Flame: `ModularCarComponent` uses `SpriteComponent` layers (body, wheels, helmet) and reuses existing wheel rotation logic.
- Flutter UI: `ModularCarPreview` widget layers `Image.asset` in a `Stack` using the same `CarRenderSpec`.

### Asset naming conventions
- `assets/cars/{carId}/base.png`
- `assets/cars/{carId}/{skinId}.png`
- `assets/cars/wheels/{wheelId}.png`
- `assets/cars/helmets/{helmetId}.png` (if/when added)
- Keep legacy `assets/full_cars/` for migration fallback.

## D) Step-by-step tasks (checkbox list)

### Phase 1: Asset standardization rules
- [ ] Define canonical body canvas size and document anchor coordinates (update `docs/TASKS_MODULAR_CARS.md`).
- [ ] Align existing assets under `assets/cars/` to the naming convention (verify `car_01` etc.).
- [ ] Add helmets folder and placeholder naming scheme in `assets/cars/` (no new assets required yet).
- [ ] Update `pubspec.yaml` to include `assets/cars/` (and helmets folder if added).

### Phase 2: Data model + storage plan
- [ ] Define `CarConfig` and a `CarCatalog` mapping (likely new files under `lib/models/` or a new `lib/features/car/`).
- [ ] Decide storage strategy: extend `lib/models/game_progress.dart` to persist `CarConfig` OR add a new SharedPreferences-backed repository with Riverpod provider.
- [ ] Update `assets/mock_data/garage_cars.json` and `lib/features/garage/data/models/garage_car_model.dart` to include `carId` and default cosmetics instead of only `imagePath`.
- [ ] Add migration logic: if only `selectedCar` exists, map to default `CarConfig`.

### Phase 3: Shared rendering plan
- [ ] Create `CarRenderSpec` resolver (shared logic) with normalized anchors and asset paths.
- [ ] Implement `ModularCarComponent` in Flame to load body, wheels, helmet; keep wheel rotation logic from `lib/components/car.dart`.
- [ ] Implement `ModularCarPreview` Flutter widget that reuses the same render spec for UI screens.

### Phase 4: Garage preview integration plan
- [ ] Update `lib/features/garage/presentation/widgets/car_display_section.dart` to use `ModularCarPreview`.
- [ ] Update `lib/features/garage/presentation/pages/garage_page.dart` to read/write selected `CarConfig` via provider.
- [ ] Update or retire `lib/screens/garage_screen.dart` to avoid divergence.

### Phase 5: Race integration plan
- [ ] Update `lib/screens/game_screen.dart` to pass selected `CarConfig` into `RaceGame`.
- [ ] Update `lib/game/race_game.dart` to build player/AI cars from `CarConfig` using `ModularCarComponent`.
- [ ] Decide AI selection rule (fixed default or random from catalog).

### Phase 6: Testing plan
- [ ] Unit tests for `CarRenderSpec` (asset path resolution + anchors).
- [ ] Unit tests for selection persistence and migration (SharedPreferences).
- [ ] Widget test or golden test for `ModularCarPreview` layering.
- [ ] Manual smoke tests: Garage preview and Race show the same selected config on device.

### Phase 7: Migration plan
- [ ] Keep legacy `imagePath` rendering as fallback if modular assets are missing.
- [ ] Maintain `assets/full_cars/` and `assets/images/main_screen/car.png` during transition.
- [ ] Remove legacy fallbacks only after modular assets cover all cars in `garage_cars.json`.

## E) Acceptance criteria
- [ ] Garage preview shows the selected skin, wheels, and helmet.
- [ ] Race gameplay uses the exact same selection as Garage.
- [ ] All screens that show cars use the shared renderer or a defined fallback.
- [ ] No UI regressions in Garage/Nitro/Main Menu layouts.
- [ ] Performance stays acceptable on phone (no frame drops when rendering cars).
