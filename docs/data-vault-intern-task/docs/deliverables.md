# Deliverables

Two files, committed to your own repository, in a folder named design.

| File | Content |
|------|---------|
| design/erd.mmd | Mermaid entity relationship diagram of your Raw Vault design, with the reasoning inline |
| design/profiling_note.md | What you found in the data before you modelled |

Start from the file in templates/.

## 1. Entity relationship diagram

Mermaid format, in design/erd.mmd. Start from templates/erd.mmd.

Requirements:

- Every Raw Vault model you would build appears in the diagram, and nothing
  else does.
- Show the key columns of each model and the payload columns of each
  satellite. Key columns alone are not enough to judge a satellite split.
- Draw the relationship lines from satellites to their parents and from links
  to their hubs.
- Group by model type visually if you can, so hubs are readable as a set.

Every model carries a why comment above it, in the mermaid comment syntax:

- What one row of the model means, in one sentence. This is the grain.
- Why it exists as a separate model. For a satellite, why it is split out
  instead of merged with another. For a link, what the relationship is and
  why it is a link rather than an attribute.

The why comments are where the marks are. A why that restates the model name
scores nothing. The diagram is what we will hold the review conversation
over, so anything you decided but did not write down will read as something
you did not decide.

## 2. Profiling note

A short file, design/profiling_note.md, no more than one page. It must
record:

- Columns that are empty for every row.
- Columns that are empty only for a subset, and what defines that subset.
- For each table, the row count against the distinct count of the identifier.
- Any value you found that does not match what docs/source_dictionary.md
  says.
- Any referential gap between the three tables in either direction.
- Every assumption you had to make, and the question you would ask the
  source system owner to remove it.

This is the file that proves you looked at the data instead of modelling
from the dictionary.
