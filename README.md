# lex-neuromodulation

Neuromodulatory system for the LegionIO cognitive architecture. Models dopamine, serotonin, norepinephrine, and acetylcholine pathways and their influence on cognitive processing.

## What It Does

Maintains four neuromodulatory channels, each with a current level, an optimal range, and a baseline. Levels can be boosted or suppressed in response to cognitive events, then drift back toward baseline over time. The composite influence of all modulators on properties like learning rate, arousal, attention precision, and patience is exposed for consumption by other extensions.

## Usage

```ruby
client = Legion::Extensions::Neuromodulation::Client.new

# Boost dopamine after a successful prediction
client.boost_modulator(name: :dopamine, amount: 0.15, reason: 'prediction correct')
# => { modulator: :dopamine, level: 0.65, state: :optimal }

# Suppress norepinephrine after a low-stress period
client.suppress_modulator(name: :norepinephrine, amount: 0.1, reason: 'calm period')

# Check system balance
client.system_balance
# => { score: 0.75, status: :mostly_balanced, states: { dopamine: :optimal, ... } }

# Get composite cognitive influence
client.cognitive_influence
# => { influences: { learning_rate: 0.3, arousal_level: -0.1, attention_precision: 0.2, ... } }

# Tick: drift all modulators toward baseline
client.update_neuromodulation
```

## Modulators and Their Cognitive Influences

| Modulator | Optimal Range | Influences |
|---|---|---|
| dopamine | 0.4–0.7 | learning_rate, exploration_bias |
| serotonin | 0.4–0.7 | patience_factor |
| norepinephrine | 0.3–0.6 | arousal_level, attention_precision |
| acetylcholine | 0.4–0.7 | memory_encoding, attention_precision |

## State Labels

Each modulator reports `:optimal`, `:surplus` (above range), or `:deficit` (below range).

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
