;;; -*- coding: utf-8-unix -*-
;;;
;;;Part of: Vicare/Flite
;;;Contents: Nausicaa interface for Flite
;;;Date: Sat Sep 21, 2013
;;;
;;;Abstract
;;;
;;;
;;;
;;;Copyright (C) 2013 Marco Maggi <marco.maggi-ipsu@poste.it>
;;;
;;;This program is free software:  you can redistribute it and/or modify
;;;it under the terms of the  GNU General Public License as published by
;;;the Free Software Foundation, either version 3 of the License, or (at
;;;your option) any later version.
;;;
;;;This program is  distributed in the hope that it  will be useful, but
;;;WITHOUT  ANY   WARRANTY;  without   even  the  implied   warranty  of
;;;MERCHANTABILITY or  FITNESS FOR  A PARTICULAR  PURPOSE.  See  the GNU
;;;General Public License for more details.
;;;
;;;You should  have received a  copy of  the GNU General  Public License
;;;along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;;


#!r6rs
(library (nausicaa speech-tools flite)
  (export
    flite-init
    flite-available-voice-names

    <flite-voice>
    flite-voice.vicare-arguments-validation
    flite-voice/alive.vicare-arguments-validation
    false-or-flite-voice.vicare-arguments-validation
    false-or-flite-voice/alive.vicare-arguments-validation

    <flite-utterance>
    flite-utterance.vicare-arguments-validation
    flite-utterance/alive.vicare-arguments-validation
    false-or-flite-utterance.vicare-arguments-validation
    false-or-flite-utterance/alive.vicare-arguments-validation

    )
  (import (nausicaa)
    (vicare speech-tools flite))


(define-label <flite-voice>
  (predicate flite-voice?)
  (protocol (lambda () flite-voice-select))
  (virtual-fields (mutable (destructor <procedure>)
			   flite-voice-custom-destructor
			   set-flite-voice-custom-destructor!))
  (methods (alive?		flite-voice?/alive)
	   (putprop		flite-voice-putprop)
	   (getprop		flite-voice-getprop)
	   (remprop		flite-voice-remprop)
	   (property-list	flite-voice-property-list)
	   (hash		flite-voice-hash)
	   (finalise		flite-voice-finalise)
	   (name		flite-voice-name)
	   )
  (method (play-text (V <flite-voice>) (T <string>))
    (flite-text-to-speech T V "play"))
  (method (play-file (V <flite-voice>) (F <string>))
    (flite-file-to-speech F V "play"))
  )


(define-label <flite-utterance>
  (predicate flite-utterance?)
  (protocol (lambda () flite-synth-text))
  (virtual-fields (mutable (destructor <procedure>)
			   flite-utterance-custom-destructor
			   set-flite-utterance-custom-destructor!))
  (methods (alive?		flite-utterance?/alive)
	   (putprop		flite-utterance-putprop)
	   (getprop		flite-utterance-getprop)
	   (remprop		flite-utterance-remprop)
	   (property-list	flite-utterance-property-list)
	   (hash		flite-utterance-hash)
	   (finalise		flite-utterance-finalise)
	   )
  (method (play (U <flite-utterance>))
    (flite-process-output U "play"))
  (method (save-to-file (U <flite-utterance>) (filename <string>))
    (flite-process-output U filename))
  )


;;;; done

)

;;; end of file
