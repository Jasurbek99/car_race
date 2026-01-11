# Updated File Tree - Modular Cars & HUD Implementation

## New Structure

```
car_race/
├── lib/
│   ├── core/                                    # NEW: Core utilities
│   │   ├── constants/
│   │   │   ├── car_constants.dart              # NEW: Car rendering constants
│   │   │   └── hud_constants.dart              # NEW: HUD gauge constants
│   │   └── utils/
│   │       └── math_utils.dart                 # NEW: Math helper functions
│   │
│   ├── features/
│   │   ├── car/                                # NEW: Modular car feature
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── car_config.dart         # NEW: Car configuration entity
│   │   │   │   └── repositories/
│   │   │   │       └── car_selection_repository.dart  # NEW: Repository interface
│   │   │   ├── data/
│   │   │   │   ├── catalogs/
│   │   │   │   │   └── car_catalog.dart        # NEW: Available cars/parts catalog
│   │   │   │   └── repositories/
│   │   │   │       └── car_selection_repository_sp.dart  # NEW: SharedPreferences impl
│   │   │   ├── application/
│   │   │   │   ├── providers/
│   │   │   │   │   ├── car_selection_provider.dart     # NEW: Riverpod provider
│   │   │   │   │   └── car_selection_provider.g.dart   # GENERATED
│   │   │   │   └── services/
│   │   │   │       └── car_render_spec.dart    # NEW: Rendering service
│   │   │   └── presentation/
│   │   │       └── widgets/
│   │   │           └── modular_car_preview.dart  # NEW: Flutter preview widget
│   │   │
│   │   ├── hud/                                # NEW: HUD feature
│   │   │   ├── domain/
│   │   │   │   └── entities/
│   │   │   │       └── hud_telemetry.dart      # NEW: Telemetry data entity
│   │   │   └── presentation/
│   │   │       └── widgets/
│   │   │           ├── tachometer.dart         # NEW: RPM gauge widget
│   │   │           └── g_meter.dart            # NEW: G-force meter widget
│   │   │
│   │   ├── garage/                             # EXISTING (modified)
│   │   │   └── presentation/
│   │   │       └── widgets/
│   │   │           └── car_display_section.dart  # MODIFIED: Uses modular cars
│   │   │
│   │   ├── account/                            # EXISTING
│   │   ├── nitro/                              # EXISTING
│   │   └── shop/                               # EXISTING
│   │
│   ├── game/
│   │   ├── components/
│   │   │   └── modular_car_component.dart      # NEW: Flame modular car
│   │   ├── race_game.dart                      # MODIFIED: RPM/G-force calc
│   │   └── race_hud_controller.dart            # MODIFIED: Extended state
│   │
│   ├── screens/
│   │   └── game/
│   │       └── widgets/
│   │           └── race_status_panels.dart     # MODIFIED: Integrated gauges
│   │
│   └── [other existing files...]
│
├── test/                                        # NEW: Unit tests
│   ├── core/
│   │   └── utils/
│   │       └── math_utils_test.dart            # NEW
│   └── features/
│       └── car/
│           ├── domain/
│           │   └── entities/
│           │       └── car_config_test.dart    # NEW
│           └── application/
│               └── services/
│                   └── car_render_spec_test.dart  # NEW
│
├── assets/
│   ├── cars/                                    # EXISTING (assets present)
│   │   ├── car_01/base.png
│   │   ├── car_02/base.png
│   │   ├── car_03/base.png, green.png, pink.png, yellow.png
│   │   ├── car_04/base.png, blue.png
│   │   └── car_05/base.png
│   ├── wheels/                                  # NEW (directory created)
│   │   └── type_1.png to type_5.png (to be added)
│   └── helmets/                                 # NEW (directory created)
│       └── (future helmet assets)
│
├── docs/
│   └── TASKS_MODULAR_CARS.md                   # NEW: Implementation guide
│
├── IMPLEMENTATION_SUMMARY.md                    # NEW: Summary document
├── FILE_TREE.md                                 # NEW: This file
└── pubspec.yaml                                 # MODIFIED: Added modular assets

## File Statistics

- **New files**: 25+ (excluding generated files)
- **Modified files**: 5
- **Test files**: 3
- **Documentation files**: 3
- **Total lines of code**: ~3000+

## Key Files to Review

### Must Review
1. `lib/core/constants/car_constants.dart` - Car rendering configuration
2. `lib/features/car/application/services/car_render_spec.dart` - Core rendering logic
3. `lib/features/hud/presentation/widgets/tachometer.dart` - RPM gauge
4. `docs/TASKS_MODULAR_CARS.md` - Complete implementation guide

### Integration Points
1. `lib/features/garage/presentation/widgets/car_display_section.dart` - Garage integration
2. `lib/game/race_game.dart` - RPM/G-force calculation
3. `lib/screens/game/widgets/race_status_panels.dart` - HUD gauge integration

### Configuration
1. `lib/features/car/data/catalogs/car_catalog.dart` - Add new cars here
2. `lib/core/constants/hud_constants.dart` - Tweak gauge behavior here
```
