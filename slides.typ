#import "touying/lib.typ": *
#import "@preview/pinit:0.1.4": *
#import "@preview/xarrow:0.3.0": xarrow
#import "@preview/cetz:0.3.3"
#import "quiz-slides-0.6.1.typ": *

// color-scheme can be navy-red, blue-green, or pink-yellow
#show: quiz-theme.with(aspect-ratio: "16-9",
                       footer-a: none,
                       footer-b: none,
                       footer-c: none,
                             config-info(
                                title: [MARVEL Retreat Pub Quiz],
                                subtitle: [],
                                author: [Edward Linscott],
                                date: datetime(year: 2026, month: 1, day: 12),
                                location: [Grindelwald],
                             ))

#let fill-in-the-blank(before, after, answer) = {
  only(before, box(text(answer, weight: "bold", fill: white), stroke: (bottom: 1pt, rest: none), clip: true))
  only(after, text(answer, weight: "bold"))
}

#title-slide()

= How it works
== Format
- five regular rounds #pause
  - eight questions each, which we will go through together #pause
  - questions within each round are linked by some common thread #pause
- we will have an extended break after round 3 (during which round 4 will take place) #pause
- rounds 7 and 8 are the picture and puzzle rounds #pause
  - *for you to complete in your spare time* #pause
  - example puzzles to follow #pause

- if you need something clarified, just ask! #pause
- at the end of each round I can repeat previous questions upon request, so don't worry if you've forgotten a previous question #pause
- the quizmaster is _always_ right!

= Example puzzles

#slide(repeat: 3, self => [
  #let (uncover, only, alternatives) = utils.methods(self)

  _Fill in the missing piece of the puzzle_

  #uncover("2-")[Pillar] 1. Natarajan

  #uncover("2-")[Pillar] 2. Ceriotti

  #uncover("2-")[Pillar] 3. Pizzi

  #uncover("2-")[Pillar] 4. #fill-in-the-blank("1-2", "3-", "Marzari")
])

#slide(repeat: 6, self => [
  #let (uncover, only, alternatives) = utils.methods(self)

  _Fill in the missing piece of the puzzle_

  - pe (skateboarding) #only("2-")[\= half-pi#text(weight: "bold", "pe")]
  
  - thon (athletics) #only("3-")[\= half-mara#text(weight: "bold", "thon")]

  - son (wrestling) #only("4-")[\= half-nel#text(weight: "bold", "son")]

  - ley (#fill-in-the-blank("-5", "6-", "tennis")) #only("5-")[\= half-vol#text(weight: "bold", "ley")]

])

// Loop over the rounds
#let generate_slides(contents) = {
   for (round_num) in array.range(1, contents.rounds.len() + 1) [
      #let round = contents.rounds.at(round_num - 1)
      = Round #round_num: #round.title

    #if ("hint") in round [
      #slide[
        #align(center + horizon, text(round.hint, size: 1.5em, style: "italic"))
      ]
    ]
    #if ("explanation") in round [
      #include(round.explanation)
    ]
    #if ("questions") in round [

      #for (question_num) in array.range(1, round.questions.len() + 1) [
        #let question = round.questions.at(question_num - 1)
        #if ("picture_resize") not in question [
          #question.insert("picture_resize", 1)
        ]
        #slide[
          #align(center + horizon, [#question_num] + [. ] + question.question)
          #if ("picture" in question) [
            #align(center + horizon, image(question.picture, height: 60% * question.picture_resize ))
          ]
          #if ("pictures" in question) [
            #align(center, grid(columns: question.pictures.len(), column-gutter: 1em, ..for (pic) in question.pictures {(image(pic, height: 60% * question.picture_resize),)}))
          ]
          #if ("question_content" in question) [
            #include(question.question_content)
          ]
          #if ("question_pic" in question) [
            #align(center + horizon, image(question.question_pic, height: 60% * question.picture_resize))
          ]
          #if ("question_pics" in question) [
            #align(center, grid(columns: question.question_pics.len(), column-gutter: 1em, ..for (pic) in question.question_pics {(image(pic, height: 60% * question.picture_resize),)}))
          ]
        ]
      ]
      = Answers
      #for (question_num) in array.range(1, round.questions.len() + 1) [
        #let question = round.questions.at(question_num - 1)
        #if ("picture_resize") not in question [
          #question.insert("picture_resize", 1)
        ]
        #slide(repeat: 2 + str(question.answer).matches(";").len(), self => [
          #let (uncover, only, alternatives) = utils.methods(self)
          #align(center + horizon, [#question_num] + [. ] + question.question)
          #if ("picture" in question) [
            #align(center + horizon, image(question.picture, height: 60% * question.picture_resize))
          ]
          #if ("pictures" in question) [
            #align(center, grid(columns: question.pictures.len(), column-gutter: 1em, ..for (pic) in question.pictures {(image(pic, height: 60% * question.picture_resize),)}))
          ]
          #if ("question_pic" in question or "question_pics" in question or "question_content" in question) [
            #only("1")[
              #if ("question_pic" in question) [
                #align(center + horizon, image(question.question_pic, height: 60% * question.picture_resize))
              ]
              #if ("question_pics" in question) [
                #align(center, grid(columns: question.question_pics.len(), column-gutter: 1em, ..for (pic) in question.question_pics {(image(pic, height: 60% * question.picture_resize),)}))
              ]
              #if ("question_content" in question) [
                #include(question.question_content)
              ]
            ]
            #only("2-")[
              #if ("answer_pic" in question) [
                #align(center + horizon, image(question.answer_pic, height: 60% * question.picture_resize))
              ]
              #if ("answer_pics" in question) [
                #align(center, grid(columns: question.answer_pics.len(), column-gutter: 1em, ..for (pic) in question.answer_pics {(image(pic, height: 60% * question.picture_resize),)}))
              ]
            ]
          ] else [
            #uncover("2-")[
              #if ("answer_pic" in question) [
                #align(center + horizon, image(question.answer_pic, height: 60% * question.picture_resize))
              ]
              #if ("answer_pics" in question) [
                #align(center, grid(columns: question.answer_pics.len(), column-gutter: 1em, ..for (pic) in question.answer_pics {(image(pic, height: 60% * question.picture_resize),)}))
              ]
            ]

          ]
          #pause
          #align(center + horizon, str(question.answer).split(";").join("," + pause))
        ])
      ]
    ]
  ]


  heading(contents.pictures.title, depth: 1)
  for picture_num in array.range(1, contents.pictures.pictures.len() + 1) [
    #let picture = contents.pictures.pictures.at(picture_num - 1)
    #slide(repeat: 2, self => [
      #align(center + horizon, [#picture_num.])
      #alternatives[
        #align(center + horizon, image(picture.question, height: 60%))
        #linebreak()
      ][
        #align(center + horizon, image(picture.answer_pic, height: 60%))
        #align(center + horizon, picture.answer)
      ]
    ])
  ]

  // for puzzle_num in array.range(1, contents.puzzles.puzzles.len() + 1) [
  //   #let puzzle = contents.puzzles.puzzles.at(puzzle_num - 1)
  //   #slide(repeat: 6, self => [
  //     #let (uncover, only, alternatives) = utils.methods(self)
  //     #include(puzzle.content)
  //   ])
  // ]
}

