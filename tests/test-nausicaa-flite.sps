;;; -*- coding: utf-8-unix -*-
;;;
;;;Part of: Vicare/Flite
;;;Contents: tests for Flite bindings, Nausicaa language
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
;;;MERCHANTABILITY  or FITNESS FOR  A PARTICULAR  PURPOSE.  See  the GNU
;;;General Public License for more details.
;;;
;;;You should  have received  a copy of  the GNU General  Public License
;;;along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;;


#!r6rs
(import (nausicaa)
  (nausicaa speech-tools flite)
;;;  (prefix (vicare ffi) ffi.)
  (vicare arguments validation)
  (vicare checks))

(check-set-mode! 'report-failed)
(check-display "*** testing Nausicaa Flite bindings\n")

(flite-init)


;;;; helpers



(parametrise ((check-test-name		'voice-struct)
	      (struct-guardian-logger	#f))

  (define who 'test)

;;; --------------------------------------------------------------------

  (check	;this will be garbage collected
      (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
;;;(debug-print voice)
	((<flite-voice>) voice))
    => #t)

  (check
      (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
	(voice alive?))
    => #t)

  (check	;single finalisation
      (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
  	(voice finalise))
    => #f)

  (check	;double finalisation
      (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
  	(voice finalise)
  	(voice finalise))
    => #f)

  (check	;alive predicate after finalisation
      (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
  	(voice finalise)
  	(voice alive?))
    => #f)

;;; --------------------------------------------------------------------
;;; destructor

  (check
      (with-result
       (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
	 (set! (voice destructor) (lambda (voice)
				    (add-result 123)))
	 (voice finalise)))
    => '(#f (123)))

;;; --------------------------------------------------------------------
;;; hash

  (check-for-true
   (let (((V <flite-voice>) (<flite-voice> ("rms"))))
     (integer? (V hash))))

  (check
      (let ((A (<flite-voice> ()))
	    (B (<flite-voice> ()))
	    (T (make-hashtable (lambda ((V <flite-voice>))
				 (V hash))
			       eq?)))
	(hashtable-set! T A 1)
	(hashtable-set! T B 2)
	(list (hashtable-ref T A #f)
	      (hashtable-ref T B #f)))
    => '(1 2))

;;; --------------------------------------------------------------------
;;; properties

  (check
      (let (((S <flite-voice>) (<flite-voice> ("rms"))))
	(S property-list))
    => '())

  (check
      (let (((S <flite-voice>) (<flite-voice> ("rms"))))
	(S putprop 'ciao 'salut)
	(S getprop 'ciao))
    => 'salut)

  (check
      (let (((S <flite-voice>) (<flite-voice> ("rms"))))
	(S getprop 'ciao))
    => #f)

  (check
      (let (((S <flite-voice>) (<flite-voice> ("rms"))))
	(S putprop 'ciao 'salut)
	(S remprop 'ciao)
	(S getprop 'ciao))
    => #f)

  (check
      (let (((S <flite-voice>) (<flite-voice> ("rms"))))
	(S putprop 'ciao 'salut)
	(S putprop 'hello 'ohayo)
	(list (S getprop 'ciao)
	      (S getprop 'hello)))
    => '(salut ohayo))

;;; --------------------------------------------------------------------
;;; arguments validation

  (check-for-true
   (let (((S <flite-voice>) (<flite-voice> ("rms"))))
     (with-arguments-validation (who)
	 ((<flite-voice>	S))
       #t)))

  (check-for-true
   (let (((S <flite-voice>) (<flite-voice> ("rms"))))
     (S finalise)
     (with-arguments-validation (who)
	 ((<flite-voice>	S))
       #t)))

  (check-for-true
   (let (((S <flite-voice>) (<flite-voice> ("rms"))))
     (with-arguments-validation (who)
	 ((<flite-voice>/alive	S))
       #t)))

;;;

  (let (((S <flite-voice>) (<flite-voice> ("rms"))))
    (check-for-procedure-argument-violation
	(begin
	  (S finalise)
	  (with-arguments-validation (who)
	      ((<flite-voice>/alive	S))
	    #t))
      => (list who (list S))))

  (collect))


(parametrise ((check-test-name		'voice-ops))

;;; voice name

  (check
      (let (((voice <flite-voice>) (<flite-voice> ())))
  	(voice name))
    => "rms")

  (check
      (let (((voice <flite-voice>) (<flite-voice> ("slt"))))
  	(voice name))
    => "slt")

  (check
      (let (((voice <flite-voice>) (<flite-voice> ("kal"))))
  	(voice name))
    => "kal")

  (check
      (let (((voice <flite-voice>) (<flite-voice> ("kal16"))))
  	(voice name))
    => "kal16")

  (check
      (let (((voice <flite-voice>) (<flite-voice> ("awb"))))
  	(voice name))
    => "awb")

  (collect))


(parametrise ((check-test-name		'text-to-speech))

  (check-for-true
   (let (((voice <flite-voice>) (<flite-voice> ("rms"))))
     (flonum? (voice play-text "rms voice"))))

  (check-for-true
   (let (((voice <flite-voice>) (<flite-voice> ("slt"))))
     (flonum? (voice play-text "slt voice"))))

  (check-for-true
   (let (((voice <flite-voice>) (<flite-voice> ("kal"))))
     (flonum? (voice play-text "kal voice"))))

  (check-for-true
   (let (((voice <flite-voice>) (<flite-voice> ("awb"))))
     (flonum? (voice play-text "awb voice"))))

;;; --------------------------------------------------------------------

  (check-for-true
   (let (((voice <flite-voice>) (<flite-voice> ())))
     (flonum? (voice play-text "text to speech play"))))

;;; --------------------------------------------------------------------

  (check
      (with-compensations
	(define (clean-file)
	  (when (file-exists? "proof-03.txt")
	    (delete-file "proof-03.txt")))
	(letrec (((voice <flite-voice>) (compensate
					    (<flite-voice> ())
					  (with
					   (voice finalise)))))
	  (clean-file)
	  (compensate
	    (with-output-to-file "proof-03.txt"
	      (lambda ()
		(display "file to speech test")))
	    (with
	     (clean-file)))
	  (flonum? (voice play-file "proof-03.txt"))))
    => #t)

  (collect))


(parametrise ((check-test-name		'utterance-struct)
	      (struct-guardian-logger	#f))

  (define who 'test)
  (define voice (<flite-voice> ()))

;;; --------------------------------------------------------------------

  (check	;this will be garbage collected
      (let (((utterance <flite-utterance>) (<flite-utterance> ("hello" voice))))
;;;(debug-print utterance)
	((<flite-utterance>) utterance))
    => #t)

  (check
      (let (((utterance <flite-utterance>) (<flite-utterance> ("hello" voice))))
	(utterance alive?))
    => #t)

  (check	;single finalisation
      (let (((utterance <flite-utterance>) (<flite-utterance> ("hello" voice))))
  	(utterance finalise))
    => #f)

  (check	;double finalisation
      (let (((utterance <flite-utterance>) (<flite-utterance> ("hello" voice))))
  	(utterance finalise)
  	(utterance finalise))
    => #f)

  (check	;alive predicate after finalisation
      (let (((utterance <flite-utterance>) (<flite-utterance> ("hello" voice))))
  	(utterance finalise)
  	(utterance alive?))
    => #f)

;;; --------------------------------------------------------------------
;;; destructor

  (check
      (with-result
       (let (((utterance <flite-utterance>) (<flite-utterance> ("hello" voice))))
	 (set! (utterance destructor) (lambda (utterance)
					(add-result 123)))
	 (utterance finalise)))
    => '(#f (123)))

;;; --------------------------------------------------------------------
;;; hash

  (check-for-true
   (let (((V <flite-utterance>) (<flite-utterance> ("hello" voice))))
     (integer? (V hash))))

  (check
      (let ((A (<flite-utterance> ("hello" voice)))
	    (B (<flite-utterance> ("hello" voice)))
	    (T (make-hashtable (lambda ((V <flite-utterance>))
				 (V hash))
			       eq?)))
	(hashtable-set! T A 1)
	(hashtable-set! T B 2)
	(list (hashtable-ref T A #f)
	      (hashtable-ref T B #f)))
    => '(1 2))

;;; --------------------------------------------------------------------
;;; properties

  (check
      (let (((S <flite-utterance>) (<flite-utterance> ("hello" voice))))
	(S property-list))
    => '())

  (check
      (let (((S <flite-utterance>) (<flite-utterance> ("hello" voice))))
	(S putprop 'ciao 'salut)
	(S getprop 'ciao))
    => 'salut)

  (check
      (let (((S <flite-utterance>) (<flite-utterance> ("hello" voice))))
	(S getprop 'ciao))
    => #f)

  (check
      (let (((S <flite-utterance>) (<flite-utterance> ("hello" voice))))
	(S putprop 'ciao 'salut)
	(S remprop 'ciao)
	(S getprop 'ciao))
    => #f)

  (check
      (let (((S <flite-utterance>) (<flite-utterance> ("hello" voice))))
	(S putprop 'ciao 'salut)
	(S putprop 'hello 'ohayo)
	(list (S getprop 'ciao)
	      (S getprop 'hello)))
    => '(salut ohayo))

;;; --------------------------------------------------------------------
;;; arguments validation

  (check-for-true
   (let (((S <flite-utterance>) (<flite-utterance> ("hello" voice))))
     (with-arguments-validation (who)
	 ((<flite-utterance>	S))
       #t)))

  (check-for-true
   (let (((S <flite-utterance>) (<flite-utterance> ("hello" voice))))
     (S finalise)
     (with-arguments-validation (who)
	 ((<flite-utterance>	S))
       #t)))

  (check-for-true
   (let (((S <flite-utterance>) (<flite-utterance> ("hello" voice))))
     (with-arguments-validation (who)
	 ((<flite-utterance>/alive	S))
       #t)))

;;;

  (let (((S <flite-utterance>) (<flite-utterance> ("hello" voice))))
    (check-for-procedure-argument-violation
	(begin
	  (S finalise)
	  (with-arguments-validation (who)
	      ((<flite-utterance>/alive	S))
	    #t))
      => (list who (list S))))

  (collect))


(parametrise ((check-test-name		'utterance-ops))

  (define voice (<flite-voice> ()))

;;; --------------------------------------------------------------------

  (check
      (let (((utterance <flite-utterance>) (<flite-utterance> ("utterance play" voice))))
;;;(debug-print utterance)
	(flonum? (utterance play)))
    => #t)

  (check
      (with-compensations
	(define (clean-file)
	  (when (file-exists? "proof-04.txt")
	    (delete-file "proof-04.txt")))
	(clean-file)
	(letrec (((utterance <flite-utterance>) (compensate
						    (<flite-utterance> ("utterance save to file" voice))
						  (with
						   (utterance finalise)))))
	  (compensate
	      (begin
		(utterance save-to-file "proof-04.txt")
		(file-exists? "proof-04.txt"))
	    (with
	     (clean-file)))))
    => #t)

  #t)


;;;; done

(check-report)

;;; end of file
