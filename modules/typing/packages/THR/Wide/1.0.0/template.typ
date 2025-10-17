#import "@THR/Base:1.0.0" as Base: *

#let template(doc, title: [], mainpage: true, summarize: false, contents: true, disclaimer: none, writer: none, comment: none, warning: none) = [
  #set page(margin: 1.5cm, columns: 2, flipped: true)
  #set par(justify: true)
  #show: Base.template.with(
    title: title,
    mainpage: mainpage,
    summarize: summarize,
    contents: contents,
    disclaimer: disclaimer,
    writer: writer,
    warning: warning,
    comment: comment
  )

  #doc
]
