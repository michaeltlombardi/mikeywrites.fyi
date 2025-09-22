# `en_US` Vale package

## Synopsis

The core package for US English.

## Description

The `en_US` package is a convenience package containing the full set of style rules for US English.
The included configuration file applies every `en_US_*` style and the base Vale style to every
Markdown document.

## Included styles

- [`en_US_bias`](../en_US_bias/readme.md): Provides rules for reducing bias in prose.
- [`en_US_grammar`](../en_US_grammar/readme.md): Provides rules for fixing grammatical issues.
- [`en_US_hugo`](../en_US_hugo/readme.md): Provides rules specific to writing for Hugo.
- [`en_US_numerals`](../en_US_numerals/readme.md): Provides rules for writing numeric values and
  numerals in prose.
- [`en_US_punctuation`](../en_US_punctuation/readme.md): Provides rules for correctly defining
  punctuation in prose.
- [`en_US_readability`](../en_US_readability/readme.md): Provides metrics for checking the
  readability of prose.
- [`en_US_style`](../en_US_style/readme.md): Provides rules for ensuring consistent style in prose.

## Rules

<!-- Remainder of document is generated, do not edit -->
<!-- markdownlint-disable MD033-->

The following table summarizes the available rules for the `en_US` style:

| Rule | Level | Scope | Fixable |
|:-----|:-----:|:-----:|:-------:|
| [`en_US.avoid_todo_placeholders`](#en_US.avoid_todo_placeholders) | `error` | `text` | No |
| [`en_US.use_valid_spelling`](#en_US.use_valid_spelling) | `error` | `text` | No |

### <a id="en_US.avoid_todo_placeholders"></a> `en_US.avoid_todo_placeholders` ([Definition file](./styles/en_US/avoid_todo_placeholders.yml))

Make sure all temporary markers have been removed before publishing by
checking for the strings `XXX`, `FIXME`, and `TODO`.

```yaml
Level   : error
Scope   : text
Fixable : False
```

### <a id="en_US.use_valid_spelling"></a> `en_US.use_valid_spelling` ([Definition file](./styles/en_US/use_valid_spelling.yml))

Apply custom `hunspell` dictionaries to the prose. This style defines the
following dictionaries:

<dl>
  <dt>
    <a href="./config/dictionaries/en_US.dic"><code>en_US</code></a>
    (<a href="./config/dictionaries/en_US.aff">Affix file</a>)
  </dt>
  <dd>Basic US English dictionary.</dd>
  <dt>
    <a href="./config/dictionaries/en_US_tech.dic"><code>en_US_tech</code></a>
    (<a href="./config/dictionaries/en_US_tech.aff">Affix file</a>)
  </dt>
  <dd>Additional dictionary for technical terms in US English.</dd>
</dl>

This style also defines the ignore file, [`phrases.txt`][phrases.txt], which
provides overrides to ignore as misspellings.

Add any unrecognized terms to one of the two dictionaries. Add any terms
that need specific casing to the project vocabulary instead.

[phrases.txt]: ./config/ignore/phrases.txt

```yaml
Level   : error
Scope   : text
Fixable : False
```
