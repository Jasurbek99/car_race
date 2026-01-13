 Race Game Fix - Implementation Plan

 Problem Summary

 Issue: Cars in the race game show as colored boxes (blue/red rectangles) instead of actual sprites. Console shows asset loading errors.

 Root Cause: Flame's asset loading uses gameRef.images which requires proper path handling. The current implementation strips 'assets/' prefix but doesn't use the
 game's image cache correctly.

 ---
 Critical Files to Modify

 1. lib/game/components/modular_car_component.dart - Fix asset loading and positioning
 2. lib/game/race_game.dart - Improve AI behavior and add asset preloading
 3. lib/core/services/asset_logger.dart - NEW FILE for error logging
 4. lib/core/utils/asset_diagnostic.dart - NEW FILE for debugging

 ---
 Implementation Steps

 Step 1: Fix Asset Loading in ModularCarComponent (CRITICAL)

 File: lib/game/components/modular_car_component.dart

 Problem: Currently uses Sprite.load() which fails. Need to use gameRef.images for proper Flame asset loading.

 Changes:
 - Line 9: Add HasGameRef<FlameGame> mixin to class declaration
 - Lines 54-146: Rewrite onLoad() method to:
   - Use gameRef.images.load(path) instead of Sprite.load(path)
   - Create sprites from cached images: Sprite(gameRef.images.fromCache(path))
   - Apply CarConstants.carBodyVerticalOffset to all components
   - Apply wheel adjustments (wheelTopAdjust, sizeScale) from rendering plan
   - Add enhanced error logging with asset paths
   - Show "ASSET ERROR" text on fallback rectangles

 Key Code Pattern:
 // Load body
 final bodyPath = (plan['bodyPath'] as String).replaceAll('assets/', '');
 await gameRef.images.load(bodyPath);
 final bodyImage = gameRef.images.fromCache(bodyPath);
 final bodySprite = Sprite(bodyImage);

 carBody = SpriteComponent(
   sprite: bodySprite,
   size: Vector2(bodySize.width, bodySize.height),
   position: Vector2(0, CarConstants.carBodyVerticalOffset),
 );

 Step 2: Add Asset Preloading in RaceGame

 File: lib/game/race_game.dart

 Changes:
 - Line 58: Add _preloadAssets() call at start of onLoad()
 - After line 588: Add new method _preloadAssets() to load car assets before game starts
 - Add helper method _preloadCarAssets(CarConfig) to load individual car assets

 Purpose: Prevents lag when cars are created by loading assets upfront.

 Step 3: Improve AI Behavior

 File: lib/game/race_game.dart

 Changes:
 - Lines 266-272: Replace random AI with _updateAIBehavior(dt) call
 - After line 588: Add new method _updateAIBehavior(dt) with:
   - Decision-making every 0.5 seconds
   - Speed matching based on player speed
   - Intelligent gear shifting
   - Configurable aggressiveness (0.7-1.0 random)
 - Add AI state variables: _aiAggressiveness, _aiReactionTime, _aiDecisionInterval
 - Line 491: Reset AI state in resetGame()

 Purpose: Make AI more competitive and less predictable than current random behavior.

 Step 4: Add Error Logging Service

 New File: lib/core/services/asset_logger.dart

 Purpose: Centralized logging for asset loading with clear console output.

 Methods:
 - logAssetLoadSuccess(path, type) - Success messages
 - logAssetLoadFailure(path, type, error, stackTrace) - Detailed error reports
 - logCarLoadAttempt(carId, skinId, wheelId) - Track load attempts

 Step 5: Add Asset Diagnostic Tool

 New File: lib/core/utils/asset_diagnostic.dart

 Purpose: Verify asset existence before loading for debugging.

 Methods:
 - assetExists(path) - Check if asset can be loaded
 - verifyCarAssets(carId, skinId, wheelId) - Check all assets for a car
 - printAssetReport(carId, skinId, wheelId) - Print diagnostic report

 Step 6: Apply Positioning Fixes from Preview Widget

 Ensure these values are applied in ModularCarComponent:
 - CarConstants.carBodyVerticalOffset = -25 (moves entire car up)
 - CarConstants.rearWheelTopAdjust = 25.0
 - CarConstants.frontWheelTopAdjust = 25.0
 - CarConstants.rearWheelSizeScale = 0.6
 - CarConstants.frontWheelSizeScale = 0.6

 Positioning Pattern (from ModularCarPreview):
 position: Vector2(
   offset.dx,
   offset.dy + wheelTopAdjust + CarConstants.carBodyVerticalOffset,
 )

 ---
 Implementation Order (Priority)

 1. CRITICAL - Step 1: Fix asset loading (colored boxes → real sprites)
 2. HIGH - Step 4: Add error logging (better debugging)
 3. HIGH - Step 6: Apply positioning fixes (centering)
 4. MEDIUM - Step 2: Asset preloading (performance)
 5. MEDIUM - Step 3: AI improvements (game feel)
 6. LOW - Step 5: Diagnostic tool (debugging helper)

 ---
 Testing Checklist

 After implementation, verify:

 Visual Tests

 - Player car shows correct sprite (not colored box)
 - AI car shows correct sprite (not colored box)
 - Wheels are positioned correctly under car
 - Wheels rotate during movement
 - Cars are centered vertically on track
 - Multiple car types work (car_01 through car_05)
 - Different wheel types work (type_1 through type_5)

 Console Tests

 - No asset loading errors in console
 - Success messages show loaded assets
 - Diagnostic output confirms asset paths

 Gameplay Tests

 - AI provides competitive racing
 - AI uses gear shifting
 - Controls work (gas/brake/gear shift)
 - Race countdown works
 - Winner detection works
 - Reset/restart works

 Error Handling Tests

 - Missing assets show "ASSET ERROR" text
 - Console shows detailed error with paths
 - Game doesn't crash on missing assets
 - Fallback assets load correctly

 ---
 Technical Details

 Asset Path Format

 - CarRenderSpec generates: "assets/cars/car_01/base.png"
 - Strip for Flame: "cars/car_01/base.png" (remove 'assets/')
 - Flame loads from: assets/cars/car_01/base.png (adds 'assets/' back automatically)

 Flame Image Loading

 // WRONG (current - causes errors):
 final sprite = await Sprite.load(path);

 // CORRECT (new - uses game reference):
 await gameRef.images.load(path);
 final sprite = Sprite(gameRef.images.fromCache(path));

 Component Layering Order

 1. Car body (bottom)
 2. Rear wheel
 3. Front wheel
 4. Helmet (top, optional)

 Positioning System

 - Normalized anchors (0.0-1.0) in CarConstants.defaultAnchorsNormalized
 - Converted to pixels by CarRenderSpec.getRenderingPlan()
 - Adjustments applied: wheelTopAdjust, carBodyVerticalOffset, sizeScale

 ---
 Risk Mitigation

 Risk: Flame version compatibility

 - Solution: Add HasGameRef<FlameGame> mixin to ModularCarComponent
 - Verification: Check Flame version in pubspec.yaml (should be 1.x.x compatible)

 Risk: Asset loading timing

 - Solution: Preload assets in RaceGame.onLoad() before creating cars
 - Fallback: Components handle their own loading with error handling

 Risk: Performance issues

 - Solution: Use gameRef.images cache (loads once, reuses)
 - Optimization: Preload common assets upfront

 Risk: Different car sizes

 - Solution: Use normalized anchors (work for any car size)
 - Verification: Test with all 5 car models

 ---
 Expected Outcome

 After implementation:
 - ✅ Cars render with actual sprites (no colored boxes)
 - ✅ Positioning matches garage preview
 - ✅ Wheels positioned correctly and rotate
 - ✅ Better AI racing behavior
 - ✅ Clear error messages if assets fail
 - ✅ Smooth gameplay without lag
 - ✅ Easy to debug asset issues

 ---
 Reference Files (Read-Only)

 These files show correct patterns to follow:

 - lib/features/car/presentation/widgets/modular_car_preview.dart - Correct positioning implementation
 - lib/features/car/application/services/car_render_spec.dart - Path generation (already correct)
 - lib/core/constants/car_constants.dart - Positioning constants and adjustments