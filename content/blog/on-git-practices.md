---
author: Mikey Lombardi
title: On git practices
date: 2025-09-01
description: > 
  A set of proposed practices for making maintenance and collaboration easier
  when working with git repositories.
tags:
- git
- workflow
- open source
---

I've been working full time in open source for the better part of a decade. At this point, I've
developed some... heterodox positions.

I'm writing this post primarily so I can point to it instead of reiterating it over and over.

I think that the way teams and projects approach their git workflow frequently sucks and can be
improved with a few (relatively) small adjustments.

> Note on terms:
>
> In this post, I'm going to talk generally about `change requests` to mean pull requests (GitHub),
> merge requests (GitLab), and similar. I don't want to exclude users of any platform or imply that
> the guidance in this post is specific to any platform.
>
> Similarly, I'm going to refer to the canonical remote repository as `upstream` and the primary
> branch as `main` for simplicity.
>
> I'm not going to explain terms like `repository`, `branch`, `fork`, or `commit`. I'm assuming
> if you're reading this post, you're familiar with such terminology. If you're not, you can
> always reach out to me. If you need help understanding how to use git or get stuck on anything
> related to the guidance I'm writing here, I'm genuinely happy to help you.

If you're reaching out to yell at me, do that on twitter, where I'll probably ignore it because I
don't have the energy to fight online over this stuff as much as I used to. Otherwise, if you're
reaching out to have a conversation or report a goof I've made in this post, _please_ see footnote
[^0].

## Always work from a branch on a fork

When you're collaborating on a repository, it can be tempting to create working branches on the
upstream repository and work from those to merge back into main. Don't do this if you can help it.
It makes fetching the upstream very noisy and generally the upstream repository should be
considered the canonical source of truth. If you have admin rights and accidentally goof up a
branch on the upstream, you can badly break everyone until you fix things (if you can).

Always create a fork of the repository and work on branches in your fork that you submit back to
the upstream repository as a merge or pull request.

_Never_ work from the `main` branch, even on your fork. It makes things more confusing, makes
your work more prone to merge conflicts, and generally introduces a lot of pain you can simply
avoid by creating a working branch.

When you create a working branch for your changes, always ensure your branch is based on the
upstream `main` (unless doing something like backporting a fix to a long-term servicing branch).

The following snippet shows a generic example for creating a working branch from the upstream
`main` branch, where `<branch name>` is a placeholder for whatever you're calling your new working
branch:

```sh
git checkout main
git rebase upstream/main
git push -u origin main
git checkout -b <branch name>
```

## Name your branches coherently

There's an endless number of wrong opinions about how you should name your branches. The correct
opinion[^1] is to use the following syntax:

```Syntax
<work-item-id|maint|docs>/<target-branch>/<synopsis>
```

Where:

`work-item-id`
: Depends on whatever you use for tracking your work. It could be `gh-123` for an issue
  in GitHub, or `issue-123` or `epic-123` or `jira-123`. If your work is specifically related to a
  particular work item, make sure that the first segment of your branch name indicates which work
  item your branch is addressing. You can use your commit messages to reference other work items if
  you need to.

  > Aside:
  > The convention you use for the work item doesn't really matter, so long as it's consistent
  > and coherent for your working context.

`maint`
: Indicates a set of changes not specifically related to any existing work item. Use this
  when you're updating dependencies, fixing a build issue, refactoring, or similar. If you're
  working on a full feature or a user-affecting bug, you should probably define a work item and
  have your branch reference that.

`docs`
: Indicates changes only to your documentation, not affecting the code behavior or build.
  Personally, I think docs issues should generally be tracked as work items, so this shouldn't be
  used much, except to indicate small changes/fixes to docs that don't warrant a full writeup.

`target-branch`
: Indicates which branch on the upstream your changes are meant to be merged into.
  Generally, this will be `main`, but you might be backporting a fix or preparing a release branch.

`synopsis`
: Is a very short way to indicate what the changes are doing, like `refactor-type-names`
  or `add-config-tests` or `fix-export-function`. They're meant to quickly provide minimal context
  to collaborators. They don't replace writing good and useful commit messages or pull/merge
  request titles and bodies.

Consider the following examples:

