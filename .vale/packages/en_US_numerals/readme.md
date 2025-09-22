# `en_US_numerals` Vale package

## Synopsis

Provides rules for writing numeric values and numerals in prose.

## Description

This style package provides rules to ensure that you specify measurements and percentages
accurately. It defines rules for using numerals instead of ordinal number words, correcting spacing,
and using nonbreaking spaces between numerals and units.

## Rules

<!-- Remainder of document is generated, do not edit -->
<!-- markdownlint-disable MD033-->

The following table summarizes the available rules for the `en_US_numerals` style:

| Rule | Level | Scope | Fixable |
|:-----|:-----:|:-----:|:-------:|
| [`en_US_numerals.avoid_spaces_before_degree_symbol`](#en_US_numerals.avoid_spaces_before_degree_symbol) | `error` | `text` | Yes |
| [`en_US_numerals.avoid_spaces_before_double_prime_symbol`](#en_US_numerals.avoid_spaces_before_double_prime_symbol) | `error` | `text` | Yes |
| [`en_US_numerals.avoid_spaces_before_omega_symbol`](#en_US_numerals.avoid_spaces_before_omega_symbol) | `error` | `text` | Yes |
| [`en_US_numerals.avoid_spaces_before_percent_symbol`](#en_US_numerals.avoid_spaces_before_percent_symbol) | `error` | `text` | Yes |
| [`en_US_numerals.avoid_spaces_before_prime_symbol`](#en_US_numerals.avoid_spaces_before_prime_symbol) | `error` | `text` | Yes |
| [`en_US_numerals.use_en_dash_for_negative_numbers`](#en_US_numerals.use_en_dash_for_negative_numbers) | `error` | `sentence` | Yes |
| [`en_US_numerals.use_nonbreaking_space_before_measurement_unit`](#en_US_numerals.use_nonbreaking_space_before_measurement_unit) | `warning` | `text` | Yes |
| [`en_US_numerals.use_nonbreaking_space_before_percent_unit`](#en_US_numerals.use_nonbreaking_space_before_percent_unit) | `warning` | `text` | Yes |
| [`en_US_numerals.use_numerals_with_measurements`](#en_US_numerals.use_numerals_with_measurements) | `warning` | `text` | No |
| [`en_US_numerals.use_numerals_with_percentages`](#en_US_numerals.use_numerals_with_percentages) | `warning` | `text` | No |

### <a id="en_US_numerals.avoid_spaces_before_degree_symbol"></a> `en_US_numerals.avoid_spaces_before_degree_symbol` ([Definition file](./styles/en_US_numerals/avoid_spaces_before_degree_symbol.yml))

Avoid spaces between numerals and degree symbols (`°`) when indicating
a measurement like degrees of temperature or arc. For example, prefer
`45° wide` and `18°C` over `45 ° wide` and `18 °C`.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_numerals.avoid_spaces_before_double_prime_symbol"></a> `en_US_numerals.avoid_spaces_before_double_prime_symbol` ([Definition file](./styles/en_US_numerals/avoid_spaces_before_double_prime_symbol.yml))

Avoid spaces between numerals and double prime symbols (`″` or `"`) when
indicating a measurement like inches or arcseconds. For example, prefer
`5'4" long` and `30°5'20″` over `5 ' 4" long` or `30° 5' 20″`.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_numerals.avoid_spaces_before_omega_symbol"></a> `en_US_numerals.avoid_spaces_before_omega_symbol` ([Definition file](./styles/en_US_numerals/avoid_spaces_before_omega_symbol.yml))

Avoid spaces between numerals and omega symbols (`Ω`) when indicating
a measurement of ohms. For example, prefer `1.5Ω` over `1.5 Ω`.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_numerals.avoid_spaces_before_percent_symbol"></a> `en_US_numerals.avoid_spaces_before_percent_symbol` ([Definition file](./styles/en_US_numerals/avoid_spaces_before_percent_symbol.yml))

Avoid spaces between numerals and percent symbols (`%`). For example, prefer
`25%` over `25 %`. Percentages with the symbol suffix shouldn't have a space
between numerals and the symbol.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_numerals.avoid_spaces_before_prime_symbol"></a> `en_US_numerals.avoid_spaces_before_prime_symbol` ([Definition file](./styles/en_US_numerals/avoid_spaces_before_prime_symbol.yml))

Avoid spaces between numerals and prime symbols (`′` or `'`) when indicating
a measurement like feet or arcminutes. For example, prefer `5' long` and
`30°5′` over`5 ' long` or `30° 5 ′`.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_numerals.use_en_dash_for_negative_numbers"></a> `en_US_numerals.use_en_dash_for_negative_numbers` ([Definition file](./styles/en_US_numerals/use_en_dash_for_negative_numbers.yml))

En dashes are the correct punctuation to use for negative numbers.

```yaml
Level   : error
Scope   : sentence
Fixable : True
```

### <a id="en_US_numerals.use_nonbreaking_space_before_measurement_unit"></a> `en_US_numerals.use_nonbreaking_space_before_measurement_unit` ([Definition file](./styles/en_US_numerals/use_nonbreaking_space_before_measurement_unit.yml))

When you're listing a measurement with a given unit, always:

1.  Specify the value with numerals, like `5 kg`, not `five kg`.
1.  Always place a nonbreaking space after the numerals and before the unit
    when spelling out the unit out or using an abbreviation.
1.  For measurements where the unit is a symbol, define the symbol immediately
    after the numerals without a separating nonbreaking space, like `5' long`.

Measurements require precision, so write them with numerals. Use nonbreaking
spaces between the numerals and the unit so that the pair are always
displayed together even when the rendered text would normally break across
a line.

```yaml
Level   : warning
Scope   : text
Fixable : True
```

### <a id="en_US_numerals.use_nonbreaking_space_before_percent_unit"></a> `en_US_numerals.use_nonbreaking_space_before_percent_unit` ([Definition file](./styles/en_US_numerals/use_nonbreaking_space_before_percent_unit.yml))

When you're defining a specific percentage, always:

1.  Specify the value with numerals, like:
    - `5 perent`, not `five percent`.
    - `3.2 percentage points`, not `three point two percentage points`.
    - `90%`, not `ninety %`.
1.  Always place a nonbreaking space after the numerals and before the text
    when using `percent`, `percentage`, `percentages`, `percentage point`,
    or `percentage points`.
1.  When using the percent symbol (`%`), define the symbol immediately
    after the numerals without a separating nonbreaking space, like `5%`.

Percentages require precision, so write them with numerals. Use nonbreaking
spaces between the numerals and the indicating text so that the pair are
always displayed together even when the rendered text would normally break
across a line.

```yaml
Level   : warning
Scope   : text
Fixable : True
```

### <a id="en_US_numerals.use_numerals_with_measurements"></a> `en_US_numerals.use_numerals_with_measurements` ([Definition file](./styles/en_US_numerals/use_numerals_with_measurements.yml))

When you're defining a measurement with a given unit, always:

1.  Specify the value with numerals, like `5 kg`, not `five kg`.
1.  Always place a nonbreaking space after the numerals and before the unit
    when spelling out the unit out or using an abbreviation.
1.  For measurements where the unit is a symbol, define the symbol immediately
    after the numerals without a separating nonbreaking space, like `5' long`.

Measurements require precision, so write them with numerals. Use nonbreaking
spaces between the numerals and the unit so that the pair are always
displayed together even when the rendered text would normally break across
a line.

```yaml
Level   : warning
Scope   : text
Fixable : False
```

### <a id="en_US_numerals.use_numerals_with_percentages"></a> `en_US_numerals.use_numerals_with_percentages` ([Definition file](./styles/en_US_numerals/use_numerals_with_percentages.yml))

When you're defining a specific percentage, always:

1.  Specify the value with numerals, like:
    - `5 perent`, not `five percent`.
    - `3.2 percentage points`, not `three point two percentage points`.
    - `90%`, not `ninety %`.
1.  Always place a nonbreaking space after the numerals and before the text
    when using `percent`, `percentage`, `percentages`, `percentage point`,
    or `percentage points`.
1.  When using the percent symbol (`%`), define the symbol immediately
    after the numerals without a separating nonbreaking space, like `5%`.

Percentages require precision, so write them with numerals. Use nonbreaking
spaces between the numerals and the indicating text so that the pair are
always displayed together even when the rendered text would normally break
across a line.

```yaml
Level   : warning
Scope   : text
Fixable : False
```
