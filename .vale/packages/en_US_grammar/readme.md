# `en_US_grammar` Vale package

## Synopsis

Provides rules for fixing grammatical issues.

## Description

The `en_US_grammar` style package includes rules for reducing grammatical, rather than style,
errors.

## Rules

<!-- Remainder of document is generated, do not edit -->
<!-- markdownlint-disable MD033-->

The following table summarizes the available rules for the `en_US_grammar` style:

| Rule | Level | Scope | Fixable |
|:-----|:-----:|:-----:|:-------:|
| [`en_US_grammar.use_that_or_which_for_clauses`](#en_US_grammar.use_that_or_which_for_clauses) | `suggestion` | `text` | Yes |

### <a id="en_US_grammar.use_that_or_which_for_clauses"></a> `en_US_grammar.use_that_or_which_for_clauses` ([Definition file](./styles/en_US_grammar/use_that_or_which_for_clauses.yml))

Use `that` for restrictive clauses. Use `which` for nonrestrictive clauses.

A clause is _restrictive_ when a reader requires the clause to correctly
understand the preceding noun. A clause is _nonrestrictive_ if a reader can
understand the preceding noun without the clause.

For more information, see [_That vs. Which_][that-vs-which].

[that-vs-which]: https://owl.purdue.edu/owl/general_writing/grammar/that_vs_which.html

```yaml
Level   : suggestion
Scope   : text
Fixable : True
```
