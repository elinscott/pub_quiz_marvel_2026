#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2cm),
)

#show heading: set align(center)

#let generate_sheets(contents) = [
  // Small first page
  #set text( size: 16pt)
  #align(center,[
  #text(size: 1.3em, weight: "bold", [MARVEL Review and Retreat Pub Quiz])
  #linebreak()
  Edward Linscott #h(0.5em) | #h(0.5em) Grindelwald #h(0.5em) | #h(0.5em) #datetime(year: 2026, month: 1, day: 12).display("[day padding:none] [month repr:long] [year]")

  #v(1em)

  Team name: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

  #v(1em)
  #grid(
    columns: (3cm, 6cm, 2cm),
    align: left,
    column-gutter: 1em,
    row-gutter: 1em,
    ..for (round_num) in array.range(1, contents.rounds.len() + 1) {
      let round = contents.rounds.at(round_num - 1)
      //([Round #round_num:], [#round.title], line(length: 2cm))
      ([Round #round_num:],[#round.title], line(start: (0em, 0.8em), length: 2cm))
    },
    [Round 7: ], [#contents.pictures.title], line(start: (0em, 0.8em), length: 2cm),
    [Round 8: ], [The last piece of the puzzle], line(start: (0em, 0.8em), length: 2cm),
    [*Total*], [], line(start: (0em, 0.8em), length: 2cm),
  )
]
  )

  #pagebreak()
  #set text(size: 24pt)
  #for (round_num) in array.range(1, contents.rounds.len() + 1) [
    #let round = contents.rounds.at(round_num - 1)
    == Round #round_num: #round.title
    #if ("hint") in round [
      #align(center, text(round.hint, size: 0.8em, style: "italic"))
    ]
    #v(1em)
    #for (question_num) in array.range(1, round.questions.len() + 1) [
      + #v((page.height - 15cm) / round.questions.len())
    ]
    #pagebreak()
  ]

  == Round 7: #contents.pictures.title
  #let round = contents.pictures
  #align(center, text(round.hint + " Scan the QR code to see the images in greater detail.", size: 0.8em, style: "italic"))
  #align(center, image("media/qr.png", height: 20%))

  #grid(columns: (1cm, 1fr, 1cm, 1fr, 1cm, 1fr),
    align: center,
    row-gutter: 3em,
    ..for (picture_num) in array.range(1, round.pictures.len() + 1) {
      let picture = round.pictures.at(picture_num - 1)
      ([#picture_num.], [#image(picture.question, height: 10%)],)
    }
  )


  #pagebreak()

  == Round 8: The last piece of the puzzle

  #align(center, text("Fill in all the blanks. 2 points per puzzle.", size: 0.8em, style: "italic"))

  #set text(size: 16pt)

  + #v(1em)
    - asking for information about a temple in Cambodia
    - to sharpen a knife soaked in water
    - during which, be cunning and devious
    - complain about #box(line(length: 5em))

  + #v(1em)
    366.48 K, #box(line(length: 5em)) \
    $v_"me" = c$ \
    #box(line(length: 5em)) > 343 m/s (in dry air at 1 atm and 20°C) #box(line(length: 5em)) \
    #box(line(length: 5em)) $bold(p)_"me" (t) - integral_t^(t_"now") bold(F)(t') dif t' = 0$

  + #v(1em)
    - Tongans treat waiters poorly
    - The Danes get road rage
    - Tunisians lie about their age
    - #box(line(length: 5em)) like pineapple on pizza

  + #v(1em)
    + an international citizen
    + the outskirts of a hub
    + a useless ability
    + ignore the #box(line(length: 5em)) #text("X", fill: white)

]

#context generate_sheets(
   yaml("questions.yaml")
)
