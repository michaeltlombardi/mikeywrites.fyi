# `en_US_bias` Vale package

## Synopsis

Provides rules for reducing bias in prose.

## Description

The `en_US_grammar` style package includes rules for reducing bias in prose. The purpose of this
package is to make the prose more inclusive.

## Rules

<!-- Remainder of document is generated, do not edit -->
<!-- markdownlint-disable MD033-->

The following table summarizes the available rules for the `en_US_bias` style:

| Rule | Level | Scope | Fixable |
|:-----|:-----:|:-----:|:-------:|
| [`en_US_bias.avoid_gender_bias`](#en_US_bias.avoid_gender_bias) | `error` | `text` | Yes |

### <a id="en_US_bias.avoid_gender_bias"></a> `en_US_bias.avoid_gender_bias` ([Definition file](./styles/en_US_bias/avoid_gender_bias.yml))

Avoid using gendered language where possible. Using gendered language raises
issues of inclusivity and bias.

```yaml
Level   : error
Scope   : text
Fixable : True
```
