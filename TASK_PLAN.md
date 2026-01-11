# Task Plan: Clean Architecture + State Management + Mock Data (TDD/DRY/KISS)

## Principles
- TDD first: write failing tests before implementation.
- Small vertical slice: one feature end-to-end before scaling.
- DRY: shared mappers, DTOs, and error handling in `core/`.
- KISS: keep models and flows simple; avoid over-abstraction.

## Decisions (pick once, then stick to it)
- State management: Riverpod / Provider / Bloc (default: Riverpod if no preference).
- Dependency injection: constructor injection (default) or get_it.
- Error handling: `Result<T>` or `Either<Failure, T>` style.
- Mock data location: in-memory fixtures or JSON assets.

## Definition of Done
- Feature works with mock data and has loading/error/empty states.
- Domain + data + presentation layers exist and are test-covered.
- Repository can swap between mock and API data sources.
- Unit tests for use cases/repository/controller, widget test for UI.
- No direct data fetching in UI widgets.

## Step-by-step Plan

### 1) Baseline and scope
- Choose the first feature/screen (recommended: `MainMenuScreen` or `GarageScreen`).
- Identify the minimal data it needs and the UI states required.
- Define inputs/outputs for the feature in plain English.

### 2) Create architecture skeleton
- Add `lib/core/` utilities:
  - `core/error/failure.dart`
  - `core/result/result.dart` (or use `Either`)
- Add `lib/features/<feature>/` folders for `domain/`, `data/`, `presentation/`.

### 3) Domain layer (TDD)
- Write tests for the use case first.
- Create:
  - Entity (pure Dart model, no JSON).
  - Repository interface.
  - Use case (single responsibility).
- Keep domain free of Flutter and data source details.

### 4) Data layer (mock first)
- Write tests for repository implementation.
- Create:
  - DTO/model with `fromJson` and `toJson`.
  - Mapper between DTO and entity.
  - Mock data source (in-memory or JSON asset).
  - Repository implementation that uses the mock source.
- Keep mappers in `data/models/` or `data/mappers/`.

### 5) Presentation layer (TDD)
- Write tests for controller/state transitions.
- Create:
  - State class: `loading`, `data`, `error`, `empty`.
  - Controller/ViewModel wired to the use case.
- Keep the UI dumb: it reads state and renders.

### 6) UI integration
- Wire controller into UI via the chosen state management.
- Add UI states:
  - Loading placeholder.
  - Error message + retry action.
  - Empty state (if list is empty).
- Add widget tests for key states.

### 7) Prepare for API swap (no real API yet)
- Add an API data source interface + stub.
- Add `core/network/` with a client wrapper.
- Make repository choose data source via DI/config.
- Add integration test with a fake client (no real HTTP).

### 8) Rollout to next features
- Repeat steps 3-7 for additional screens.
- Extract shared code when duplication appears (not earlier).

## Suggested Folder Structure
```
lib/
  core/
    error/
    network/
    result/
  features/
    <feature>/
      data/
        datasources/
          <feature>_mock_datasource.dart
          <feature>_api_datasource.dart
        models/
        repositories/
      domain/
        entities/
        repositories/
        usecases/
      presentation/
        state/
        widgets/
        pages/
```

## Test Matrix (minimum)
- Domain use case: success + failure.
- Repository: maps DTO <-> entity correctly.
- Controller/ViewModel: transitions through loading -> data or error.
- Widget: renders state and actions.

## First Slice Checklist
- [ ] Feature selected
- [ ] Use case tests written
- [ ] Repository tests written
- [ ] Mock data source implemented
- [ ] Controller tests written
- [ ] UI wired and widget tests pass

## Open Questions
- Which state management package do you want?
- Which feature/screen should be the first slice?
- Do you want mock data as JSON assets or in-memory fixtures?

## Next Step
- Confirm the choices above, then implement steps 2-6 for the first slice.
