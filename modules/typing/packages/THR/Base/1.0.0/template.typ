#import "@preview/droplet:0.3.1": dropcap

#let __chp-sect-count = counter("chapter-section-counter")
#let __cbox-count = counter("cboxes-counter")

#let __color(hue, chroma, brightness) = color.oklch(brightness, chroma, hue * 20deg, 100%)

#let __sum-content = state("sum-content", [])
#let add-to-summary(content) = {
  __sum-content.update(sum => [#sum#content])
}

#let __cbox(hue, title, content) = {
  let fill-color = __color(hue, 10%, 96%)
  let border-color = __color(hue, 40%, 70%)
  let title-color = border-color.darken(20%)

  let colored-block = {
    align(center)[
      #block(
        width: 95%,
        inset: 3mm,
        fill: fill-color,
        stroke: (left: 1mm + border-color),
        align(left)[
          #text(weight: "bold", style: "normal", fill: title-color, title + ":")
          #text(style: "italic", content)
        ]
      )
    ]
  }

  colored-block
  add-to-summary(colored-block)
}

#let ooc(body) = [
  #block(
    stroke: (left: 1mm + black),
    inset: (left: 4mm),
    outset: (y: 2mm, left: -1mm),
    width: 100%,
    body
  )
]

#let outlines() = [
  #v(1fr)
  #block(
    stroke: (left: 0.5mm + black),
    inset: (left: 7mm),
    outset: (y: 2mm, left: -1mm),
    [
      #set par(justify: false)
      #text("Contents", size: 1.5em)
      #set par(justify: true)
      #outline()
    ]
  )
]

#let __ctbox(hue, title, subtitle, content, count: true, level: 1, ovcount: true, countval: -1) = {
  if (count) { __cbox-count.step(level: level) }
  let ctitle = {
    title + if (count) {[ #context {if (ovcount) {__chp-sect-count.display("1.") } else { "" } + __cbox-count.display("1.1")}]} + if subtitle != "" {" (" + subtitle + ")"}
  }
  __cbox(hue, ctitle, content)
}

#let ctitle(title) = align(center)[
  #v(2mm)
  #text(size: 2em, title)
]

#let chapter(title, jump: true, body, num: -1) = [
  #{
    if (jump == true) { pagebreak(weak: true) }
    else { colbreak(weak: true) }
    if (num < 0) { __chp-sect-count.step() } 
    else { __chp-sect-count.update(num) }

    __cbox-count.update(0)
  }

  #block(inset: (y: 3mm), [
    = *Chapter*: #title
    #text(size: 2em, "Chapter " + context __chp-sect-count.display())
    #v(-6mm)
    #text(size: 3em, title)
    #v(-3mm)
    #dropcap(gap: 3pt)[#body]
  ])

  #add-to-summary({
    text(size: 2em, "Chapter " + context __chp-sect-count.display() + ": " + title)
    linebreak()
    v(2mm)
  })
]

#let section(title, level: 2) = [
  == #title
  #__chp-sect-count.step(level: level)
  #text(context __chp-sect-count.display("1.") + " " + title, size: 1.6em, weight: "bold") \
  #v(1mm)

  #add-to-summary({
    text(size: 1.5em, context __chp-sect-count.display("1.1") + ": " + title)
    linebreak()
    v(2mm)
  })
]

#let subsection(title) = [
  === #title
  #__chp-sect-count.step(level: 3)
  #text(context __chp-sect-count.display("1.") + " " + title, size: 1.3em, weight: "bold") \
  #v(0mm)

  #add-to-summary({
    text(size: 1.2em, context __chp-sect-count.display("1.1") + ": " + title)
    linebreak()
    v(2mm)
  })
]

#let summary() = [
  = *Summary*
  #text(size: 3em, "Summary")
  #linebreak()
  #v(2mm)
  #context __sum-content.final()
]

#let def(name: "", count: true, ovcount: true, body)  = __ctbox( 7, count: count, ovcount: ovcount, "Definition", name, body)
#let thm(name: "", count: true, ovcount: true, body)  = __ctbox( 4, count: count, ovcount: ovcount, "Theorem", name, body)
#let pro(name: "", count: true, ovcount: true, body)  = __ctbox(16, count: count, ovcount: ovcount, "Proposition", name, body)
#let cor(name: "", count: true, ovcount: true, body)  = __ctbox( 0, count: count, ovcount: ovcount, "Corollary", name, body)
#let lem(name: "", count: true, ovcount: true, body)  = __ctbox( 3, count: count, ovcount: ovcount, "Lemma", name, body)
#let nte(name: "", count: false, ovcount: true, body) = __ctbox( 9, count: count, ovcount: ovcount, "Note", name, body)
#let ntt(name: "", count: false, ovcount: true, body) = __ctbox(12, count: count, ovcount: ovcount, "Notation", name, body)
#let exr(name: "", count: true, ovcount: true, body)  = __ctbox(13, count: count, ovcount: ovcount, "Exercise", name, body)
#let qst(name: "", count: true, ovcount: true, body)  = __ctbox(16, count: count, ovcount: ovcount, "Question", name, body, level: 2)
#let alg(name: "", count: true, ovcount: true, body)  = __ctbox(13, count: count, ovcount: ovcount, "Algorithm", name, body, level: 2)

#let exm(body, count: false) = [
  #if (count) {__cbox-count.step()}
  * Example#context if (count) {" " + __chp-sect-count.display("1.") + __cbox-count.display("1.1")}: * #body
]


#let prf(body) = [_Proof. _
  #body #h(1fr) $square.stroked$
]

#let prfout(name: "", body) = [
  #ooc[
    *Proof Outline:*
    #text(style: "normal", body)
  ]
]

#let code(title: none, link: none, code) = [
  #align(center)[
    #block(
      fill: color.rgb("#282C34"),
      inset: 3mm,
      width: 95%,
      radius: 1mm,
      align(left)[
        #show raw.line: it => [
          #let n = str(it.number)
          #let disp = " " * (3 - n.len()) + n
          #text(fill: color.rgb("#6c7079"), [#disp #h(-1mm)- ]) #it.body
        ]

        #show raw: set text(ligatures: true, size: 0.9em, weight: "regular", style: "normal")

        #code
      ]
    )
  ]
]

#let template(doc, title: [], mainpage: true, summarize: false, contents: true, disclaimer: none, writer: none, comment: none, warning: none) = {
  show heading: none
  show table: contents => { align(center, contents) }
  set table(stroke: 0.3mm)

  set raw(theme: "One Dark.tmTheme", syntaxes: "pseudo.sublime-syntax")
  show raw: body => block(fill: color.rgb("#282C34"), inset: 0.7mm, body)

  if (mainpage) {
    set par(justify: false)
    text(title, size: 4em) 
    linebreak()
    v(2mm)
    if(writer != none) { text(size: 1.3em, [Written by #writer.]); linebreak()}
    set par(justify: true)

    v(1fr)

    if (disclaimer != none) {
      text("Disclaimer", size: 2em)
      linebreak()
      v(1mm)
      text([#disclaimer])
      linebreak()
      v(2mm)
    }

    ooc([
      #if (comment != none) [
        #comment
        #linebreak()
      ]
      To separate the contents of the course to actual additions or out of context information, a black band will be added by its side like the globing this comment.
    ])
    linebreak()

    if(warning != none) { text(fill: red, [#warning]); linebreak(); }
    
    if (contents) {
      colbreak()
      outlines()
      pagebreak(weak: true)
    }
  }

  doc

  if (summarize) {
    pagebreak(weak: true)
    summary()
  }
}
