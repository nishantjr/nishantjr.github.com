---
title: My AI Policy
cover: njr
---

Generative AI tools have become impressive
in their ability to synthesize code, text, and various media.
One one hand, its training and use have me concerned in terms of
ethics, integrity, and personal sovereignty over my digital tools.
On the other, it is becoming pervasive in software development, the
foundation of my career---at the very least, I must have some familiarity with
it, and clear boundaries when interacting with other people who use these tools.
Thinking through these concerns lets me frame clear, consistent,
and explicit boundaries.

Disclaimers:

- This document governs my own use of AI and tailored to my comfort levels.
  It is not intended to pass judgement on how others use it.
- This document is a living document, subject to change as generative AI, its
  costs, and its uses evolve, and as I have a chance to think about things more
  deeply.

### Summary

* I will not pay for access to LLMs [(rationale)](#rationale-no-pay)
* LLMs in Software Development [(rationale)](#rationale-software)
  - I may use AI as a search engine and research tool
  - I may use AI for code review and bug finding
  - I will *not* use AI for substantial code synthesis
  - I will *not* review or accept AI contributions, unless the contributor accepts
    responsibilty for the code as if they had written and reviewed it in full,
    and their reputation is on the line.
* LLMs in writing [(rationale)](#rationale-ai-writing)
  - I will *not* use LLMs to write or communicate in any way.
  - I may use LLMs for research to inform my writing.
* AI in Art [(rationale)](#rationale-ai-art)
  - I will *not* use AI for any artistic creation of my own
  - I will only patronise (e.g. buying, liking on Instagram...)
    artwork that has substantial and transformative human contributions.


### Rationale: I will not pay for access to LLMs {#rationale-no-pay}

In my opinion, developers of frontier models are working on a moral framework
that is incompatible with my own.
*I will not be complicit.*
Enumerated below are some aspects of this:

Personal sovereignty
: Currently, a paid subscription costs around \$20, not cheap, but not too
  expensive if it is a useful tool that saves a few hours a week. However, it is
  well-known that usage of frontier models are heavily subsidised but it is not
  publicly know by how much. I'd rather not become dependent on a tool that can
  suddenly start costing me $200 a month.

Techno-colonialism
: The last two decades has seen our digital platforms have fall under the
  control of a few large American corporations, run by CEOs with questionable
  intentions. These platforms are our third-places, central to our communities,
  social lives and democracies. They have hollowed out the decentralized
  internet that existed before. With AI, their end-game
  seems to be having the means of (digital) creation in their control.

Disregard for intellectual property
: LLMs have been trained on copyrighted art and literature, pirated books, GPL-licensed
  code, scientific papers, and so on. Whether or not this usage is legal, it is
  non-consenting. There also seems to be a [two-tier justice system for
  enforcement copyright law][us-v-swartz].

[us-v-swartz]: https://en.wikipedia.org/wiki/United_States_v._Swartz


(a non-consideration) climate change and the energy transition
:   In the face of a looming climate crisis, the massive carbon costs and stress
    to the grid because of AI training and usage cannot be ignored.
    This is a concern I personally have,
    yet hesitate to make it a core rationale for my policy, at least directly.

    At the end of the day, I consider climate change fundamentally
    a social justice concern---minimizing carbon usage is
    not an objective in and of itself, but a convenient measure of the harm
    we may bring upon the most vulnerable in our society.

    I cannot object to AI in direct terms of its carbon usage because that would
    be deeply hypocritical and come from a perspective of great privilege.
    I have used trans-continental flights to enrich myself in terms of my education
    and personal enjoyment. Though perhaps I also need a personal "climate policy".

    My main objections to AI in aspects such as eminent domain being used
    to build data centers, local energy prices are, however, covered by other
    rationale, such as 'Inequity'.

Inequity (unequal availablity)
: One of my attractions to opensource and programming is its democratic nature.
  With (relatively) little capital expenditure (though with copious investment
  of time), one can teach yourself how to program and make contributions to
  projects. If LLMs take off, those without access may find themselves left out.

Inequity (unequal costs)
: It is inexcusable the Indian goverment is using eminent domain to build data
  centers.

Incentive to addict
: Similar to social media, getting users addicted seems to be in these companies
  interest. This seems far more worrying and dangerous than the case with
  social media, with cognitive offloading. If I use this tool regularly
  I think I can slowly slide into this mode of interacting with it.
  Not paying for the tool is one (perhaps crude) method of adding friction.

<!--
Action Points:

* stop paying Google for Google Drive. While I am not paying for AI usage, the
  contribution nethertheless helps them train LLMs.
-->

### Rationale: AI in Software Development {#rationale-ai-software}

Synthesising substantial (say 50 lines of non-throwaway code, to place a line in
the sand) code comes with significant drawbacks.

LLMs can speed up development, but not by much
: While LLMs have become pretty decent at synthesizing code, the time spent
  reviewing the code negates much of the advantages. Failure to review
  generated code (even in the absense of bugs) can lead to the LLM making
  subtle decisions with consequences that I do not understand. This may cause
  substantial backtracking later.

Reviewing AI generated code exhausts me
: Because I am on the lookout for subtle bugs and decisions that the AI has
  made. I'm constantly aware that the AI has less context about what the code
  is doing. This is different from reviewing even a junior developers code.
  In fact, AIs seem to rarely make mistakes that junior developers would.
  The summary of the changes the AI spits out is rarely helpful, as that is
  quite verbose and must also be reviewed, adding to the cognitive load.

Less "institutional knowledge" of the codebase
: Reviewing code does not give you the same in-depth understanding than if you
  wrote it yourself. This means that there is less likely to be someone on the
  team with an in-depth understanding of why particular decisions were made.

While LLMs can be useful for when working with unfamiliar languages or tools,
I find the approach of:

1. Ask the LLM research questions
2. Write the code yourself
3. Ask the LLM for a review

This approach lets me muddle along, learning the tool in the process, but
puts me back on the idiomatic path through the review. I have a much
more in-depth understanding of how and why things are the way they are.
The approach of: 1. The LLM writes; 2. I review; feels like learning
glass blowing purely through watching YouTube videos. While you will get some
understanding, you'd be clumsy at best if you tried to do it yourself.

Postscript: Perhaps at some point AI will get so good that we can trust its code without
review and let it write and evolve full applications on its own,  but I do not
think that day is today, and I do not think that that tech is this iteration
of AI.

### Rationale: AI in writing {#rationale-ai-writing}

While LLMs could significantly reduce the effort needed to write documents
and combat my dyslexia, I feel that writing is too core a part of how I form
my thoughts and voice them to trust it to a machine.

### Rationale: AI in Art {#rationale-ai-art}

Art is fundamentally about human expression, emotion, and communication.
Sometimes these may come out of the process of creation itself rather than
the finished product. Purely or largely AI art is meaningless.
