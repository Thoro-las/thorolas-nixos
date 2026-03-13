#import "src/boxes.typ": def, thm, pro, cor, lem, exr, qst, alg, nte, ntt, prf, exm
#import "src/texts.typ": ooc, ctitle, chapter, section, subsection, outlines, follow-bar
#import "src/codes.typ": code

#let template(
  cover: (
    hide-page: false,
    hide-contents: false,

    title: [],
    image: none,
    writer: none,
    comment: none,
    warning: none,
    disclaimer: none,
  ),

  doc
) = {
  show heading: none
  set raw(theme: "./themes/theme.tmTheme", syntaxes: "./syntaxes/pseudo.sublime-syntax")
  set table(stroke: 0.2mm)

  show raw.where(block: true): contents => code(contents)
  show table: contents => align(center, contents)

  if (not cover.at("hide-page", default: false)) {
    set par(justify: false)
    text(cover.title, size: 4em) 
    linebreak()
    v(2mm)
    if("writer" in cover and cover.writer != none) { text(size: 1.3em, [Written by #cover.writer.]); linebreak()}
    set par(justify: true)

    v(1fr)
    v(1cm)

    block(
      stroke: (left: 1mm + black),
      inset: (left: 7mm),
      outset: (y: 2mm, left: -1mm),
      [
        #if ("disclaimer" in cover and cover.disclaimer != none) {
          text("Disclaimer", size: 2em)
          linebreak()
          v(1mm)
          text([#cover.disclaimer])
          linebreak()
          v(2mm)
        }

        #if ("comment" in cover and cover.comment != none) [
          #cover.comment
          #linebreak()
        ]
        To separate the contents of the course to actual additions or out of context information, a black band will be added by its side like the one on this comment.

        #linebreak()

        #if("warning" in cover and cover.warning != none) { text(fill: red, [#cover.warning]); linebreak(); }
      ]
    )

    if (not cover.at("hide-contents", default: false)) {
      outlines()
      colbreak(weak: true)
    }
  }

  doc
}