#generate_slides(
   yaml("questions.yaml")
)

= The last piece of the puzzle

#slide(repeat: 10, self => [
  1. #v(2em)
  - asking for information about #only("2-")[(#text(weight: "bold", [wh])at)] a temple in Cambodia #only("3-")[(#text(weight: "bold", [w])at)]
  - to sharpen a knife #only("4-")[(#text(weight: "bold", [wh])et)] soaked in water #only("5-")[(#text(weight: "bold", [w])et)]
  - during which#only("6-")[ (#text(weight: "bold", [wh])ile)], be cunning and devious #only("7-")[(#text(weight: "bold", [w])ile)]
  - complain about #only("8-")[(#text(weight: "bold", [wh])ine)] #fill-in-the-blank("-9", "10-", "e.g. fermented grapes") #only("9-")[(#text(weight: "bold", [w])ine)]
]) 


// 1. federal
// 2. academy
// 3. intelligent
// 4. ________
// e.g. literature
// 
//
// 
#slide(repeat: 6, self => [
  2. #v(2em)
    #align(horizon, [
      #alternatives-match(("1": [366.48 K], "2-": [200 degrees,])) #fill-in-the-blank("-5", "6-", "that's why they call me Mr. Fahrenheit") \
      #alternatives-match(("-2": [$v_"me" = c$], "3-": [I'm travelling at the speed of light])) \
      #fill-in-the-blank("-5", "6-", "I wanna make a") #alternatives-match(("-3": [> 343 m/s (in dry air at 1 atm and 20°C)], "4-": [supersonic])) #fill-in-the-blank("-5", "6-", "man out of you/woman of you") \
      #fill-in-the-blank("-5", "6-", "Don't") #alternatives-match(("-4": [$bold(p)_"me" (t) - integral_t^(t_"now") bold(F)(t') dif t' = 0$], "5-": "stop me now"))\
      // #fill-in-the-blank("343 m/s", "-4", "5-") #only("4-")[#sym.eq in dry air at 1 atm and 20 deg c]
      // #fill-in-the-blank("p_me(t) - int_t^t_now F(t') dt' = 0", "-5", "6-") #only("5-")[#sym.eq equation of motion]
      // 
      
    ])

]) 

#slide(repeat: 5, self => [
  3.

  #align(center,
  grid(columns: 4, align: horizon, gutter: 1em,
  [Tongans treat waiters poorly],
  [The Danes get road rage],
  [Tunisians lie about their age],
  [#fill-in-the-blank("1-4", "5", "e.g. The Swiss") like pineapple on pizza],
  pause + image("media/tonga.svg", height: 3em),
  pause + image("media/denmark.svg", height: 3em),
  pause + image("media/Flag_of_Tunisia.svg", height: 3em) + pause,
  image("media/flag_of_switzerland.svg", height: 3em)
  ))
])

