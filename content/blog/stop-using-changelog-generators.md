---
author: Mikey Lombardi
title: 'Stop using changelog generators'
date: 2025-09-23
draft: false
description: >-
  Changelog generators are bad and you should stop using them. I'm begging you,
  stop using changelog generators.
tags:
- git
- workflow
- open source
---

<!-- vale en_US_punctuation.avoid_heading_punctuation["?"] = NO -->

I promised in my last post, [_On git practices_][aa], that I would address my heterodoxy on
changelog generators. I fully recognize that the vast majority of developers who think about
changelog generators at all are on the other side of this issue. To that I say:

They're wrong. All of them. Fundamentally, utterly, conclusively, devastatingly wrong.

Changelog generators are lies made into software and presented as enhancements to the developer
experience. The tools are lies and they generate abominations. They are a disservice to every
segment of a project.

I'm going to explain, carefully and clearly, why I reject these horrific tools and show you how
they're lying to you. Then I'll talk about what you should do instead.

> I know this post is inflammatory. I'm indicting thousands of developers and dozens of tools and
> disparaging a lot of hard work (I mean developing these tools, though also onboarding them in many
> cases) innumerable people have invested.
>
> I think we deserve better. I think you deserve better if you're a developer. I know you deserve
> better as a user and integrating developer and systems engineer. I want you to demand better for
> yourself, if not the people who use your tools.
>
> If you want to yell at me, I get it. I can take it.
>
> If you'd like to reach out to have a conversation or report a goof I've made in this post,
> _please_ see footnote [^0].

## The fundamental lie

Functionally, every changelog generator purports to save you time, attention, and effort by enabling
you to write your changelogs as a normal component of the change documentation you already write.
Usually, this means reusing either or both your commit messages and change request (PR, MR, etc)
titles and bodies.

And thus we get, immediately, to the first lie. A lie fundamental to the tooling that would
disqualify it even if the other lies were true.

Commit messages and change requests are _not user facing documentation_. A
[commit message is maintainer facing documentation][ab]. So are change requests.

Changelogs are _primarily_ for people outside of your project. Changelogs are for end users, for
integrating developers, for developers using your library, for sysadmins whose tools depend on your
software, and so on.

<!-- vale en_US_style.avoid_passive_voice["is recorded"] = NO -->

Yes, your maintainers and collaborators probably should and do read your changelogs, but they're
_not_ the primary audience. Instead, the documentation you write for them about your changes
is recorded in... commit messages and change requests.

<!-- vale en_US_style.avoid_passive_voice["is recorded"] = YES -->

Changelog generators tell you that you can simultaneously write to completely different audiences
without any loss of efficacy in that communication. This is, simply, a lie. A good commit message
is not a good changelog entry. A good changelog entry is not a good commit message.

A changelog entry conveys to users and integrating developers:

- What you changed _functionally_.

  The reader doesn't care about the details of the change. They care about how this release differs
  from the previous release.
- How that change affects _the reader_.

  Does the change require the reader to take any actions? Does it have any implications for specific
  edge cases? Does it provide the reader with new options? Does it make things easier, safer, or
  more performant?

Which is to say, your changelog entry contextualizes changes to your software for specific
audiences. When you're writing a changelog entry, you're writing a note to your users and
integrating developers, not the maintainers of your project.

_You cannot effectively write concise communicative prose to completely different audiences with
entirely differing concerns and contexts_.

You might think you can, but you're wrong.

So, while personally, I think this fundamental lie is the only nail we need for the coffin, I'm
going to continue to the other lies, because they're _also_ important.

## The lie changelog generators sell you

Changelog generators almost always make you a promise: you can have a good changelog with less
effort than manually writing each entry.

Below is a sample of different generators explicitly selling you a version of this lie:

<!-- vale en_US_punctuation.avoid_spaces_around_em_dashes = NO -->

- [github-changelog-generator][ac]

  > Fully automated changelog generation - This gem generates a changelog file based on tags, issues
  > and merged pull requests (and splits them into separate lists according to labels) from
  > :octocat: GitHub.
  >
  > Since you don't have to fill your CHANGELOG.md manually now: just run the script, relax and
  > take a cup of ☕ before your next release! 🎉

<!-- vale en_US_punctuation.avoid_spaces_around_em_dashes = YES -->

- [chronicle][ad]

  > A fast changelog generator that sources changes from GitHub PRs and issues, organized by labels.

- [10up/changelog-generator][ae]

  > A simple tool to automate changelog generation during release process.

The other, increasingly common version of this lie is to _elide_ the promise and make it implicit,
assuming you're following a coherent model for authoring your commit messages:

- [git-cliff][af]

  > git-cliff can generate changelog files from the Git history by utilizing conventional commits as
  > well as regex-powered custom parsers.

- [Conventional Changelog][ag]

  > Generate a CHANGELOG from git metadata.

- [git-changelog][ah]

  > Automatic Changelog generator using Jinja2 templates. From git logs to change logs.

- [whatchanged][ai]

  > An elegant changelog generator. follow the Conventional Commits Specification to generate a
  > beautiful and neat change log.

In the following subsections, I'll address the ways in which these tools _aren't actually saving you
work_. But first, we need to talk about the work you _need to do_ to manually write a changelog
entry.

