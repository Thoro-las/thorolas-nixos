#import "@preview/droplet:0.3.1": dropcap

#let template(doc) = [
  #show heading: none
  #doc
]

#let __chp-sect-count = counter("chapter-section-counter")
#let __cbox-count = counter("cboxes-counter")

#let __color(hue, chroma, brightness) = color.oklch(brightness, chroma, hue * 20deg, 100%)

#let __cbox(hue, title, content) = {
  let fill-color = __color(hue, 10%, 96%)
  let border-color = __color(hue, 40%, 70%)
  let title-color = border-color.darken(20%)

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

#let ooc(body) = [
  #block(
    stroke: (left: 1mm + black),
    inset: (left: 6mm),
    outset: (y: 2mm, left: -1mm),
    body
  )
]

#let contents() = [
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

#let mainpage(title, writer, professor, comment: []) = [
  #set par(justify: false)
  #text(title, size: 4em)
  #set par(justify: true)
  #v(1fr)
  #text("Disclaimer", size: 2em)

  #text([This follows the lessons from Mr. #professor given in course, major additions, changes or rearrangements can be applied on the course for the sake of clarity, better explainations or just subjective opinions, written by #writer.

  #if (comment != []) [
    #ooc([
      #comment. To seperate the contents of the course to actual additions or out of context information, a black band will be added by its side like the one englobing this comment.
    ])
  ]

  #text(fill: red, [USE THIS AT YOUR OWN RISK.])])
  #colbreak()
  #contents()
  #pagebreak(weak: true)
]


#let __ctbox(hue, title, subtitle, content, count: true, level: 1) = {
  __cbox-count.step(level: level)
  let ctitle = {
    title + if count {[ #context {__chp-sect-count.display("1.") + __cbox-count.display("1.1")}]} + if subtitle != "" {" (" + subtitle + ")"}
  }
  __cbox(hue, ctitle, content)
}


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
]

#let sect(title, level: 2) = [
  == #title
  #__chp-sect-count.step(level: level)
  #text(context __chp-sect-count.display("1.") + " " + title, size: 1.6em, weight: "bold") \
  #v(1mm)
]

#let subs(title) = [
  === #title
  #__chp-sect-count.step(level: 3)
  #text(context __chp-sect-count.display("1.") + " " + title, size: 1.3em, weight: "bold") \
  #v(0mm)
]

#let def(name: "", body) = __ctbox( 7, "Definition", name, body)
#let thm(name: "", body) = __ctbox( 4, "Theorem", name, body)
#let pro(name: "", body) = __ctbox(16, "Proposition", name, body)
#let cor(name: "", body) = __ctbox( 0, "Corollary", name, body)
#let lem(name: "", body) = __ctbox( 3, "Lemma", name, body)
#let nte(name: "", body) = __ctbox( 9, "Note", name, body, count: false)
#let ntt(name: "", body) = __ctbox(12, "Notation", name, body, count: false)
#let exr(name: "", body) = __ctbox(13, "Exercise", name, body)
#let qst(name: "", body) = __ctbox(16, "Question", name, body, level: 2)
#let alg(name: "", body) = __ctbox(13, "Algorithm", name, raw(body), count: false)

#let exm(body) = [*Example: * #body]
#let prf(body) = [_Proof. _
  #body
  #h(1fr)
  $square.stroked$
]
