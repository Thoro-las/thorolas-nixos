#import "@THR/Base:1.0.0" as Base: *

#let template(doc, ..args) = [
  #set page(margin: (x: 0.5cm, top: 0.5cm, bottom: 1cm), columns: 2)
  #set par(justify: true)
  #show: Base.template.with(..args)
  #doc
]
