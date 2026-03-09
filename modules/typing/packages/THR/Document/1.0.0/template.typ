#import "@THR/Base/1.0.0/template.typ" as Base: *

#let template(doc, ..args) = [
  #set page(margin: 0.5cm, columns: columns)
  #set par(justify: true)
  #show: Base.template.with(..args)
  #doc
]
