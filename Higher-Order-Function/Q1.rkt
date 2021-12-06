;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; straight-line: Posn Posn → (Num → Num)
;; requires: x-coordinates of p1 and p2 are not equal to each other

(define (straight-line p1 p2)
  (local[(define slope (/ (− (posn-y p1) (posn-y p2))
                          (− (posn-x p1) (posn-x p2))))
         (define intercept (− (posn-y p1) (∗ slope (posn-x p1))))
         (define (y-at x) (+ (∗ slope x) intercept))]
    y-at))

(define f1 (straight-line (make-posn 0 0) (make-posn 1 1)))
(f1 4) 
(define f2 (straight-line (make-posn 8 3) (make-posn 3 3)))
(f2 2)
(define f3 (straight-line (make-posn 0 0) (make-posn −1 4)))
(f3 3)