#import "@preview/cetz:0.4.2"
#cetz.canvas({
  import cetz.draw: *
  arc((0,0), start: 0deg, delta: 180deg, radius: 1, stroke: 1pt)
  arc((0,0), start: 0deg, delta: 90deg, radius: 1, mark: (end: "stealth"), stroke: none)
})
