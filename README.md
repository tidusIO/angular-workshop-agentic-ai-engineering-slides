> [!WARNING]
> This is an experimental repostory that uses AI helping us to create & update our workshop material based on our coding solutions.


# Welcome to [Slidev](https://github.com/slidevjs/slidev)!

To start the slide show:

- `pnpm install`
- `pnpm dev`
- visit <http://localhost:3030>

Edit the [slides.md](./slides.md) to see the changes.

Learn more about Slidev at the [documentation](https://sli.dev/).

## AI Generation

Prompt for generating slides based on code solutions.

```md
Act as presenter and workshop presenter who is a Senior Software Engineer and presents to
fellow developers.

- Aks for more information if anything is unclear
- Check The solution Branch in the submodule
- Pick one commit having a tag starting with `solution--migration-control-flow-syntax`
- Analyse its content & check @Angular for official, technical docs.
- Create a topic or structure it in sub-topics
- Create slides for the topic
- Goal: The slides shall enable the viewer on how to build the solution shown in the commit.
```
