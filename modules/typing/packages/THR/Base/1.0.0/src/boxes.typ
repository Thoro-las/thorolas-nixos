#import "./colors.typ": indexed-colors

#let colored-box(hue, title, content) = {
  let colors = indexed-colors(hue)
  let fill-color = colors.foreground
  let border-color = colors.background
  let title-color = colors.text

  align(center)[
    #block(
      width: 95%,
      inset: 3mm,
      fill: fill-color,
      stroke: (left: 1mm + border-color),
      align(left)[
        #text(weight: "bold", style: "normal", fill: title-color)[*#{title + ":"}*]
        #text(style: "italic", content)
      ]
    )
  ]
}

#let colored-titlebox(hue, title, subtitle, content, count: true, level: 1, ovcount: true) = {
  if (count) { counter("box-counter").step(level: level) }

  let ctitle = {
    title + if (count) {
      context {
        if (ovcount) {
          " " + counter("title-counter").display("1.")
      } else {
        " "
      } + counter("box-counter").display("1.1")}
    } + if subtitle != "" {" (" + subtitle + ")"}
  }

  colored-box(hue, ctitle, content)
}

#let set-box-count(value) = {
  counter("box-counter").update(calc.max(value - 1, 0))
}

#let def(name: "", count: true, ovcount: true, body)  = colored-titlebox( 7, count: count, ovcount: ovcount, "Definition", name, body)
#let thm(name: "", count: true, ovcount: true, body)  = colored-titlebox( 4, count: count, ovcount: ovcount, "Theorem", name, body)
#let pro(name: "", count: true, ovcount: true, body)  = colored-titlebox(16, count: count, ovcount: ovcount, "Proposition", name, body)
#let cor(name: "", count: true, ovcount: true, body)  = colored-titlebox( 0, count: count, ovcount: ovcount, "Corollary", name, body)
#let lem(name: "", count: true, ovcount: true, body)  = colored-titlebox( 9, count: count, ovcount: ovcount, "Lemma", name, body)
#let exr(name: "", count: true, ovcount: true, body)  = colored-titlebox(13, count: count, ovcount: ovcount, "Exercise", name, body)
#let qst(name: "", count: true, ovcount: true, body)  = colored-titlebox(16, count: count, ovcount: ovcount, "Question", name, body, level: 2)
#let alg(name: "", count: true, ovcount: true, body)  = colored-titlebox(13, count: count, ovcount: ovcount, "Algorithm", name, body, level: 2)

#let nte(name: "", count: false, ovcount: true, body) = colored-titlebox( 9, count: count, ovcount: ovcount, "Note", name, body)
#let ntt(name: "", count: false, ovcount: true, body) = colored-titlebox(12, count: count, ovcount: ovcount, "Notation", name, body)

#let exm(body, count: false) = [
  #if (count) {counter("box-counter").step()}
  * Example#context if (count) {" " + counter("title-counter").display("1.") + counter("box-counter").display("1.1")}: * #body
]


#let prf(body) = [
  #block(width: 100%, {
    [_Proof. _]
    body
    place(right + bottom, $square.filled$)
  })
]

#let prfout(name: "", body) = [
  #ooc[
    #text("Proof Outline:", weight: "bold", style: "normal")
    #text(style: "normal", body)
  ]
]
