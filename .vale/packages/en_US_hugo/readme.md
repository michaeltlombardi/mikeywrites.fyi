# `en_US_hugo` Vale package

## Synopsis

Provides rules specific to writing for Hugo.

## Description

This style package provides rules specific to using Hugo, rather than general style or grammar. In
particular, it addresses issues of typography.

## Rules

<!-- Remainder of document is generated, do not edit -->
<!-- markdownlint-disable MD033-->

The following table summarizes the available rules for the `en_US_hugo` style:

| Rule | Level | Scope | Fixable |
|:-----|:-----:|:-----:|:-------:|
| [`en_US_hugo.use_double_hyphen_for_en_dashes`](#en_US_hugo.use_double_hyphen_for_en_dashes) | `error` | `text` | Yes |
| [`en_US_hugo.use_triple_hyphen_for_em_dashes`](#en_US_hugo.use_triple_hyphen_for_em_dashes) | `error` | `text` | Yes |
| [`en_US_hugo.use_triple_period_for_ellipsis`](#en_US_hugo.use_triple_period_for_ellipsis) | `error` | `text` | Yes |

### <a id="en_US_hugo.use_double_hyphen_for_en_dashes"></a> `en_US_hugo.use_double_hyphen_for_en_dashes` ([Definition file](./styles/en_US_hugo/use_double_hyphen_for_en_dashes.yml))

Use double hyphens (`--`) to represent em dashes (`–`). Hugo automatically
converts the double hyphens. It's easier to distinguish between em and en
hyphens as `---` and `--` than `—` and `–`.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_hugo.use_triple_hyphen_for_em_dashes"></a> `en_US_hugo.use_triple_hyphen_for_em_dashes` ([Definition file](./styles/en_US_hugo/use_triple_hyphen_for_em_dashes.yml))

Use triple dashes (`---`) to represent em dashes (`—`). Hugo automatically
converts the triple dashes. It's easier to distinguish between em and en
dashes as `---` and `--` than `—` and `–`.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_hugo.use_triple_period_for_ellipsis"></a> `en_US_hugo.use_triple_period_for_ellipsis` ([Definition file](./styles/en_US_hugo/use_triple_period_for_ellipsis.yml))

Use triple periods (`...`) to represent an ellipsis (`…`). Hugo automatically
converts the triple periods. Nonstandard characters can make diffing and
parsing more difficult.

```yaml
Level   : error
Scope   : text
Fixable : True
```
