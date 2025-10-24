#import "@THR/Base:1.0.0" as Base: *

#let template(doc, title: [], mainpage: true, summarize: false, contents: true, disclaimer: none, writer: none, comment: none, warning: none, columns: 2) = [
  #set page(margin: 0.5cm, columns: columns)
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