### Work to write a changelog entry manually

To judge whether or not these tools actually save you any work, we need to know what they're
supposed to simplify. The following list enumerates the general steps for writing a changelog entry
for a change to your project.

1.  Identify whether the change affects users at all.

    Changes to your project only get an entry in your changelog if they affect non-maintainers. For
    example, updating your unit test suite without modifying any actual library code doesn't affect
    non-maintainers. It shouldn't get a changelog entry. Refactoring your code probably doesn't need
    an entry either.

    On the other hand, fixing a bug, adding a new feature, renaming a public function in your
    library---all of these _do_ affect your users and integrating developers. They need a changelog
    entry.

1.  Categorize the change.

    At a minimum, changelog readers expect to be able to distinguish between breaking changes,
    improvements, and bug fixes.

    The most popular changelog format, [keep a changelog (KAC)][aj], groups changelog entries into
    `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, and `Security`.

    Similarly, [Common changelog][ak] groups changelog entries into `Changed`, `Added`, `Removed`,
    and `Fixed`.

    In any case, you need to know how your change affects your users to effectively put it in the
    right grouping in your changelog. Doing so requires you to review the change and consider its
    impact. You might even want to categorize your change within a matrix of concerns, like:

    Kind
    : Analogous to the general categorization above. Is it a fix, improvement, breaking change, or
      something else?

    Impact and priority
    : How important is it to communicate this change? You should ensure, when you can, that your
      changelog lists changes from most to least impactful  and important.

    Audience
    : If your project has multiple audiences, like CLI users and library users, you might want to
      segregate those changes or highlight them differently for those audiences.

    Domain
    : What part of your project does this affect? You might want to categorize changes into groups
      like performance, security, accessibility, and so on. This can make it easier for a reader to
      find changes they care about.

1.  Summarize the change.

    Changelog readers need to be able to scan your changelog to find entries relevant to them and
    quickly understand, at a high level, how it affects them. You need to write about the change
    for your users and integrating developers.

    For example:

    <!-- vale en_US_style.avoid_passive_voice["be surprised"] = NO -->
    - If you fixed a bug, you need to clarify what behavior _was_ broken in the last release and
      _is_ working in this release.
    - If you added a feature, you need to tell the reader what you added and give them information
      to help them decide whether to use it.
    - If you deprecated a feature, you need to alert readers so that they won't be surprised when it
      gets removed in the future.
    - If you removed a feature, you need to very clearly tell the reader what you removed and point
      them at any steps they need to take to keep their usage functional.
    - If you addressed a security vulnerability, you need to highlight the vulnerability and explain
      how you've secured your project.

    <!-- vale en_US_style.avoid_passive_voice["be surprised"] = YES -->

1.  Provide extended details.

    This is an optional but recommended step, especially for changes that have more impact and for
    new features. Some changes can be summarized and readers won't get much value from additional
    details, like fixing typos or increasing timeouts.

    On the other hand, when you add features, it's generally very helpful to explain in more detail
    how the reader benefits. Even better, you provide some more details and then link to extended
    documentation. If you have a tutorial for using a new feature, you should _absolutely_ link to
    it.

1.  Identify and highlight contributors for the change.

    This is an optional but recommended step. If you're working in open source, it's good practice
    to highlight contributions. So you need to review the change and find out, minimally, who
    implemented it. You might also want to highlight the reviewers and other contributors.

1.  Identify and link to related work items.

    This is an optional but recommended step. You need to find and link to any issues, tickets,
    and change requests related to the change. This can help your most technically savvy readers
    to gain more context on the change. It's _not_ a replacement for writing extended details about
    the change. Most of your readers are _never_ going to dive through GitHub issues, Jira tickets,
    or pull requests to review a change.

    On the statistical improbability that your project is using
    [Architecture Decision Records (ADRs)][al], or writing formal specifications for features, you
    should treat those as related work items and link to them too.

Things you _don't_ need to do for your changelog entry, in no particular order[^1]:

- Add an emoji prefix or suffix.
- Link to every commit that was part of the change.
- Make jokes or cute references.

Okay, so if those are the things you need to do to write a useful changelog entry---categorize the
change, summarize the change, provide extended details, highlight contributors, and highlight
related work items---then we can now review whether these changelog generators actually save you any
work.

### Do changelog generators save you from categorizing changes?

No. Of course they fucking don't.

<!-- vale en_US_grammar.use_that_or_which_for_clauses["tool that relies"] = NO -->

If you're using a tool like [github-changelog-generator][ac] or any other tool that relies on
your change requests, you _still_ have to categorize your change. Usually, this means giving your
change requests specific labels that have attached semantics for your changelog, like:

<!-- vale en_US_grammar.use_that_or_which_for_clauses["tool that relies"] = YES -->

- Considering any change request labeled `bugfix` as a `Fixed` category change entry.
- Skipping any change request labeled `maintenance` or `refactor`.
- Ensuring you add the `backwards-incompatible` label for any breaking changes.

Similarly, for tools like [git-cliff][af], which rely on your commit conventions---in general, these
tools work best when you're writing [conventional commits][am]---you're _still_ doing the work of
categorization, but on every commit.

Tools that work on issues, and I'm sure I've seen at least one of these out there, also rely on
labels or carefully parsing the text.

In every case, you haven't _saved any work_, you've just _moved it around_.

> But mikey, it's easier to add labels to a PR or follow a commit standard!

What the fuck are you talking about, strawman? What are you saying to me? That categorizing a change
is _easier when you're still looking at and thinking about the change_? No shit. That's also a good
time to... write the actual changelog entry for that change.

### Do changelog generators save you from summarizing changes?

Surprisingly, no, no they don't. These tools almost universally extract the summary of the change
from whatever they're inspecting---change request titles, commit headers, issue bodies, whatever.
You're still on the hook for writing a coherent summary.

<!-- vale en_US_grammar.use_that_or_which_for_clauses["drawback that is"] = NO -->

I'll address this in more detail later, but I also want to point out that these tools _also_ tend
to have a drawback that is very obvious when you think about it for five calendar seconds:

<!-- vale en_US_grammar.use_that_or_which_for_clauses["drawback that is"] = YES -->

You only get one changelog entry for each item the changelog generator inspects. For change
requests, you get one entry per PR or MR. For commits, you get one entry per commit. If you'd like
to skip ahead to me yelling about this, see
[_The lie changelog generators hope you won't notice_][an].

### Do changelog generators save you from providing details?

You guessed it: no they don't. Worse, they frequently _prevent_ you from providing these details.

Tools that inspect change requests generally reuse the change request title. You get _whatever_
you titled the change request, and that's it. Unfortunately, that makes adding details functionally
impossible with these tools.

If you're lucky, the tool _might_ consume the body of the PR for
details. But then you have to be very intentional about your PR bodies, crafting your templates and
fixing any goofs from contributors so you can actually generate a changelog.

Similarly, changelog generators that work from commits typically only take the header. They _might_
parse the commit body.

But, again, even if your tool _does_ allow you to provide details, you... still have to write them
yourself. You're _categorically not saving any effort here_.

### Do changelog generators save you from highlighting contributors?

Finally, a question I can answer at least partially affirmatively: yes, sometimes, they do. Wow!

<!-- vale en_US_grammar.use_that_or_which_for_clauses["generator that operates"] = NO -->

Pretty much every changelog generator that operates on change requests _at least_ manages to
identify the user who submitted the change request. That's good. It's helpful.

<!-- vale en_US_grammar.use_that_or_which_for_clauses["generator that operates"] = YES -->

Most changelog generators that operate on commits can associate the commit author with the change.

Many of these tools support templated output. They might not _default_ to highlighting contributors,
but their data model generally supports it and people frequently configure the tools to do this.

We have found the first part of writing a good changelog entry that these tools can _actually_ save
you time and effort on. Is it a little silly that it's _also_ one of the least intensive components
of a changelog entry for you to manually add? Sure. But it's still a win for these tools[^2].

### Do changelog generators save you from highlighting work items?

Hell yeah, another win for changelog generators: generally speaking, yes, they do. At the very
least, they _can_.

<!-- vale en_US_grammar.use_that_or_which_for_clauses["request that generated"] = NO -->
<!-- vale en_US_style.avoid_passive_voice["is associated"] = NO -->

Tools that work from change requests almost always support associating a changelog entry with the
change request that generated it. I assume tools that build on issues do the same. Tools that work
from commits can at least associate the change with the commit. Generally, they also support
extracting other information. Some of the tools can even check which PRs and issues a commit
is associated with in your git repository (like GitHub).

<!-- vale en_US_grammar.use_that_or_which_for_clauses["request that generated"] = YES -->
<!-- vale en_US_style.avoid_passive_voice["is associated"] = YES -->

<!-- vale en_US_grammar.use_that_or_which_for_clauses["automation that saves"] = NO -->

This is probably where the tools are strongest. Again, this is also one of the steps in writing
a changelog that _isn't very difficult_, but it _is_ automation that saves you more than literally
zero time and effort.

<!-- vale en_US_grammar.use_that_or_which_for_clauses["automation that saves"] = YES -->

Again, it's worth pointing out that the tools may not even do this by default. You probably have to
configure them or provide templating to get the changelog generator to do this for you. So there's
probably _some_ work involved, but you can frontload it. Still useful.

### How much work do changelog generators save?

Very little. Really, they only save you from the work of highlighting contributors and work items.
They _require_ you to categorize, summarize, and provide details for each changelog entry. They
move the work around and generally enforce very specific standards for whatever work item they
use to generate your changelog.

> Mikey, you fool, you rube, you malicious hobgoblin, you've deliberately avoided mentioning the
> main drawback to manually updating a changelog: dealing with merge conflicts.
>
> You must agree that changelog generators obviate this very common, very painful problem and,
> therefore, _do_ save substantial work!

Yes. But they do it wrong, and I'll get to this later. If you want to skip ahead, see
[_The biggest drawback to manually maintaining a changelog_][ao]

## The lie changelog generators imply

Here is a merely implicit lie for changelog generators as a class of tool:

You can't effectively automate releases with a manually maintained changelog.

This is, trivially, factually, incorrect. In fact, the effort to automate releases with a manually
maintained changelog _is precisely the same_ as for a generated changelog.

Whether you're using a changelog generator or manually writing a changelog, you need to ensure your
source of truth is correctly defined and formatted and so on before you release your project:

- For tools that work from change requests and issues, this means reviewing and possibly adjusting
  titles and labels for your change requests and issues.
- For tools that work from commits, this means you have to ensure high levels of discipline and
  conformance to the structure and format of the commits during every change request review. You
  won't get to fix them after the fact[^3].
- For manually maintained changelogs, you need to review and update the changelog before you can
  start your release process.

Again, all these tools do, generally, is _move the work around_. Instead of needing to review and
update the changelog as a source of truth, you need to adjust the rest of your workflow. You
haven't _saved_ much work, if any. Nor is it particularly more difficult to release your project
with a manually maintained changelog than a generated one.

In fact, I think this can _add to your work_ if you're not careful. With a manually maintained
changelog, you can review the changelog for your next release at any point after you've added
your entries. With a generated changelog, you need to _generate the changelog_ and _then_ review
it. If your changelog has problems, you need to fix those before release. For tools that generate
from commits, you might have to manually adjust the generated changelog in the middle of your
release prep. I'm not sure how this is _better_ than manually writing the changelog entries, but
many otherwise intelligent people insist that changelog generators are better.

> But Mikey, changelog generators can tell me what the next semantic version of my project should
> be! They analyze the work items to determine whether I need to do a major, minor, or patch
> release!

Wow! You can figure the same thing out by checking your manually maintained changelog and applying
the exact same heuristic these tools do:

1.  Does this release contain any changelog entries for a backwards-incompatible or breaking change?
    If so, the next release should increment the project's major version. For example, if the
    current version is `3.1.2` the next version should be `4.0.0`.
1.  If this release doesn't contain any backwards-incompatible or breaking changes, does it contain
    any improvements or features? That is, does it contain anything other than bug fixes? If so, the
    next release should increment the project's minor version. For example, if the current version
    is `3.1.2`, the next version should be `3.2.0`.
1.  If this release doesn't contain any backwards-incompatible or breaking changes and doesn't
    contain any improvements or features, the next release should increment the project's patch
    version. For example, if the current version is `3.1.2`, the next version should be `3.1.3`.

Here, I'll give you a matrix you can use to figure this out:

| Current version | Has breaking changes | Has features or improvements | Has fixes | Next version |
|:---------------:|:--------------------:|:----------------------------:|:---------:|:------------:|
|     `3.1.2`     |         Yes          |             Yes              |    Yes    |   `4.0.0`    |
|     `3.1.2`     |         Yes          |             Yes              |    No     |   `4.0.0`    |
|     `3.1.2`     |         Yes          |              No              |    Yes    |   `4.0.0`    |
|     `3.1.2`     |         Yes          |              No              |    No     |   `4.0.0`    |
|     `3.1.2`     |          No          |             Yes              |    Yes    |   `3.2.0`    |
|     `3.1.2`     |          No          |             Yes              |    No     |   `3.2.0`    |
|     `3.1.2`     |          No          |              No              |    Yes    |   `3.1.3`    |
|     `3.1.2`     |          No          |              No              |    No     |      -       |

Now you can scan your changelog for breaking changes, improvements, and fixes to figure out whether
you need to increment the major, minor, or patch version of your project in the next release. That
should take you a minute or two. This hardly seems like a real win for automation, especially since
you _could_ take a couple minutes to script this check if you **really** don't want to do it
manually.

## The lie changelog generators hope you won't notice

I think the documentation for nearly every single changelog generator I've ever reviewed has, at
some point, mentioned how flexible the tool is. Most of them support templating, advanced
functionality, custom parsing, and so on.

<!-- vale en_US_grammar.use_that_or_which_for_clauses["designs that makes"] = NO -->
<!-- vale en_US_style.avoid_passive_voice["are designed"] = NO -->

But there's a flaw in these designs that makes them deeply inflexible in one very important way.
Changelog generator tools can only work from the data they are designed to parse. Because the
entire selling point of these tools is to reduce the work you need to do to write a changelog,
they generally do this by reusing existing work items---change requests, issues, and commit
messages.

<!-- vale en_US_grammar.use_that_or_which_for_clauses["designs that makes"] = YES -->
<!-- vale en_US_style.avoid_passive_voice["are designed"] = YES -->

I alluded to this problem earlier, but this generally means you get a one-to-one mapping for
changelog entries and work items. Why is this a problem? Because maintaining projects is messy
and, for open source projects, frequently means contributions from people who aren't on your
team. They probably won't be benefiting from the onboarding you do for new maintainers. Many of
them won't carefully read your contributing guides, assuming you have written a coherent one.

Even for your maintainers, these tools can require them to munge their workflow or for the team to
accept subpar changelogs.

I'll illustrate this with a few examples:

1.  In this example, someone is contributing a new feature to a project. The project uses a
    changelog generator that relies on change requests. As the contributor is working on this new
    feature, they discover a previously unreported bug. If they didn't have to consider the
    changelog generator, they could just quickly fix the bug, commit that change, and keep going.

    But, because the changelog generator is only going to give them one changelog entry for this
    change request, the contributor now has to choose from the following (nonexhaustive) options:

    - If they want to fix the bug in this change request, they need to decide whether to put the
      bugfix in the change request title, like:

      ```commit
      (JIRA-123) Add retry mechanism and fix URI parsing
      ```

      Or to leave it off. If they put it in the title, readers now get an awkward changelog entry
      that is for a new feature (the retry mechanism) and an apparently unrelated bug fix.

    - If they want to fix the bug but keep a coherent changelog entry for their feature, the
      contributor needs to switch contexts, fix the bug in a different branch, and submit just the
      fix in its own change request. Then they can return to this work. If the feature actually
      depends on the fix, they'll need to arrange for the fix to be merged before this PR. If the
      maintainers care about their git history, this will probably require some amount of rebasing
      for the contributor.

      That's a relatively high bar for someone who isn't on the maintainer team.

    - If the feature _doesn't_ depend on the bugfix, the contributor could also just file a
      detailed bug report for the project. Then, they can continue with the feature and maybe
      someone else will pick up the bugfix. This still requires the contributor to briefly switch
      contexts, but it's not nearly so high a bar as breaking out a separate change request and
      managing rebasing.

    Whatever the contributor chooses, the limitations of the changelog tool pushed the choice on
    them. Worse, in my experience, this friction often means that contributors will just _drop_ this
    additional contribution. Especially if your team pushes them to split out their change request
    or drops a blocking review because of the multiple changes.

    Note that this scenario applies _any time_ a change request contains more than one change that
    should have a changelog entry. It's just _worse_ when the categories of change aren't identical.

1.  In this example, someone is contributing a bug fix to a project. The project uses a changelog
    generator that relies on contributions following the
    [conventional commits][am] standard.

    The contributor is relatively inexperienced with git and new to the project. They take a couple
    of commits to get the fix correctly passing tests. During review, a maintainer asks them to add
    a new regression test. The contributor adds the test in a new commit. Now, everything is
    passing... but the maintainers need this change to follow the conventional commits
    specification.

    Here, the maintainers have a choice. They can ask the contributor to rework their commits into a
    single commit following the convention (or two commits, one for the bug and one for the
    regression test). They could also offer to adopt the change request and fix the commits
    themselves.

    In either case, for the sake of a useful changelog, _someone_ needs to fix these commits. I
    find this personally less onerous than the splitting-a-change-request problem, but it's still
    not very fun for contributors.

    Worse, if these commits are accidentally merged by a maintainer who isn't paying close enough
    attention, you might need to do some complicated magic to: revert the change, correctly define
    the commits for your changelog, and resubmit without losing the contributor's attachment to
    the work. Or you could live with the goofed up changelog. Either way, gross.

The fix for this category of problem, where a contribution doesn't perfectly match the assumptions
your changelog generator relies on, almost always requires additional labor for the contributor
and the maintainers. The maintainers _must_ notice the problem and raise it. If they're very,
_very_ lucky, the contributor will do the work to resolve the problem. More likely, the maintainer
will need to do at least _some_ of the work[^4].

Sooner or later, this problem _will_ show up in your project when you use a changelog generator and
get contributions from outside your maintainer team.

## The biggest drawback to manually maintaining a changelog

As I alluded to earlier, there _is_ one truly horrendous problem that manual changelogs frequently
encounter. The dreaded merge conflict for changelog entries.

For those unfamiliar, here's a summary of the problem and how it arises:

<!-- vale en_US_style.avoid_passive_voice["be merged"] = NO -->

1.  You start work on a change. Your change requires a changelog entry, so you do the work. You
    categorize your change, summarize it, provide details, highlight contributors and work items.
1.  Someone else submits a change request that also requires a changelog entry. Their change gets
    approved and merged first, for whatever reason.
1.  Now your change can't just be merged. Both change requests modify the changelog and those
    modifications have raised a [merge conflict][ap]. To get your changes merged,
    you need to resolve the merge conflict.

<!-- vale en_US_style.avoid_passive_voice["be merged"] = YES -->

For me, personally, this isn't much of a problem anymore. I've broken my fingers and brains on
enough merge conflicts that I'm comfortable working through them. However, this _is_ a major problem
for a lot of open source contributors.

To deal with this, generally, you either need to educate and help the contributor resolve the merge
conflict[^5] or someone on your team needs to adopt the change request and resolve the conflict for
them.

Proponents of changelog generators _frequently_ bring this up to me as an argument for these tools.
I'm more inclined to point out that this isn't a feature of the tools but a drawback of the way
[KAC][aj] conditioned people to keep an unreleased section in their project changelog.

I'm also not very concerned about this drawback for projects I work on. I've helped more than a
dozen contributors across various projects resolve merge conflicts like this, and I've adopted
more change requests than I can remember to resolve it _for_ the contributors.

<!-- vale en_US_style.avoid_passive_voice["are frustrated"] = NO -->

But I get it, people are frustrated and (or?) terrified of this, so they want to avoid it. They
see these tools as a solution.

<!-- vale en_US_style.avoid_passive_voice["are frustrated"] = YES -->

## Summarizing the problems with changelog generators

Here I should take a moment to clarify my problems with changelog generators (somewhat) more
succinctly. The following list enumerates those problems in order of importance to me:

1.  Changelog generators are bad tools because they fundamentally conflate _maintainer-facing_
    documentation---like git commits, issues, and change requests---with user-facing documentation.
    Changelogs are for users and integrating developers, not (just) your project maintainers.

    The tools are bad because they rest on incorrect design. You can't code your way out of this
    problem.
1.  Changelog generators don't save you any of the hardest and most important work for writing
    changelog entries. You still have to categorize and summarize your changes. The tooling _might_
    support providing details. It _probably_ supports highlighting contributors and work items,
    but just as probably that requires you to do the work to configure the tooling.
1.  Changelog generators are flexible, except when it comes to matching changelog entries to
    whatever work item they parse. You can't really, as far as I know, get around this limitation
    with the tools except by brute force and manual intervention. Worse, trying to conform to these
    tools can introduce friction for your contributors.
1.  Changelog generators don't actually make it easier to release your project. Again, they just
    move the work around. Whether you validate your changelog manually as entries get added during
    development or after you generate it, you _still_ have to ensure your changelog is coherent
    before release. Or, I guess, you could just not care and smash release anyway. But at that
    point, why even go through the exercise of pretending to care about your changelog and, by
    brutal application of the commutative property, your users?
1.  Changelog generators _do_ fix the apparent problem of merge conflicts for the unreleased section
    of your changelog, but by no means is this a winning tradeoff. You can address that drawback in
    other, more coherent ways that don't make the fundamental mistake of conflating maintainers and
    users.

With those problems clarified[^6], it's finally time to mention alternatives.

## Alternatives to changelog generators

<!-- vale en_US_style.avoid_passive_voice["being said"] = NO -->

With all of this being said, it's only fair that I point out that, as bad as changelog generators
are, I do think there are coherent options you can use.

<!-- vale en_US_style.avoid_passive_voice["being said"] = YES -->

The first and most obvious is to... just manually maintain a changelog. Pick a changelog format
you like and iteratively write entries for it as needed. Maybe you can even incorporate this into
your review process for change requests. You, the maintainer reviewing a change, could either ask
the contributor to do the work or take it on yourself. I've done this for several projects.

The next option is to use a tool that _doesn't_ make the fundamental category error of these
changelog generators. The only tools I'm currently aware of in this category are:

- [antsibull-changelog][aq]

  <!-- vale en_US_style.avoid_passive_voice["was designed"] = NO -->
  <!-- vale en_US_grammar.use_that_or_which_for_clauses["file that keeps"] = NO -->

  While you can use `antsibull-changelog` for [any arbitrary project][ar], it was designed for
  Ansible collections. The tool requires you to author [_changelog fragments_][as] as YAML files in
  the `$PROJECT_ROOT/changelogs/fragments` folder. The tooling supports pulling the fragments
  together into a YAML file that keeps changelog entries in data. It also generates a readable
  rendered form for your changelog, either as `ReStructuredText` or `Markdown`.

  <!-- vale en_US_grammar.use_that_or_which_for_clauses["file that keeps"] = YES -->
  <!-- vale en_US_style.avoid_passive_voice["was designed"] = YES -->

  The main drawback for this approach is that you're _adapting_ a tool designed for a very specific
  workflow and purpose (documenting changes to Ansible projects) and have to sort through the docs
  for your own needs. This isn't a _problem_, but something to keep in mind.

  I _love_ that this tool allows you to keep your changelog as data. In a future post, I'll write
  about how and why I came to believe that the canonical resting format for reference
  documentation---which changelogs _are_---is data (assuming the docs don't live exclusively in
  code, like annotating library functions).

  <!-- vale en_US_style.avoid_passive_voice["was designed"] = NO -->

  A secondary drawback for me is that I don't _love_ the data model, but then I also don't refute
  the efficacy and ergonomics of this tool for the purpose it was designed to fit. I'm glad it
  functions outside of that purpose _at all_.

  <!-- vale en_US_style.avoid_passive_voice["was designed"] = YES -->

- [changie][at]

  The `changie` project also requires you to author YAML files to describe your changes. By default,
  `changie` expects you to define new changelog entries in the `.changes/unreleased` folder.
  `changie` has [commands][au] for:

  - Creating new changelog entries (`changie new`)
  - Creating a changelog from those entries (`changie batch`)
  - Checking changes between releases (`changie diff`)
  - Merging your changelog files to cover every release (`changie merge`)
  - Using your changelogs to check what the next version of your project should be (`changie next`)

  `changie` is somewhat more flexible than `antsibull-changelog`, built from the start to serve
  general projects. On the other hand, the documentation isn't... good. That makes it really hard
  for me, personally to adopt or recommend.

  There's a lot of small things that I really don't like about this project. Primarily I mark it as
  a worse option because it eventually treats the output document as a source of truth instead of
  keeping the data model.

  It does do a lot of things right, especially around templating, flexibility, and centering the
  need for a human to actually do the work. It doesn't pretend to save you from _doing_ that work.
  Instead, it aims to reduce the friction and improve the experience. It's an admirable tool, for
  all my reservations.

<!-- vale en_US_style.avoid_passive_voice["am fueled"] = NO -->

And, of course, someday, I'm hoping to publish my own very special and obviously perfect and correct
tool for writing and publishing changelogs. I don't know when I'll actually get to this, but I _can_
promise that I'll blog about it here when I do. If that's something you'd like to see me prioritize,
let me know. I am _fueled_ by attention and praise, and you can easily bribe me with it.

<!-- vale en_US_style.avoid_passive_voice["am fueled"] = YES -->

## Final thoughts

This post got way longer than I intended. I do feel like it's done, for now. I could write a section
about what I actually personally want from a changelog tool, but I'm going to save that for a future
post where I lay out my unassailable plans for developing that tool.

If you remember _nothing_ else from this post, I am earnestly begging you to remember this:

> Changelogs are reference documentation _for_ your **users and integrating developers** _about_ how
> your project has changed since the last release. Specifically, your changelog needs to tell this
> audience not only what you changed but how it impacts them. You need to tell them about:
>
> - Any actions they need to take to keep using your tool (if you made breaking changes)
> - What new features and improvements they can take advantage of (if you made improvements)
> - What bugs they might have been working around or not even noticed that you resolved (if you
>   fixed any issues)
>
> Unlike changelogs, your commit messages, issues, tickets, and change requests are for your
> **maintainers** to help them understand changes in the project.
>
> These audiences are _not_ the same. Both of them deserve coherently, intentionally crafted
> documentation to suit their context and needs. Don't do either of them the disservice of
> conflating changelogs and work items. Do the work. They deserve it, and so do you.

Until next time,

~ Mikey

<!-- footnotes -->
<!-- markdownlint-disable MD007 -->
[^0]: I'm always happy to have a conversation and receive feedback. Options include:

      - Start a thread or join an existing one in the [GitHub discussion for this post][00].
      - Report any goofs I've made, like typos or inaccuracies, [as a GitHub issue][01].

      And, if you do join the conversation or report a goof, know that I appreciate you.

[^1]: Holy god does this stuff irritate me. Emojis not only add noise to your changelog, they're
      also an accessibility irritant. Imagine trying to read a changelog with a screen reader only
      to have every single entry for a feature start with `hammer and wrench`. Yes, you can get
      around this with accessible HTML, but I bet your changelog generator isn't doing that. Also,
      it's unnecessary. I know these are features because you probably put them in an unordered list
      under the H3 section `Features` or `Added`.

      Nor do I want to see a series of portions of git SHAs that I'm supposed to make sense of.
      Again, this is also gobbledygook for anyone using a screen reader. Stop it.

      Finally, and I mean this sincerely, if you insert jokes into your changelog, it's entirely
      your fault if someone snaps and reshapes your skull with a brick. The two most common times
      someone is going to review your changelog are:

      1.  When they're excited about a new release and want to see what shiny beautiful things
          you've done for them.
      1.  When something you released broke their system and they absolutely need to get it fixed
          ASAP. If they have to parse out how you ruined their day while you make jokes, I know _I_
          wouldn't testify against them.

[^2]: Worth pointing out, however, that this assumes the change is perfectly captured in a single
      item. Consider the case where someone submits a new feature, which gets a changelog entry.
      Before release, someone else comes along and improves the implementation or fixes a bug in it.
      Now, it's time to release, and you need to put together your changelog.

      With changelog generators, you really have two options here, and you're making a compromise
      _somewhere_:

      <!-- vale en_US_style.avoid_passive_voice["is supposed"] = NO -->
      <!-- vale en_US_style.avoid_passive_voice["was added"] = NO -->

      1.  You can add an entry for both the initial implementation and the fix or improvement. This
          is, in my correct opinion, a misstep. Your changelog is supposed to tell users and
          integrating developers what has changed since your last release. What has _actually_
          changed is that you've added a new feature. Adding additional entries for modifying the
          feature _before_ release increases cognitive load for readers. It might even confuse them
          about whether the feature was added in this release.

      <!-- vale en_US_style.avoid_passive_voice["was added"] = YES -->
      <!-- vale en_US_style.avoid_passive_voice["is supposed"] = YES -->

      1.  You can just ignore the fix or improvement for your changelog. If you do this, though,
          you can't credit the contributor who fixed or improved the new feature. That sucks. It
          downplays their contribution. You probably don't want to do that, either.

      So yes, while you _can_ get information about contributors from the changelog generator
      without spending the extra effort yourself, _most of the time_, you're still not totally
      covered.

[^3]: Oops, another drawback to these tools. Changelog entries are _documentation_. It's very, very
      likely that you'll find good reasons to update them at some point. Maybe you need to fix a
      typo. Maybe someone contributed a new tutorial for a feature after release and you want to
      link to it so readers can find it.

      When your tooling generates changelogs from commits, you're limited in how you can update
      existing entries. Some of the tools will only generate _new_ entries. Some of the tools will
      override existing entries when you regenerate your changelog. I'm sure some tools let you
      selectively override prior entries or modify them. All of this complicates maintenance, not
      to mention the cognitive model you need to hold to leverage these tools.

[^4]: Ever since I worked at Puppet, I've spent a fair amount of my time in open source helping
      people navigate these sorts of problems. I used to pair program with contributors to help
      them write and run tests, show them how to craft commits from specific changes in their
      files, decompose commits, and so on.

      <!-- vale en_US_grammar.use_that_or_which_for_clauses["position that educating"] = NO -->

      I really love doing this, but most of the engineers on my teams have generally found this
      labor to be frustrating, maybe even a distraction from their "real" work. I've always held
      the position that educating and helping contributors is both ethically something I need to
      do to live with myself but also pragmatically good for the project.

      <!-- vale en_US_grammar.use_that_or_which_for_clauses["position that educating"] = YES -->

      The more people who _can_ effectively contribute without my help, the more and better
      contributions we can get. Maybe they'll help someone else learn, too. God knows I've been
      indescribably lucky in the mentors who've helped me.

[^5]: I think I can count on one hand the number of contributors who weren't also open source
      maintainers that could get through resolving a merge conflict without some help. As I
      said in the previous footnote, I have done this a lot and I'm always happy to do so.

      But it _is_ a burden for maintainers and contributors alike. It's frustrating and if you
      don't already know what to do, it can make contributors give up and walk away. So while I
      _always_ ask if the contributor is comfortable resolving the conflict, I _also_ tell them:

      1.  If you'd like, I'm happy to hop on a call with you and pair up to resolve this. You can
          drive and I can help, or I can drive and you can ask me any questions. Whatever you're
          comfortable with.

      <!-- vale en_US_style.avoid_passive_voice["be done"] = NO -->

      1.  If you'd prefer, I'm perfectly willing to adopt this change request. I'll make sure to
          resolve the merge conflict and take care of any other issues if you'd rather be done.
          I'll make sure you get the credit for this work.

      <!-- vale en_US_style.avoid_passive_voice["be done"] = YES -->

      And seriously, I extend that same offer to you, dear reader: if you're struggling with any
      contributions you try to make, even if they're not to projects I maintain, I'm happy to
      pair with you or otherwise help get your work merged. Reach out to me and we'll get it done.

[^6]: Missing from the body of this post, perhaps conspicuously, is any mention of a completely
      different kind of changelog generator: the LLM-based generator. More and more of these are
      popping up now. I could probably rant and rave about this for another thousand words, but
      instead I'll just note a few things here.

      <!-- vale en_US.use_valid_spelling["pseudomagic"] = NO -->

      These tools are bad, maybe even _worse_ than the tools I've been railing against in this post.
      I cannot stress enough that changelogs are user-facing documentation. Above all, changelog
      entries must be _accurate_ in describing what they changed and how it impacts users. This is
      _not_ a place for a machine to hallucinate. Sure, you could be super careful during review,
      and _technically_, _maybe_ these tools could save you labor, but only if you fundamentally
      don't give a goddamn about your users. Communication is about choices. Every word you use in
      your writing is a choice. Changelogs are communicating specific information to a specific
      audience for a specific purpose. The machine is guessing, based on very advanced and powerful
      heuristics and other pseudomagic, how to describe those changes. Your users deserve better.

      <!-- vale en_US.use_valid_spelling["pseudomagic"] = YES -->

      You can write, I promise. After all, presumably, you write code if you care about a blog post
      on changelogs. You can write changelog entries. You've probably already been doing it, even if
      you thought your changelog generator was saving you from that work.

      If you _do_ decide to use an LLM to generate a rough draft of your changelog entries, please,
      _please_, _**please**_ make sure you review and edit that draft before publishing it for your
      users. Don't just spot check it. Carefully review every single entry. Make sure it didn't miss
      anything or misrepresent something. If you don't care to do this work, I would rather you just
      didn't keep a changelog. It would be more earnest, actually save you time and effort, and you
      won't be lying to people who are trusting you enough to run your software.

<!-- markdownlint-enable MD007 -->

<!-- Reference link definitions -->
[00]: https://github.com/michaeltlombardi/mikeywrites.fyi/discussions/18
[01]: https://github.com/michaeltlombardi/mikeywrites.fyi/issues/new?template=00-report-a-goof.yml&location=-%20%60content%2Fblog%2Fstop-using-changelog-generators.md%60
[ac]: https://github.com/github-changelog-generator/github-changelog-generator?tab=readme-ov-file#changelog-generation-has-never-been-so-easy
[ad]: https://github.com/anchore/chronicle
[ae]: https://github.com/10up/changelog-generator
[af]: https://git-cliff.org/docs/
[ag]: https://github.com/conventional-changelog/conventional-changelog
[ah]: https://github.com/pawamoy/git-changelog
[ai]: https://github.com/release-lab/whatchanged
[aj]: https://keepachangelog.com/en/1.1.0/
[ak]: https://common-changelog.org/
[al]: https://adr.github.io/
[am]: https://www.conventionalcommits.org/en/v1.0.0/
[ap]: https://docs.github.com/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/about-merge-conflicts
[aq]: https://ansible.readthedocs.io/projects/antsibull-changelog/
[ar]: https://ansible.readthedocs.io/projects/antsibull-changelog/other-projects/
[as]: https://docs.ansible.com/ansible/devel/community/development_process.html#changelogs-how-to
[at]: https://changie.dev
[au]: https://changie.dev/cli/changie/
[aa]: ./on-git-practices.md
[ab]: ./on-git-practices.md#write-commit-messages-as-maintainer-facing-documentation
[an]: #the-lie-changelog-generators-hope-you-wont-notice
[ao]: #the-biggest-drawback-to-manually-maintaining-a-changelog
