# `en_US_readability` Vale package

## Synopsis

Provides metrics for checking the readability of prose.

## Description

This style package contains rules that extend Vale's `metrics` rule type. The rules provide a
rough insight into the readability of prose. These metrics are tuned to a generally technical
audience.

## Rules

<!-- Remainder of document is generated, do not edit -->
<!-- markdownlint-disable MD033-->

The following table summarizes the available rules for the `en_US_readability` style:

| Rule | Level | Scope | Fixable |
|:-----|:-----:|:-----:|:-------:|
| [`en_US_readability.limit_average_syllables`](#en_US_readability.limit_average_syllables) | `warning` | `text` | No |
| [`en_US_readability.limit_difficulty`](#en_US_readability.limit_difficulty) | `suggestion` | `text` | No |
| [`en_US_readability.limit_grade_level`](#en_US_readability.limit_grade_level) | `suggestion` | `text` | No |
| [`en_US_readability.limit_h2_count`](#en_US_readability.limit_h2_count) | `suggestion` | `text` | No |
| [`en_US_readability.limit_page_length`](#en_US_readability.limit_page_length) | `suggestion` | `text` | No |
| [`en_US_readability.limit_paragraph_length`](#en_US_readability.limit_paragraph_length) | `suggestion` | `paragraph` | No |
| [`en_US_readability.limit_sentence_length`](#en_US_readability.limit_sentence_length) | `suggestion` | `sentence` | No |

### <a id="en_US_readability.limit_average_syllables"></a> `en_US_readability.limit_average_syllables` ([Definition file](./styles/en_US_readability/limit_average_syllables.yml))

The writing for these posts is often highly technical but should remain
accessible to readers. Average syllable count is a very rough metric to
indicate reading difficulty. Here we just aim to keep it reasonable.

If an article triggers this rule, it's likely extremely complex and failing
other metrics.

```yaml
Level   : warning
Scope   : text
Fixable : False
```

### <a id="en_US_readability.limit_difficulty"></a> `en_US_readability.limit_difficulty` ([Definition file](./styles/en_US_readability/limit_difficulty.yml))

<!-- vale en_US_style.avoid_passive_voice["is defined"] = NO -->

The LIX score provides a high level representation of how difficult a text is
to read. It is defined as the sum of the average word-count per sentence and
the percentage of words that are longer than six letters. The score breakdown
is:

<!-- vale en_US_style.avoid_passive_voice["is defined"] = YES -->

|      Score      | Reading difficulty |
|:---------------:|:-------------------|
|  `20` to `25`   | Very easy          |
|  `30` to `35`   | Easy               |
|  `40` to `45`   | Medium             |
|  `50` to `55`   | Difficult          |
| `60` and higher | Very difficult     |

```yaml
Level   : suggestion
Scope   : text
Fixable : False
```

### <a id="en_US_readability.limit_grade_level"></a> `en_US_readability.limit_grade_level` ([Definition file](./styles/en_US_readability/limit_grade_level.yml))

The Flesch-Kincaid grade level metric is an approximation of difficulty for
reading and normalizes the score to match US grade levels. Because this
blog tends to discuss complex and niche topics, we limit the grade level
to 10 rather than the more common 8.

```yaml
Level   : suggestion
Scope   : text
Fixable : False
```

### <a id="en_US_readability.limit_h2_count"></a> `en_US_readability.limit_h2_count` ([Definition file](./styles/en_US_readability/limit_h2_count.yml))

Every page gets a single H1 heading. H2 headings divide the prose into
sections. This metric functions as a smell-test for the overall complexity
of a page. More than 10 H2s pushes the content towards the very complex
end of the scale and indicates the post is a candidate for decomposing into
a series of posts.

```yaml
Level   : suggestion
Scope   : text
Fixable : False
```

### <a id="en_US_readability.limit_page_length"></a> `en_US_readability.limit_page_length` ([Definition file](./styles/en_US_readability/limit_page_length.yml))

Blog posts should be generally quick to read. A page in a book is roughly
250--300 words. Three thousand words is about ten pages of reading. While
it's okay to write longer posts, we should aim to keep things short. Long
posts are candidates for series of posts instead.

```yaml
Level   : suggestion
Scope   : text
Fixable : False
```

### <a id="en_US_readability.limit_paragraph_length"></a> `en_US_readability.limit_paragraph_length` ([Definition file](./styles/en_US_readability/limit_paragraph_length.yml))

Avoid long paragraphs for readability.

```yaml
Level   : suggestion
Scope   : paragraph
Fixable : False
```

### <a id="en_US_readability.limit_sentence_length"></a> `en_US_readability.limit_sentence_length` ([Definition file](./styles/en_US_readability/limit_sentence_length.yml))

Avoid long sentences for readability.

```yaml
Level   : suggestion
Scope   : sentence
Fixable : False
```
