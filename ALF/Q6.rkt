;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Q6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; produces #t if all the elements of lst satisfy pred, and #f otherwise
;; my-ormap1: (X->boolean) (listof X) -> boolean
;; Recursively using basic Racket functions
(define my-ormap1?
  (lambda (pred lst)
    (cond
        ((empty? lst) #f)
        ((pred (first lst)) #t)
        (else
            (or (pred (first lst))
                (my-ormap1? pred (rest lst))))
      )
    )
)

;; produces #t if all the elements of lst satisfy pred, and #f otherwise
;; my-andmap1: (X->boolean) (listof X) -> boolean
;; Recursively using basic Racket functions
(define my-andmap1?
    (lambda (pred lst)
        (cond
            ((empty? lst) #t)
            (else
                (and (pred (first lst))
                     (my-andmap1? pred (rest lst))))
        )
    )
)

;; my-ormap: (X->boolean) (listof X) -> boolean
;; Using Foldr
(define (my-ormap? pred lst)
  (foldr (lambda (a b) (or (pred a) b)) #f lst))

;; my-andmap: (X->boolean) (listof X) -> boolean
;; Using Foldr 
(define my-andmap?
    (lambda (pred lst)
        (foldr (lambda (a b) (and (pred a) b)) #t lst)
    )
)

;; my-ormap3: (X->boolean) (listof X) -> boolean
;; Using my-andmap? to implement my-ormap?
(define my-ormap3?
    (lambda (pred lst)
        (not (my-andmap? (lambda (x) (not (pred x))) lst))
    )
)

;; my-andma3p: (X->boolean) (listof X) -> boolean
;; Using my-ormap? to implement my-andmap?
(define my-andmap3?
    (lambda (pred lst)
        (not (my-ormap? (lambda (x) (not (pred x))) lst))
    )
)

(check-expect #t (my-andmap1? positive? '(1 2 3)))
(check-expect #f (my-andmap1? positive? '(1 -2 3)))
(check-expect #f (my-andmap? positive? '(1 -2 3)))
(check-expect #t (my-andmap3? positive? '(1 2 3)))

(check-expect #t (my-ormap1? positive? '(1 2 3)))
(check-expect #f (my-ormap1? positive? '(-1 -2 -3)))
(check-expect #t (my-ormap? positive? '(1 -2 3)))
(check-expect #f (my-ormap3? positive? '(-1 -2 -3)))