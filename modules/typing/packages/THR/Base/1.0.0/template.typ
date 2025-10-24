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
          #text(weight: "bold", fill: title-color, title):
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

#let __ctbox(hue, title, subtitle, content, count: true, level: 1, ovcount: true) = {
  __cbox-count.step(level: level)
  let ctitle = {
    title + if (count) {[ #context {if (ovcount) {__chp-sect-count.display("1.") } else { "" } + __cbox-count.display("1.1")}]} + if subtitle != "" {" (" + subtitle + ")"}
  }
  __cbox(hue, ctitle, content)
}

#let ctitle(title) = align(center)[ #text(size: 2em, title) ]

#let chap(title, body, num: -1) = [
  #{
    pagebreak(weak: true)
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

#let sect(title, level: 2) = [
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

#let subs(title) = [
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

#let summarize() = [
  = *Summary*
  #text(size: 3em, "Summary")
  #linebreak()
  #v(2mm)
  #context __sum-content.final()
]

#let def(name: "", ovcount: true, body) = __ctbox( 7, ovcount: ovcount, "Definition", name, body)
#let thm(name: "", ovcount: true, body) = __ctbox( 4, ovcount: ovcount, "Theorem", name, body)
#let pro(name: "", ovcount: true, body) = __ctbox(16, ovcount: ovcount, "Proposition", name, body)
#let cor(name: "", ovcount: true, body) = __ctbox( 0, ovcount: ovcount, "Corollary", name, body)
#let lem(name: "", ovcount: true, body) = __ctbox( 3, ovcount: ovcount, "Lemma", name, body)
#let nte(name: "", ovcount: true, body) = __ctbox( 9, ovcount: ovcount, "Note", name, body, count: false)
#let ntt(name: "", ovcount: true, body) = __ctbox(12, ovcount: ovcount, "Notation", name, body, count: false)
#let exr(name: "", ovcount: true, body) = __ctbox(13, ovcount: ovcount, "Exercise", name, body)
#let qst(name: "", ovcount: true, body) = __ctbox(16, ovcount: ovcount, "Question", name, body, level: 2)
#let alg(name: "", ovcount: true, body) = __ctbox(13, ovcount: ovcount, "Algorithm", name, raw(body), count: false)

#let exm(body) = [*Example: * #body]
#let prf(body) = [_Proof. _
  #body
  #h(1fr)
  $square.stroked$
]

#let prfout(name: "", body) = [
  #ooc[
    *Proof Outline:*
    #text(style: "normal", body)
  ]
]

#let template(doc, title: [], mainpage: true, summarize: false, contents: true, disclaimer: none, writer: none, comment: none, warning: none) = {
  show heading: none
  show table: contents => { align(center, contents) }
  set table(stroke: 0.3mm)

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
      To seperate the contents of the course to actual additions or out of context information, a black band will be added by its side like the one englobing this comment.
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
    summarize()
  }
}
