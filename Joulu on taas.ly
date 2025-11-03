\version "2.24.4"
% automatically converted by musicxml2ly from Joulu on taas.musicxml
\pointAndClickOff

\header {
    title =  "Joulu on taas"
    encodingsoftware =  "MuseScore 3.6.2"
    encodingdate =  "2025-11-02"
    }

#(set-global-staff-size 20.0)
\paper {
    
    paper-width = 21.0\cm
    paper-height = 29.7\cm
    top-margin = 1.5\cm
    bottom-margin = 1.5\cm
    left-margin = 1.5\cm
    right-margin = 1.5\cm
    indent = 1.6153846153846154\cm
    short-indent = 1.2923076923076922\cm
    }
\layout {
    \context { \Score
        autoBeaming = ##f
        }
    }


#(define (colored-notehead grob)
   "Creates a colored circle behind the lowest notehead in a chord."
   (let* ((note (ly:note-head::print grob))
          (x-ext (ly:stencil-extent note X))
          (y-ext (ly:stencil-extent note Y))
          (cn-circle-color (ly:grob-property grob 'cn-circle-color))
          (is-lower-note
            (let ((parent (ly:grob-parent grob X)))
              (or (not parent)  ;; If there's no chord, apply normally
                  (eq? grob (car (ly:grob-array->list (ly:grob-object parent 'note-heads))))))) ;; Check if this is the lowest note
          (combo-stencil
            (if (and cn-circle-color)
                (ly:stencil-add
                  (ly:stencil-translate
                    (stencil-with-color
                      (make-circle-stencil 1 0.8 1)
                      cn-circle-color)
                    (cons (interval-center x-ext)
                          (interval-center y-ext)))
                  note)
                note))) ;; If it's not the lowest note, draw only the black notehead
     (ly:make-stencil (ly:stencil-expr combo-stencil)
                      (ly:stencil-extent note X)
                      (ly:stencil-extent note Y))))


%% CUSTOM GROB PROPERTIES
%% I use "cn-" to keep my functions separate from standard
%% LilyPond functions (like a poor man's namespace).

% function from "scm/define-grob-properties.scm" (modified)
#(define (cn-define-grob-property symbol type?)
   (set-object-property! symbol 'backend-type? type?)
   (set-object-property! symbol 'backend-doc "custom grob property")
   symbol)

#(cn-define-grob-property 'cn-circle-color color?)

red-note = {
  \once \override NoteHead.cn-circle-color = "#FF3131"
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}
yellow-note = {
  \once \override NoteHead.cn-circle-color = #(x11-color "yellow")
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}
green-note = {
  \once \override NoteHead.cn-circle-color = #(x11-color "green")
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}
blue-note = {
  \once \override NoteHead.cn-circle-color = "#1F51FF"
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}
orange-note = {
  \once \override NoteHead.cn-circle-color = #(x11-color "orange")
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}
purple-note = {
  \once \override NoteHead.cn-circle-color = #(x11-color "purple")
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}
pink-note = {
  \once \override NoteHead.cn-circle-color = #(x11-color "pink")
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}


PartPOneVoiceOne =  \relative e' {
    \clef "treble" \time 3/4 \key c \major \repeat volta 2 {
        | % 1
        \yellow-note \stemUp e4 \yellow-note \stemUp e8 [ \orange-note \stemUp d8 ] \red-note \stemUp c4 | % 2
        \yellow-note \stemUp e4 \yellow-note \stemUp e8 [ \orange-note \stemUp d8 ] \red-note \stemUp c4 | % 3
        \orange-note \stemUp d4 \orange-note \stemUp d8 [ \red-note \stemUp c8 ] \purple-note \stemUp b8 [ \red-note \stemUp c8 ] | % 4
        \orange-note \stemUp d4 \red-note \stemUp c4 r4 }
    \break \repeat volta 2 {
        | % 5
        \green-note \stemUp f4 \green-note \stemUp f8 [ \green-note \stemUp f8 ] \pink-note \stemUp a4 | % 6
        \yellow-note \stemUp e4 \yellow-note \stemUp e8 [ \yellow-note \stemUp e8 ] \blue-note \stemUp g4 | % 7
        \orange-note \stemUp d4 \orange-note \stemUp d8 [ \yellow-note \stemUp e8 ] \green-note \stemUp f8 [ \yellow-note \stemUp e8 ] | % 8
        \orange-note \stemUp d4 \red-note \stemUp c4 r4 }
    }

PartPOneVoiceFive =  \relative c {
    \clef "bass" \time 3/4 \key c \major \repeat volta 2 {
        | % 1
        \red-note \stemUp c2. | % 2
        \red-note \stemUp c2. | % 3
        \blue-note \stemUp g2. | % 4
        \red-note \stemUp c2. }
    \break \repeat volta 2 {
        | % 5
        \green-note \stemUp f,2. | % 6
        \red-note \stemUp c'2. | % 7
        \blue-note \stemUp g2. | % 8
        \red-note \stemUp c2. }
    }


% The score definition
\score {
    <<
        
        \new PianoStaff
        <<
            \set PianoStaff.instrumentName = ""
            \set PianoStaff.shortInstrumentName = ""
            
            \context Staff = "1" << 
                \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
                \context Voice = "PartPOneVoiceOne" {  \PartPOneVoiceOne }
                >> \context Staff = "2" <<
                \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
                \context Voice = "PartPOneVoiceFive" {  \PartPOneVoiceFive }
                >>
            >>
        
        >>
    \layout {}
    % To create MIDI output, uncomment the following line:
    %  \midi {\tempo 4 = 100 }
    }

