\version "2.24.4"
% automatically converted by musicxml2ly from Satu meni saunaan.musicxml
\pointAndClickOff

\header {
    title =  "Satu meni saunaan"
    encodingsoftware =  "MuseScore 3.6.2"
    encodingdate =  "2025-09-25"
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


PartPOneVoiceOne =  \relative c' {
    \clef "treble" \numericTimeSignature\time 4/4 \key c \major | % 1
    \red-note \stemUp c4 \orange-note \stemUp d4 \yellow-note \stemUp e4 \green-note \stemUp f4 | % 2
    \blue-note \stemUp g2 \blue-note \stemUp g2 | % 3
    \blue-note \stemUp g4 \green-note \stemUp f4 \yellow-note \stemUp e4 \orange-note \stemUp d4 | % 4
    \red-note \stemUp c2 \red-note \stemUp c2 \break | % 5
    \red-note \stemUp c4 \orange-note \stemUp d4 \yellow-note \stemUp e4 \green-note \stemUp f4 | % 6
    \blue-note \stemUp g4 \blue-note \stemUp g4 \blue-note \stemUp g4 r4 | % 7
    \blue-note \stemUp g4 \green-note \stemUp f4 \yellow-note \stemUp e4 \orange-note \stemUp d4 | % 8
    \red-note \stemUp c4 \red-note \stemUp c4 \red-note \stemUp c2 \bar "|."
    }

PartPOneVoiceFive =  \relative c {
    \clef "bass" \numericTimeSignature\time 4/4 \key c \major | % 1
    \red-note \stemUp c4 \red-note \stemDown c'4 \red-note \stemUp c,4 \red-note \stemDown c'4 | % 2
    \red-note \stemUp c,4 \red-note \stemDown c'4 \red-note \stemUp c,4 \red-note \stemDown c'4 | % 3
    \blue-note \stemUp g,4 \blue-note \stemDown g'4 \blue-note \stemUp g,4 \blue-note \stemDown g'4 | % 4
    \red-note \stemUp c,4 \red-note \stemDown c'4 \red-note \stemUp c,4 \red-note \stemDown c'4 \break | % 5
    \red-note \stemUp c,4 \red-note \stemDown c'4 \red-note \stemUp c,4 \red-note \stemDown c'4 | % 6
    \red-note \stemUp c,4 \red-note \stemDown c'4 \red-note \stemUp c,4 \red-note \stemDown c'4 | % 7
    \blue-note \stemUp g,4 \blue-note \stemDown g'4 \blue-note \stemUp g,4 \blue-note \stemDown g'4 | % 8
    \red-note \stemUp c,4 \red-note \stemDown c'4 \red-note \stemUp <c, c'>2 \bar "|."
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

