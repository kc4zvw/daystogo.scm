#! /usr/local/bin/guile3 -s
 !#

(define (addx in-num in-x)
  (if (>  (* in-num in-x) 999)
      0
      (+ (* in-num in-x) (addx in-num (+ 1 in-x)))))

(display (- (+ (addx 3 1) (addx 5 1)) (addx 15 1)))
(newline)

(display (addx 3 1))
(newline)

(display (addx 5 1))
(newline)

(display (addx 15 1))
(newline)

; EOF