#slide(repeat: 8, self => [
  4. #box() #v(1em)
    #align(horizon, [
      + an international #only("2-")[_(opposite of “national”)_] citizen #only("3-")[_(synonym of “national”)_]
      + the outskirts #only("4-")[_(opposite of “centre”)_] of a hub #only("4-")[_(synonym of “centre”)_]
      + a useless #only("5-")[_(opposite of “competence”)_] ability #only("5-")[_(synonym of “competence”)_]
      + ignore #only("6-")[_(opposite of “research”)_] the #fill-in-the-blank("-7", "8-", "evidence") #only("7-")[_(synonym of “research”)_]
    ])
])

// #slide[
//   #v(1em)
//   1.
//   #grid(columns: (1fr, 1fr, 1fr, 1fr), align: center, column-gutter: 1em,
//     image("puzzles/marilyn_monroe.jpg", height: 50%),
//     image("puzzles/carey_mulligan.jpg", height: 50%),
//     image("puzzles/madonna.jpg", height: 50%),
//     image("puzzles/kylie_minogue.png", height: 50%)
//   )
//   #pause
//   #grid(columns: (1fr, 1fr, 1fr, 1fr), align: center, column-gutter: 1em, [Marilyn Monroe], [Carey Mulligan], [Madonna], [Kylie Minogue])
//   #pause
//   #grid(columns: (1fr, 1fr, 1fr, 1fr), align: center, column-gutter: 1em, [mm], [cm], [m], [km])
// ]
// 
// #slide(repeat: 6, self => [
//   #let (uncover, only, alternatives) = utils.methods(self)
//   #v(2em)
//   2.
// 
//   - #uncover("2-")[*prote*]in molecules with amino acids
//   - #uncover("3-")[*prote*]gee, she's got an attentive mentor
//   - #uncover("4-")[*prote*]sting, march and chant
//   - #uncover("5-")[*prote*]a plant from South Africa
// 
//   #only("6-")[
//   Add "prote" to the beginning of the first word to get the definition that follows
//   ]
// ])
// 
// #slide[
//   #v(2em)
//   3.
// 
//   #align(center + horizon,
//   grid(columns: (1fr, 1fr, 1fr, 1fr), column-gutter: 1em,
//   image("puzzles/guatemala_rotated_with_flag_and_outline.png", height: 30%),
//   image("puzzles/spain_rotated_with_flag_and_outline.png", height: 30%),
//   image("puzzles/bangladesh_rotated_with_flag_and_outline.png", height: 30%),
//   image("puzzles/fiji_rotated_with_flag_and_outline.png", height: 30%)))
//   #pause
//   #align(center + horizon,
//     grid(columns: (1fr, 1fr, 1fr, 1fr), column-gutter: 1em, [Guatemala], [Spain], [Bangladesh], [Fiji],)
//   )
//   #pause
//   #align(center + horizon,
//     grid(columns: (1fr, 1fr, 1fr, 1fr), column-gutter: 1em, [89° W], [4° W], [90° E], [175° E])
//   )
// ]
// 
// 
// #slide(repeat: 6, self => [
//   #let (uncover, only, alternatives) = utils.methods(self)
//   #align(center + horizon,
//   grid(columns: (1fr, 1fr, 1fr, 1fr), align: center, column-gutter: 1em, [car], [handbag], [television], [movie])
//   )
//   #pause
//   #only("2")[#align(center + horizon, image("puzzles/car.png", width: 80%))]
//   #only("3")[#align(center + horizon, image("puzzles/handbag.png", height: 80%))]
//   #only("4")[#align(center + horizon, image("puzzles/tv2.png", height: 80%))]
//   #only("5")[#align(center + horizon, image("puzzles/movie.png", height: 80%))]
//   #only("6")[#align(center + horizon, image("puzzles/piracy_its_a_crime.png", height: 80%))]
// ])
// 

= Please add up your total score and bring up your answer sheets

=

= Our winner, with a score of , is...
==

#focus-slide([
#align(center + horizon,
  image("media/chatgpt_wins.png", width: 110%, height: 120%)
)
]
)

= And while you may be obsolete... I'm not (yet)
==
> _Come up with interesting pub questions about objects/concepts/people/etc. which have "come to an end". The questions should encourage lateral thinking and be gettable with an educated guess, but not too easy._

#pause

Sure, here are some interesting pub quiz questions about objects, concepts, or people that have "come to an end":

#pause

🌍 Nature & Environment
#pause
1. What dodo-sized bird was driven to extinction in the 17th century due to human activity and introduced species on its native island of Mauritius?
   - Answer: The Dodo

#focus-slide(background-color: black)[
  #set text(font: "edwardian script itc", size: 3em)
  #align(center, [_Fin_])
]