`gh-11/main/add-retry-handling`
: Branch is for item `11` in Github, targets `main`, and adds handling for retries.

`issue-55/v1/backport-auth-fix`
: Branch is for issue `55`, targets the `v1` branch, and backports a fix for authentication.

`maint/main/release-prep-v1.1.0`
: Branch targets `main` to prepare for the `v1.1.0` release.

`maint/main/refactor-tests`
: Branch targets `main` and refactors tests for the project.

`docs/main/draft-getting-started`
: Branch targets `main` for adding draft documentation on getting started.

## Write generally atomic commits

Commits should be [atomic][01] - they should be as small a set of changes as makes sense to put into
a single commit - i.e. you should not fix a bug in the same commit that you correct linting or
change two unrelated implementation details at the same time.

This doesn't mean you try to play changeset golf, turning each commit into as small a changeset as
possible - the goal is to make it easier to review and understand each commit by ensuring that
whatever happens in that commit is related.

If you find yourself choosing between understandability and size, choose understandability.

## Write commit messages as maintainer-facing documentation

I'm going to say this three times so that it is as clear as possible:

> Commit messages are maintainer facing documentation.
>
> Commit messages are maintainer facing documentation.
>
> Commit messages are maintainer facing documentation.

Commit messages are written by contributors for the reviewers and future maintainers. For this
reason, you should write concise explanatory commit messages with each commit. Writing useful
messages takes very slightly longer than not writing them, but pays enormous dividends over time.

The rest of this section describes how you can write useful commit messages. If you're already
thinking about things like [conventional commits][02], I'm going to stop you right here: I don't
care. I have my own separate problems with trying to force commit messages (maintainer facing
documentation) to serve double duty for changelogs or release notes (user and integrating developer
documentation).

### Writing a useful commit heading

The first line in a commit message is its heading. You should write headings with the following
syntax:

```Syntax
(<work-item-id|maint|docs>) <synopsis>
```

