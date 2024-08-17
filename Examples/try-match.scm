#! /usr/local/bin/guile3 -s
 !#

; $Id:$

(use-modules (ice-9 format))
(use-modules (ice-9 iconv))
(use-modules (ice-9 pretty-print))
(use-modules (ice-9 rdelim))
(use-modules (ice-9 regex))
(use-modules (ice-9 string-fun))

; 2024/08/14:Topic~ KVM for Beginners
; 2024/08/22:Crafting Interpreters in Rust Collaboratively
; 2024/08/22:TOPIC~ To Be Determined Offer to talk!
; 2024/08/27:TOPIC~ To Be Determined Offer to talk!

(define s (string-match ":" "2024/08/14:Topic~ KVM for Beginners"))

(newline)
(display (format #f "start: ~a~%" (match:start s)))
(display (format #f "end: ~a~%" (match:end s)))
(newline)
(display (format #f "prefix: ~a~%" (match:prefix s)))
(display (format #f "suffix: ~a~%~%"(match:suffix s)))
(newline)

;
; EOF
