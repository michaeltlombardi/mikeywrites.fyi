# `en_US_style` Vale package

## Synopsis

Provides rules for ensuring consistent style in prose.

## Description

This style package provides general rules for the style of the prose. It aims
to ensure that the prose is strong, clear, and accessible.

## Rules

<!-- Remainder of document is generated, do not edit -->
<!-- markdownlint-disable MD033-->

The following table summarizes the available rules for the `en_US_style` style:

| Rule | Level | Scope | Fixable |
|:-----|:-----:|:-----:|:-------:|
| [`en_US_style.avoid_heading_acronyms`](#en_US_style.avoid_heading_acronyms) | `warning` | `heading` | No |
| [`en_US_style.avoid_passive_voice`](#en_US_style.avoid_passive_voice) | `suggestion` | `text` | No |

### <a id="en_US_style.avoid_heading_acronyms"></a> `en_US_style.avoid_heading_acronyms` ([Definition file](./styles/en_US_style/avoid_heading_acronyms.yml))

Avoid acronyms in headings, as they can be less readable especially when using
accessibility navigation.

```yaml
Level   : warning
Scope   : heading
Fixable : False
```

### <a id="en_US_style.avoid_passive_voice"></a> `en_US_style.avoid_passive_voice` ([Definition file](./styles/en_US_style/avoid_passive_voice.yml))

Avoid using the passive voice. Active voice is stronger and reads more
clearly. Passive voice introduces ambiguity and weakens any message.

```yaml
Level   : suggestion
Scope   : text
Fixable : False
```