This probably looks familiar, because it draws on the same conventions as the
[branch naming](#name-your-branches-coherently).

> But mikey, that's in the branch name, why should it be in the commit heading?

Because commits endure beyond their branches. The branch naming helps your current collaborators
and reviewers understand what the entire changeset is for. Commit headings tell your current _and
future_ collaborators and reviewers what **this commit is for.**

You will eventually find yourself working on a bug fix or feature implementation where you discover
some unrelated problem or enhancement that is too small to warrant filing an issue and extracting
your change into a separate pull or merge request. Instead, you can add a commit to your current
branch that clearly indicates what you're doing and why, then get back to the main body of your
work.

Commit headers are especially important because they show up as the synopsis for the commit in
most repository web UIs, editor UIs, and when you use `git log --oneline` in the terminal.

Consider the following examples of good commit headers:

`(DOCS) Fix typo in 'Usage' section of README`
: Clearly indicates that you're making a quick fix to a typo in the project `README`.

``(GH-123) Ensure `foo` is idempotent``
: Clearly indicates that this commit is adressing issue 123 in GitHub and that it's resolving a
  bug that made `foo` behave incorectly.

``(JIRA-123) Prep for `0.5.0` release``
: Clearly indicates that this commit is addressing issue 123 in Jira to prepare for releasing
  version `0.5.0` of the software.

Consider the following examples of bad commit headers:

`(MAINT) Fix typo`
: Where is this typo? I need to review the changeset to have any understanding. Is it a typo in
  a document, in the code? Does fixing this typo change behavior? I have no idea.

``(GH-123) idempotent `foo` ``.
: While this does refer to the work item and does address something around `foo` and idempotency,
  I have no idea what's happening without reviewing the changeset, the work item, or both.

`Prep for 0.5.0 release`
: This isn't terrible, but I have no idea whether this is part of a planned release or is just
  maintenance work or what.

### Writing a useful commit body

As important as the headers for immediate readability and context-signposting are, the body of the
commit is also critical because it tells reviewers and future maintainers the what and why of the
commit. The changeset itself shows the _how_, so you don't need to cover that in your commit body.

Explaining the what and why of a commit reduces the amount of hunting and context building required
to understand any given changeset to the repository and enables quicker, safer reviews.

> Since one of the common complaints I hear is that people don't want to waste time writing context
> for every commit, I'll point this out explicitly:
>
> Not **every** commit needs an expanded body message.
>
> For example, both the `(MAINT) Fix typo in 'Usage' section of README` as well as the
> `(GH-123) Prep for 0.5.0 release` commit headers are perfectly explanatory of what's going on in
> the commit. They sufficiently establish the context on their own.

If your repository host supports it, you can and should reference related work items (issues, pull
requests, merge requests, projects, discussions, and so on) in your commit body. The automatic
reference linking goes a long, long way towards making it easier to follow context for changes.

When you're authoring the body for a commit message, you should:

1. Set the context for _why_ you're making these changes.
1. Explain _what_ your changes do.

Consider using one of the following template for the body of your commit message:

- **Contextual paragraphs**

  This is how I used to do all of my commit messages. I wrote paragraphs of prose to define the
  context and my changes. I still think this is a good practice, especially for defining the
  context that lead to the PR and for cases where I'm making a single, easy to describe change.

  ```text
  Prior to this change, <context-for-why>
  
  This change <context for what>
  ```

  The following snippet shows an [example commit][03] I've written in this format:

  ```text
  (IAC-1045) Extricate base provider

  Prior to this commit the code for the base provider of the new
  puppetized DSC modules was vendored into each module; this
  meant that if the provider ever needs to be updated, every
  prior release of the puppetized module would need to be built
  again and pushed with an incremented number.

  Moving the base provider to the pwshlib Puppet module means
  that the provider can be updated separately from the PowerShell
  builder code and does not require rebuilding puppetized modules,
  only updating the reference pin for pwshlib.

  This also makes testing the provider easier as it lives in a
  ruby library now instead of in a PowerShell module.

  This commit completes the extrication on the builder side by
  removing the templated files and updating the provider definition
  to point at the new location.
  ```

- **Contextual lists**

  This is how I generally write my commit messages now, especially for complex changes. I find it
  easier to follow list items, personally, and the way GitHub references look in a list item feels
  cleaner in the UI than embedded in the middle of a sentence.

  ```text
  Prior to this change, <context-for-why>

  This change:

  - <first thing the change does>
  - <next thing the change does>
  ```

  The following snippet shows an [example commit][04] I've written in this format:

  ```text
  (GH-407) Support negative integers in manifest exitCodes

  Prior to this change, the JSON schema for the `exitCodes` property of
  resource manifests only supported positive integers as exit codes.

  DSC itself supports negative integers as exit codes, and some apps
  return negative integers as exit codes for hexadecimal exit codes,
  like `-2147024891` for `0x80070005`, "Access denied."

  This change:

  - Updates both the source and composed schemas to allow negative
    integers.
  - Updates the reference documentation to clarify that you must specify
    integers, that you can't use any alternate formats for those integers,
    and that the keys in YAML must be wrapped in quotes for parsing.
  - Addresses #407 by making the schema compliant with the implementation.
  ```

These templates are just suggestions. The important thing is that you capture relevant context
and reasoning for the changes and surface them to reviewers and future maintainers. It's so much
easier to work in a project where changes are described and given context in the commits when
compared to having to investigate history, cross-referencing with pull request comments, issues,
and the memory of any teammates who are still there.

> Quick note about rewriting commit messages:
>
> When I'm working on a change, I'll often rework the commits in my branch after review and
> prior to merge, adjusting the commits and  messages to match the final design. This reduces
> the amount of work I or other maintainers will need to do in the future. It's cheap to reword
> commit messages, less cheap to clean up the commits themselves. It's worth it, especially for
> complex or critical changes to the project.

## Scoping a change request

I said earlier in this post that commits should generally be atomic, containing as few related
changes as makes sense. In contrast, you should submit semi-atomic change requests. While you
_can_ require atomic commits and atomic change requests, I find this to be deeply impractical.

Sooner than later, you're going to find a bug or refactor that you didn't _plan_ to tackle in a
change request but makes sense contextually. Stopping your work to start a new working branch
for that subset of changes introduces enormous friction. For external contributors to your
project, that friction is an order of magnitude worse. If you reject change requests for being
non-atomic, you'll have to reject (or someone on your team will have to rework) contributions
to adhere to that practice.

A semi-atomic change request groups related planned changes and minor unplanned changes. You should
still prefer submitting multiple separate change requests for planned work where feasible, to
reduce cognitive load for reviewers and get changes merged into the project as soon as possible.

Again, you're not trying to get the smallest change requests you can submit. You're making a
tradeoff for maintainability, throughput, and coherence. Use your judgement.

> Aside on changelogs:
>
> I'm going to address this more fully in a future post, but I simply don't care even a little bit
> about any arguments around submitting change requests (or titling them) for changelog generation
> tools. My stance on generating changelogs from commits or PRs can be summed up like this:
>
> Don't. They're based on bad principles to obviate an important part of the work. You should
> write changelogs and docs with the same care you give to your code.
>
> More on that later - I promise to update this post to link to my extended thoughts on changelogs
> whenever I write it.

## Submit changes early and clearly

Change requests (PRs on GitHub, MRs in GitLab, etc) should be raised as early as feasible in draft
mode. This allows you to take advantage of things CI will catch, get early review from the team,
and let the community see you do your work more in the open. Important to note: Draft PRs are not
expected to be in a mergeable/reviewable state---they capture work-in-progress, not _final_
submissions. Sometimes a draft PR isn't needed at all, as in the case of release prep or small
maintenance fixes.

In addition to submitting your changes early, you need to make sure your change request has a clear
title, correct labels, and a coherent body that provides context for the reviewers and other
collaborators.

### Titling a change request

Unsurprisingly, I think your change request titles should mirror your branch naming and commit
header templates:

```text
(<work-item-id>|maint|docs>) <synopsis>
```

Again, you want to provide useful context and cross-referencing for the people reviewing your
changes and for all maintainers of the project. The title for your change request should reflect
the _main_ purpose it fulfills. Don't try to provide a synopsis for _every_ change you're making,
especially if you fixed an unrelated bug along the way.

You just want to make sure that the change request title adequately pre-contextualizes your changes
for readers before they open the link to it.

### Labeling a change request

Presumably, you're using labels for your changes already. If not, I strongly recommend you define
useful, contextually appropriate labels for your projects. Always apply the relevant labels to
your change requests. This makes searching and filtering changes _much_ easier. It also helps a
reviewer understand what the change touches, even if they haven't fully read your change request
or the commits in it.

Labels are a tool to provide context to your maintainers and reviewers. Use them.

I don't have particular guidance on what labels you should use because the labels _should_ be
contextual to every project, but here's a few common labels I think nearly every project should
have:

`backwards-incompatible`
: Change requests with this label introduce a change which _can_ break existing users of the code.
  These breaks may include things like dropping support, removing features, or changing behavior
  which accidentally enabled use cases but was dangerous or problematic.

  You want these changes to be as obvious and easy to search for as possible.

`refactor`
: Change requests with this label are only meant to make changes that don't impact users. These
  changes include things like changing function names, renaming tests, and extracting functionality
  into new functions. Generally, refactors are important for _maintainers_ to know about, and no
  one else will probably care.

`maintenance`
: Change requests with this label are for changes around how you maintain the project, rather than
  modifying the code or documentation. These changes include things like updating the test suite,
  changing how you publish documentation, and updating your build scripts. Like refactors,
  maintenance changes are generally only important for _maintainers_ to know about.

### Writing a change request body

If your repository platform supports it, you should define and use a template for the body of your
change requests and _stick to it_. I strongly recommend you include a high-level version of the
commit body in your change request, like this template:

```text
Prior to these changes, <context>

These changes:

- <synopsis of the most important change>
- <synopsis of the next most important change>
```

You may want to include checklists or other information in change requests. Do whatever is coherent
and contextually important for your project. Some of my projects use CI to validate change request
bodies, because it _feels different_ when an automated process blocks a change for non-compliance
compared to when a maintainer writes a comment.

As always, the important thing here is that you want to ensure reviewers have the context they need
to start reviewing and understanding the changes you're submitting. Use your judgement, but create
a relatively lightweight process and follow it.

## Keeping a change request up to date

Inevitably, you'll find yourself working on a change request and find that some other changes get
merged to the upstream after you get started but before your change is merged. Typically, people
resolve this by either rebasing on `upstream/main` or merging `upstream/main` into your working
branch.

The correct answer is to _always_ rebase on `upstream/main`. **Never** merge `main` into your
working branch. It makes the changes in your branch _extremely_ noisy, difficult to follow, and only
serves to make reviewing your work more difficult.

The following snippet is one I often use to rebase my working branch while I'm working.

```sh
git fetch upstream --prune && git rebase upstream/main
```

Sometimes, you'll need to address merge conflicts. I prefer doing this locally in my editor. After
you've rebased and resolved any merge conflicts, push your working branch with the
`--force-with-lease` option to ensure the branch on your fork is updated.

## Marking a change request as ready for review

Change requests should remain in draft until all code for the change has been implemented, CI tests
are passing, and documentation has been added. Once those conditions are met, you should mark the
change request as ready for review. This ensures that reviews can happen more smoothly and with
fewer cycles spent checking to see if the request is ready to go.

When you want review while your changes are still in draft, specifically request the type of
feedback you are looking for for pointed constructive review from maintainers. If your repository
host supports it, request review of a particular snippet whenever possible.

The following list shows example questions for requesting reviews:

- Are these tests sufficient?
- Is this code idiomatic?
- Does this documentation make sense?
- Can you review the new caching mechanism? I don't want to continue this change until we're happy
  with the design.

After you've marked your change as ready for review, be as responsive as possible to feedback from
the reviewers. The more distance and time between when you write a change and respond to feedback,
the more context you lose. The same goes for reviewers, who should prioritize reviewing your
changes as early as feasible, so you can collaborate to get your changes merged.

## Wrapping up

I don't think anything I've proposed here is particularly inflammatory, but I've been in enough
fights over these items to understand my perception isn't reality. I truly do believe that how
we structure and write our commits and change requests is nearly as important as how we structure
and write our code and documentation.

The goal is to write safe, sensible, maintainable software in a way that includes our collaborators
and community members. That means caring about how we do the work, which includes how we document
the changes we're making.

Is it slower to follow these practices than to write `add caching` and leave it at that? Yes. But
the apparent speed increase for skipping caring about maintainer-facing documentation is the same
as skipping tests: faster to make more problems that are harder to resolve in the future. The time
you spend today saves you an order of magnitude more time later, and often invisibly. Maintainer
documentation speeds up getting your changes merged, troubleshooting, and onboarding new
maintainers to your project.

Writing code, like writing prose, is a craft. Caring about your craft and practicing it isn't
something I or anyone can make you do, but I think you should.

Until next time,

~ Mikey

<!-- footnotes -->
[^0]: I'm always happy to have a conversation and receive feedback. Options include:

      - Start a thread or join an existing one in the [GitHub discussion for this post][aa].
      - Report any goofs I've made, like typos or inaccuracies, [as a GitHub issue][ab].

      And, if you do join the conversation or report a goof, know that I appreciate you.

[^1]: As pointed out to me by a reviewer much smarter than me, this is very pedantic for apparently
      little payoff. That's true. Branch naming is the least important thing I discuss in this post. On
      the other hand, this post is a collection of my pedantic heterodox opinions on working with git,
      and I do genuinely find it helpful to quickly filter and orient myself in codebases by branch
      names.

      I don't say so in the body of this post, but these are just my personal (correct) opinions. You're
      free to do whatever makes sense for your context. Sometimes, I break these rules myself. None of
      us is perfect, mea culpa, etc.

<!-- link reference definitions -->
[aa]: https://github.com/michaeltlombardi/mikeywrites.fyi/discussions/12
[ab]: https://github.com/michaeltlombardi/mikeywrites.fyi/issues/new?template=00-report-a-goof.yml&location=-%20%60content%2Fblog%2Fon-git-practices.md%60
[01]: https://dev.to/cbillowes/why-i-create-atomic-commits-in-git-kfi
[02]: https://www.conventionalcommits.org/en/v1.0.0/
[03]: https://github.com/puppetlabs/Puppet.Dsc/commit/d3433d3b105cab580d1233a728bc6beab86d022d
[04]: https://github.com/PowerShell/DSC/commit/916548c74fcef82ec3f3e84cf917d969f9d826ad
