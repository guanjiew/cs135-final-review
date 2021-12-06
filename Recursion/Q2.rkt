;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; remove-all-first: (listof Any) → (listof Any)
;; requires: lst is non-empty

(define (remove-all-first lst)
(filter (lambda (x) (not (equal? x (first lst)))) (rest lst)))
;; count-uniq: (listof Any) → Nat  (define (count-uniq lst)
(cond
[(empty? lst) 0]
[else (add1 (count-uniq (remove-all-first lst)))])