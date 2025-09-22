# `en_US_punctuation` Vale package

## Synopsis

Provides rules for correctly defining punctuation in prose.

## Description

This style package defines rules relating specifically to using punctuation in prose. It handles
checking for invalid usages of punctuation and for invalid spacing around punctuation.

## Rules

<!-- Remainder of document is generated, do not edit -->
<!-- markdownlint-disable MD033-->

The following table summarizes the available rules for the `en_US_punctuation` style:

| Rule | Level | Scope | Fixable |
|:-----|:-----:|:-----:|:-------:|
| [`en_US_punctuation.avoid_consecuritve_commas`](#en_US_punctuation.avoid_consecuritve_commas) | `error` | `text` | Yes |
| [`en_US_punctuation.avoid_double_periods`](#en_US_punctuation.avoid_double_periods) | `error` | `text` | Yes |
| [`en_US_punctuation.avoid_heading_punctuation`](#en_US_punctuation.avoid_heading_punctuation) | `warning` | `heading` | Yes |
| [`en_US_punctuation.avoid_hyphenated_ly`](#en_US_punctuation.avoid_hyphenated_ly) | `error` | `text` | Yes |
| [`en_US_punctuation.avoid_periods_in_acronyms`](#en_US_punctuation.avoid_periods_in_acronyms) | `error` | `text` | Yes |
| [`en_US_punctuation.avoid_semicolons_in_sentences`](#en_US_punctuation.avoid_semicolons_in_sentences) | `suggestion` | `sentence` | No |
| [`en_US_punctuation.avoid_spaces_around_em_dashes`](#en_US_punctuation.avoid_spaces_around_em_dashes) | `error` | `text` | Yes |
| [`en_US_punctuation.avoid_spaces_before_commas`](#en_US_punctuation.avoid_spaces_before_commas) | `error` | `text` | Yes |
| [`en_US_punctuation.use_lowercase_after_colon`](#en_US_punctuation.use_lowercase_after_colon) | `warning` | `sentence` | Yes |
| [`en_US_punctuation.use_one_space_after_sentence`](#en_US_punctuation.use_one_space_after_sentence) | `error` | `text` | Yes |
| [`en_US_punctuation.use_oxford_comma`](#en_US_punctuation.use_oxford_comma) | `warning` | `sentence` | Yes |
| [`en_US_punctuation.use_punctuation_inside_quotes`](#en_US_punctuation.use_punctuation_inside_quotes) | `error` | `text` | Yes |

### <a id="en_US_punctuation.avoid_consecuritve_commas"></a> `en_US_punctuation.avoid_consecuritve_commas` ([Definition file](./styles/en_US_punctuation/avoid_consecuritve_commas.yml))

Multiple consecutive commas have no meaningful semantics in US English. If
the comma was accidentally repeated, it should be replaced with a single
comma. If the commas were accidentally used instead of periods for an
ellipsis (`...`), it should be replaced with the ellipsis.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_punctuation.avoid_double_periods"></a> `en_US_punctuation.avoid_double_periods` ([Definition file](./styles/en_US_punctuation/avoid_double_periods.yml))

A double period has no meaningful semantics in US English. If the period
was accidentally repeated, it should be replaced with a single period. If
the last period in an ellipsis was accidentally left off, it should be added.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_punctuation.avoid_heading_punctuation"></a> `en_US_punctuation.avoid_heading_punctuation` ([Definition file](./styles/en_US_punctuation/avoid_heading_punctuation.yml))

Avoid using punctuation in headings. Headings aren't sentences, they're
landmarks for navigation and intradocument orientation.

```yaml
Level   : warning
Scope   : heading
Fixable : True
```

### <a id="en_US_punctuation.avoid_hyphenated_ly"></a> `en_US_punctuation.avoid_hyphenated_ly` ([Definition file](./styles/en_US_punctuation/avoid_hyphenated_ly.yml))

Don't hyphenate compound words that precede and modify a noun as a unit.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_punctuation.avoid_periods_in_acronyms"></a> `en_US_punctuation.avoid_periods_in_acronyms` ([Definition file](./styles/en_US_punctuation/avoid_periods_in_acronyms.yml))

Don't use periods with acronyms or initialisms. They aren't necessary.
Screen readers read letters in fully uppercased words individually.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_punctuation.avoid_semicolons_in_sentences"></a> `en_US_punctuation.avoid_semicolons_in_sentences` ([Definition file](./styles/en_US_punctuation/avoid_semicolons_in_sentences.yml))

Sentences that contain semicolons are often complex. Try to simplify the
sentence to eliminate the semicolon. Consider breaking the sentence into
multiple sentences or a list.

```yaml
Level   : suggestion
Scope   : sentence
Fixable : False
```

### <a id="en_US_punctuation.avoid_spaces_around_em_dashes"></a> `en_US_punctuation.avoid_spaces_around_em_dashes` ([Definition file](./styles/en_US_punctuation/avoid_spaces_around_em_dashes.yml))

Use an em dash (`---`) to set off a parenthetical phrase with more emphasis
than parentheses provide. In US English, you don't use spaces before or
after the em dash.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_punctuation.avoid_spaces_before_commas"></a> `en_US_punctuation.avoid_spaces_before_commas` ([Definition file](./styles/en_US_punctuation/avoid_spaces_before_commas.yml))

A comma should follow the immediately preceding word or construct in a
sentence. Spaces between words and commas, like `one , two` are invalid.
Spaces between enclosing punctuation, like `(truly) , and so on` are also
invalid.

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_punctuation.use_lowercase_after_colon"></a> `en_US_punctuation.use_lowercase_after_colon` ([Definition file](./styles/en_US_punctuation/use_lowercase_after_colon.yml))

<!-- vale en_US_grammar.use_that_or_which_for_clauses["clause that continues"] = NO -->

A colon in a sentence indicates the start of a clause that continues the
same sentence. The clause should follow normal sentence casing, not start
a new sentence with the first word capitalized.

<!-- vale en_US_grammar.use_that_or_which_for_clauses["clause that continues"] = YES -->

This rule can trigger false positives for proper nouns. You can either add
a linting exception around the text, like:

```markdown
<!-- vale en_US_punctuation.use_lowercase_after_colon["example: Hi"] = NO -->

For example: Hi world!

<!-- vale en_US_punctuation.use_lowercase_after_colon["example: Hi"] = YES -->
```

Or ensure that the word is in the `accept.txt` file for a vocabulary. When
the word is the correctly cased form of a vocabulary term, this rule doesn't
flag the text.

```yaml
Level   : warning
Scope   : sentence
Fixable : True
```

### <a id="en_US_punctuation.use_one_space_after_sentence"></a> `en_US_punctuation.use_one_space_after_sentence` ([Definition file](./styles/en_US_punctuation/use_one_space_after_sentence.yml))

<!-- vale en_US_grammar.use_that_or_which_for_clauses["convention that is"] = NO -->

The use of an em space or two spaces after a sentence is a historical
convention that is no longer required or recommended. Instead, separate
sentences with a single space after the ending punctuation and before the
first word of the new sentence.

<!-- vale en_US_grammar.use_that_or_which_for_clauses["convention that is"] = YES -->

```yaml
Level   : error
Scope   : text
Fixable : True
```

### <a id="en_US_punctuation.use_oxford_comma"></a> `en_US_punctuation.use_oxford_comma` ([Definition file](./styles/en_US_punctuation/use_oxford_comma.yml))

The Oxford comma, also known as the serial comma, helps to provide clarity
for a list of three or more items. Use the Oxford comma for clarity and to
make the prose easier to understand for readers who aren't native English
speakers.

For example, consider the following sentence with an Oxford comma:

```markdown
I love my friends, my dog, and big oak trees.
```

Here the author is saying that they love three distinct entities:

- Their friends
- Their dog
- Big oak trees

Without the Oxford comma, the meaning of the sentence changes, especially
for readers who aren't necessarily native English speakers:

```markdown
I love my friends, my dog and big oak trees.
```

Without the comma, the sentence now implies that the authors friends _are_
their dog and big oak trees.

```yaml
Level   : warning
Scope   : sentence
Fixable : True
```

### <a id="en_US_punctuation.use_punctuation_inside_quotes"></a> `en_US_punctuation.use_punctuation_inside_quotes` ([Definition file](./styles/en_US_punctuation/use_punctuation_inside_quotes.yml))

In general, sentence-ending punctuation should be inside the quotation marks.

```yaml
Level   : error
Scope   : text
Fixable : True
```
