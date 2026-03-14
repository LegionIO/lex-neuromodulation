# lex-neuromodulation

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Gem**: `lex-neuromodulation`
- **Version**: 0.1.0
- **Namespace**: `Legion::Extensions::Neuromodulation`

## Purpose

Neuromodulatory system modeling the four classical monoamine/cholinergic pathways: dopamine, serotonin, norepinephrine, and acetylcholine. Each modulator has a level (0–1), an optimal range, a baseline, and an event log. Levels drift back to baseline over time. The composite influence of all modulators on specific cognitive properties (learning rate, arousal, attention precision, patience, memory encoding) is exposed for consumption by other extensions.

## Gem Info

- **Gemspec**: `lex-neuromodulation.gemspec`
- **Homepage**: https://github.com/LegionIO/lex-neuromodulation
- **License**: MIT
- **Ruby**: >= 3.4

## File Structure

```
lib/legion/extensions/neuromodulation/
  version.rb
  client.rb
  helpers/
    constants.rb         # MODULATORS list, optimal ranges, state labels, EMA alpha
    modulator.rb         # Modulator class — level, baseline, boost/suppress, drift, influence
    modulator_system.rb  # ModulatorSystem — manages all four modulators
  runners/
    neuromodulation.rb   # Runner module
  actors/
    drift.rb             # Periodic actor calling update_neuromodulation each tick
spec/
  helpers/constants_spec.rb
  helpers/modulator_spec.rb
  helpers/modulator_system_spec.rb
  runners/neuromodulation_spec.rb
  client_spec.rb
```

## Key Constants

From `Helpers::Constants`:
- `MODULATORS = %i[dopamine serotonin norepinephrine acetylcholine]`
- `DEFAULT_LEVEL = 0.5`, `MODULATION_ALPHA = 0.15`, `BASELINE_DRIFT = 0.01`
- `MAX_EVENTS = 200` (per modulator event log)
- `OPTIMAL_RANGES`: dopamine `0.4..0.7`, serotonin `0.4..0.7`, norepinephrine `0.3..0.6`, acetylcholine `0.4..0.7`

From `Helpers::Modulator::INFLUENCE_MAP`:
- `dopamine`: influences `[:learning_rate, :exploration_bias]`
- `serotonin`: influences `[:patience_factor]`
- `norepinephrine`: influences `[:arousal_level, :attention_precision]`
- `acetylcholine`: influences `[:memory_encoding, :attention_precision]`

## Runners

| Method | Key Parameters | Returns |
|---|---|---|
| `boost_modulator` | `name:`, `amount:`, `reason:` | `{ modulator:, level:, state: }` |
| `suppress_modulator` | `name:`, `amount:`, `reason:` | `{ modulator:, level:, state: }` |
| `modulator_level` | `name:` | `{ modulator:, level:, state: }` |
| `all_modulator_levels` | — | `{ levels: { dopamine:, ... } }` |
| `cognitive_influence` | — | composite influence snapshot across all properties |
| `is_optimal` | `name:` | `{ optimal: bool, level:, range: }` |
| `system_balance` | — | `{ score:, status: (:fully_balanced, :mostly_balanced, :partially_balanced, :imbalanced) }` |
| `modulator_history` | `name:`, `limit: 20` | `{ events:, count: }` |
| `update_neuromodulation` | — | tick: drift all modulators toward baseline |

## Helpers

### `Helpers::Modulator`
Single modulator: `@level` (current), `@baseline` (target), `@events` (log). `boost(amount, reason:)` and `suppress(amount, reason:)` clamp to [0, 1] and record event. `drift_to_baseline` moves level by `(baseline - level) * BASELINE_DRIFT` per tick. `state_label` returns `:surplus`, `:optimal`, or `:deficit`. `influence_on(target_property)` returns scaled influence (positive/negative relative to 0.5 baseline) for the relevant properties from `INFLUENCE_MAP`.

### `Helpers::ModulatorSystem`
Manages all four `Modulator` instances. `boost(name, amount, reason:)` and `suppress(name, amount, reason:)` delegate to the named modulator. `tick` calls `drift_to_baseline` on each. `composite_influences` aggregates all modulator influences across all target properties. `balance_score` = fraction of modulators in optimal range.

## Integration Points

- `cognitive_influence` output can modulate `lex-memory` encoding strength (acetylcholine)
- `dopamine[:learning_rate]` can modulate `lex-prediction` update rates
- `norepinephrine[:arousal_level]` aligns with `lex-emotion` arousal dimension
- `serotonin[:patience_factor]` can influence decision thresholds in `lex-planning`
- `update_neuromodulation` is the tick method for the `Drift` actor

## Development Notes

- `Modulator#influence_on` scales around 0.5: `(level - 0.5) * 2.0` — so optimal level (0.5) = zero influence (neutral)
- `balance_score` = count of optimal modulators / 4
- System balance status thresholds: >= 1.0 = `:fully_balanced`, >= 0.75 = `:mostly_balanced`, >= 0.5 = `:partially_balanced`, else `:imbalanced`
- State is fully in-memory; reset on process restart
